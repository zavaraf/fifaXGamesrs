DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateDatosFinancieros$$
CREATE PROCEDURE createOrUpdateDatosFinancieros(IN idDatos INT, 
											    IN monto INT, 
                                                IN idEquipo INT,
                                                IN idTemporada INT)
BEGIN

DECLARE idTemporadaVar int;
DECLARE idDatosVar  int;
DECLARE isUpdate  int;

SET idTemporadaVar = idTemporada;


select idDatosFinancieros INTO idDatosVar
from datosfinancieros 
where datosfinancieros.Equipos_idEquipo = idEquipo 

and datosfinancieros.tempodada_idTemporada = idTemporadaVar
limit 1
;



select con.idConceptosFinancieros into isUpdate
from conceptosfinancieros con
where con.CatalogoConceptos_idCatalogoConceptos = idDatos
and con.DatosFinancieros_idDatosFinancieros = idDatosVar
and con.DatosFinancieros_Equipos_idEquipo = idEquipo

and con.datosfinancieros_tempodada_idTemporada = idTemporadaVar;

	IF isUpdate is null or isUpdate = 0  then


	INSERT INTO `fifaxgamersbd`.`conceptosfinancieros`
		(`idConceptosFinancieros`,
		`DatosFinancieros_idDatosFinancieros`,
		`monto`,
		`CatalogoConceptos_idCatalogoConceptos`,
        `DatosFinancieros_Equipos_idEquipo`,
        
        `datosfinancieros_tempodada_idTemporada`)
		VALUES
		(null,
        idDatosVar,
		monto,
		idDatos,
        idEquipo,
        
        idTemporadaVar);
    
    elseif isUpdate is not null then
    
		UPDATE `fifaxgamersbd`.`conceptosfinancieros`
		SET	`monto` = monto
		WHERE `idConceptosFinancieros` = isUpdate 
		AND `DatosFinancieros_idDatosFinancieros` = idDatosVar 
		AND `CatalogoConceptos_idCatalogoConceptos` = idDatos
        and `DatosFinancieros_Equipos_idEquipo` = idEquipo
		
		and `datosfinancieros_tempodada_idTemporada` = idTemporadaVar;

	
	END IF;



END $$
DELIMITER ;