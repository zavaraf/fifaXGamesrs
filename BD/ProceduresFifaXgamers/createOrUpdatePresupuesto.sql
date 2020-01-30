DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdatePresupuesto$$
CREATE PROCEDURE createOrUpdatePresupuesto(IN idEquipo INT,  IN monto INT, IN montoFinal INT,
										  IN montoFinalSponsor INT,
                                          IN idTemporada INT)
BEGIN

DECLARE idTemporadaVar int;
DECLARE idDatosVar  int;
DECLARE isUpdate  int;


set idTemporadaVar = idTemporada;

select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 
and datos.Temporadas_idTemporada = idTemporadaVar;



if idDatosVar is null then 

INSERT INTO `fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`Temporadas_idTemporada`,
`sponsorOpcional`,
`presupuestoFinalSponsor`)
VALUES
(1,
monto,
montoFinal,
idEquipo,
idTemporadaVar,
0,
montoFinalSponsor);

else

UPDATE `fifaxgamersbd`.`datosfinancieros`
SET

`presupuestoInicial` = monto,
`presupuestoFinal` = montoFinal,
`presupuestoFinalSponsor` = montoFinalSponsor

WHERE `idDatosFinancieros` = idDatosVar 
AND `Equipos_idEquipo` = idEquipo

AND `Temporadas_idTemporada` = idTemporadaVar;

end if;

END $$
DELIMITER ;