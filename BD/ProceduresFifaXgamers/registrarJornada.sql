DELIMITER $$
DROP PROCEDURE IF EXISTS registrarJornada$$
CREATE PROCEDURE registrarJornada(IN `json` JSON,
								  IN nombreTorneo varchar(200),
								  IN idTemporada INT,
                               out isError int, 
                               out message varchar(200))
BEGIN

  DECLARE `json_items` BIGINT ;
  DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Imagenes` BIGINT ;
  DECLARE `_index_Imagenes` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Jornadas` BIGINT ;
  DECLARE `_index_Jornadas` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Juegos` BIGINT ;
  DECLARE `_index_Juegos` BIGINT UNSIGNED DEFAULT 0;
  
  declare jsonGoles JSON;
  declare jsonImagenes JSON;
  declare jsonJuego    JSON;
  declare var varchar(200);
  declare cumplido varchar(100);
  declare cum int(10);
  
  declare idTorneo int;
  
  declare idEquipoJson int;
  declare numeroGrupoJson int;
  declare idjornadaVal int;
  declare idJ int;
  
  declare golesLocal int;
  declare golesVisita int;
  declare id  int;
  declare idJor int;
  
  declare idVal int;
  declare deletedVal int;
  declare isImg varchar(200) ;
  
 


  
  set isError = 1 ;
set message = 'Error al crear grupos';

select JSON_EXTRACT(`json`, "$.golesLocal") into golesLocal;
select JSON_EXTRACT(`json`, "$.golesVisita") into golesVisita;
select JSON_EXTRACT(`json`, "$.id") into id;

select JSON_EXTRACT(`json`, "$.idJornada") into idJor;


select id,idJor;




SELECT JSON_EXTRACT(`json`, "$.golesJornada") into jsonGoles ;



set `json_items` = JSON_LENGTH(jsonGoles);


  WHILE `_index` < `json_items` DO
		set cumplido = '';
        set _index_Imagenes = 0;
        set _index_Jornadas = 0;
        
        SELECT JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].id')) into idVal ;
        
        select JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].deleted')) into deletedVal;
        
		if (idVal = 0 && deletedVal != 1) then
           
        select jsonGoles;
        

           
           INSERT INTO `fifaxgamersbd`.`golesjornadas`
			(`id`,
			`persona_idPersona`,
			`numgoles`,
			`updatedate`,
			`equipos_idEquipo`,
			`jornadas_has_equipos_id`,
			`jornadas_has_equipos_jornadas_idJornada`,
			`isautogol`)
			VALUES
			(null,
			(select JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].idPersona'))),
			null,
			sysdate(),
			(select JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].idEquipo'))),
			(SELECT JSON_EXTRACT(`json`, "$.id")),
			(SELECT JSON_EXTRACT(`json`, "$.idJornada")),
			(select JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].isAutogol')))
            )
            
            ;

            
        
        end if;
        
        if (idVal != 0 && deletedVal = 1) then
          

         
         DELETE FROM `fifaxgamersbd`.`golesjornadas`
			WHERE golesjornadas.id = idVal;

           
           
            
        
        end if;
        
       -- SELECT JSON_EXTRACT(`jsonGoles`, CONCAT('$[', `_index`, '].equipos')) into jsonEquipos ;
        
        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;
  
  SELECT JSON_EXTRACT(`json`, "$.imagenes") into jsonImagenes ;
  set `json_items_Imagenes` = JSON_LENGTH(jsonImagenes);
  
  select jsonImagenes;

  WHILE `_index_Imagenes` < `json_items_Imagenes` DO
  
  
  select imgJornada into isImg
  from imagenesjornadas
  where imagenesjornadas.jornadas_has_equipos_id = (SELECT JSON_EXTRACT(`json`, "$.id"))
  and imagenesjornadas.jornadas_has_equipos_jornadas_idJornada = (SELECT JSON_EXTRACT(`json`, "$.idJornada"))
  and imgJornada = (select JSON_EXTRACT(`jsonImagenes`, CONCAT('$[', `_index_Imagenes`, '].img')))
  ;
  
  select isImg;
  if isImg is null then 
  
  select JSON_EXTRACT(`jsonImagenes`, CONCAT('$[', `_index_Imagenes`, '].img')) into isImg;
  
  

  INSERT INTO `fifaxgamersbd`.`imagenesjornadas`
	(`id`,
	`jornadas_has_equipos_id`,
	`jornadas_has_equipos_jornadas_idJornada`,
	`imgJornada`)
	VALUES
	(null,
	(SELECT JSON_EXTRACT(`json`, "$.id")),
	(SELECT JSON_EXTRACT(`json`, "$.idJornada")),
	REPLACE(isImg,'\"','')
    );

  select isImg;
  
  end if;

   set isImg = null;
  
  SET `_index_Imagenes` := `_index_Imagenes` + 1;
  END WHILE;


select count( equipos.idEquipo) goles into golesLocal
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = (SELECT JSON_EXTRACT(`json`, "$.idJornada"))
and equipos.idEquipo in ((SELECT JSON_EXTRACT(`json`, "$.idEquipoLocal")));


select count( equipos.idEquipo) goles into golesVisita
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = (SELECT JSON_EXTRACT(`json`, "$.idJornada"))
and equipos.idEquipo in ((SELECT JSON_EXTRACT(`json`, "$.idEquipoVisita")));

call updateResultadoJornada((SELECT JSON_EXTRACT(`json`, "$.idJornada")),(SELECT JSON_EXTRACT(`json`, "$.idEquipoLocal")),(SELECT JSON_EXTRACT(`json`, "$.idEquipoVisita")),golesLocal,golesVisita);
  
set isError = 0 ;
set message = 'OK';

END $$
DELIMITER ;