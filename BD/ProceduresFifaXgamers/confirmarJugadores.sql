DELIMITER $$
DROP PROCEDURE IF EXISTS confirmarJugadores$$
CREATE PROCEDURE confirmarJugadores(IN `json` JSON ,
								IN idTemporada int,
								out isError int, 
                                out message varchar(200))
BEGIN


DECLARE `json_items` BIGINT UNSIGNED DEFAULT JSON_LENGTH(`json`);
DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;

DECLARE `json_items_jugador` BIGINT ;
DECLARE `_index_Jugadpr` BIGINT UNSIGNED DEFAULT 0;


DECLARE idVal INT;
DECLARE idPersonaVal INT;

DECLARE count_update INT;
DECLARE count_insert INT;

declare idsofifa_json int;
declare Name_json varchar(300);
declare Overall_json int;
declare Potential_json int;
declare URL_json varchar(300);
declare Imagen_json varchar(300);

set count_update = 0;
set count_insert = 0;

set isError = 1 ;
set message = 'Error al Fase final';

WHILE `_index` < `json_items` DO

set idVal = null;
set idPersonaVal = null;

set idsofifa_json = (  select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].ID'))  );
set Name_json = replace( (  select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].Name'))),'"',''  );
set Overall_json = (  select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].Overall'))  );
set Potential_json = (  select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].Potential'))  );
set URL_json = CONCAT( 'https://sofifa.com' , replace((select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].Url'))  ),'"','')  );
set Imagen_json = replace((  select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].Imagen'))  ) ,'"','');


select persona.idPersona into idVal
from persona 
where persona.idsofifa = idsofifa_json
limit 1;

	if(idVal is null ) then 
    
    
		INSERT INTO `persona`
		(`idPersona`,
		`nombre`,
		`apellidoPaterno`,
		`apellidoMaterno`,
		`NombreCompleto`,
		`sobrenombre`,
		`fehaNacimiento`,
		`raiting`,
		`potencial`,
		`Equipos_idEquipo`,
		`activo`,
		`userManager`,
		`prestamo`,
		`link`,
		`idsofifa`,
		`img`)
		VALUES
		(null,
		null,
		null,
		null,
		Name_json,
		Name_json,
		null,
		Overall_json,
		Potential_json,
		1,
		1,
		null,
		null,
		URL_json,
		idsofifa_json,
		Imagen_json);

        select persona.idPersona into idPersonaVal
		from persona 
		where persona.idsofifa = idsofifa_json
        limit 1;
    
       INSERT INTO `fifaxgamersbd`.`persona_has_temporada`
			   (`persona_idPersona`,
				`temporada_idTemporada`,
				`rating`,
				`equipos_idEquipo`,
				`costo`,
				`updateDate`,
				`idEquipoPago`)
				VALUES
				(idPersonaVal,
				idTemporada,
				Overall_json,
				1,
				null,
				null,
				null);
                
                set count_insert := count_insert +1;


	else 
    
    UPDATE `persona`
		SET
-- 		`NombreCompleto` = Name_json,
-- 		`sobrenombre` = Name_json,		
		`raiting` = Overall_json,
		`potencial` = Potential_json,		
		`link` = URL_json,
		`idsofifa` = idsofifa_json,
		`img` = Imagen_json        
		WHERE `idPersona` = idVal;
        
    
       
	 UPDATE `fifaxgamersbd`.`persona_has_temporada`
		SET
		`rating` = Overall_json
	
		WHERE `persona_idPersona` = idVal 
        AND `temporada_idTemporada` = idTemporada ;

        set count_update := count_update +1;
    end if;
    
    
    
    
    


SET `_index` := `_index` + 1;
END WHILE;


set isError = 0 ;
set message = CONCAT( 'OK' , ' insertados:' ,count_insert, '  modificados:',count_update);

END $$
DELIMITER ;