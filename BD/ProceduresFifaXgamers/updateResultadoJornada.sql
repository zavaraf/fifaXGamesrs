DELIMITER $$
DROP PROCEDURE IF EXISTS updateResultadoJornada$$
CREATE PROCEDURE updateResultadoJornada (IN idJornada int ,
							   IN equipoLocal int , 
                               IN equipoVisita int,
                               IN golesLocal int,
                               in golesVisita int)
BEGIN


DECLARE jornadaVal int;
DECLARE idjornadaVal int;



select jhe.id into jornadaVal
from jornadas_has_equipos jhe
where jhe.jornadas_idJornada = idJornada
and jhe.equipos_idEquipoLocal = equipoLocal
and jhe.equipos_idEquipoVisita = equipoVisita
;

UPDATE `fifaxgamersbd`.`jornadas_has_equipos`
SET
`golesLocal` = golesLocal,
`golesVisita` = golesVisita
WHERE `id` = jornadaVal
AND `jornadas_idJornada` = idJornada
;


END $$
DELIMITER ;