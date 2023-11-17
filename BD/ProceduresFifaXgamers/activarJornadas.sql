DELIMITER $$
DROP PROCEDURE IF EXISTS activarJornadas$$
CREATE PROCEDURE activarJornadas (out isError int, 
                                out message varchar(200))
BEGIN



update jornadas
set activa = 1
where jornadas.fechaInicio <= DATE_SUB(now(), INTERVAL 1 HOUR) and jornadas.activa = 0
and jornadas.idJornada > 0;

update jornadas
set cerrada = 1
where jornadas.fechaFin <= DATE_SUB(now(), INTERVAL 1 HOUR) and jornadas.cerrada = 0
and jornadas.idJornada > 0;

update jornadas
set activa = 1,
 cerrada = 0
where jornadas.fechaFin > DATE_SUB(now(), INTERVAL 1 HOUR) and cerrada = 1
and jornadas.idJornada > 0;

set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;