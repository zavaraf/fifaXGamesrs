DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateCastigo$$
CREATE PROCEDURE createOrUpdateCastigo ( IN id int,
							   IN idEquipo int ,
							   IN idTemporada int , 
                               IN valor int,
                               IN observaciones varchar(450),
                               IN tipo varchar(45),
                               IN idTorneo int,
                               out isError int, 
                               out message varchar(200)
                            )
BEGIN



set isError = 1 ;
set message = 'No se pudo agregar';


if (id is  null or id = 0 ) then 

INSERT INTO castigos
(`idcastigos`,
`idEquipo`,
`idTemporada`,
`observaciones`,
`valor`,
`tipo`,
`torneo_idtorneo`)
VALUES
(null,
idEquipo,
idTemporada,
observaciones,
valor,
tipo,
idTorneo);

else

UPDATE castigos
SET
`observaciones` = observaciones,
`valor` = valor,
`tipo` = tipo 
WHERE `idcastigos` = id 
AND `idEquipo` = idEquipo
AND `idTemporada` = idTemporada
and castigos.torneo_idtorneo = idTorneo;


end if;

set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;