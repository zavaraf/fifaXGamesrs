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

select 
diasSe,
MINUTOSDIA_CERO,
minutosdia,
minutos_dia_actual,
(minutosdia+minutos_dia_actual) sumaminutosdia,
(minutosdia_cero+minutos_dia_actual) sumaminutosdia_cero
into 
diasVar ,
minDia_ceroVar,
minDiaVar ,
minDiaActualVar ,
sumaVar,
sumaminutosdia_cero_Var 
from
(
select 
draftpc.fechaCompra,
timestampdiff(day,DATE(draftpc.fechaCompra),Date(NOW())) as diasSe,
timestampdiff(MINUTE, draftpc.fechaCompra, now()) MINUTOSDIA_CERO,
timestampdiff(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra),INTERVAL 24 HOUR)) MINUTOSDIA,
timestampdiff(MINUTE, DATE_ADD(DATE(now()),INTERVAL horaInicio HOUR), now()) Minutos_dia_Actual
from draftpc where draftpc.Persona_idPersona =  idJugadorVal and draftpc.tempodada_idTemporada = idTemporada) ta
;

SELECT timestampdiff(Minute, fechaCompra, now()) >= horasConfir as activo INTO activoVar
FROM draftpc
where draftpc.Persona_idPersona =  idJugadorVal
and tempodada_idTemporada = idTemporadaVar
;

select idJugadorVal;

if idJugadorExist is null then 
  set isError = 1 ;
  set message = 'El jugador no Existe';
  
-- elseif activoVar = 0 then 
elseif (diasVar = 1 and sumaVar < horasConfir ) 
   or (diasVar = 0 and minDia_ceroVar < horasConfir )
   then
   
   if diasVar = 1 then
     set minRest = sumaVar;
   else 
      set minRest = minDia_ceroVar;
   end if;
   
  set isError = 1 ;
    set message = concat('Aun no concluye el tiempo para confirmar : ', minRest);
elseif idEquipoVar != idEquipoOferta then
  set isError = 1 ;
    set message = 'Solamente el equipo que gano al jugador puede confirmar';

elseif idEquipoExist = idEquipoVar then
  set isError = 1 ;
    set message = 'El Jugador y se confirmo';
  

elseif idJugador is not null then 
   
     UPDATE `fifaxgam_fifaxgamersbd`.`persona`
  SET
    `Equipos_idEquipo` = idEquipoVar

  WHERE `idPersona` = idJugador;
    
    UPDATE `fifaxgam_fifaxgamersbd`.`persona_has_temporada`
    SET
   `equipos_idEquipo` = idEquipoVar
   WHERE `persona_idPersona` = idJugador
   AND `temporada_idTemporada` = idTemporadaVar 
;

  
    
    set isError = 0 ;
  set message = 'OK';
    
    
end if;


END $$
DELIMITER ;