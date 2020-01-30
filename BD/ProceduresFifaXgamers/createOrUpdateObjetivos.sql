DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateObjetivos$$
CREATE PROCEDURE createOrUpdateObjetivos(IN `json` JSON,IN idEquipo INT, IN idSponsor INT,IN idTemporada INT)
BEGIN

DECLARE `json_items` BIGINT UNSIGNED DEFAULT JSON_LENGTH(`json`);
  DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;
  declare var varchar(200);
  declare cumplido varchar(100);
  declare cum int(10);
  
  select _index;
  

  WHILE `_index` < `json_items` DO
		set cumplido = '';
		select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].id')) into var;
        select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].cumplido')) into cumplido;
        
        select var, cumplido;
        
        IF cumplido = 'true' then
		
			set cum = 1;
		
        ELSEIF cumplido = 'false' then
        
			set cum = 0;
            
        end if;
        
        
        UPDATE `fifaxgamersbd`.`dadosfinancierossponsor`
		SET
		`cumplio` = cum
		WHERE `DatosFinancieros_idDatosFinancieros` = 1
        AND `DatosFinancieros_Equipos_idEquipo` = idEquipo
        AND `DatosFinancieros_Temporadas_idTemporada` = idTemporada
        AND `Sponsor_idSponsor` = idSponsor
        AND `ConceptoSponsor_idConcepto` = var;

        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;

  


END $$
DELIMITER ;