
--
-- Dumping routines for database 'fifaxgam_fifaxgamersbd'
--
 DROP PROCEDURE IF EXISTS `addGoles` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addGoles`(IN idJornada int ,
							   IN id int , 
                               IN idJugador int,
                               IN idEquipo int,
                               out isError int, 
                               out message varchar(200)
                            )
BEGIN


DECLARE jornadaVal int;
DECLARE idjornadaVal int;
DECLARE golesLocal int;
DECLARE golesVisita int;
declare equipoLocal int;
declare equipoVisita int;
declare isAutogol int;
declare idEquipoJugador int;




set isError = 1 ;
set message = 'No se pudo agregar';

select Equipos_idEquipo into idEquipoJugador
from persona
where idPersona = idJugador
;

set isAutogol = 0;

if idEquipoJugador != idEquipo then 
	set isAutogol = 1;
end if;


INSERT INTO `fifaxgam_fifaxgamersbd`.`golesjornadas`
(`id`,
`persona_idPersona`,
`updatedate`,
`equipos_idEquipo`,
`jornadas_has_equipos_id`,
`jornadas_has_equipos_jornadas_idJornada`,
`isautogol`
)
VALUES
(null,
idJugador,
sysdate(),
idEquipo,
id,
idJornada,
isAutogol
);

select jhe.equipos_idEquipoLocal ,jhe.equipos_idEquipoVisita into equipoLocal, equipoVisita
from jornadas_has_equipos jhe 
where jhe.jornadas_idJornada = idJornada
and jhe.id = id;



select count( equipos.idEquipo) goles into golesLocal
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = idJornada
and equipos.idEquipo in (equipoLocal);


select count( equipos.idEquipo) goles into golesVisita
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = idJornada
and equipos.idEquipo in (equipoVisita);

call updateResultadoJornada(idJornada,equipoLocal,equipoVisita,golesLocal,golesVisita);




set isError = 0 ;
set message = 'OK';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `addImagen` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `addImagen`(IN idJornada int ,
							   IN id int , 
                               IN idEquipo int,
                               IN img varchar(300),
                               out isError int, 
                               out message varchar(200)
                            )
BEGIN


set isError = 1 ;
set message = 'No se pudo agregar';

if img is not null and img !='' then
INSERT INTO `fifaxgam_fifaxgamersbd`.`imagenesjornadas`
(`id`,
`jornadas_has_equipos_id`,
`jornadas_has_equipos_jornadas_idJornada`,
`imgJornada`)
VALUES
(null,
id,
idJornada,
img);



set isError = 0 ;
set message = 'OK';

end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `confirmPlayer` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `confirmPlayer`(IN idJugador INT,
                            IN idEquipoOferta INT,
                            IN idTemporada INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE idEquipoExist int;

DECLARE idEquipoVar int;
DECLARE idTemporadaVar int;
declare activoVar bit;
declare horasConfir int;


select draftpc.Persona_idPersona,draftpc.idEquipo into  idJugadorVal,idEquipoVar
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.tempodada_idTemporada = idTemporada;

select persona.idPersona , persona.Equipos_idEquipo into  idJugadorExist, idEquipoExist
from persona
where persona.idPersona = idJugador;

set  idTemporadaVar = idTemporada;



select monto into horasConfir
from configuraciondraft
where codigo='confirmacionDraft'
limit 1;

SELECT timestampdiff(Minute, fechaCompra, now()) >= horasConfir as activo INTO activoVar
FROM draftpc
where draftpc.Persona_idPersona =  idJugadorVal
and tempodada_idTemporada = idTemporadaVar
;

select idJugadorVal;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';
  
elseif activoVar = 0 then 
	set isError = 1 ;
    set message = 'Aun no concluye el tiempo para confirmar';
elseif idEquipoVar != idEquipoOferta then
	set isError = 1 ;
    set message = 'Solamente el equipo que gano al jugador puede confirmar';

elseif idEquipoExist = idEquipoVar then
	set isError = 1 ;
    set message = 'El Jugador y se confirmo';
	

elseif idJugador is not null then 
	 
     UPDATE `fifaxgam_fifaxgamersbd`.`persona`
	SET
	  `Equipos_idEquipo` = idEquipoVar

	WHERE `idPersona` = idJugador;
	
    
    set isError = 0 ;
	set message = 'OK';
    
    
end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `crearJornada` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `crearJornada`(IN equipoLocal int , 
                               IN equipoVisita int,
							   IN numJornada INT,
                               IN torneo INT,
                               IN division int,
                               IN liga int,
                               IN activa int,
                               IN cerrada int,
                               IN id int,
                               out isError int, 
                               out message varchar(200))
BEGIN

-- Opcion 1, crear jornadas, opcion 2 activar Jornadas

DECLARE jornadaVal int;
DECLARE idjornadaVal int;
DECLARE idjornadaValInsert int;
declare idJ int;
declare tipoTorneo int;


set isError = 1 ;
set message = 'El jugador no Existe';


select equipos.Division_idDivision into division
from equipos where equipos.idEquipo = equipoLocal;

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo
and jornadas.division_idDivision = division;

select torneo.tipoTorneo_idtipoTorneo into tipoTorneo
from torneo
where torneo.idtorneo = torneo;

if tipoTorneo = 2 then 

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo;

UPDATE `fifaxgam_fifaxgamersbd`.`jornadas`
SET
`activa` = activa,
`cerrada` = cerrada

WHERE `idJornada` = idjornadaVal AND `torneo_idtorneo` = torneo;


else if idjornadaVal is null then

INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas`
(`idJornada`,
`division_idDivision`,
`numeroJornada`,
`activa`,
`cerrada`,
`nombreJornada`,
`torneo_idtorneo`)
VALUES
(null,
division,
numJornada,
activa,
cerrada,
'',
torneo
);



else if idjornadaVal is not null then

UPDATE `fifaxgam_fifaxgamersbd`.`jornadas`
SET
`activa` = activa,
`cerrada` = cerrada

WHERE `idJornada` = idjornadaVal AND `torneo_idtorneo` = torneo;
end if;


end if;

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneo_idtorneo = torneo
and jornadas.division_idDivision = division;


select hje.id into idJ
from jornadas_has_equipos hje
where hje.id = id 
and hje.equipos_idEquipoLocal = equipoLocal
and hje.equipos_idEquipoVisita = equipoVisita
and hje.jornadas_idJornada = idjornadaVal;

if idJ is null then 

INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas_has_equipos`
(`id`,
`jornadas_idJornada`,
`equipos_idEquipoLocal`,
`equipos_idEquipoVisita`)
VALUES
(null,
idjornadaVal,
equipoLocal,
equipoVisita);

end if;

end if;
set isError = 0 ;
set message = 'OK';



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `crearJornadasFinales` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `crearJornadasFinales`(IN `json` JSON ,IN idTorneo int, IN idTemporada int,
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
            
            INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas`
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
				
				INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas_has_equipos`
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `crearJugador` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `crearJugador`(IN nombreCompleto varchar(200) , 
							   IN sobrenonbre varchar(200),
                               IN raiting INT,
                               IN idEquipo INT,
                               IN link varchar(200),
                               IN idTemporada INT
                               )
BEGIN

DECLARE idEquipoVar INT;

INSERT INTO `fifaxgam_fifaxgamersbd`.`persona`
(`idPersona`,
`NombreCompleto`,
`sobrenombre`,
`fehaNacimiento`,
`Raiting`,
`potencial`,
`Equipos_idEquipo`,
`activo`,
`link`)    

VALUES
(null,
        nombreCompleto,
		sobrenonbre,
        null,
        raiting,
        0,
        idEquipo,
        1,
        link
	    );
    
        
INSERT INTO `fifaxgam_fifaxgamersbd`.`persona_has_roles`
(`Persona_idPersona`,
`Roles_idRoles`)
VALUES
((SELECT persona.idPersona
FROM persona
ORDER by persona.idPersona DESC limit 1),
1);


select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.tempodada_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO `fifaxgam_fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`tempodada_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 
 end if ;


        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `crearTorneo` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `crearTorneo`(IN nombreTorneo varchar(45),
							   in idTemporada int,
                               in tipoTorneo int,
                               out isError int, 
                               out message varchar(200))
BEGIN

declare isTorneo int;

declare torneoval int; 

set isError = 1 ;
set message = 'El torneo ya Existe';

if tipotorneo = 1 then 
	select nombre into nombreTorneo	
	from division where idDivision = 1;
end if;

select torneo.idtorneo into isTorneo 
from torneo
where torneo.tempodada_idTemporada = idTemporada
and torneo.nombreTorneo = nombreTorneo;

if isTorneo is null then 

if tipotorneo = 1 then

INSERT INTO `fifaxgam_fifaxgamersbd`.`torneo`
(`idtorneo`,
`nombreTorneo`,
`tempodada_idTemporada`,
`tipoTorneo_idtipoTorneo`)

(select null, nombre,idTemporada,tipotorneo from division);

 	  
	  INSERT INTO `fifaxgam_fifaxgamersbd`.`grupos_torneo`
		(`torneo_idtorneo`,
		`equipos_idEquipo`,
		`nombreGrupo`)
		
		(select idTorneo, idEquipo,null
		from torneo,division, equipos
		where torneo.nombreTorneo = division.nombre 
		and equipos.Division_idDivision = division.idDivision and equipos.idEquipo!=1
		and torneo.tempodada_idTemporada = idTemporada);
       
 
else  


select nombreTorneo,
idTemporada,
tipotorneo;

INSERT INTO `fifaxgam_fifaxgamersbd`.`torneo`
(`idtorneo`,
`nombreTorneo`,
`tempodada_idTemporada`,
`tipoTorneo_idtipoTorneo`)
VALUES
(null,
nombreTorneo,
idTemporada,
tipotorneo);



end if;


end if;

set isError = 0 ;
set message = 'OK';



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createInitialDraft` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createInitialDraft`(IN idJugador INT,
									IN montoOferta INT,
                                    IN manager varchar(100),
                                    IN observaciones varchar(100), 
                                    IN idEquipoOferta INT,
                                    IN idTemporada INT,
                                    out isError int, 
                                    out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE montoBD int;
DECLARE idTemporadaVar int;
DECLARE sumaDraftPC int;
DECLARE ofertaInicial int;
declare horaInicio int;
declare horaFin int;

select draftpc.Persona_idPersona into  idJugadorVal
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.tempodada_idTemporada = idTemporada;

select persona.idPersona into idJugadorExist
from persona
where persona.idPersona = idJugador;

set idTemporadaVar = idTemporada;


select dat.presupuestoFinal into montoBD
from datosfinancieros dat
where dat.Equipos_idEquipo = idEquipoOferta
and dat.tempodada_idTemporada = idTemporadaVar;

select monto into ofertaInicial
from configuraciondraft
where codigo='ofertaInicial'
limit 1;

select monto into horaInicio
from configuraciondraft
where codigo='horaInicio'
limit 1;


select monto into horaFin
from configuraciondraft
where codigo='horaFin'
limit 1;

select idJugadorVal;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';
elseif ( hour(now()) < horaInicio )
       or ( hour(now()) >= horaFin )
   
then 
	set isError = 1 ;
    set message = 'DRAFT EN CERRADO';
elseif  montoBD is null or montoBD < montoOferta then 
  set isError = 1 ;
  set message = 'Revisa tus finanzas fondos insuficientes1' ;
elseif idJugadorVal is not null then
  set isError = 1 ;
  set message = 'El jugador ya se esta ofertando';

elseif montoOferta is null or montoOferta = 0 or montoOferta < ofertaInicial then 
  set isError = 1 ;
  set message = concat('El monto no es correcto el monto minimo es :',ofertaInicial);

elseif manager is null  then 
  set isError = 1 ;
  set message = 'El manager es incorrecto';

elseif idJugador is not null then 
	INSERT INTO `fifaxgam_fifaxgamersbd`.`draftpc`
	(`idDraftPC`,
	`oferta`,
	`Persona_idPersona`,
	`fechaCompra`,
	`usuarioOferta`,
	`tempodada_idTemporada`,
	`comentarios`,
	`abierto`,
    `ofertaFinal`,
    `idEquipo`)
	VALUES
	(1,
	montoOferta,
	idJugador,
	SYSDATE(),
	manager,
	(select idTemporada from temporada order by temporada.idTemporada desc limit 1),
	observaciones,
	1,
    montoOferta,
    idEquipoOferta);
    
    INSERT INTO `fifaxgam_fifaxgamersbd`.`historicodraft`
		(`idHistoricoDraft`,
		`oferta`,
		`fechaOferta`,
		`usuarioOferta`,
		`DraftPC_idDraftPC`,
		`DraftPC_Persona_idPersona`,
		`tempodada_idTemporada`,
		`comentarios`,
		`ofertaFinal`,
        `idEquipo`)
		(select null,
			draftpc.oferta,
			draftpc.fechaCompra,
			draftpc.usuarioOferta,
			draftpc.idDraftPC,
			draftpc.Persona_idPersona,
			draftpc.tempodada_idTemporada,
			draftpc.comentarios,
			draftpc.ofertaFinal,
            draftpc.idEquipo
			from draftpc
		where draftpc.Persona_idPersona = idJugador
        and draftpc.tempodada_idTemporada = (select idTemporada from temporada order by temporada.idTemporada desc limit 1)
        and draftpc.idDraftPC = 1
        limit 1);
        
        select sum(draftpc.ofertaFinal) into sumaDraftPC
		from draftpc
		where draftpc.idEquipo = idEquipoOferta;
        
        call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoOferta);

    
    set isError = 0 ;
	set message = 'OK';
    
    
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrTorneoGrupos` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrTorneoGrupos`(IN `json` JSON,
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
  declare idEquipoTorneoVar int;
  
  declare idEquipoJson int;
  declare numeroGrupoJson int;
  declare idjornadaVal int;
  declare idJ int;
  
  
  set isError = 1 ;
set message = 'Error al crear grupos';
  
-- call crearTorneo(nombreTorneo,idTemporada,2,@iserr,@ip);

select torneo.idtorneo into idTorneo
from torneo
where torneo.nombreTorneo = nombreTorneo and torneo.tempodada_idTemporada = idTemporada ;

if idTorneo is null then 
  call crearTorneo(nombreTorneo,idTemporada,2,@iserr,@ip);
  
  select torneo.idtorneo into idTorneo
	from torneo
	where torneo.nombreTorneo = nombreTorneo and torneo.tempodada_idTemporada = idTemporada;


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
        
      
        set idEquipoTorneoVar = null;
        
        select grupos_torneo.equipos_idEquipo into idEquipoTorneoVar
        from grupos_torneo
        where grupos_torneo.equipos_idEquipo = idEquipoJson 
        and torneo_idtorneo = idTorneo ;
        
        -- select idEquipoTorneoVar,idTorneo,var,idEquipoJson;
        if idEquipoTorneoVar  is null and idEquipoJson > -1 then 
                INSERT INTO `fifaxgam_fifaxgamersbd`.`grupos_torneo`
				(`torneo_idtorneo`,
				`equipos_idEquipo`,
				`nombreGrupo`)
				VALUES
				(idTorneo,
				idEquipoJson,
				var);
          --       select idEquipoTorneoVar,idTorneo,var,idEquipoJson;
		end if;
        
        SET `_index_Equipos` := `_index_Equipos` + 1;
        
        END WHILE;
         -- select 'saliendo grupos';
        
        
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
							INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas`
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
					
           --     select (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) ) idEquipoLocal,
           --     (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') ) ) idEquipoVisita;
                
					select hje.id into idJ
					from jornadas_has_equipos hje
					where 
					hje.equipos_idEquipoLocal = (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) )
					and hje.equipos_idEquipoVisita = (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') ))
					and hje.jornadas_idJornada = idjornadaVal;

				if  (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoLocal') ) ) != -1
				&&  (SELECT JSON_EXTRACT(`jsonJuego`, CONCAT('$[', `_index_Juegos`, '].idEquipoVisita') )) != -1 then  

						INSERT INTO `fifaxgam_fifaxgamersbd`.`jornadas_has_equipos`
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

				 	end if;
				
				
				
			 SET `_index_Juegos` := `_index_Juegos` + 1;
			
			END WHILE;
        
        
     
       
        
        SET `_index_Jornadas` := `_index_Jornadas` + 1;
        
        END WHILE;
        
       
        
    -- select _index,_index_Equipos;
        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;

  
set isError = 0 ;
set message = 'OK';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrUpdateConceptos` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrUpdateConceptos`(
                            IN codigo varchar(100),
                            IN descripcion varchar(100), 
                            IN tipo INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idConcepto int;
DECLARE idConceptoIn int;

set isError = 1 ;
  set message = 'Error al intentar modificar';
  
select idCatalogoConceptos into idConcepto
 from catalogoconceptos
where catalogoconceptos.nombre = codigo;	 
	
if idConcepto is null then 

select max(idCatalogoConceptos)+1 into idConceptoIn
from catalogoconceptos;

select idConceptoIn;

INSERT INTO `fifaxgam_fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(idConceptoIn,
codigo,
descripcion,
tipo);

else if idConcepto is not null then 

UPDATE `fifaxgam_fifaxgamersbd`.`catalogoconceptos`
SET
`nombre` = codigo,
`descripcion` = descripcion,
`TipoConcepto_idTipoConcepto` =tipo
WHERE `idCatalogoConceptos` = idConcepto ;


end if;


end if;    

    
    set isError = 0 ;
	set message = 'OK';
    
    


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrUpdateDatosFinancieros` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrUpdateDatosFinancieros`(IN idDatos INT, IN monto INT,IN idEquipo INT)
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

and datos.tempodada_idTemporada = idTemporadaVar
limit 1
;

select con.idConceptosFinancieros into isUpdate
from conceptosfinancieros con
where con.CatalogoConceptos_idCatalogoConceptos = idDatos
and con.DatosFinancieros_idDatosFinancieros = idDatosVar
and con.DatosFinancieros_Equipos_idEquipo = idEquipo

and con.datosfinancieros_tempodada_idTemporada = idTemporadaVar;

	IF isUpdate is null or isUpdate = 0  then





	INSERT INTO `fifaxgam_fifaxgamersbd`.`conceptosfinancieros`
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
    
		UPDATE `fifaxgam_fifaxgamersbd`.`conceptosfinancieros`
		SET	`monto` = monto
		WHERE `idConceptosFinancieros` = isUpdate 
		AND `DatosFinancieros_idDatosFinancieros` = idDatosVar 
		AND `CatalogoConceptos_idCatalogoConceptos` = idDatos
        and `DatosFinancieros_Equipos_idEquipo` = idEquipo
		
		and `datosfinancieros_tempodada_idTemporada` = idTemporadaVar;

	
	END IF;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrUpdateDatosSponsor` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrUpdateDatosSponsor`(IN idEquipo INT, IN idSponsor INT, IN opcionales INT)
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
and datos.tempodada_idTemporada = idTemporadaVar
limit 1
;

select idDatosVar;

IF idTemporadaVar is not null  and idDatosVar is null then
   INSERT INTO `fifaxgam_fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`tempodada_idTemporada`,
`sponsorOpcional`)
VALUES
(1,
0,
0,
idEquipo,
idTemporadaVar,
opcionales);

elseif idDatosVar is not null then

UPDATE `fifaxgam_fifaxgamersbd`.`datosfinancieros`
SET 
`sponsorOpcional` = opcionales
WHERE  `Equipos_idEquipo` = idEquipo
AND `tempodada_idTemporada` = idTemporadaVar;


END IF;

	IF opcionales = 0 then 
    
    INSERT INTO `fifaxgam_fifaxgamersbd`.`dadosfinancierossponsor`
	(`DatosFinancieros_idDatosFinancieros`,
	`DatosFinancieros_Equipos_idEquipo`,
	`datosfinancieros_tempodada_idTemporada`,
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
		INSERT INTO `fifaxgam_fifaxgamersbd`.`dadosfinancierossponsor`
			(`DatosFinancieros_idDatosFinancieros`,
			`DatosFinancieros_Equipos_idEquipo`,
			`datosfinancieros_tempodada_idTemporada`,
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



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrUpdateObjetivos` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrUpdateObjetivos`(IN `json` JSON,IN idEquipo INT, IN idSponsor INT,IN idTemporada INT)
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
        
        
        UPDATE `fifaxgam_fifaxgamersbd`.`dadosfinancierossponsor`
		SET
		`cumplio` = cum
		WHERE `DatosFinancieros_idDatosFinancieros` = 1
        AND `DatosFinancieros_Equipos_idEquipo` = idEquipo
        AND `datosfinancieros_tempodada_idTemporada` = idTemporada
        AND `Sponsor_idSponsor` = idSponsor
        AND `ConceptoSponsor_idConcepto` = var;

        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;

  


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createOrUpdatePresupuesto` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createOrUpdatePresupuesto`(IN idEquipo INT,  IN monto INT, IN montoFinal INT,
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
and datos.tempodada_idTemporada = idTemporadaVar;



if idDatosVar is null then 

INSERT INTO `fifaxgam_fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`tempodada_idTemporada`,
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

UPDATE `fifaxgam_fifaxgamersbd`.`datosfinancieros`
SET

`presupuestoInicial` = monto,
`presupuestoFinal` = montoFinal,
`presupuestoFinalSponsor` = montoFinalSponsor

WHERE `idDatosFinancieros` = idDatosVar 
AND `Equipos_idEquipo` = idEquipo

AND `tempodada_idTemporada` = idTemporadaVar;

end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createPrestamo` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createPrestamo`(IN idJugador INT,IN idEquipo INT,IN idTemporada INT,IN opcion INT)
BEGIN

DECLARE idEquipoAnterior int;
DECLARE idJugadorVal int;

select prestamos.Persona_idPersona into idJugadorVal
from prestamos
where prestamos.Persona_idPersona = idJugador
and prestamos.tempodada_idTemporada = idTemporada;

IF opcion is null or opcion = 1 then 

	if(idJugadorVal is null) then

		select persona.Equipos_idEquipo into  idEquipoAnterior
		from persona
		where persona.idPersona = idJugador;

		select idEquipoAnterior;

		UPDATE `fifaxgam_fifaxgamersbd`.`persona`
		SET
		`Equipos_idEquipo` = idEquipo,
		`prestamo` = 1
		WHERE `idPersona` = idJugador;


		INSERT INTO `fifaxgam_fifaxgamersbd`.`prestamos`
		(`Persona_idPersona`,
		`Equipos_idEquipo`,
        `tempodada_idTemporada`,
		`activo`)
		VALUES
		(idJugador,
		idEquipoAnterior,
        idTemporada,
		1);

	END IF;

elseif opcion = 2 then

	select prestamos.Equipos_idEquipo  into  idEquipoAnterior
	from prestamos
	where prestamos.Persona_idPersona  = idJugador;
    
    UPDATE `fifaxgam_fifaxgamersbd`.`persona`
		SET
		`Equipos_idEquipo` = idEquipoAnterior,
		`prestamo` = 0
		WHERE `idPersona` = idJugadorVal ;

	delete from prestamos 
    where prestamos.Persona_idPersona = idJugadorVal
    and prestamos.Equipos_idEquipo = idEquipoAnterior
    and prestamos.tempodada_idTemporada = idTemporada;

end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `createTemporada` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `createTemporada`( IN nombreTemporada varchar(200) , IN descripcionTemporada varchar(200), IN idLiga int)
BEGIN

DECLARE idTemporadaVar int;


select idTemporada into idTemporadaVar 
from temporada
where temporada.NombreTemporada = nombreTemporada
and temporada.Liga_idLiga = idLiga;


if idTemporadaVar is null then 
INSERT INTO `fifaxgam_fifaxgamersbd`.`temporada`
(
`NombreTemporada`,
`Descripcion`,
`Liga_idLiga`)
VALUES
(
NombreTemporada,
descripcionTemporada,
idLiga);

select idTemporada into idTemporadaVar 
from temporada
where temporada.NombreTemporada = nombreTemporada
and temporada.Liga_idLiga = idLiga;

end if;



INSERT INTO `fifaxgam_fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`tempodada_idTemporada`)
(select idEquipo,idTemporadaVar 
from equipos);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `modificarJugador` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `modificarJugador`(IN nombreCompleto varchar(200) , 
								   IN sobrenonbre varchar(200),
                                   IN raiting INT,
                                   IN idEquipo INT, 
                                   IN idJugador INT,
                                   IN link varchar(300),
                                   IN idTemporada INT
                                   )
BEGIN

declare  idEquipoVar int;


update persona set persona.NombreCompleto = nombreCompleto,
                   persona.sobrenombre = sobrenonbre,
                   persona.Raiting = raiting,
                   persona.Equipos_idEquipo = idEquipo,
                   persona.link = link
where persona.idPersona = idJugador;

select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.tempodada_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO `fifaxgam_fifaxgamersbd`.`equipos_has_temporada`
(`Equipos_idEquipo`,
`tempodada_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 
 end if ;
       

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `registrarJornada` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `registrarJornada`(IN `json` JSON,
								  IN nombreTorneo varchar(200),
								  IN idTemporada INT,
                                  IN username varchar(30),
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
        

           
           INSERT INTO `fifaxgam_fifaxgamersbd`.`golesjornadas`
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
          

         
         DELETE FROM `fifaxgam_fifaxgamersbd`.`golesjornadas`
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
  
  

  INSERT INTO `fifaxgam_fifaxgamersbd`.`imagenesjornadas`
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
and golesjornadas.jornadas_has_equipos_id = (SELECT JSON_EXTRACT(`json`, "$.id"))
and equipos.idEquipo in ((SELECT JSON_EXTRACT(`json`, "$.idEquipoLocal")));


select count( equipos.idEquipo) goles into golesVisita
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = (SELECT JSON_EXTRACT(`json`, "$.idJornada"))
and golesjornadas.jornadas_has_equipos_id = (SELECT JSON_EXTRACT(`json`, "$.id"))
and equipos.idEquipo in ((SELECT JSON_EXTRACT(`json`, "$.idEquipoVisita")));

 call updateResultadoJornada((SELECT JSON_EXTRACT(`json`, "$.idJornada"))
 							,(SELECT JSON_EXTRACT(`json`, "$.idEquipoLocal")),
                             (SELECT JSON_EXTRACT(`json`, "$.idEquipoVisita")),
                           golesLocal,golesVisita);

                      
UPDATE `fifaxgam_fifaxgamersbd`.`jornadas_has_equipos`
SET
`golesLocal` = golesLocal,
`golesVisita` = golesVisita,
`username` = username

WHERE jornadas_has_equipos.id = id
;
  
set isError = 0 ;
set message = 'OK';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `spTest` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `spTest`()
BEGIN


select * from equipos;
select * from conceptosponsor;

 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `updateDraft` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateDraft`(IN idJugador INT,
							IN montoInicial INT,
                            IN montoOferta INT,
                            IN manager varchar(100),
                            IN observaciones varchar(100), 
                            IN idEquipoOferta INT,
                            IN idTemporada INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE montoFinalVal int;
DECLARE idEquipo int;
DECLARE idTemporadaVar int;
DECLARE montoBD int;
DECLARE sumaDraftPC int;
DECLARE idEquipoAnterior int;
DECLARE contraoferta int;
declare activoVar bit;
declare minConfirm int;
declare horaInicio int;
declare horaFin int;
declare minDiaVar int;
declare diasVar int;
declare minDiaActualVar int;
declare sumaVar int;
declare sumaminutosdia_cero_Var int;
declare minDia_ceroVar int;


select draftpc.Persona_idPersona,draftpc.ofertaFinal into  idJugadorVal,montoFinalVal
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.tempodada_idTemporada = idTemporada;

select persona.idPersona into idJugadorExist
from persona
where persona.idPersona = idJugador;

set idTemporadaVar = idTemporada ;

select dat.presupuestoFinal into montoBD
from datosfinancieros dat
where dat.Equipos_idEquipo = idEquipoOferta
and dat.tempodada_idTemporada = idTemporadaVar;

select monto into contraoferta
from configuraciondraft
where codigo='contraoferta'
limit 1;

select monto into minConfirm
from configuraciondraft
where codigo='confirmacionDraft'
limit 1;

select monto into horaInicio
from configuraciondraft
where codigo='horaInicio'
limit 1;


select monto into horaFin
from configuraciondraft
where codigo='horaFin'
limit 1;


select 
diasSe,
MINUTOSDIA_CERO,
minutosdia,
minutos_dia_actual,
(minutosdia+minutos_dia_actual) sumaminutosdia,
(minutosdia_cero+minutos_dia_actual) sumaminutosdia_cero
into 
diasVar ,
minDia_ceroVar,
minDiaVar ,
minDiaActualVar ,
sumaVar,
sumaminutosdia_cero_Var 
from
(
select 
draftpc.fechaCompra,
timestampdiff(day,DATE(draftpc.fechaCompra),Date(NOW())) as diasSe,
timestampdiff(MINUTE, draftpc.fechaCompra, now()) MINUTOSDIA_CERO,
timestampdiff(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra),INTERVAL 24 HOUR)) MINUTOSDIA,
timestampdiff(MINUTE, DATE_ADD(DATE(now()),INTERVAL 9 HOUR), now()) Minutos_dia_Actual
from draftpc where draftpc.Persona_idPersona =  idJugadorVal and draftpc.tempodada_idTemporada = idTemporada) ta
;

select idJugadorVal;

select diasVar ,
minDia_ceroVar,
minDiaVar ,
minDiaActualVar ,
sumaVar,
sumaminutosdia_cero_Var,horaInicio,horaFin ;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';

elseif ( hour(now()) < horaInicio )
       or ( hour(now()) >= horaFin )
   
then 
	set isError = 1 ;
    set message = 'DRAFT EN CERRADO';
  
elseif (diasVar = 1 and sumaVar >= minConfirm ) 
   or (diasVar = 0 and minDia_ceroVar >= minConfirm )
   
then 
	set isError = 1 ;
    set message = 'Ya no se puede ofertar este Jugador paso el tiempo para ofertar';

elseif montoBD is null or  montoOferta > montoBD then 
	set isError = 1 ;
  set message = 'Monto insuficiente';
elseif idJugadorVal is null then
  set isError = 1 ;
  set message = 'El jugador no Existe para ofertar';

elseif montoInicial != montoFinalVal then 
  set isError = 1 ;
  set message = 'El monto ya cambio favor de checar de nuevo la oferta';

elseif montoOferta is null or montoOferta <= montoFinalVal then 
  set isError = 1 ;
  set message = 'El monto no es correcto debe ser mayor';
  
elseif montoOferta < (contraoferta + montoFinalVal) then 
  set isError = 1 ;
  set message = concat('El monto minimo a ofertar es por : ',contraoferta);  

elseif manager is null  then 
  set isError = 1 ;
  set message = 'El manager es incorrecto';

elseif idJugador is not null then 
	 
     select draftpc.idEquipo into idEquipoAnterior
     from draftpc
     WHERE `idDraftPC` = 1
     AND `Persona_idPersona` = idJugador
     AND `tempodada_idTemporada` = (select idTemporada from temporada order by temporada.idTemporada desc limit 1);
	
    UPDATE `fifaxgam_fifaxgamersbd`.`draftpc`
	SET
    `oferta`      = montoInicial,
	`ofertaFinal` = montoOferta,
	`fechaCompra` = sysdate(),
	`usuarioOferta` = manager,
	`comentarios` = observaciones,
    `idEquipo` = idEquipoOferta
	WHERE `idDraftPC` = 1
    AND `Persona_idPersona` = idJugador
    AND `tempodada_idTemporada` = (select idTemporada from temporada order by temporada.idTemporada desc limit 1);

	INSERT INTO `fifaxgam_fifaxgamersbd`.`historicodraft`
		(`idHistoricoDraft`,
		`oferta`,
		`fechaOferta`,
		`usuarioOferta`,
		`DraftPC_idDraftPC`,
		`DraftPC_Persona_idPersona`,
		`tempodada_idTemporada`,
		`comentarios`,
		`ofertaFinal`,
        `idEquipo`)
		(select null,
			montoFinalVal,
			draftpc.fechaCompra,
			draftpc.usuarioOferta,
			draftpc.idDraftPC,
			draftpc.Persona_idPersona,
			draftpc.tempodada_idTemporada,
			draftpc.comentarios,
			montoOferta,
            draftpc.idEquipo
			from draftpc
		where draftpc.Persona_idPersona = idJugador
        and draftpc.tempodada_idTemporada = (select idTemporada from temporada order by temporada.idTemporada desc limit 1)
        and draftpc.idDraftPC = 1
        limit 1);
        
        select sum(draftpc.ofertaFinal) into sumaDraftPC
		from draftpc
		where draftpc.idEquipo = idEquipoOferta;
        
        call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoOferta);
                                            
		
        
        if idEquipoAnterior != idEquipoOferta then 
        
			select sum(draftpc.ofertaFinal) into sumaDraftPC
			from draftpc
			where draftpc.idEquipo = idEquipoAnterior;
			
            call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoAnterior);
		end if;
	
    
    set isError = 0 ;
	set message = 'OK';
    
    
end if;

select isError,message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `updateDraftCorreccion` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateDraftCorreccion`(IN idJugador INT,
							IN montoInicial INT,
                            IN montoOferta INT,
                            IN manager varchar(100),
                            IN observaciones varchar(100), 
                            IN idEquipoOferta INT,
                            IN idTemporada INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE montoFinalVal int;
DECLARE idEquipo int;
DECLARE idTemporadaVar int;
DECLARE montoBD int;
DECLARE sumaDraftPC int;
DECLARE idEquipoAnterior int;
DECLARE contraoferta int;
declare activoVar bit;
declare minConfirm int;
declare horaInicio int;
declare horaFin int;
declare minDiaVar int;
declare diasVar int;
declare minDiaActualVar int;
declare sumaVar int;
declare sumaminutosdia_cero_Var int;
declare minDia_ceroVar int;


set isError = 1 ;
  set message = 'Error al intentar modificar';
	 
     select draftpc.idEquipo into idEquipoAnterior
     from draftpc
     WHERE `idDraftPC` = 1
     AND `Persona_idPersona` = idJugador
     AND tempodada_idTemporada = idTemporada;
	
    UPDATE `fifaxgam_fifaxgamersbd`.`draftpc`
	SET
    `oferta`      = montoInicial,
	`ofertaFinal` = montoOferta,
	`fechaCompra` = sysdate(),
	`usuarioOferta` = manager,
	`comentarios` = observaciones,
    `idEquipo` = idEquipoOferta
	WHERE `idDraftPC` = 1
    AND `Persona_idPersona` = idJugador
    AND tempodada_idTemporada = idTemporada;

	INSERT INTO `fifaxgam_fifaxgamersbd`.`historicodraft`
		(`idHistoricoDraft`,
		`oferta`,
		`fechaOferta`,
		`usuarioOferta`,
		`DraftPC_idDraftPC`,
		`DraftPC_Persona_idPersona`,
		`tempodada_idTemporada`,
		`comentarios`,
		`ofertaFinal`,
        `idEquipo`)
		(select null,
			montoFinalVal,
			draftpc.fechaCompra,
			draftpc.usuarioOferta,
			draftpc.idDraftPC,
			draftpc.Persona_idPersona,
			draftpc.tempodada_idTemporada,
			draftpc.comentarios,
			montoOferta,
            draftpc.idEquipo
			from draftpc
		where draftpc.Persona_idPersona = idJugador
        and draftpc.tempodada_idTemporada = idTemporada
        and draftpc.idDraftPC = 1
        limit 1);
        
        select sum(draftpc.ofertaFinal) into sumaDraftPC
		from draftpc
		where draftpc.idEquipo = idEquipoOferta;
        
        call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoOferta);
                                            
		
        
        if idEquipoAnterior != idEquipoOferta then 
        
			select sum(draftpc.ofertaFinal) into sumaDraftPC
			from draftpc
			where draftpc.idEquipo = idEquipoAnterior;
			
            call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoAnterior);
		end if;
	
    
    set isError = 0 ;
	set message = 'OK';
    
    


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `updateResultadoJornada` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateResultadoJornada`(IN idJornada int ,
							   IN equipoLocal int , 
                               IN equipoVisita int,
                               IN golesLocal int,
                               in golesVisita int)
BEGIN


DECLARE jornadaVal int;
DECLARE idjornadaVal int;



select jhe.id into jornadaVal
from jornadas_has_equipos jhe
where jhe.jornadas_idJornada = idJornada
and jhe.equipos_idEquipoLocal = equipoLocal
and jhe.equipos_idEquipoVisita = equipoVisita
;

UPDATE `fifaxgam_fifaxgamersbd`.`jornadas_has_equipos`
SET
`golesLocal` = golesLocal,
`golesVisita` = golesVisita
WHERE `id` = jornadaVal
AND `jornadas_idJornada` = idJornada
;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
 DROP PROCEDURE IF EXISTS `updateUserManager` ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateUserManager`(IN idUsuario VARCHAR(30), 
								   IN idEquipo INT,
                                   IN rolesJson JSON, 
                                   
                                   out isError int, 
								   out message varchar(200)
                                   )
BEGIN

DECLARE userNameVar varchar(30);
DECLARE userNameActVar varchar(30);
DECLARE `_index` BIGINT UNSIGNED DEFAULT 0;
DECLARE `json_items` BIGINT UNSIGNED DEFAULT JSON_LENGTH(`rolesJson`);
DECLARE idRolVar INT;
DECLARE idRolExist INT;
DECLARE idRolInsert INT;
DECLARE deleteRol BIGINT UNSIGNED DEFAULT 0;





select userName into userNameActVar
from usuarios
where 
usuarios.userName = idUsuario 
;

if userNameActVar is not null then

	if idEquipo is not null and idEquipo > 0 then
		UPDATE `fifaxgam_fifaxgamersbd`.`usuarios`
		SET	
		`idequipo` = idEquipo
		
		WHERE `userName` = userNameActVar;
	else 
		UPDATE `fifaxgam_fifaxgamersbd`.`usuarios`
		SET	
		`idequipo` = null
		
		WHERE `userName` = userNameActVar;
    end if;

	if rolesJson is not null then 
		WHILE `_index` < `json_items` DO
			
            select JSON_EXTRACT(`rolesJson`, CONCAT('$[', `_index`, '].id')) into idRolVar;
			
            SELECT roles.idRoles into idRolExist
            FROM roles WHERE roles.idRoles = idRolVar;
            
            IF idRolExist IS NOT NULL THEN 
				if deleteRol = 0  then
					DELETE FROM `fifaxgam_fifaxgamersbd`.`usuarios_has_roles` 
					WHERE Usuarios_userName = userNameActVar ;
                    set deleteRol = 1;
				end if;
             
                
					INSERT INTO `fifaxgam_fifaxgamersbd`.`usuarios_has_roles`
					(`Usuarios_userName`,
					`Roles_idRoles`)
					VALUES
					(userNameActVar,
					idRolExist);

                
            END IF;
            
            
			SET `_index` := `_index` + 1;
    
    
		END WHILE;
    end if;
    
	set isError = 0 ;
	set message = 'OK';


elseif userNameActVar is null then
	set isError = 1 ;
	set message = 'El usuario no existe';
    
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-21 14:02:50
