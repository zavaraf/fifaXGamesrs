DELIMITER $$

-- Función para formatear montos con máscara de pesos
DROP FUNCTION IF EXISTS formatearMonto$$
CREATE FUNCTION formatearMonto(monto BIGINT) 
RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(50);
    DECLARE montoStr VARCHAR(50);
    DECLARE longitud INT;
    DECLARE i INT;
    DECLARE contador INT DEFAULT 0;
    
    -- Manejar casos especiales
    IF monto IS NULL THEN
        RETURN '$0';
    END IF;
    
    IF monto = 0 THEN
        RETURN '$0';
    END IF;
    
    -- Convertir a string sin signo
    SET montoStr = CAST(ABS(monto) AS CHAR);
    SET longitud = CHAR_LENGTH(montoStr);
    SET resultado = '';
    SET i = longitud;
    
    -- Construir el número con separadores de miles
    WHILE i > 0 DO
        SET resultado = CONCAT(SUBSTRING(montoStr, i, 1), resultado);
        SET contador = contador + 1;
        
        -- Agregar coma cada 3 dígitos (excepto al final)
        IF contador MOD 3 = 0 AND i > 1 THEN
            SET resultado = CONCAT(',', resultado);
        END IF;
        
        SET i = i - 1;
    END WHILE;
    
    -- Agregar signo de peso y signo negativo si es necesario
    IF monto < 0 THEN
        SET resultado = CONCAT('-$', resultado);
    ELSE
        SET resultado = CONCAT('$', resultado);
    END IF;
    
    RETURN resultado;
END$$

-- Procedimiento mejorado con formato de montos y ajuste de zona horaria
DROP PROCEDURE IF EXISTS updateDraft$$
CREATE PROCEDURE updateDraft(IN idJugador INT,
              IN montoInicial INT,
                            IN montoOferta INT,
                            IN manager varchar(100),
                            IN observaciones varchar(100), 
                            IN idEquipoOferta INT,
                            IN idTemporada INT,
                            out isError int, 
                            out message varchar(200))
main_proc: BEGIN

    DECLARE idJugadorVal INT;
    DECLARE idJugadorExist INT;
    DECLARE montoFinalVal INT;
    DECLARE idEquipo INT;
    DECLARE idTemporadaVar INT;
    DECLARE montoBD INT;
    DECLARE sumaDraftPC INT;
    DECLARE idEquipoAnterior INT;
    DECLARE contraoferta INT;
    DECLARE activoVar BIT;
    DECLARE minConfirm INT;
    DECLARE horaInicio INT;
    DECLARE horaFin INT;
    DECLARE minDiaVar INT;
    DECLARE diasVar INT;
    DECLARE minDiaActualVar INT;
    DECLARE sumaVar INT;
    DECLARE sumaminutosdia_cero_Var INT;
    DECLARE minDia_ceroVar INT;
    DECLARE ofertasActivas INT;
    DECLARE horaLocal DATETIME;
    
    -- Declarar handlers para excepciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error interno del sistema. Contacte al administrador.';
    END;
    
    -- Inicializar variables
    SET ofertasActivas = 0;
    SET isError = 0;
    SET message = '';
    
    -- Obtener hora actual del servidor (ya configurada correctamente)
    SET horaLocal = NOW();
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- **1. VALIDACIONES BÁSICAS DE ENTRADA**
    
    -- Validar parámetros obligatorios
    IF idJugador IS NULL OR idJugador <= 0 THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: ID de jugador inválido';
        LEAVE main_proc;
    END IF;
    
    IF montoOferta IS NULL OR montoOferta <= 0 THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: El monto de oferta debe ser mayor a 0';
        LEAVE main_proc;
    END IF;
    
    IF idEquipoOferta IS NULL OR idEquipoOferta <= 0 THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: ID de equipo inválido';
        LEAVE main_proc;
    END IF;
    
    IF idTemporada IS NULL OR idTemporada <= 0 THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: ID de temporada inválido';
        LEAVE main_proc;
    END IF;
    
    IF manager IS NULL OR TRIM(manager) = '' THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: El manager es obligatorio';
        LEAVE main_proc;
    END IF;
    
    -- **2. VALIDAR EXISTENCIA DE JUGADOR**
    SELECT persona.idPersona INTO idJugadorExist
    FROM persona
    WHERE persona.idPersona = idJugador;
    
    IF idJugadorExist IS NULL THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: El jugador no existe en el sistema';
        LEAVE main_proc;
    END IF;
    
    -- **3. OBTENER DATOS DEL DRAFT**
    SELECT draftpc.Persona_idPersona, draftpc.ofertaFinal 
    INTO idJugadorVal, montoFinalVal
    FROM draftpc
    WHERE draftpc.Persona_idPersona = idJugador 
    AND draftpc.tempodada_idTemporada = idTemporada;
    
    IF idJugadorVal IS NULL THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: El jugador no está disponible para ofertar en esta temporada';
        LEAVE main_proc;
    END IF;
    
    -- **4. VALIDAR MONTO INICIAL**
    IF montoInicial IS NULL OR montoInicial != montoFinalVal THEN
        ROLLBACK;
        SET isError = 1;
        SET message = CONCAT('Error: El monto base cambió. Monto actual: ', formatearMonto(montoFinalVal));
        LEAVE main_proc;
    END IF;
    
    -- **5. OBTENER PRESUPUESTO DEL EQUIPO**
    SELECT COALESCE(dat.presupuestoFinal, 0) INTO montoBD
    FROM datosfinancieros dat
    WHERE dat.Equipos_idEquipo = idEquipoOferta
    AND dat.tempodada_idTemporada = idTemporada;
    
    -- **6. VALIDAR PRESUPUESTO**
    IF montoBD IS NULL THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: No se encontraron datos financieros para el equipo en esta temporada';
        LEAVE main_proc;
    END IF;
    
    IF montoOferta > montoBD THEN
        ROLLBACK;
        SET isError = 1;
        SET message = CONCAT('Error: Presupuesto insuficiente. Dinero disponible: ', formatearMonto(montoBD), 
                           ', Monto ofertado: ', formatearMonto(montoOferta));
        LEAVE main_proc;
    END IF;
    
    -- **7. OBTENER CONFIGURACIONES DE DRAFT**
    SELECT COALESCE(monto, 0) INTO contraoferta
    FROM configuraciondraft
    WHERE codigo='contraoferta'
    LIMIT 1;
    
    SELECT COALESCE(monto, 0) INTO minConfirm
    FROM configuraciondraft
    WHERE codigo='confirmacionDraft'
    LIMIT 1;
    
    SELECT COALESCE(monto, 0) INTO horaInicio
    FROM configuraciondraft
    WHERE codigo='horaInicio'
    LIMIT 1;
    
    SELECT COALESCE(monto, 24) INTO horaFin
    FROM configuraciondraft
    WHERE codigo='horaFin'
    LIMIT 1;
    
    -- Validar que las configuraciones existan
    IF contraoferta IS NULL OR minConfirm IS NULL OR horaInicio IS NULL OR horaFin IS NULL THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error: Configuraciones de draft incompletas';
        LEAVE main_proc;
    END IF;
    
    -- **7A. CÁLCULO DE TIEMPO MEJORADO CON HORA CORRECTA DEL SERVIDOR**
    SELECT 
    COALESCE(TIMESTAMPDIFF(DAY, DATE(draftpc.fechaCompra), DATE(NOW())), 0) as diasSe,
    COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, NOW()), 0) as MINUTOSDIA_CERO,
    COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra), INTERVAL 24 HOUR)), 0) as MINUTOSDIA,
    COALESCE(TIMESTAMPDIFF(MINUTE, DATE_ADD(DATE(NOW()), INTERVAL horaInicio HOUR), NOW()), 0) as Minutos_dia_Actual
    INTO diasVar, minDia_ceroVar, minDiaVar, minDiaActualVar
    FROM draftpc 
    WHERE draftpc.Persona_idPersona = idJugadorVal 
    AND draftpc.tempodada_idTemporada = idTemporada;

    SET sumaVar = minDiaVar + minDiaActualVar;
    SET sumaminutosdia_cero_Var = minDia_ceroVar + minDiaActualVar;

    -- Contar ofertas activas con mejor query
    SELECT COUNT(*) INTO ofertasActivas 
    FROM draftpc
    JOIN persona_has_temporada ON persona_has_temporada.Persona_idPersona = draftpc.Persona_idPersona 
        AND persona_has_temporada.temporada_idTemporada = draftpc.tempodada_idTemporada
    WHERE draftpc.usuarioOferta = manager 
    AND draftpc.tempodada_idTemporada = idTemporada
    AND draftpc.idEquipo != 1
    AND persona_has_temporada.equipos_idEquipo = 1;
    
    -- **8. VALIDACIONES ADICIONALES**
    
    -- Validar ofertas activas
    IF ofertasActivas > 2 THEN 
        ROLLBACK;
        SET isError = 1;
        SET message = 'Solo puedes tener 2 ofertas activas';
        LEAVE main_proc;
    END IF;
    
    -- **9. VALIDACIONES DE HORARIO (CON HORA CORRECTA DEL SERVIDOR)**
    IF (HOUR(NOW()) < horaInicio) OR (HOUR(NOW()) >= horaFin) THEN 
        ROLLBACK;
        SET isError = 1;
        SET message = CONCAT('DRAFT CERRADO. Horario: ', horaInicio-1, ':00 - ', horaFin-1, ':00');
        LEAVE main_proc;
    END IF;
    
    -- Validar tiempo límite para ofertar
    IF (diasVar = 1 AND sumaVar >= minConfirm) OR (diasVar = 0 AND minDia_ceroVar >= minConfirm) THEN 
        ROLLBACK;
        SET isError = 1;
        SET message = 'Tiempo límite alcanzado para ofertar';
        LEAVE main_proc;
    END IF;
    
    -- **10. VALIDAR MONTO DE OFERTA**
    IF montoOferta <= montoFinalVal THEN
        ROLLBACK;
        SET isError = 1;
        SET message = CONCAT('Error: La oferta debe ser mayor a ', formatearMonto(montoFinalVal));
        LEAVE main_proc;
    END IF;
    
    -- **11. VALIDAR MONTO MÍNIMO DE CONTRAOFERTA**
    IF montoOferta < (contraoferta + montoFinalVal) THEN
        ROLLBACK;
        SET isError = 1;
        SET message = CONCAT('Error: El monto mínimo a ofertar es ', formatearMonto(contraoferta + montoFinalVal));
        LEAVE main_proc;
    END IF;
    
    -- **12. OBTENER EQUIPO ANTERIOR**
    SELECT draftpc.idEquipo INTO idEquipoAnterior
    FROM draftpc
    WHERE draftpc.idDraftPC = 1
    AND draftpc.Persona_idPersona = idJugador
    AND draftpc.tempodada_idTemporada = idTemporada;
    
    -- **13. ACTUALIZAR DRAFT CON TIMESTAMP CORRECTO**
    UPDATE draftpc
    SET
        oferta = montoInicial,
        ofertaFinal = montoOferta,
        fechaCompra = NOW(),
        usuarioOferta = manager,
        comentarios = observaciones,
        idEquipo = idEquipoOferta
    WHERE idDraftPC = 1
    AND Persona_idPersona = idJugador
    AND tempodada_idTemporada = idTemporada;
    
    -- Verificar que el UPDATE fue exitoso
    IF ROW_COUNT() = 0 THEN
        ROLLBACK;
        SET isError = 1;
        SET message = 'Error al actualizar la oferta';
        LEAVE main_proc;
    END IF;

    -- **14. INSERTAR EN HISTÓRICO CON TIMESTAMP CORRECTO**
    INSERT INTO historicodraft (
        idHistoricoDraft,
        oferta,
        fechaOferta,
        usuarioOferta,
        DraftPC_idDraftPC,
        DraftPC_Persona_idPersona,
        tempodada_idTemporada,
        comentarios,
        ofertaFinal,
        idEquipo
    )
    SELECT 
        NULL,
        montoFinalVal,
        NOW(),
        manager,
        draftpc.idDraftPC,
        draftpc.Persona_idPersona,
        draftpc.tempodada_idTemporada,
        observaciones,
        montoOferta,
        idEquipoOferta
    FROM draftpc
    WHERE draftpc.Persona_idPersona = idJugador
    AND draftpc.tempodada_idTemporada = idTemporada
    AND draftpc.idDraftPC = 1
    LIMIT 1;
        
    -- **15. ACTUALIZAR DATOS FINANCIEROS DEL EQUIPO QUE OFERTA**
    SELECT COALESCE(SUM(draftpc.ofertaFinal), 0) INTO sumaDraftPC
    FROM draftpc
    WHERE draftpc.idEquipo = idEquipoOferta
    AND draftpc.tempodada_idTemporada = idTemporada;
        
    CALL createOrUpdateDatosFinancieros(
        (SELECT idCatalogoConceptos FROM catalogoconceptos WHERE nombre = 'altasPC' LIMIT 1), 
        sumaDraftPC,
        idEquipoOferta,
        idTemporada
    );
        
    -- Si cambió de equipo, actualizar el equipo anterior
    IF idEquipoAnterior IS NOT NULL AND idEquipoAnterior != idEquipoOferta THEN 
        SELECT COALESCE(SUM(draftpc.ofertaFinal), 0) INTO sumaDraftPC
        FROM draftpc
        WHERE draftpc.idEquipo = idEquipoAnterior
        AND draftpc.tempodada_idTemporada = idTemporada;
        
        CALL createOrUpdateDatosFinancieros(
            (SELECT idCatalogoConceptos FROM catalogoconceptos WHERE nombre = 'altasPC' LIMIT 1), 
            sumaDraftPC,
            idEquipoAnterior,
            idTemporada
        );
    END IF;
    
    -- **16. CONFIRMAR TRANSACCIÓN**
    COMMIT;
    
    SET isError = 0;
    SET message = CONCAT('Oferta actualizada: ', formatearMonto(montoOferta));

proc_exit: BEGIN END;

END$$

DELIMITER ;
