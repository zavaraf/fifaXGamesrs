DELIMITER $$
DROP PROCEDURE IF EXISTS createTemporada$$
CREATE PROCEDURE createTemporada( IN nombreTemporada varchar(200) , 
                                 IN descripcionTemporada varchar(200), 
                                 IN idLiga int)
BEGIN

DECLARE idTemporadaVar int;
DECLARE idTemporadaAnt int;


select idTemporada into idTemporadaVar 
from temporada
where temporada.NombreTemporada = nombreTemporada
and temporada.Liga_idLiga = idLiga;


if idTemporadaVar is null then 
INSERT INTO temporada
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

select max(temporada.idTemporada) into idTemporadaAnt
from temporada
where temporada.idTemporada != idTemporadaVar
;


INSERT INTO equipos_has_temporada
(`Equipos_idEquipo`,
`tempodada_idTemporada`,
`nombreEquipo`,
`idDivision`)
(select equipos.idEquipo, 
idTemporadaVar,
equipos_has_temporada.nombreEquipo , 
equipos_has_temporada.idDivision
from equipos
join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = equipos.idEquipo
where equipos_has_temporada.tempodada_idTemporada = idTemporadaAnt);




INSERT INTO persona_has_temporada
(`persona_idPersona`,
`temporada_idTemporada`,
`rating`,
`equipos_idEquipo`)
(select  
persona_has_temporada.persona_idPersona,
idTemporadaVar,
persona_has_temporada.rating,
persona_has_temporada.equipos_idEquipo
from persona_has_temporada
where persona_has_temporada.temporada_idTemporada = idTemporadaAnt);

INSERT INTO equipos_has_imagen
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