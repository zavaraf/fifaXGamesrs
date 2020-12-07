DELIMITER $$
DROP PROCEDURE IF EXISTS createTemporada$$
CREATE PROCEDURE createTemporada( IN nombreTemporada varchar(200) , IN descripcionTemporada varchar(200), IN idLiga int)
BEGIN

DECLARE idTemporadaVar int;


select idTemporada into idTemporadaVar 
from temporada
where temporada.NombreTemporada = nombreTemporada
and temporada.Liga_idLiga = idLiga;


if idTemporadaVar is null then 
INSERT INTO `fifaxgamersbd`.`temporada`
(
`NombreTemporada`,
`Descripcion`,
`Liga_idLiga`)
VALUES
(
NombreTemporada,
descripcionTemporada,
idLiga);

select idTemporada into idTemporadaVar 
from temporada
where temporada.NombreTemporada = nombreTemporada
and temporada.Liga_idLiga = idLiga;

end if;



INSERT INTO `fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`tempodada_idTemporada`)
(select idEquipo,idTemporadaVar 
from equipos);


INSERT INTO `fifaxgamersbd`.`persona_has_temporada`
(`persona_idPersona`,
`temporada_idTemporada`,
`rating`,
`equipos_idEquipo`)
(select 
persona.idPersona,
idTemporadaVar, 
persona.raiting,
persona.Equipos_idEquipo 
from persona);

INSERT INTO `fifaxgamersbd`.`equipos_has_imagen`
(`equipos_idEquipo`,
`tipoImagen_idTipoImagen`,
`imagen`,
`idTemporada`)

(SELECT equipos_idEquipo,
    equipos_has_imagen.tipoImagen_idTipoImagen,
    equipos_has_imagen.imagen,
    idTemporadaVar
FROM equipos_has_imagen
where equipos_has_imagen.idTemporada = (select max(idTemporada) from equipos_has_imagen
where equipos_has_imagen.idTemporada != (select max(idTemporada) from temporada))
);





END $$
DELIMITER ;