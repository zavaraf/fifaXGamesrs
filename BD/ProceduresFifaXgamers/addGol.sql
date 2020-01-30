DELIMITER $$
DROP PROCEDURE IF EXISTS addGoles$$
CREATE PROCEDURE addGoles (IN idJornada int ,
							   IN id int , 
                               IN idJugador int,
                               IN idEquipo int,
                               out isError int, 
                               out message varchar(200)
                            )
BEGIN


DECLARE jornadaVal int;
DECLARE idjornadaVal int;
DECLARE golesLocal int;
DECLARE golesVisita int;
declare equipoLocal int;
declare equipoVisita int;
declare isAutogol int;
declare idEquipoJugador int;




set isError = 1 ;
set message = 'No se pudo agregar';

select Equipos_idEquipo into idEquipoJugador
from persona
where idPersona = idJugador
;

set isAutogol = 0;

if idEquipoJugador != idEquipo then 
	set isAutogol = 1;
end if;


INSERT INTO `fifaxgamersbd`.`golesjornadas`
(`id`,
`persona_idPersona`,
`updatedate`,
`equipos_idEquipo`,
`jornadas_has_equipos_id`,
`jornadas_has_equipos_jornadas_idJornada`,
`isautogol`
)
VALUES
(null,
idJugador,
sysdate(),
idEquipo,
id,
idJornada,
isAutogol
);

select jhe.equipos_idEquipoLocal ,jhe.equipos_idEquipoVisita into equipoLocal, equipoVisita
from jornadas_has_equipos jhe 
where jhe.jornadas_idJornada = idJornada
and jhe.id = id;



select count( equipos.idEquipo) goles into golesLocal
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = idJornada
and equipos.idEquipo in (equipoLocal);


select count( equipos.idEquipo) goles into golesVisita
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = idJornada
and equipos.idEquipo in (equipoVisita);

call updateResultadoJornada(idJornada,equipoLocal,equipoVisita,golesLocal,golesVisita);




set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;