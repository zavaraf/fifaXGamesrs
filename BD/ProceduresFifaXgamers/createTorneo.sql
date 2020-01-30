DELIMITER $$
DROP PROCEDURE IF EXISTS createTemporada$$
CREATE PROCEDURE createTemporada( IN nombreTemporada varchar(200) , IN descripcionTemporada varchar(200))
BEGIN

DECLARE idTemporadaVar int;

INSERT INTO `fifaxgamersbd`.`temporada`
(
`NombreTemporada`,
`Descripcion`)
VALUES
(
NombreTemporada,
descripcionTemporada);

select idTemporada into idTemporadaVar
from temporada
order by temporada.idTemporada desc
limit 1;

INSERT INTO `fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`Temporadas_idTemporada`)
(select idEquipo,idTemporadaVar 
from equipos);



END $$
DELIMITER ;