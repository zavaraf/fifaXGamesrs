DELIMITER $$
DROP PROCEDURE IF EXISTS modificarJugador$$
C PROCEDURE `modificarJugador`(IN nombreCompleto varchar(200) , 
								   IN sobrenonbre varchar(200),
                                   IN raiting INT,
                                   IN idEquipo INT, 
                                   IN idJugador INT,
                                   IN link varchar(300),
                                   IN idsofifa INT,
                                   IN idTemporada INT
                                   )
BEGIN

declare  idEquipoVar int;


update persona set persona.NombreCompleto = nombreCompleto,
                   persona.sobrenombre = sobrenonbre,
                 --  persona.Raiting = raiting,
                   persona.Equipos_idEquipo = idEquipo,
                   persona.link = link,
                   persona.idsofifa = idsofifa
where persona.idPersona = idJugador;

UPDATE persona_has_temporada
SET
`rating` = raiting,
`equipos_idEquipo` = idEquipo
WHERE `persona_idPersona` = idJugador
AND `temporada_idTemporada` = idTemporada
;



select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.tempodada_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO equipos_has_temporada
(`Equipos_idEquipo`,
`Temporada_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 
 end if ;
       

END $$
DELIMITER ;