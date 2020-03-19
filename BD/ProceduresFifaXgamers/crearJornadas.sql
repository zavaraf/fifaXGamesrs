DELIMITER $$
DROP PROCEDURE IF EXISTS crearJornada$$
CREATE PROCEDURE crearJornada (IN equipoLocal int , 
                               IN equipoVisita int,
							   IN numJornada INT,
                               IN torneo INT,
                               IN division int,
                               IN liga int,
                               IN activa int,
                               IN cerrada int,
                               IN id int,
                               out isError int, 
                               out message varchar(200))
BEGIN

-- Opcion 1, crear jornadas, opcion 2 activar Jornadas

DECLARE jornadaVal int;
DECLARE idjornadaVal int;
DECLARE idjornadaValInsert int;
declare idJ int;
declare tipoTorneo int;


set isError = 1 ;
set message = 'El jugador no Existe';


select equipos.Division_idDivision into division
from equipos where equipos.idEquipo = equipoLocal;

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo
and jornadas.division_idDivision = division;

select torneo.tipoTorneo_idtipoTorneo into tipoTorneo
from torneo
where torneo.idtorneo = torneo;

if tipoTorneo = 2 then 

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo;

UPDATE `fifaxgamersbd`.`jornadas`
SET
`activa` = activa,
`cerrada` = cerrada

WHERE `idJornada` = idjornadaVal AND `torneo_idtorneo` = torneo;


else if idjornadaVal is null then

INSERT INTO `fifaxgamersbd`.`jornadas`
(`idJornada`,
`division_idDivision`,
`numeroJornada`,
`activa`,
`cerrada`,
`nombreJornada`,
`torneo_idtorneo`)
VALUES
(null,
division,
numJornada,
activa,
cerrada,
'',
torneo
);



else if idjornadaVal is not null then

UPDATE `fifaxgamersbd`.`jornadas`
SET
`activa` = activa,
`cerrada` = cerrada

WHERE `idJornada` = idjornadaVal AND `torneo_idtorneo` = torneo;
end if;


end if;

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo
and jornadas.division_idDivision = division;


select hje.id into idJ
from jornadas_has_equipos hje
where hje.id = id 
and hje.equipos_idEquipoLocal = equipoLocal
and hje.equipos_idEquipoVisita = equipoVisita
and hje.jornadas_idJornada = idjornadaVal;

if idJ is null then 

INSERT INTO `fifaxgamersbd`.`jornadas_has_equipos`
(`id`,
`jornadas_idJornada`,
`equipos_idEquipoLocal`,
`equipos_idEquipoVisita`)
VALUES
(null,
idjornadaVal,
equipoLocal,
equipoVisita);

end if;

end if;
set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;