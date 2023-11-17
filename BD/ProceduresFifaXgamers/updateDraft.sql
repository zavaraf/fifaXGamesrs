DELIMITER $$
DROP PROCEDURE IF EXISTS updateDraft$$
CREATE PROCEDURE updateDraft(IN idJugador INT,
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
declare ofertasActivas int;

set ofertasActivas = 0;


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
timestampdiff(MINUTE, DATE_ADD(DATE(now()),INTERVAL horaInicio HOUR), now()) Minutos_dia_Actual
from draftpc where draftpc.Persona_idPersona =  idJugadorVal and draftpc.tempodada_idTemporada = idTemporada) ta
;

select (case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end) nombreEquipo into observaciones
from equipos_has_temporada
join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
where  equipos_has_temporada.Equipos_idEquipo = idEquipoOferta
and  equipos_has_temporada.tempodada_idTemporada = idTemporada;

select count(*) into ofertasActivas 
from draftpc
join persona_has_temporada on persona_has_temporada.Persona_idPersona = draftpc.Persona_idPersona 
						and persona_has_temporada.temporada_idTemporada = draftpc.tempodada_idTemporada
where draftpc.usuarioOferta = manager 
and draftpc.tempodada_idTemporada = idTemporada
and draftpc.idEquipo != 1
and persona_has_temporada.equipos_idEquipo = 1;

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
  
  elseif ofertasActivas > 2
  
  then 
  set isError = 1 ;
  set message = 'Solo puedes tener 2 Ofertas Activas';

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
  set message = concat('Monto insuficiente revisa tus finanzas dinero restante: ' , montoBD);
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
     AND `tempodada_idTemporada` = idTemporada;
  
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
    AND `tempodada_idTemporada` = idTemporada;

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
    where draftpc.idEquipo = idEquipoOferta
        and draftpc.tempodada_idTemporada = idTemporada;
        
        call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
                      where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoOferta,
                                            idTemporada);
                                            
    
        
        if idEquipoAnterior != idEquipoOferta then 
        
      select sum(draftpc.ofertaFinal) into sumaDraftPC
      from draftpc
      where draftpc.idEquipo = idEquipoAnterior
      and draftpc.tempodada_idTemporada = idTemporada;
      
            call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
                      where nombre = 'altasPC' limit 1), 
                                            sumaDraftPC,
                                            idEquipoAnterior,
                                            idTemporada);
    end if;
  
    
    set isError = 0 ;
  set message = 'OK';
    
    
end if;

select isError,message;

END $$
DELIMITER ;