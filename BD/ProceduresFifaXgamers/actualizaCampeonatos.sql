DELIMITER $$
DROP PROCEDURE IF EXISTS actualizaCampeonatos$$
CREATE PROCEDURE actualizaCampeonatos (out isError int, 
                                out message varchar(200))
BEGIN

DECLARE isFound INTEGER;
DECLARE var_id INTEGER;
DECLARE idEquipoVal INTEGER;
DECLARE idTorneoVAl INTEGER;
  DECLARE var_paginas INTEGER;
  DECLARE var_titulo VARCHAR(255);
  DECLARE var_inicio INTEGER DEFAULT 0;
  DECLARE var_final INTEGER DEFAULT 0;
  
  DECLARE done INT DEFAULT FALSE;

DECLARE cursor1 CURSOR FOR (SELECT torneo.idtorneo from torneo where torneo.idtorneo not in (select cat_salon_fama.idtorneo from cat_salon_fama)order by torneo.idtorneo desc);
-- DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
 
 SELECT count(torneo.idtorneo) into var_final  from torneo where torneo.idtorneo not in (select cat_salon_fama.idtorneo from cat_salon_fama);


-- DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final =  (select max(idtorneo) from torneo);

-- DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

 set  var_inicio = 1;

OPEN cursor1;

  bucle: LOOP

    FETCH cursor1 INTO var_id;
   
      IF (var_final+1) = var_inicio THEN
		select var_final, var_inicio, var_id;
      LEAVE bucle;
    END IF;

     
	set isFound = null;
    
    select cat_salon_fama.idtorneo into isFound  from cat_salon_fama where cat_salon_fama.idtorneo = var_id;
    
    if isFound is null then 
    
    IF (var_final) = var_inicio THEN
		select var_final, var_inicio, var_id;
      LEAVE bucle;
    END IF;
    set idEquipoVal = null;
    set idTorneoVal = null;
    select 
		(case when tabla1.golesLocal > golesVisita then tabla1.equipos_idEquipoLocal else tabla1.equipos_idEquipoVisita end) 
        as idEquipo  ,
		tabla1.idtorneo
        
        into idEquipoVal, idTorneoVal

		from (

		select tabla.equipos_idEquipoLocal,
		tabla.equipos_idEquipoVisita,
		sum(golesLocal) as golesLocal,
		sum(golesVisita) as golesVisita,
		tabla.idtorneo
		from (

		select jornadas_has_equipos.equipos_idEquipoLocal ,
		jornadas_has_equipos.equipos_idEquipoVisita, 
		golesLocal,
		golesVisita,
		torneo.idtorneo
		from jornadas_has_equipos
		join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
		join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
		where torneo.idtorneo = var_id  and jornadas.tipoJornada = 1
		and jornadas.nombreJornada = 'Final'
        and jornadas_has_equipos.golesLocal is not null
        and torneo.cat_torneo != 2

		UNION 

		select 
		jornadas_has_equipos.equipos_idEquipoVisita as equipos_idEquipoLocal, 
		jornadas_has_equipos.equipos_idEquipoLocal as equipos_idEquipoVisita,
		golesVisita as golesLocal,
		golesLocal as golesVisita,
		torneo.idtorneo

		from jornadas_has_equipos
		join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
		join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
		where torneo.idtorneo = var_id and jornadas.tipoJornada = 1
		and jornadas.nombreJornada = 'Final Vuelta'
        and jornadas_has_equipos.golesLocal is not null
        and torneo.cat_torneo != 2
		) tabla
		group by tabla.equipos_idEquipoLocal, tabla.equipos_idEquipoVisita
		) tabla1
		;
        
        if idEquipoVal is not null then 
    
			INSERT INTO `cat_salon_fama`
				(`id`,
				`username`,
				`nombreEquipo`,
				`img`,
				`idtorneo`,
				`idtemporada`,
				`campeon`,
                `idequipo`,
                `idcat_torneo`,
                `nombretorneo`,
                `nombretemporada`,
                `img_torneo`
                
                )
				
				(select tabla.id,
                tabla.userName,
                tabla.nombreEquipo,
                tabla.imagen,
                tabla.idtorneo,
                tabla.tempodada_idTemporada,
                tabla.campeon,
                tabla.idEquipo,
                tabla.idCattorneo,
                tabla.nombre,
                tabla.NombreTemporada,
                tabla.img
                from ( 
                select null as id,
                usuarios.userName,                
				(case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end ) as nombreEquipo,
				equipos_has_imagen.imagen,
                torneo.idtorneo,
				torneo.tempodada_idTemporada,
                1 as campeon,
				equipos.idEquipo ,
                cat_torneo.id as idCattorneo,
                cat_torneo.nombre,
                temporada.NombreTemporada,
                cat_torneo.img
				from equipos_has_temporada
				join torneo on torneo.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada
                join temporada on temporada.idTemporada = torneo.tempodada_idTemporada
                join cat_torneo on torneo.cat_torneo = cat_torneo.id
				join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
				join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = equipos.idEquipo and equipos_has_imagen.idTemporada = torneo.tempodada_idTemporada
				join usuarios on usuarios.idequipo = equipos.idEquipo
				where torneo.idtorneo = idTorneoVal
				and equipos.idEquipo = idEquipoVal
				and equipos_has_imagen.tipoImagen_idTipoImagen = 1
                limit 1) tabla);
                
		end if;

     
    
    end if;
    
 set  var_inicio = var_inicio + 1;
   
  
  END LOOP bucle;
  CLOSE cursor1;

set isError = 0 ;
set message = 'OK';


END $$
DELIMITER ;