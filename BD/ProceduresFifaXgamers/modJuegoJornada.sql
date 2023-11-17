DELIMITER $$
DROP PROCEDURE IF EXISTS modJuegoJornada$$
CREATE PROCEDURE modJuegoJornada ( in idJuego int,
								in idEquipoLocal int,
                                in idEquipoVisita int,
								out isError int, 
                                out message varchar(200))
BEGIN



update jornadas_has_equipos 
set jornadas_has_equipos.equipos_idEquipoLocal = idEquipoLocal,
jornadas_has_equipos.equipos_idEquipoVisita = idEquipoVisita
where jornadas_has_equipos.id = idJuego;

select jornadas_has_equipos.equipos_idEquipoLocal, equipos_idEquipoVisita
from jornadas_has_equipos
where jornadas_has_equipos.id = idJuego;

set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;