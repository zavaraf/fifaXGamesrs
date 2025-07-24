DELIMITER $$
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
BEGIN

-- Declaración de variables con valores por defecto para evitar NULL
DECLARE idJugadorVal int DEFAULT NULL;
DECLARE idJugadorExist int DEFAULT NULL;
DECLARE montoFinalVal int DEFAULT 0;
DECLARE idEquipo int DEFAULT NULL;
DECLARE idTemporadaVar int;
DECLARE montoBD int DEFAULT 0;
DECLARE sumaDraftPC int DEFAULT 0;
DECLARE idEquipoAnterior int DEFAULT NULL;
DECLARE contraoferta int DEFAULT 0;
declare activoVar bit DEFAULT 0;
declare minConfirm int DEFAULT 0;
declare horaInicio int DEFAULT 0;
declare horaFin int DEFAULT 24;
declare minDiaVar int DEFAULT 0;
declare diasVar int DEFAULT 0;
declare minDiaActualVar int DEFAULT 0;
declare sumaVar int DEFAULT 0;
declare sumaminutosdia_cero_Var int DEFAULT 0;
declare minDia_ceroVar int DEFAULT 0;
declare ofertasActivas int DEFAULT 0;
declare temporadaActiva int DEFAULT 0;
declare equipoEnTemporada int DEFAULT 0;

-- Manejo de errores mejorado
DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
    ROLLBACK;
    SET isError = 99;
    SET message = 'Error interno del sistema';
END;

-- Inicializar variables de salida
SET isError = 0;
SET message = 'OK';

-- Iniciar transacción para consistencia
START TRANSACTION;

-- Validaciones iniciales mejoradas
IF idJugador IS NULL OR idJugador <= 0 THEN
    SET isError = 1;
    SET message = 'ID de jugador inválido';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

IF idEquipoOferta IS NULL OR idEquipoOferta <= 0 THEN
    SET isError = 2;
    SET message = 'ID de equipo inválido';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

IF idTemporada IS NULL OR idTemporada <= 0 THEN
    SET isError = 3;
    SET message = 'ID de temporada inválido';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

IF manager IS NULL OR TRIM(manager) = '' THEN
    SET isError = 4;
    SET message = 'Manager requerido';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

IF montoOferta IS NULL OR montoOferta <= 0 THEN
    SET isError = 5;
    SET message = 'Monto de oferta inválido';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

-- Validar que la temporada esté activa (nueva validación)
SELECT COUNT(*) INTO temporadaActiva
FROM temporada 
WHERE idTemporada = idTemporada AND activa = 1;

IF temporadaActiva = 0 THEN
    SET isError = 6;
    SET message = 'La temporada no está activa';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

-- Validar que el equipo esté en la temporada (nueva validación)
SELECT COUNT(*) INTO equipoEnTemporada
FROM equipos_has_temporada 
WHERE Equipos_idEquipo = idEquipoOferta AND tempodada_idTemporada = idTemporada;

IF equipoEnTemporada = 0 THEN
    SET isError = 7;
    SET message = 'El equipo no participa en esta temporada';
    ROLLBACK;
    LEAVE proc_exit;
END IF;

-- Obtener oferta actual del jugador con mejor manejo de errores
SELECT draftpc.Persona_idPersona, COALESCE(draftpc.ofertaFinal, 0) INTO idJugadorVal, montoFinalVal
FROM draftpc
WHERE draftpc.Persona_idPersona = idJugador AND draftpc.tempodada_idTemporada = idTemporada;

-- Validar existencia del jugador
SELECT persona.idPersona INTO idJugadorExist
FROM persona
WHERE persona.idPersona = idJugador;

set idTemporadaVar = idTemporada;

-- Obtener presupuesto con manejo de NULL
SELECT COALESCE(dat.presupuestoFinal, 0) INTO montoBD
FROM datosfinancieros dat
WHERE dat.Equipos_idEquipo = idEquipoOferta
AND dat.tempodada_idTemporada = idTemporadaVar;

-- Obtener configuraciones con valores por defecto
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

-- Cálculo de tiempo mejorado con manejo de NULL y ajuste de zona horaria
SELECT 
COALESCE(TIMESTAMPDIFF(DAY, DATE(draftpc.fechaCompra), DATE(DATE_SUB(NOW(), INTERVAL 1 HOUR))), 0) as diasSe,
COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, DATE_SUB(NOW(), INTERVAL 1 HOUR)), 0) as MINUTOSDIA_CERO,
COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra), INTERVAL 24 HOUR)), 0) as MINUTOSDIA,
COALESCE(TIMESTAMPDIFF(MINUTE, DATE_ADD(DATE(DATE_SUB(NOW(), INTERVAL 1 HOUR)), INTERVAL horaInicio HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR)), 0) as Minutos_dia_Actual
INTO diasVar, minDia_ceroVar, minDiaVar, minDiaActualVar
FROM draftpc 
WHERE draftpc.Persona_idPersona = idJugadorVal 
AND draftpc.tempodada_idTemporada = idTemporada;

SET sumaVar = minDiaVar + minDiaActualVar;
SET sumaminutosdia_cero_Var = minDia_ceroVar + minDiaActualVar;

-- Obtener nombre del equipo de manera más robusta
SELECT COALESCE(
    (CASE WHEN equipos_has_temporada.nombreEquipo IS NOT NULL AND equipos_has_temporada.nombreEquipo != '' 
          THEN equipos_has_temporada.nombreEquipo 
          ELSE equipos.nombreEquipo END),
    'Equipo Desconocido'
) INTO observaciones
FROM equipos_has_temporada
JOIN equipos ON equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
WHERE equipos_has_temporada.Equipos_idEquipo = idEquipoOferta
AND equipos_has_temporada.tempodada_idTemporada = idTemporada;

-- Contar ofertas activas con mejor query
SELECT COUNT(*) INTO ofertasActivas 
FROM draftpc
JOIN persona_has_temporada ON persona_has_temporada.Persona_idPersona = draftpc.Persona_idPersona 
    AND persona_has_temporada.temporada_idTemporada = draftpc.tempodada_idTemporada
WHERE draftpc.usuarioOferta = manager 
AND draftpc.tempodada_idTemporada = idTemporada
AND draftpc.idEquipo != 1
AND persona_has_temporada.equipos_idEquipo = 1;

-- Validaciones con mensajes más descriptivos
IF idJugadorExist IS NULL THEN 
    SET isError = 10;
    SET message = 'El jugador no existe';
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF ofertasActivas > 2 THEN 
    SET isError = 11;
    SET message = 'Solo puedes tener 2 ofertas activas';
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF (HOUR(DATE_SUB(NOW(), INTERVAL 1 HOUR)) < horaInicio) OR (HOUR(DATE_SUB(NOW(), INTERVAL 1 HOUR)) >= horaFin) THEN 
    SET isError = 12;
    SET message = CONCAT('DRAFT CERRADO. Horario: ', horaInicio, ':00 - ', horaFin, ':00');
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF (diasVar = 1 AND sumaVar >= minConfirm) OR (diasVar = 0 AND minDia_ceroVar >= minConfirm) THEN 
    SET isError = 13;
    SET message = 'Tiempo límite alcanzado para ofertar';
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF montoBD IS NULL OR montoBD = 0 OR montoOferta > montoBD THEN 
    SET isError = 14;
    SET message = CONCAT('Presupuesto insuficiente. Disponible: ', COALESCE(montoBD, 0));
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF idJugadorVal IS NULL THEN
    SET isError = 15;
    SET message = 'El jugador no está en draft';
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF montoInicial != montoFinalVal THEN 
    SET isError = 16;
    SET message = CONCAT('Monto cambió. Actual: ', montoFinalVal);
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF montoOferta IS NULL OR montoOferta <= montoFinalVal THEN 
    SET isError = 17;
    SET message = CONCAT('Oferta debe ser mayor a ', montoFinalVal);
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF montoOferta < (contraoferta + montoFinalVal) THEN 
    SET isError = 18;
    SET message = CONCAT('Monto mínimo: ', (contraoferta + montoFinalVal));
    ROLLBACK;
    LEAVE proc_exit;
ELSEIF idJugador IS NOT NULL THEN 
    
    -- Obtener equipo anterior
    SELECT draftpc.idEquipo INTO idEquipoAnterior
    FROM draftpc
    WHERE idDraftPC = 1
    AND Persona_idPersona = idJugador
    AND tempodada_idTemporada = idTemporada;
  
    -- Actualizar oferta con timestamp ajustado a zona horaria local
    UPDATE draftpc
    SET
        oferta = montoInicial,
        ofertaFinal = montoOferta,
        fechaCompra = DATE_SUB(NOW(), INTERVAL 1 HOUR),
        usuarioOferta = manager,
        comentarios = observaciones,
        idEquipo = idEquipoOferta
    WHERE idDraftPC = 1
    AND Persona_idPersona = idJugador
    AND tempodada_idTemporada = idTemporada;

    -- Verificar que el UPDATE fue exitoso
    IF ROW_COUNT() = 0 THEN
        SET isError = 19;
        SET message = 'Error al actualizar la oferta';
        ROLLBACK;
        LEAVE proc_exit;
    END IF;

    -- Insertar en histórico con mejor manejo de errores
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
        DATE_SUB(NOW(), INTERVAL 1 HOUR),
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
        
    -- Actualizar datos financieros del equipo que oferta
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
  
    -- Commit de la transacción
    COMMIT;
    
    SET isError = 0;
    SET message = CONCAT('Oferta actualizada: ', montoOferta);
    
END IF;

proc_exit: BEGIN END;

END $$
DELIMITER ;

-- AJUSTE DE ZONA HORARIA:
-- La BD está 1 hora adelantada respecto a la zona horaria local
-- Por eso restamos 1 hora con DATE_SUB(NOW(), INTERVAL 1 HOUR)

-- Alternativa: Crear una función para manejar la zona horaria
-- También podrías configurar la zona horaria de la sesión con:
-- SET time_zone = '+00:00'; -- o la zona horaria correspondiente

-- Función auxiliar para formatear montos con máscara de pesos
-- Convierte 20000000 a $20,000,000
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS formatearMonto(monto BIGINT) RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE montoFormateado VARCHAR(50);
    
    IF monto IS NULL OR monto = 0 THEN
        RETURN '$0';
    END IF;
    
    -- Formatear con separadores de miles
    SET montoFormateado = FORMAT(monto, 0);
    
    -- Agregar símbolo de peso
    SET montoFormateado = CONCAT('$', montoFormateado);
    
    RETURN montoFormateado;
END$$
DELIMITER ;
