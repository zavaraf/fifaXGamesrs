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



END $$
DELIMITER ;