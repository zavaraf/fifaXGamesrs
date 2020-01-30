DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateDatosSponsor$$
CREATE PROCEDURE createOrUpdateDatosSponsor(IN idEquipo INT, IN idSponsor INT, IN opcionales INT)
BEGIN

DECLARE idTemporadaVar int;
DECLARE idDatosVar  int;

select idTemporada into idTemporadaVar
from temporada
order by temporada.idTemporada desc
limit 1;

select idTemporadaVar;

select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 
and datos.Temporadas_idTemporada = idTemporadaVar
limit 1
;

select idDatosVar;

IF idTemporadaVar is not null  and idDatosVar is null then
   INSERT INTO `fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`Temporadas_idTemporada`,
`sponsorOpcional`)
VALUES
(1,
0,
0,
idEquipo,
idTemporadaVar,
opcionales);

elseif idDatosVar is not null then

UPDATE `fifaxgamersbd`.`datosfinancieros`
SET 
`sponsorOpcional` = opcionales
WHERE  `Equipos_idEquipo` = idEquipo
AND `Temporadas_idTemporada` = idTemporadaVar;


END IF;

	IF opcionales = 0 then 
    
    INSERT INTO `fifaxgamersbd`.`dadosfinancierossponsor`
	(`DatosFinancieros_idDatosFinancieros`,
	`DatosFinancieros_Equipos_idEquipo`,
	`DatosFinancieros_Temporadas_idTemporada`,
	`Sponsor_idSponsor`,
	`ConceptoSponsor_idConcepto`,
	`cumplio`)
	select 1,idEquipo,idTemporadaVar,idSponsor,cons.idConcepto,0
			from sponsor
			join sponsor_has_concepto sponc on sponsor.idSponsor = sponc.Sponsor_idSponsor
			join conceptosponsor cons on sponc.Concepto_idConcepto = cons.idConcepto
			where sponsor.idSponsor = idSponsor
			and cons.opcional = opcionales;

        
	ELSEIF opcionales = 1 then
		INSERT INTO `fifaxgamersbd`.`dadosfinancierossponsor`
			(`DatosFinancieros_idDatosFinancieros`,
			`DatosFinancieros_Equipos_idEquipo`,
			`DatosFinancieros_Temporadas_idTemporada`,
			`Sponsor_idSponsor`,
			`ConceptoSponsor_idConcepto`,
			`cumplio`)
		select 1,idEquipo,idTemporadaVar,idSponsor,cons.idConcepto,0
        from sponsor
        join sponsor_has_concepto sponc on sponsor.idSponsor = sponc.Sponsor_idSponsor
		join conceptosponsor cons on sponc.Concepto_idConcepto = cons.idConcepto
		where sponsor.idSponsor = idSponsor
		;
	END IF;



END $$
DELIMITER ;