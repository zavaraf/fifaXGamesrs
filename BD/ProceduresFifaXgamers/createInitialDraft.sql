DELIMITER $$
DROP PROCEDURE IF EXISTS createInitialDraft$$
CREATE PROCEDURE createInitialDraft(IN idJugador INT,
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
	INSERT INTO `fifaxgamersbd`.`draftpc`
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
	idTemporada,
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
        and draftpc.tempodada_idTemporada = idTemporada
        and draftpc.idDraftPC = 1
        limit 1);
        
        select sum(draftpc.ofertaFinal) into sumaDraftPC
		from draftpc
		where draftpc.idEquipo = idEquipoOferta and
		      draftpc.tempodada_idTemporada = idTemporada;
        
        call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
											where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoOferta);

    
    set isError = 0 ;
	set message = 'OK';
    
    
end if;

END $$
DELIMITER ;