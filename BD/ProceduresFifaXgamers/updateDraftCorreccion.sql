DELIMITER $$
DROP PROCEDURE IF EXISTS updateDraftCorreccion$$
CREATE PROCEDURE updateDraftCorreccion(IN idJugador INT,
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
    AND tempodada_idTemporada = idTemporada;

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
    
    


END $$
DELIMITER ;