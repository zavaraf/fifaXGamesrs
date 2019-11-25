
DELIMITER ;;
DROP PROCEDURE IF EXISTS `addGoles` ;;
CREATE  PROCEDURE `addGoles`(IN idJornada int ,
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




set isError = 1 ;
set message = 'No se pudo agregar';

INSERT INTO `fifaxgamersbd`.`golesjornadas`
(`id`,
`persona_idPersona`,
`updatedate`,
`equipos_idEquipo`,
`jornadas_has_equipos_id`,
`jornadas_has_equipos_jornadas_idJornada`
)
VALUES
(null,
idJugador,
sysdate(),
idEquipo,
id,
idJornada
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
DELIMITER ;;
DROP PROCEDURE IF EXISTS `addImagen` ;;
CREATE  PROCEDURE `addImagen`(IN idJornada int ,
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
INSERT INTO `fifaxgamersbd`.`imagenesjornadas`
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
DELIMITER ;;
DROP PROCEDURE IF EXISTS `confirmPlayer` ;;
CREATE  PROCEDURE `confirmPlayer`(IN idJugador INT,
                            IN idEquipoOferta INT,
                            IN idTorneo INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE idEquipoExist int;

DECLARE idEquipoVar int;
DECLARE idTorneoVar int;
declare activoVar bit;
declare horasConfir int;


select draftpc.Persona_idPersona,draftpc.idEquipo into  idJugadorVal,idEquipoVar
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.Torneos_idTorneo = idTorneo;

select persona.idPersona , persona.Equipos_idEquipo into  idJugadorExist, idEquipoExist
from persona
where persona.idPersona = idJugador;

set  idTorneoVar = idTorneo;



select monto into horasConfir
from configuraciondraft
where codigo='confirmacionDraft'
limit 1;

SELECT timestampdiff(Minute, fechaCompra, now()) >= horasConfir as activo INTO activoVar
FROM draftpc
where draftpc.Persona_idPersona =  idJugadorVal
and Torneos_idTorneo = idTorneoVar
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
	 
     UPDATE `fifaxgamersbd`.`persona`
	SET
	  `Equipos_idEquipo` = idEquipoVar

	WHERE `idPersona` = idJugador;
	
    
    set isError = 0 ;
	set message = 'OK';
    
    
end if;


END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `crearJornada` ;;
CREATE  PROCEDURE `crearJornada`(IN equipoLocal int , 
                               IN equipoVisita int,
							   IN numJornada INT,
                               IN torneo INT,
                               IN division int,
                               IN liga int,
                               IN activa int,
                               IN id int,
                               out isError int, 
                               out message varchar(200))
BEGIN

-- Opcion 1, crear jornadas, opcion 2 activar Jornadas

DECLARE jornadaVal int;
DECLARE idjornadaVal int;
DECLARE idjornadaValInsert int;
declare idJ int;

set isError = 1 ;
set message = 'El jugador no Existe';


select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneos_idTorneo = torneo
and jornadas.liga_idLiga = liga
and jornadas.division_idDivision = division;




if idjornadaVal is null then

INSERT INTO `fifaxgamersbd`.`jornadas`
(`idJornada`,
`torneos_idTorneo`,
`division_idDivision`,
`numeroJornada`,
`liga_idLiga`,
`activa`)
VALUES
(null,
torneo,
division,
numJornada,
liga,
activa
);

else if idjornadaVal is not null then

UPDATE `fifaxgamersbd`.`jornadas`
SET
`activa` = activa

WHERE `idJornada` = idjornadaVal AND `division_idDivision` = division;
end if;


end if;

select jornadas.idJornada into idjornadaVal
from jornadas
where jornadas.numeroJornada = numJornada
and jornadas.torneos_idTorneo = torneo
and jornadas.liga_idLiga = liga
and jornadas.division_idDivision = division;


select hje.id into idJ
from jornadas_has_equipos hje
where hje.id = id 
and hje.equipos_idEquipoLocal = equipoLocal
and hje.equipos_idEquipoVisita = equipoVisita
and hje.jornadas_idJornada = idjornadaVal;

if idJ is null then 

INSERT INTO `fifaxgamersbd`.`jornadas_has_equipos`
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

set isError = 0 ;
set message = 'OK';



END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `crearJugador` ;;
CREATE  PROCEDURE `crearJugador`(IN nombreCompleto varchar(200) , IN sobrenonbre varchar(200),IN raiting INT,IN idEquipo INT,IN link varchar(200))
BEGIN


INSERT INTO `fifaxgamersbd`.`persona`
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
    
        
INSERT INTO `fifaxgamersbd`.`persona_has_roles`
(`Persona_idPersona`,
`Roles_idRoles`)
VALUES
((SELECT persona.idPersona
FROM persona
ORDER by persona.idPersona DESC limit 1),
1);



        

END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createInitialDraft` ;;
CREATE  PROCEDURE `createInitialDraft`(IN idJugador INT,
									IN montoOferta INT,
                                    IN manager varchar(100),
                                    IN observaciones varchar(100), 
                                    IN idEquipoOferta INT,
                                    IN idTorneo INT,
                                    out isError int, 
                                    out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE montoBD int;
DECLARE idTorneoVar int;
DECLARE sumaDraftPC int;
DECLARE ofertaInicial int;


select draftpc.Persona_idPersona into  idJugadorVal
from draftpc
where draftpc.Persona_idPersona = idJugador and draftpc.Torneos_idTorneo = idTorneo;

select persona.idPersona into idJugadorExist
from persona
where persona.idPersona = idJugador;

set idTorneoVar = idTorneo;


select dat.presupuestoFinal into montoBD
from datosfinancieros dat
where dat.Equipos_idEquipo = idEquipoOferta
and dat.Torneos_idTorneo = idTorneoVar;

select monto into ofertaInicial
from configuraciondraft
where codigo='ofertaInicial'
limit 1;

select idJugadorVal;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';
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
	INSERT INTO `fifaxgamersbd`.`draftpc`
	(`idDraftPC`,
	`oferta`,
	`Persona_idPersona`,
	`fechaCompra`,
	`usuarioOferta`,
	`Torneos_idTorneo`,
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
	(select idTorneo from torneos order by torneos.idTorneo desc limit 1),
	observaciones,
	1,
    montoOferta,
    idEquipoOferta);
    
    INSERT INTO `fifaxgamersbd`.`historicodraft`
		(`idHistoricoDraft`,
		`oferta`,
		`fechaOferta`,
		`usuarioOferta`,
		`DraftPC_idDraftPC`,
		`DraftPC_Persona_idPersona`,
		`Torneos_idTorneo`,
		`comentarios`,
		`ofertaFinal`,
        `idEquipo`)
		(select null,
			draftpc.oferta,
			draftpc.fechaCompra,
			draftpc.usuarioOferta,
			draftpc.idDraftPC,
			draftpc.Persona_idPersona,
			draftpc.Torneos_idTorneo,
			draftpc.comentarios,
			draftpc.ofertaFinal,
            draftpc.idEquipo
			from draftpc
		where draftpc.Persona_idPersona = idJugador
        and draftpc.Torneos_idTorneo = (select idTorneo from torneos order by torneos.idTorneo desc limit 1)
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
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createOrUpdateDatosFinancieros` ;;
CREATE  PROCEDURE `createOrUpdateDatosFinancieros`(IN idDatos INT, IN monto INT,IN idEquipo INT)
BEGIN

DECLARE idTorneoVar int;
DECLARE idDatosVar  int;
DECLARE isUpdate  int;

select idTorneo into idTorneoVar
from torneos
order by torneos.idTorneo desc
limit 1;


select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 

and datos.Torneos_idTorneo = idTorneoVar
limit 1
;

select con.idConceptosFinancieros into isUpdate
from conceptosfinancieros con
where con.CatalogoConceptos_idCatalogoConceptos = idDatos
and con.DatosFinancieros_idDatosFinancieros = idDatosVar
and con.DatosFinancieros_Equipos_idEquipo = idEquipo

and con.DatosFinancieros_Torneos_idTorneo = idTorneoVar;

	IF isUpdate is null or isUpdate = 0  then





	INSERT INTO `fifaxgamersbd`.`conceptosfinancieros`
		(`idConceptosFinancieros`,
		`DatosFinancieros_idDatosFinancieros`,
		`monto`,
		`CatalogoConceptos_idCatalogoConceptos`,
        `DatosFinancieros_Equipos_idEquipo`,
        
        `DatosFinancieros_Torneos_idTorneo`)
		VALUES
		(null,
        idDatosVar,
		monto,
		idDatos,
        idEquipo,
        
        idTorneoVar);
    
    elseif isUpdate is not null then
    
		UPDATE `fifaxgamersbd`.`conceptosfinancieros`
		SET	`monto` = monto
		WHERE `idConceptosFinancieros` = isUpdate 
		AND `DatosFinancieros_idDatosFinancieros` = idDatosVar 
		AND `CatalogoConceptos_idCatalogoConceptos` = idDatos
        and `DatosFinancieros_Equipos_idEquipo` = idEquipo
		
		and `DatosFinancieros_Torneos_idTorneo` = idTorneoVar;

	
	END IF;



END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createOrUpdateDatosSponsor` ;;
CREATE  PROCEDURE `createOrUpdateDatosSponsor`(IN idEquipo INT, IN idSponsor INT, IN opcionales INT)
BEGIN

DECLARE idTorneoVar int;
DECLARE idDatosVar  int;

select idTorneo into idTorneoVar
from torneos
order by torneos.idTorneo desc
limit 1;

select idTorneoVar;

select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 
and datos.Torneos_idTorneo = idTorneoVar
limit 1
;

select idDatosVar;

IF idTorneoVar is not null  and idDatosVar is null then
   INSERT INTO `fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`Torneos_idTorneo`,
`sponsorOpcional`)
VALUES
(1,
0,
0,
idEquipo,
idTorneoVar,
opcionales);

elseif idDatosVar is not null then

UPDATE `fifaxgamersbd`.`datosfinancieros`
SET 
`sponsorOpcional` = opcionales
WHERE  `Equipos_idEquipo` = idEquipo
AND `Torneos_idTorneo` = idTorneoVar;


END IF;

	IF opcionales = 0 then 
    
    INSERT INTO `fifaxgamersbd`.`dadosfinancierossponsor`
	(`DatosFinancieros_idDatosFinancieros`,
	`DatosFinancieros_Equipos_idEquipo`,
	`DatosFinancieros_Torneos_idTorneo`,
	`Sponsor_idSponsor`,
	`ConceptoSponsor_idConcepto`,
	`cumplio`)
	select 1,idEquipo,idTorneoVar,idSponsor,cons.idConcepto,0
			from sponsor
			join sponsor_has_concepto sponc on sponsor.idSponsor = sponc.Sponsor_idSponsor
			join conceptosponsor cons on sponc.Concepto_idConcepto = cons.idConcepto
			where sponsor.idSponsor = idSponsor
			and cons.opcional = opcionales;

        
	ELSEIF opcionales = 1 then
		INSERT INTO `fifaxgamersbd`.`dadosfinancierossponsor`
			(`DatosFinancieros_idDatosFinancieros`,
			`DatosFinancieros_Equipos_idEquipo`,
			`DatosFinancieros_Torneos_idTorneo`,
			`Sponsor_idSponsor`,
			`ConceptoSponsor_idConcepto`,
			`cumplio`)
		select 1,idEquipo,idTorneoVar,idSponsor,cons.idConcepto,0
        from sponsor
        join sponsor_has_concepto sponc on sponsor.idSponsor = sponc.Sponsor_idSponsor
		join conceptosponsor cons on sponc.Concepto_idConcepto = cons.idConcepto
		where sponsor.idSponsor = idSponsor
		;
	END IF;



END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createOrUpdateObjetivos` ;;
CREATE  PROCEDURE `createOrUpdateObjetivos`(IN `json` JSON,IN idEquipo INT, IN idSponsor INT,IN idTorneo INT)
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
        AND `DatosFinancieros_Torneos_idTorneo` = idTorneo
        AND `Sponsor_idSponsor` = idSponsor
        AND `ConceptoSponsor_idConcepto` = var;

        
    SET `_index` := `_index` + 1;
    
    
  END WHILE;

  


END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createOrUpdatePresupuesto` ;;
CREATE  PROCEDURE `createOrUpdatePresupuesto`(IN idEquipo INT,  IN monto INT, IN montoFinal INT,
										  IN montoFinalSponsor INT,
                                          IN idTorneo INT)
BEGIN

DECLARE idTorneoVar int;
DECLARE idDatosVar  int;
DECLARE isUpdate  int;


set idTorneoVar = idTorneo;

select datos.idDatosFinancieros INTO idDatosVar
from datosfinancieros datos
where datos.Equipos_idEquipo = idEquipo 
and datos.Torneos_idTorneo = idTorneoVar;



if idDatosVar is null then 

INSERT INTO `fifaxgamersbd`.`datosfinancieros`
(`idDatosFinancieros`,
`presupuestoInicial`,
`presupuestoFinal`,
`Equipos_idEquipo`,
`Torneos_idTorneo`,
`sponsorOpcional`,
`presupuestoFinalSponsor`)
VALUES
(1,
monto,
montoFinal,
idEquipo,
idTorneoVar,
0,
montoFinalSponsor);

else

UPDATE `fifaxgamersbd`.`datosfinancieros`
SET

`presupuestoInicial` = monto,
`presupuestoFinal` = montoFinal,
`presupuestoFinalSponsor` = montoFinalSponsor

WHERE `idDatosFinancieros` = idDatosVar 
AND `Equipos_idEquipo` = idEquipo

AND `Torneos_idTorneo` = idTorneoVar;

end if;

END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createPrestamo` ;;
CREATE  PROCEDURE `createPrestamo`(IN idJugador INT,IN idEquipo INT,IN idTorneo INT,IN opcion INT)
BEGIN

DECLARE idEquipoAnterior int;
DECLARE idJugadorVal int;

select prestamos.Persona_idPersona into idJugadorVal
from prestamos
where prestamos.Persona_idPersona = idJugador
and prestamos.Torneos_idTorneo = idTorneo;

IF opcion is null or opcion = 1 then 

	if(idJugadorVal is null) then

		select persona.Equipos_idEquipo into  idEquipoAnterior
		from persona
		where persona.idPersona = idJugador;

		select idEquipoAnterior;

		UPDATE `fifaxgamersbd`.`persona`
		SET
		`Equipos_idEquipo` = idEquipo,
		`prestamo` = 1
		WHERE `idPersona` = idJugador;


		INSERT INTO `fifaxgamersbd`.`prestamos`
		(`Persona_idPersona`,
		`Equipos_idEquipo`,
        `Torneos_idTorneo`,
		`activo`)
		VALUES
		(idJugador,
		idEquipoAnterior,
        idTorneo,
		1);

	END IF;

elseif opcion = 2 then

	select prestamos.Equipos_idEquipo  into  idEquipoAnterior
	from prestamos
	where prestamos.Persona_idPersona  = idJugador;
    
    UPDATE `fifaxgamersbd`.`persona`
		SET
		`Equipos_idEquipo` = idEquipoAnterior,
		`prestamo` = 0
		WHERE `idPersona` = idJugadorVal and `Torneos_idTorneo` = idTorneo;

	delete from prestamos 
    where prestamos.Persona_idPersona = idJugadorVal
    and prestamos.Equipos_idEquipo = idEquipoAnterior
    and prestamos.Torneos_idTorneo = idTorneo;

end if;

END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `createTorneo` ;;
CREATE  PROCEDURE `createTorneo`( IN nombreTorneo varchar(200) , IN descripcionTorneo varchar(200))
BEGIN

DECLARE idTorneoVar int;

INSERT INTO `fifaxgamersbd`.`torneos`
(
`NombreTorneo`,
`Descripcion`)
VALUES
(
NombreTorneo,
descripcionTorneo);

select idTorneo into idTorneoVar
from torneos
order by torneos.idTorneo desc
limit 1;

INSERT INTO `fifaxgamersbd`.`equipos_has_torneos`
(`Equipos_idEquipo`,
`Torneos_idTorneo`)
(select idEquipo,idTorneoVar 
from equipos);



END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `modificarJugador` ;;
CREATE  PROCEDURE `modificarJugador`(IN nombreCompleto varchar(200) , IN sobrenonbre varchar(200),IN raiting INT,IN idEquipo INT, IN idJugador INT,IN link varchar(300))
BEGIN


update persona set persona.NombreCompleto = nombreCompleto,
                   persona.sobrenombre = sobrenonbre,
                   persona.Raiting = raiting,
                   persona.Equipos_idEquipo = idEquipo,
                   persona.link = link
where persona.idPersona = idJugador;
       

END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `spTest` ;;
CREATE  PROCEDURE `spTest`()
BEGIN


select * from equipos;
select * from conceptosponsor;

 
END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `updateDraft` ;;
CREATE  PROCEDURE `updateDraft`(IN idJugador INT,
							IN montoInicial INT,
                            IN montoOferta INT,
                            IN manager varchar(100),
                            IN observaciones varchar(100), 
                            IN idEquipoOferta INT,
                            IN idTorneo INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idJugadorVal int;
DECLARE idJugadorExist int;
DECLARE montoFinalVal int;
DECLARE idEquipo int;
DECLARE idTorneoVar int;
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
where draftpc.Persona_idPersona = idJugador and draftpc.Torneos_idTorneo = idTorneo;

select persona.idPersona into idJugadorExist
from persona
where persona.idPersona = idJugador;

set idTorneoVar = idTorneo ;

select dat.presupuestoFinal into montoBD
from datosfinancieros dat
where dat.Equipos_idEquipo = idEquipoOferta
and dat.Torneos_idTorneo = idTorneoVar;

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
from draftpc where draftpc.Persona_idPersona =  42 and draftpc.Torneos_idTorneo = 2) ta
;

select idJugadorVal;

if idJugadorExist is null then 
	set isError = 1 ;
  set message = 'El jugador no Existe';

  
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
     AND `Torneos_idTorneo` = (select idTorneo from torneos order by torneos.idTorneo desc limit 1);
	
    UPDATE `fifaxgamersbd`.`draftpc`
	SET
    `oferta`      = montoInicial,
	`ofertaFinal` = montoOferta,
	`fechaCompra` = sysdate(),
	`usuarioOferta` = manager,
	`comentarios` = observaciones,
    `idEquipo` = idEquipoOferta
	WHERE `idDraftPC` = 1
    AND `Persona_idPersona` = idJugador
    AND `Torneos_idTorneo` = (select idTorneo from torneos order by torneos.idTorneo desc limit 1);

	INSERT INTO `fifaxgamersbd`.`historicodraft`
		(`idHistoricoDraft`,
		`oferta`,
		`fechaOferta`,
		`usuarioOferta`,
		`DraftPC_idDraftPC`,
		`DraftPC_Persona_idPersona`,
		`Torneos_idTorneo`,
		`comentarios`,
		`ofertaFinal`,
        `idEquipo`)
		(select null,
			montoFinalVal,
			draftpc.fechaCompra,
			draftpc.usuarioOferta,
			draftpc.idDraftPC,
			draftpc.Persona_idPersona,
			draftpc.Torneos_idTorneo,
			draftpc.comentarios,
			montoOferta,
            draftpc.idEquipo
			from draftpc
		where draftpc.Persona_idPersona = idJugador
        and draftpc.Torneos_idTorneo = (select idTorneo from torneos order by torneos.idTorneo desc limit 1)
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


END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `updateResultadoJornada` ;;
CREATE  PROCEDURE `updateResultadoJornada`(IN idJornada int ,
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

UPDATE `fifaxgamersbd`.`jornadas_has_equipos`
SET
`golesLocal` = golesLocal,
`golesVisita` = golesVisita
WHERE `id` = jornadaVal
AND `jornadas_idJornada` = idJornada
;


END ;;
DELIMITER ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `updateUserManager` ;;
CREATE  PROCEDURE `updateUserManager`(IN idUsuario VARCHAR(30), 
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
		UPDATE `fifaxgamersbd`.`usuarios`
		SET	
		`idequipo` = idEquipo
		
		WHERE `userName` = userNameActVar;
	else 
		UPDATE `fifaxgamersbd`.`usuarios`
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
					DELETE FROM `fifaxgamersbd`.`usuarios_has_roles` 
					WHERE Usuarios_userName = userNameActVar ;
                    set deleteRol = 1;
				end if;
             
                
					INSERT INTO `fifaxgamersbd`.`usuarios_has_roles`
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


-- Dump completed on 2019-11-21 11:21:52
