delete from imagenesjornadas
where id!=0;

delete from golesjornadas
where id!=0;

delete from jornadas_has_equipos
where jornadas_idJornada  != 0;

DELETE FROM jornadas
WHERE idJornada !=0;

delete from historicodraft
where historicodraft.DraftPC_idDraftPC !=0;

delete from draftpc
where draftpc.idDraftPC  !=0;

delete from prestamos
where prestamos.Equipos_idEquipo!=0;

delete from persona_has_roles
where persona_has_roles.Persona_idPersona !=0;

delete from persona 
where persona.idPersona !=0;

delete from equipos_has_temporada
where equipos_has_temporada.Equipos_idEquipo!=0;

select * from conceptosfinancieros;

delete from conceptosfinancieros
where conceptosfinancieros.idConceptosFinancieros!=0;

delete from dadosfinancierossponsor
where dadosfinancierossponsor.ConceptoSponsor_idConcepto!=0;

delete from datosfinancieros
where datosfinancieros.Equipos_idEquipo!=0;

delete from equipos 
where equipos.idEquipo!=0;




