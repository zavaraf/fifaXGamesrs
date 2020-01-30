DELIMITER $$
DROP PROCEDURE IF EXISTS createOrTorneoGrupos$$
CREATE PROCEDURE createOrTorneoGrupos(IN `json` JSON,
									  IN nombreTorneo varchar(200),
									 IN idTemporada INT,
                               out isError int, 
                               out message varchar(200))
BEGIN

  DECLARE `json_items` BIGINT UNSIGNED DEFAULT JSON_LENGTH(`json`);
  DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Equipos` BIGINT ;
  DECLARE `_index_Equipos` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Jornadas` BIGINT ;
  DECLARE `_index_Jornadas` BIGINT UNSIGNED DEFAULT 0;
  
  DECLARE `json_items_Juegos` BIGINT ;
  DECLARE `_index_Juegos` BIGINT UNSIGNED DEFAULT 0;
  
  declare jsonEquipos JSON;
  declare jsonJornadas JSON;
  declare jsonJuego    JSON;
  declare var varchar(200);
  declare cumplido varchar(100);
  declare cum int(10);
  
  declare idTorneo int;
  
  declare idEquipoJson int;
  declare numeroGrupoJson int;
  declare idjornadaVal int;
  declare idJ int;
  
  
  set isError = 1 ;
set message = 'Error al crear grupos';
  
-- call crearTorneo(nombreTorneo,idTemporada,2,@iserr,@ip);

select torneo.idtorneo into idTorneo
from torneo
where torneo.nombreTorneo = nombreTorneo;

if idTorneo is null then 
  call crearTorneo(nombreTorneo,idTemporada,2,@iserr,@ip);
  
  select torneo.idtorneo into idTorneo
	from torneo
	where torneo.nombreTorneo = nombreTorneo;


end if;



  WHILE `_index` < `json_items` DO
		set cumplido = '';
        set _index_Equipos = 0;
        set _index_Jornadas = 0;
		select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].numero')) into var;
        
      
        
        SELECT JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].equipos')) into jsonEquipos ;
        
         -- select jsonEquipos;
        
        set `json_items_Equipos` = JSON_LENGTH(jsonEquipos);
        
        
        
        WHILE `_index_Equipos` < `json_items_Equipos` DO
        
       -- select _index_Equipos,json_items_Equipos, jsonEquipos,idTorneo;
        
        
        select JSON_EXTRACT(`jsonEquipos`, CONCAT('$[', `_index_Equipos`, '].id')) into idEquipoJson;
        
      
        
        
                INSERT INTO `fifaxgamersbd`.`grupos_torneo`
				(`torneo_idtorneo`,
				`equipos_idEquipo`,
				`nombreGrupo`)
				VALUES
				(idTorneo,
				idEquipoJson,
				var);

        
        SET `_index_Equipos` := `_index_Equipos` + 1;
        
        END WHILE;
        
        
        
        SELECT JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].jornadas')) into jsonJornadas ;
        
        
         -- select jsonEquipos;
        
        set `json_items_Jornadas` = JSON_LENGTH(jsonJornadas);
        
        
        
        WHILE `_index_Jornadas` < `json_items_Jornadas` DO
        
        set idjornadaVal = null;
        set _index_Juegos = 0;
			
			select jornadas.idJornada into idjornadaVal
			from jornadas
			where jornadas.numeroJornada = (SELECT JSON_EXTRACT(`jsonJornadas`, CONCAT('$[', `_index_Jornadas`, '].numeroJornada')))
			and jornadas.torneo_idtorneo = idTorneo;

				if idjornadaVal is null then
							INSERT INTO `fifaxgamersbd`.`jornadas`
							(`idJornada`,
							`division_idDivision`,
							`numeroJornada`,
							`activa`,
							`cerrada`,
							`nombreJornada`,
							`torneo_idtorneo`)
							VALUES
							(null,
							null,
							(SELECT JSON_EXTRACT(`jsonJornadas`, CONCAT('$[', `_index_Jornadas`, '].numeroJornada'))),
							1,
							0,
							'',
							idTorneo
							);
				end if;
				
				
                
        
       -- select _index_Equipos,json_items_Equipos, jsonEquipos,idTorneo; jsonJuego
        SELECT JSON_EXTRACT(`jsonJornadas`, CONCAT('$[', `_index_Jornadas`, '].jornada')) into jsonJuego ;
        
		 set `json_items_Juegos` = JSON_LENGTH(jsonJuego);
        
			WHILE `_index_Juegos` < `json_items_Juegos` DO
            set idJ =  null;
            set idjornadaVal = null;
				
                select jornadas.idJornada into idjornadaVal
				from jornadas
				where jornadas.numeroJornada = (SELECT JSON_EXTRACT(`jsonJornadas`, CONCAT('$[', `_index_Jornadas`, '].numeroJornada')))
				and jornadas.torneo_idtorneo = idTorneo;
					
                select (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) ) idEquipoLocal,
                (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') ) ) idEquipoVisita;
                
					select hje.id into idJ
					from jornadas_has_equipos hje
					where 
					hje.equipos_idEquipoLocal = (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) )
					and hje.equipos_idEquipoVisita = (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') ))
					and hje.jornadas_idJornada = idjornadaVal;

				-- if idJ is null then 

						INSERT INTO `fifaxgamersbd`.`jornadas_has_equipos`
						(`id`,
						`jornadas_idJornada`,
						`equipos_idEquipoLocal`,
						`equipos_idEquipoVisita`)
						VALUES
						(null,
						idjornadaVal,
						(SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) ) ,
						(SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') ))
						);

				-- 	end if;
				
				
				
			 SET `_index_Juegos` := `_index_Juegos` + 1;
			
			END WHILE;
        
        
     
       
        
        SET `_index_Jornadas` := `_index_Jornadas` + 1;
        
        END WHILE;
        
       
        
    -- select _index,_index_Equipos;
        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;

  
set isError = 0 ;
set message = 'OK';

END $$
DELIMITER ;