DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateDatosFinancieros$$
CREATE PROCEDURE createOrUpdateDatosFinancieros(IN idDatos INT, IN monto INT,IN idEquipo INT)
BEGIN

DECLARE idTemporadaVar int;
DECLARE idDatosVar  int;
DECLARE isUpdate  int;

select idTemporada into idTemporadaVar
from temporada
order by temporada.idTemporada desc
limit 1;


select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 

and datos.Temporadas_idTemporada = idTemporadaVar
limit 1
;



select con.idConceptosFinancieros into isUpdate
from conceptosfinancieros con
where con.CatalogoConceptos_idCatalogoConceptos = idDatos
and con.DatosFinancieros_idDatosFinancieros = idDatosVar
and con.DatosFinancieros_Equipos_idEquipo = idEquipo

and con.DatosFinancieros_Temporadas_idTemporada = idTemporadaVar;

	IF isUpdate is null or isUpdate = 0  then


	INSERT INTO `fifaxgamersbd`.`conceptosfinancieros`
		(`idConceptosFinancieros`,
		`DatosFinancieros_idDatosFinancieros`,
		`monto`,
		`CatalogoConceptos_idCatalogoConceptos`,
        `DatosFinancieros_Equipos_idEquipo`,
        
        `DatosFinancieros_Temporadas_idTemporada`)
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
		
		and `DatosFinancieros_Temporadas_idTemporada` = idTemporadaVar;

	
	END IF;



END $$
DELIMITER ;