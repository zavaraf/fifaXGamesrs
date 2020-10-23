DROP TABLE IF EXISTS `conceptosfinancieros`;
 DROP TABLE IF EXISTS `catalogoconceptos`;
DROP TABLE IF EXISTS `dadosfinancierossponsor`;

DROP TABLE IF EXISTS `sponsor_has_concepto`;
DROP TABLE IF EXISTS `conceptosponsor`;
DROP TABLE IF EXISTS `configuraciondraft`;

DROP TABLE IF EXISTS `datosfinancieros`;

DROP TABLE IF EXISTS `historicodraft`;
DROP TABLE IF EXISTS `draftpc`;


DROP TABLE IF EXISTS `golesjornadas`;

DROP TABLE IF EXISTS `persona_has_roles`;
DROP TABLE IF EXISTS `prestamos`;
DROP TABLE IF EXISTS `persona`;


DROP TABLE IF EXISTS `equipos_has_imagen`;
DROP TABLE IF EXISTS `equipos_has_temporada`;
DROP TABLE IF EXISTS `imagenesjornadas`;
DROP TABLE IF EXISTS `jornadas_has_equipos`;

DROP TABLE IF EXISTS `jornadas`;
DROP TABLE IF EXISTS `grupos_torneo`;

DROP TABLE IF EXISTS `equipos`;


DROP TABLE IF EXISTS `sponsor`;

DROP TABLE IF EXISTS `division`;



DROP TABLE IF EXISTS `usuarios_has_roles`;



DROP TABLE IF EXISTS `roles`;


DROP TABLE IF EXISTS `tipoconcepto`;
DROP TABLE IF EXISTS `tipoimagen`;

DROP TABLE IF EXISTS `torneo`;
DROP TABLE IF EXISTS `tipotorneo`;

DROP TABLE IF EXISTS `usuarios`;

DROP TABLE IF EXISTS `temporada`;

DROP TABLE IF EXISTS `liga`;



DROP PROCEDURE IF EXISTS `addGoles` ;
DROP PROCEDURE IF EXISTS `addImagen` ;
DROP PROCEDURE IF EXISTS `confirmPlayer` ;
DROP PROCEDURE IF EXISTS `crearJornada` ;
DROP PROCEDURE IF EXISTS `crearJornadasFinales` ;
DROP PROCEDURE IF EXISTS `crearJugador` ;
DROP PROCEDURE IF EXISTS `crearTorneo` ;
DROP PROCEDURE IF EXISTS `createInitialDraft` ;
DROP PROCEDURE IF EXISTS `createOrTorneoGrupos` ;
DROP PROCEDURE IF EXISTS `createOrUpdateConceptos` ;
DROP PROCEDURE IF EXISTS `createOrUpdateDatosFinancieros` ;
DROP PROCEDURE IF EXISTS `createOrUpdateDatosSponsor` ;
DROP PROCEDURE IF EXISTS `createOrUpdateObjetivos` ;
DROP PROCEDURE IF EXISTS `createOrUpdatePresupuesto` ;
DROP PROCEDURE IF EXISTS `createPrestamo` ;
DROP PROCEDURE IF EXISTS `createTemporada` ;
DROP PROCEDURE IF EXISTS `modificarJugador` ;
DROP PROCEDURE IF EXISTS `registrarJornada` ;
DROP PROCEDURE IF EXISTS `spTest` ;
DROP PROCEDURE IF EXISTS `updateDraft` ;
DROP PROCEDURE IF EXISTS `updateDraftCorreccion` ;
DROP PROCEDURE IF EXISTS `updateResultadoJornada` ;
DROP PROCEDURE IF EXISTS `updateUserManager` ;