DELIMITER $$
DROP PROCEDURE IF EXISTS confirmPlayer$$
CREATE PROCEDURE confirmPlayer(IN idJugador INT,
                            IN idEquipoOferta INT,
                            IN idTemporada INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE idEquipoExist int;

DECLARE idEquipoVar int;
DECLARE idTemporadaVar int;
declare activoVar bit;
declare horasConfir int;

declare horaInicio int;
declare minDiaVar int;
declare diasVar int;
declare minDiaActualVar int;
declare sumaVar int;
declare sumaminutosdia_cero_Var int;
declare minDia_ceroVar int;
declare minRest int;


select draftpc.Persona_idPersona,draftpc.idEquipo into  idJugadorVal,idEquipoVar
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.tempodada_idTemporada = idTemporada;

select persona.idPersona , persona.Equipos_idEquipo into  idJugadorExist, idEquipoExist
from persona
where persona.idPersona = idJugador;

set  idTemporadaVar = idTemporada;



select monto into horasConfir
from configuraciondraft
where codigo='confirmacionDraft'
limit 1;

select monto into horaInicio
from configuraciondraft
where codigo='horaInicio'
limit 1;

-- **CÁLCULO DE TIEMPO MEJORADO CON MANEJO DE ZONA HORARIA Y HORAS ACTIVAS**
-- Usar la misma lógica que updateDraft con ajuste de zona horaria
-- NOTA: Ajustar según la diferencia real entre BD y hora local
select 
COALESCE(TIMESTAMPDIFF(DAY, DATE(draftpc.fechaCompra), DATE(NOW())), 0) as diasSe,
COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, NOW()), 0) as MINUTOSDIA_CERO,
COALESCE(TIMESTAMPDIFF(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra), INTERVAL 24 HOUR)), 0) as MINUTOSDIA,
COALESCE(TIMESTAMPDIFF(MINUTE, DATE_ADD(DATE(NOW()), INTERVAL horaInicio HOUR), NOW()), 0) as Minutos_dia_Actual
into 
diasVar,
minDia_ceroVar,
minDiaVar,
minDiaActualVar
from draftpc 
where draftpc.Persona_idPersona = idJugadorVal 
and draftpc.tempodada_idTemporada = idTemporada;

-- Calcular suma de minutos considerando solo horas activas del draft
SET sumaVar = minDiaVar + minDiaActualVar;
SET sumaminutosdia_cero_Var = minDia_ceroVar + minDiaActualVar;

-- **VALIDACIÓN MEJORADA DE TIEMPO DE CONFIRMACIÓN**
-- Solo considerar horas activas del draft (10:00 - 24:00) para el cálculo de las 2 horas
-- Usar NOW() directo para evitar problemas de zona horaria

SELECT TIMESTAMPDIFF(MINUTE, fechaCompra, NOW()) >= horasConfir as activo INTO activoVar
FROM draftpc
where draftpc.Persona_idPersona = idJugadorVal
and tempodada_idTemporada = idTemporadaVar;

select idJugadorVal;

-- **VALIDACIONES MEJORADAS**

if idJugadorExist is null then 
  set isError = 1 ;
  set message = 'El jugador no Existe';
  
-- **VALIDACIÓN MEJORADA: Solo considerar horas activas del draft para confirmación**
-- Si se hizo oferta 1 día antes, solo contar las horas activas (10:00-24:00)
elseif (diasVar = 1 and sumaVar < horasConfir ) 
   or (diasVar = 0 and minDia_ceroVar < horasConfir )
   then
   
   if diasVar = 1 then
     set minRest = horasConfir - sumaVar;  -- Minutos restantes considerando solo horas activas
   else 
      set minRest = horasConfir - minDia_ceroVar;  -- Minutos restantes desde la oferta
   end if;
   
  set isError = 1 ;
    set message = concat('Aun no concluye el tiempo para confirmar. Minutos restantes: ', minRest);
elseif idEquipoVar != idEquipoOferta then
  set isError = 1 ;
    set message = 'Solamente el equipo que gano al jugador puede confirmar';

elseif idEquipoExist = idEquipoVar then
  set isError = 1 ;
    set message = 'El Jugador ya se confirmo';
  
elseif idJugador is not null then 
   
     -- **ACTUALIZACIÓN CON TIMESTAMP AJUSTADO A ZONA HORARIA LOCAL**
     UPDATE persona
     SET
       Equipos_idEquipo = idEquipoVar
     WHERE idPersona = idJugador;
    
     UPDATE persona_has_temporada
     SET
       equipos_idEquipo = idEquipoVar
     WHERE persona_idPersona = idJugador
     AND temporada_idTemporada = idTemporadaVar;

     
    
     set isError = 0 ;
     set message = 'OK';
    
    
end if;


END $$
DELIMITER ;