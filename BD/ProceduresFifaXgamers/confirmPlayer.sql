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

SELECT timestampdiff(Minute, fechaCompra, now()) >= horasConfir as activo INTO activoVar
FROM draftpc
where draftpc.Persona_idPersona =  idJugadorVal
and tempodada_idTemporada = idTemporadaVar
;

select idJugadorVal;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';
  
elseif activoVar = 0 then 
	set isError = 1 ;
    set message = 'Aun no concluye el tiempo para confirmar';
elseif idEquipoVar != idEquipoOferta then
	set isError = 1 ;
    set message = 'Solamente el equipo que gano al jugador puede confirmar';

elseif idEquipoExist = idEquipoVar then
	set isError = 1 ;
    set message = 'El Jugador y se confirmo';
	

elseif idJugador is not null then 
	 
     UPDATE `fifaxgamersbd`.`persona`
	SET
	  `Equipos_idEquipo` = idEquipoVar

	WHERE `idPersona` = idJugador;
    
    UPDATE `fifaxgamersbd`.`persona_has_temporada`
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