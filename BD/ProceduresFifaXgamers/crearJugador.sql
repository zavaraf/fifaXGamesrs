DELIMITER $$
DROP PROCEDURE IF EXISTS crearJugador$$
CREATE PROCEDURE `crearJugador`(IN nombreCompleto varchar(200) , 
							   IN sobrenonbre varchar(200),
                               IN raiting INT,
                               IN idEquipo INT,
                               IN link varchar(200),
                               IN idsofifa INT,
                               IN idTemporada INT,
                               IN img varchar(200)
                               )
BEGIN

DECLARE idEquipoVar INT;

INSERT INTO persona
(`idPersona`,
`NombreCompleto`,
`sobrenombre`,
`fehaNacimiento`,
`Raiting`,
`potencial`,
`Equipos_idEquipo`,
`activo`,
`link`,
`idsofifa`,
`img`)    

VALUES
(null,
        nombreCompleto,
		sobrenonbre,
        null,
        raiting,
        0,
        idEquipo,
        1,
        link,
        idsofifa,
        img
	    );
    
        
INSERT INTO persona_has_roles
(`Persona_idPersona`,
`Roles_idRoles`)
VALUES
((SELECT persona.idPersona
FROM persona
ORDER by persona.idPersona DESC limit 1),
1);





select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.tempodada_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO equipos_has_temporada
(`Equipos_idEquipo`,
`Temporadas_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 
 end if ;
 
 INSERT INTO persona_has_temporada
(`persona_idPersona`,
`temporada_idTemporada`,
`rating`,
`equipos_idEquipo`)
VALUES
((SELECT persona.idPersona
FROM persona
ORDER by persona.idPersona DESC limit 1),
idTemporada,
raiting,
idEquipo);


        

END $$
DELIMITER ;