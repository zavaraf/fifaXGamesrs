DELIMITER $$
DROP PROCEDURE IF EXISTS modificarJugador$$
CREATE PROCEDURE modificarJugador (IN nombreCompleto varchar(200) , 
								   IN sobrenonbre varchar(200),
                                   IN raiting INT,
                                   IN idEquipo INT, 
                                   IN idJugador INT,
                                   IN link varchar(300),
                                   IN idTemporada INT
                                   )
BEGIN

declare  idEquipoVar int;


update persona set persona.NombreCompleto = nombreCompleto,
                   persona.sobrenombre = sobrenonbre,
                   persona.Raiting = raiting,
                   persona.Equipos_idEquipo = idEquipo,
                   persona.link = link
where persona.idPersona = idJugador;

select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.Temporadas_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO `fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`Temporadas_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 
 end if ;
       

END $$
DELIMITER ;