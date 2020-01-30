DELIMITER $$
DROP PROCEDURE IF EXISTS addImagen$$
CREATE PROCEDURE addImagen (IN idJornada int ,
							   IN id int , 
                               IN idEquipo int,
                               IN img varchar(300),
                               out isError int, 
                               out message varchar(200)
                            )
BEGIN


set isError = 1 ;
set message = 'No se pudo agregar';

if img is not null and img !='' then
INSERT INTO `fifaxgamersbd`.`imagenesjornadas`
(`id`,
`jornadas_has_equipos_id`,
`jornadas_has_equipos_jornadas_idJornada`,
`imgJornada`)
VALUES
(null,
id,
idJornada,
img);



set isError = 0 ;
set message = 'OK';

end if;

END $$
DELIMITER ;