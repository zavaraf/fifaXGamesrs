DELIMITER $$
DROP PROCEDURE IF EXISTS delJuegoJornada$$
CREATE PROCEDURE delJuegoJornada ( in idJuego int,
								out isError int, 
                                out message varchar(200))
BEGIN



delete from jornadas_has_equipos where jornadas_has_equipos.id = idJuego;

set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;