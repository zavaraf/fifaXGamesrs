DELIMITER $$
DROP PROCEDURE IF EXISTS modificarJugador$$
CREATE PROCEDURE `modificarJugador`(IN nombreCompleto varchar(200) , 
								   IN sobrenonbre varchar(200),
                                   IN raiting INT,
                                   IN idEquipo INT, 
                                   IN idJugador INT,
                                   IN link varchar(300),
                                   IN idsofifa INT,
                                   IN idTemporada INT,
                                   IN img varchar(200),
								   IN idEquipoPago INT,
                                   IN costo INT
                                   )
BEGIN

declare  idEquipoVar int;
declare  sumaDraft double;
declare  sumaDraftPago double;
declare  idEquipoAnt int;
declare  idTempAnt int;
declare  existe int ;
declare  idEquipoAct int ;





set existe = null;

update persona set persona.NombreCompleto = nombreCompleto,
                   persona.sobrenombre = sobrenonbre,
                 --  persona.Raiting = raiting,
                   persona.Equipos_idEquipo = idEquipo,
                   persona.link = link,
                   persona.idsofifa = idsofifa,
                   persona.img = img
where persona.idPersona = idJugador;

UPDATE persona_has_temporada
SET
`rating` = raiting,
`equipos_idEquipo` = idEquipo,
persona_has_temporada.costo = costo
WHERE `persona_idPersona` = idJugador
AND `temporada_idTemporada` = idTemporada
;



select Equipos_idEquipo into idEquipoVar 
 from equipos_has_temporada eht 
 where eht.Equipos_idEquipo = idEquipo and eht.tempodada_idTemporada = idTemporada;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO equipos_has_temporada
(`Equipos_idEquipo`,
`Temporada_idTemporada`)
VALUES
(idEquipo,
idTemporada);

 end if ;
 
 
 
 select max(temporada.idTemporada) into idEquipoAct
                from temporada    
               ;
               
if idTemporada = idEquipoAct then 
 
	select persona_has_temporada.persona_idPersona into existe
	from persona_has_temporada
	where persona_has_temporada.persona_idPersona = idJugador
	and persona_has_temporada.equipos_idEquipo = idEquipo
	and persona_has_temporada.temporada_idTemporada = idTemporada
	and persona_has_temporada.costo > 0 ;



	select max(temporada.idTemporada) into idTempAnt
					from temporada    
					where temporada.idTemporada < idTemporada;

	select persona_has_temporada.equipos_idEquipo  into  idEquipoAnt  
	from persona_has_temporada
	where persona_has_temporada.persona_idPersona = idJugador
	and persona_has_temporada.temporada_idTemporada = idTempAnt;
					



	set sumaDraft = 0;

	   select sum(persona_has_temporada.costo) into sumaDraft 
		from persona_has_temporada
		where 
		persona_has_temporada.temporada_idTemporada = idTemporada
		and persona_has_temporada.equipos_idEquipo = 1
	and  persona_has_temporada.persona_idPersona in (
	 select persona_has_temporada.persona_idPersona
		from persona_has_temporada
		where persona_has_temporada.equipos_idEquipo = idEquipoAnt
			and persona_has_temporada.temporada_idTemporada = idTempAnt        
			);
			
	 select existe,costo,idEquipoPago, sumaDraft,idJugador,idEquipoAnt,idTemporada,idTempAnt ;

			
	   call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
						  where nombre = 'bajasPC' limit 1), 
												sumaDraft ,
												idEquipoAnt,
												idTemporada);
		   
	 set sumaDraft = 0;
	 
		select sum(persona_has_temporada.costo) into sumaDraft 
		from persona_has_temporada
			where 
			persona_has_temporada.temporada_idTemporada = idTemporada
			and persona_has_temporada.equipos_idEquipo != 1
		and  persona_has_temporada.persona_idPersona in (
		 select persona_has_temporada.persona_idPersona
			from persona_has_temporada
			where persona_has_temporada.equipos_idEquipo = idEquipoAnt
				and persona_has_temporada.temporada_idTemporada = idTempAnt        
				);
				
			call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
						  where nombre = 'ventasDT' limit 1), 
												sumaDraft ,
												idEquipoAnt,
												idTemporada);

	  
	  set sumaDraft = 0;
	  
	select sum(persona_has_temporada.costo) into sumaDraft
		from persona_has_temporada
		where persona_has_temporada.equipos_idEquipo = idEquipoPago
			and persona_has_temporada.temporada_idTemporada = idTemporada
			and persona_has_temporada.persona_idPersona != idJugador;
			
			if sumaDraft is null then 
				set sumaDraft = costo;
			else 
				set sumaDraft = sumaDraft  + costo ;
			end if;
			
			select existe,costo,sumaDraft,idEquipoPago, sumaDraft,idJugador,idEquipoAnt,idTemporada,idTempAnt ;
			
			call createOrUpdateDatosFinancieros((select idCatalogoConceptos from catalogoconceptos
						  where nombre = 'comprasDT' limit 1), 
												sumaDraft ,
												idEquipo,
												idTemporada);
												
end if;


       

END $$
DELIMITER ;