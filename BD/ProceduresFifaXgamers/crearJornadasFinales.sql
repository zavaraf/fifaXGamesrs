DELIMITER $$
DROP PROCEDURE IF EXISTS crearJornadasFinales$$
CREATE PROCEDURE crearJornadasFinales(IN `json` JSON ,IN idTorneo int, IN idTemporada int,
								out isError int, 
                                out message varchar(200))
BEGIN


DECLARE `json_items` BIGINT UNSIGNED DEFAULT JSON_LENGTH(`json`);
DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;

DECLARE `json_items_Juegos` BIGINT ;
DECLARE `_index_Juegos` BIGINT UNSIGNED DEFAULT 0;



declare jsonJuegos JSON;
declare existJornada int;
declare numeroJornadaVar int;
declare jornadaVal int;
declare idJuego int;
declare nombreJornadaVal varchar(100);


set isError = 1 ;
set message = 'Error al Fase final';

WHILE `_index` < `json_items` DO
set nombreJornadaVal = null;
set numeroJornadaVar = null;
set numeroJornadaVar = null;
set jornadaVal = null;
set _index_Juegos = 0;



	if((select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].numeroJornada')) ) = 0) then 
    
    
    
    set nombreJornadaVal = (select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].nombreJornada')) );
    
    set nombreJornadaVal = replace(nombreJornadaVal,'"','');
    
    
    
		select jornadas.idJornada, jornadas.numeroJornada into jornadaVal, numeroJornadaVar
        from jornadas 
        where jornadas.tipoJornada = (select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].tipoJornada')) )
        and jornadas.nombreJornada = nombreJornadaVal
        and jornadas.torneo_idtorneo = idTorneo;
        
        if(jornadaVal is null) then 
			select max(jornadas.numeroJornada) into numeroJornadaVar
			from jornadas
			where jornadas.torneo_idtorneo = idTorneo;
            
            set numeroJornadaVar = numeroJornadaVar +1;
            
            INSERT INTO `fifaxgamersbd`.`jornadas`
				(`idJornada`,
				`division_idDivision`,
				`numeroJornada`,
				`activa`,
				`cerrada`,
				`nombreJornada`,
				`torneo_idtorneo`,
				`tipoJornada`)
				VALUES
				(null,
				null,
				numeroJornadaVar,
				1,
				0,
				nombreJornadaVal,
				idTorneo,
				(select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].tipoJornada')) )
                );
                
			select jornadas.idJornada, jornadas.numeroJornada into jornadaVal, numeroJornadaVar
			from jornadas 
			where jornadas.tipoJornada = (select JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].tipoJornada')) )
			and jornadas.nombreJornada = nombreJornadaVal
			and jornadas.torneo_idtorneo = idTorneo;

            
        end if;
        
        select nombreJornadaVal,idTorneo,jornadaVal, numeroJornadaVar;
        
        SELECT JSON_EXTRACT(`json`, CONCAT('$[', `_index`, '].jornada')) into jsonJuegos ;
        
        set `json_items_Juegos` = JSON_LENGTH(jsonJuegos);
        
        WHILE `_index_Juegos` < `json_items_Juegos` DO
        
			set idJuego = null;
        
			select jhe.id into idJuego 
			from jornadas_has_equipos jhe
			where jhe.jornadas_idJornada = jornadaVal
			and jhe.equipos_idEquipoLocal = (select JSON_EXTRACT(`jsonJuegos`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal')) )
			and jhe.equipos_idEquipoVisita = (select JSON_EXTRACT(`jsonJuegos`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita')) );
			
		
			
			if (idJuego is null) then
				
				INSERT INTO `fifaxgamersbd`.`jornadas_has_equipos`
				(`id`,
				`jornadas_idJornada`,
				`equipos_idEquipoLocal`,
				`equipos_idEquipoVisita`,
				`golesLocal`,
				`golesVisita`)
				VALUES
				(null,
				jornadaVal,
				(select JSON_EXTRACT(`jsonJuegos`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal')) ),
				(select JSON_EXTRACT(`jsonJuegos`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita')) ),
				null,
				null);

			
			end if;
			
        SET `_index_Juegos` := `_index_Juegos` + 1;
		END WHILE;
        
        
        
        
    end if;
    
    
    
    
    


SET `_index` := `_index` + 1;
END WHILE;


set isError = 0 ;
set message = 'OK';

END $$
DELIMITER ;