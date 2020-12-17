DELIMITER $$
DROP PROCEDURE IF EXISTS createPrestamo$$
CREATE PROCEDURE createPrestamo(IN idJugador INT,IN idEquipo INT,IN idTemporada INT,IN opcion INT)
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

		UPDATE `fifaxgamersbd`.`persona`
		SET
		`Equipos_idEquipo` = idEquipo,
		`prestamo` = 1
		WHERE `idPersona` = idJugador;
        
        UPDATE persona_has_temporada
		SET
		persona_has_temporada.equipos_idEquipo = idEquipo
		
		WHERE persona_has_temporada.persona_idPersona = idJugador 
        and persona_has_temporada.temporada_idTemporada = idTemporada;  


		INSERT INTO `fifaxgamersbd`.`prestamos`
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
    
    UPDATE persona
		SET
		persona.Equipos_idEquipo = idEquipoAnterior,
		persona.prestamo = 0
		WHERE persona.idPersona = idJugadorVal 
        ;
        
      

	delete from prestamos 
    where prestamos.Persona_idPersona = idJugadorVal
    and prestamos.Equipos_idEquipo = idEquipoAnterior
    and prestamos.tempodada_idTemporada = idTemporada;

end if;

END $$
DELIMITER ;