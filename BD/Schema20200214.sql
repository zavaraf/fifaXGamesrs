-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: database-1.c5pfdjducnqe.us-east-2.rds.amazonaws.com    Database: fifaxgamersbd
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `catalogoconceptos`
--

DROP TABLE IF EXISTS `catalogoconceptos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogoconceptos` (
  `idCatalogoConceptos` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `TipoConcepto_idTipoConcepto` int(11) NOT NULL,
  PRIMARY KEY (`idCatalogoConceptos`,`TipoConcepto_idTipoConcepto`),
  KEY `fk_CatalogoConceptos_TipoConcepto1_idx` (`TipoConcepto_idTipoConcepto`),
  CONSTRAINT `fk_CatalogoConceptos_TipoConcepto1` FOREIGN KEY (`TipoConcepto_idTipoConcepto`) REFERENCES `tipoconcepto` (`idTipoConcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conceptosfinancieros`
--

DROP TABLE IF EXISTS `conceptosfinancieros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conceptosfinancieros` (
  `idConceptosFinancieros` int(11) NOT NULL AUTO_INCREMENT,
  `monto` float DEFAULT NULL,
  `CatalogoConceptos_idCatalogoConceptos` int(11) NOT NULL,
  `DatosFinancieros_idDatosFinancieros` int(11) NOT NULL,
  `DatosFinancieros_Equipos_idEquipo` int(11) NOT NULL,
  `datosfinancieros_tempodada_idTemporada` int(11) NOT NULL,
  PRIMARY KEY (`idConceptosFinancieros`,`CatalogoConceptos_idCatalogoConceptos`,`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`datosfinancieros_tempodada_idTemporada`),
  KEY `fk_ConceptosFinancieros_CatalogoConceptos1_idx` (`CatalogoConceptos_idCatalogoConceptos`),
  KEY `fk_ConceptosFinancieros_DatosFinancieros1_idx` (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`datosfinancieros_tempodada_idTemporada`),
  CONSTRAINT `fk_ConceptosFinancieros_CatalogoConceptos1` FOREIGN KEY (`CatalogoConceptos_idCatalogoConceptos`) REFERENCES `catalogoconceptos` (`idCatalogoConceptos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConceptosFinancieros_DatosFinancieros1` FOREIGN KEY (`DatosFinancieros_idDatosFinancieros`, `DatosFinancieros_Equipos_idEquipo`, `datosfinancieros_tempodada_idTemporada`) REFERENCES `datosfinancieros` (`idDatosFinancieros`, `Equipos_idEquipo`, `tempodada_idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conceptosponsor`
--

DROP TABLE IF EXISTS `conceptosponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conceptosponsor` (
  `idConcepto` int(11) NOT NULL,
  `nombreConcepto` varchar(100) DEFAULT NULL,
  `descripcionConcepto` varchar(100) DEFAULT NULL,
  `opcional` binary(1) DEFAULT NULL,
  `monto` float DEFAULT NULL,
  `penalidad` float DEFAULT NULL,
  PRIMARY KEY (`idConcepto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configuraciondraft`
--

DROP TABLE IF EXISTS `configuraciondraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuraciondraft` (
  `idconfiguracionDraft` int(11) NOT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `monto` int(11) DEFAULT NULL,
  PRIMARY KEY (`idconfiguracionDraft`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dadosfinancierossponsor`
--

DROP TABLE IF EXISTS `dadosfinancierossponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dadosfinancierossponsor` (
  `DatosFinancieros_idDatosFinancieros` int(11) NOT NULL,
  `DatosFinancieros_Equipos_idEquipo` int(11) NOT NULL,
  `datosfinancieros_tempodada_idTemporada` int(11) NOT NULL,
  `Sponsor_idSponsor` int(11) NOT NULL,
  `ConceptoSponsor_idConcepto` int(11) NOT NULL,
  `cumplio` bit(1) DEFAULT NULL,
  PRIMARY KEY (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`datosfinancieros_tempodada_idTemporada`,`Sponsor_idSponsor`,`ConceptoSponsor_idConcepto`),
  KEY `fk_DadosFinancierosSponsor_DatosFinancieros1_idx` (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`datosfinancieros_tempodada_idTemporada`),
  KEY `fk_DadosFinancierosSponsor_Sponsor1_idx` (`Sponsor_idSponsor`),
  KEY `fk_DadosFinancierosSponsor_ConceptoSponsor1_idx` (`ConceptoSponsor_idConcepto`),
  CONSTRAINT `fk_DadosFinancierosSponsor_ConceptoSponsor1` FOREIGN KEY (`ConceptoSponsor_idConcepto`) REFERENCES `conceptosponsor` (`idConcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DadosFinancierosSponsor_DatosFinancieros1` FOREIGN KEY (`DatosFinancieros_idDatosFinancieros`, `DatosFinancieros_Equipos_idEquipo`, `datosfinancieros_tempodada_idTemporada`) REFERENCES `datosfinancieros` (`idDatosFinancieros`, `Equipos_idEquipo`, `tempodada_idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DadosFinancierosSponsor_Sponsor1` FOREIGN KEY (`Sponsor_idSponsor`) REFERENCES `sponsor` (`idSponsor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datosfinancieros`
--

DROP TABLE IF EXISTS `datosfinancieros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datosfinancieros` (
  `idDatosFinancieros` int(11) NOT NULL AUTO_INCREMENT,
  `presupuestoInicial` float DEFAULT NULL,
  `presupuestoFinal` float DEFAULT NULL,
  `Equipos_idEquipo` int(11) NOT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  `sponsorOpcional` bit(1) DEFAULT NULL,
  `presupuestoFinalSponsor` float DEFAULT NULL,
  PRIMARY KEY (`idDatosFinancieros`,`Equipos_idEquipo`,`tempodada_idTemporada`),
  KEY `fk_DatosFinancieros_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_DatosFinancieros_Temporada1_idx` (`tempodada_idTemporada`),
  CONSTRAINT `fk_DatosFinancieros_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DatosFinancieros_Temporada1` FOREIGN KEY (`tempodada_idTemporada`) REFERENCES `temporada` (`idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `division` (
  `idDivision` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `activo` binary(1) DEFAULT '1',
  `Liga_idLiga` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDivision`),
  KEY `fk_Division_Liga1_idx` (`Liga_idLiga`),
  CONSTRAINT `fk_Division_Liga1` FOREIGN KEY (`Liga_idLiga`) REFERENCES `liga` (`idLiga`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draftpc`
--

DROP TABLE IF EXISTS `draftpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draftpc` (
  `idDraftPC` int(11) NOT NULL,
  `oferta` float DEFAULT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `fechaCompra` datetime(6) DEFAULT NULL,
  `usuarioOferta` varchar(45) DEFAULT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  `comentarios` varchar(200) DEFAULT NULL,
  `abierto` bit(1) DEFAULT NULL,
  `ofertaFinal` int(11) DEFAULT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  `updateDraft` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDraftPC`,`Persona_idPersona`,`tempodada_idTemporada`),
  KEY `fk_DraftPC_Persona1_idx` (`Persona_idPersona`),
  KEY `fk_DraftPC_Temporada1_idx` (`tempodada_idTemporada`),
  CONSTRAINT `fk_DraftPC_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DraftPC_Temporada1` FOREIGN KEY (`tempodada_idTemporada`) REFERENCES `temporada` (`idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos` (
  `idEquipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEquipo` varchar(100) DEFAULT NULL,
  `descripcionEquipo` varchar(100) DEFAULT NULL,
  `activo` binary(1) DEFAULT NULL,
  `Division_idDivision` int(11) NOT NULL,
  PRIMARY KEY (`idEquipo`,`Division_idDivision`),
  KEY `fk_Equipos_Division1_idx` (`Division_idDivision`),
  CONSTRAINT `fk_Equipos_Division1` FOREIGN KEY (`Division_idDivision`) REFERENCES `division` (`idDivision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipos_has_imagen`
--

DROP TABLE IF EXISTS `equipos_has_imagen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos_has_imagen` (
  `equipos_idEquipo` int(11) NOT NULL,
  `tipoImagen_idTipoImagen` int(11) NOT NULL,
  `imagen` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`equipos_idEquipo`,`tipoImagen_idTipoImagen`),
  KEY `fk_equipos_has_tipoImagen_tipoImagen1_idx` (`tipoImagen_idTipoImagen`),
  KEY `fk_equipos_has_tipoImagen_equipos1_idx` (`equipos_idEquipo`),
  CONSTRAINT `fk_equipos_has_tipoImagen_equipos1` FOREIGN KEY (`equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipos_has_tipoImagen_tipoImagen1` FOREIGN KEY (`tipoImagen_idTipoImagen`) REFERENCES `tipoimagen` (`idTipoImagen`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipos_has_temporada`
--

DROP TABLE IF EXISTS `equipos_has_temporada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos_has_temporada` (
  `Equipos_idEquipo` int(11) NOT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  PRIMARY KEY (`Equipos_idEquipo`,`tempodada_idTemporada`),
  KEY `fk_Equipos_has_Temporada_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_Equipos_has_Temporada_Temporada1_idx` (`tempodada_idTemporada`),
  CONSTRAINT `fk_Equipos_has_Temporada_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipos_has_Temporada_Temporada1` FOREIGN KEY (`tempodada_idTemporada`) REFERENCES `temporada` (`idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `golesjornadas`
--

DROP TABLE IF EXISTS `golesjornadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `golesjornadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona_idPersona` int(11) NOT NULL,
  `numgoles` int(11) DEFAULT NULL,
  `updatedate` date DEFAULT NULL,
  `equipos_idEquipo` int(11) NOT NULL,
  `jornadas_has_equipos_id` int(11) NOT NULL,
  `jornadas_has_equipos_jornadas_idJornada` int(11) NOT NULL,
  `isautogol` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_golesJornadas_persona1_idx` (`persona_idPersona`),
  KEY `fk_golesJornadas_equipos1_idx` (`equipos_idEquipo`),
  KEY `fk_golesJornadas_jornadas_has_equipos1_idx` (`jornadas_has_equipos_id`,`jornadas_has_equipos_jornadas_idJornada`),
  CONSTRAINT `fk_golesJornadas_equipos1` FOREIGN KEY (`equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_golesJornadas_jornadas_has_equipos1` FOREIGN KEY (`jornadas_has_equipos_id`, `jornadas_has_equipos_jornadas_idJornada`) REFERENCES `jornadas_has_equipos` (`id`, `jornadas_idJornada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_golesJornadas_persona1` FOREIGN KEY (`persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1560 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupos_torneo`
--

DROP TABLE IF EXISTS `grupos_torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupos_torneo` (
  `torneo_idtorneo` int(11) NOT NULL,
  `equipos_idEquipo` int(11) NOT NULL,
  `nombreGrupo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`torneo_idtorneo`,`equipos_idEquipo`),
  KEY `fk_torneo_has_equipos_equipos1_idx` (`equipos_idEquipo`),
  KEY `fk_torneo_has_equipos_torneo1_idx` (`torneo_idtorneo`),
  CONSTRAINT `fk_torneo_has_equipos_equipos1` FOREIGN KEY (`equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_torneo_has_equipos_torneo1` FOREIGN KEY (`torneo_idtorneo`) REFERENCES `torneo` (`idtorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historicodraft`
--

DROP TABLE IF EXISTS `historicodraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historicodraft` (
  `idHistoricoDraft` int(11) NOT NULL AUTO_INCREMENT,
  `oferta` float DEFAULT NULL,
  `fechaOferta` date DEFAULT NULL,
  `usuarioOferta` varchar(45) DEFAULT NULL,
  `DraftPC_idDraftPC` int(11) NOT NULL,
  `DraftPC_Persona_idPersona` int(11) NOT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  `comentarios` varchar(200) DEFAULT NULL,
  `ofertaFinal` int(11) DEFAULT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHistoricoDraft`,`DraftPC_idDraftPC`,`DraftPC_Persona_idPersona`,`tempodada_idTemporada`),
  KEY `fk_HistoricoDraft_DraftPC1_idx` (`DraftPC_idDraftPC`,`DraftPC_Persona_idPersona`,`tempodada_idTemporada`),
  CONSTRAINT `fk_HistoricoDraft_DraftPC1` FOREIGN KEY (`DraftPC_idDraftPC`, `DraftPC_Persona_idPersona`, `tempodada_idTemporada`) REFERENCES `draftpc` (`idDraftPC`, `Persona_idPersona`, `tempodada_idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagenesjornadas`
--

DROP TABLE IF EXISTS `imagenesjornadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenesjornadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jornadas_has_equipos_id` int(11) NOT NULL,
  `jornadas_has_equipos_jornadas_idJornada` int(11) NOT NULL,
  `imgJornada` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_imagenesJornadas_jornadas_has_equipos1_idx` (`jornadas_has_equipos_id`,`jornadas_has_equipos_jornadas_idJornada`),
  CONSTRAINT `fk_imagenesJornadas_jornadas_has_equipos1` FOREIGN KEY (`jornadas_has_equipos_id`, `jornadas_has_equipos_jornadas_idJornada`) REFERENCES `jornadas_has_equipos` (`id`, `jornadas_idJornada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jornadas`
--

DROP TABLE IF EXISTS `jornadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jornadas` (
  `idJornada` int(11) NOT NULL AUTO_INCREMENT,
  `division_idDivision` int(11) DEFAULT NULL,
  `numeroJornada` int(11) DEFAULT NULL,
  `activa` int(1) DEFAULT NULL,
  `cerrada` int(1) DEFAULT NULL,
  `nombreJornada` varchar(45) DEFAULT NULL,
  `torneo_idtorneo` int(11) NOT NULL,
  `tipoJornada` int(11) DEFAULT '0',
  PRIMARY KEY (`idJornada`,`torneo_idtorneo`),
  KEY `fk_jornadas_division1_idx` (`division_idDivision`),
  KEY `fk_jornadas_torneo1_idx` (`torneo_idtorneo`),
  CONSTRAINT `fk_jornadas_division1` FOREIGN KEY (`division_idDivision`) REFERENCES `division` (`idDivision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jornadas_torneo1` FOREIGN KEY (`torneo_idtorneo`) REFERENCES `torneo` (`idtorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=722 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jornadas_has_equipos`
--

DROP TABLE IF EXISTS `jornadas_has_equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jornadas_has_equipos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jornadas_idJornada` int(11) NOT NULL,
  `equipos_idEquipoLocal` int(11) NOT NULL,
  `equipos_idEquipoVisita` int(11) NOT NULL,
  `golesLocal` int(11) DEFAULT NULL,
  `golesVisita` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`jornadas_idJornada`),
  KEY `fk_jornadas_has_equipos_equipos1_idx` (`equipos_idEquipoLocal`),
  KEY `fk_jornadas_has_equipos_jornadas1_idx` (`jornadas_idJornada`),
  KEY `fk_jornadas_has_equipos_equipos2_idx` (`equipos_idEquipoVisita`),
  CONSTRAINT `fk_jornadas_has_equipos_equipos1` FOREIGN KEY (`equipos_idEquipoLocal`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jornadas_has_equipos_equipos2` FOREIGN KEY (`equipos_idEquipoVisita`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jornadas_has_equipos_jornadas1` FOREIGN KEY (`jornadas_idJornada`) REFERENCES `jornadas` (`idJornada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8641 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liga`
--

DROP TABLE IF EXISTS `liga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liga` (
  `idLiga` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idLiga`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `apellidoPaterno` varchar(100) DEFAULT NULL,
  `apellidoMaterno` varchar(100) DEFAULT NULL,
  `NombreCompleto` varchar(100) DEFAULT NULL,
  `sobrenombre` varchar(100) DEFAULT NULL,
  `fehaNacimiento` datetime DEFAULT NULL,
  `raiting` int(11) DEFAULT NULL,
  `potencial` int(11) DEFAULT NULL,
  `Equipos_idEquipo` int(11) NOT NULL,
  `activo` binary(1) DEFAULT NULL,
  `userManager` varchar(100) DEFAULT NULL,
  `prestamo` binary(1) DEFAULT NULL,
  `link` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  KEY `fk_Persona_Equipos1_idx` (`Equipos_idEquipo`),
  CONSTRAINT `fk_Persona_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1411 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona_has_roles`
--

DROP TABLE IF EXISTS `persona_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona_has_roles` (
  `Persona_idPersona` int(11) NOT NULL,
  `Roles_idRoles` int(11) NOT NULL,
  PRIMARY KEY (`Persona_idPersona`,`Roles_idRoles`),
  KEY `fk_Persona_has_Roles_Roles1_idx` (`Roles_idRoles`),
  KEY `fk_Persona_has_Roles_Persona_idx` (`Persona_idPersona`),
  CONSTRAINT `fk_Persona_has_Roles_Persona` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_has_Roles_Roles1` FOREIGN KEY (`Roles_idRoles`) REFERENCES `roles` (`idRoles`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prestamos` (
  `Persona_idPersona` int(11) NOT NULL,
  `Equipos_idEquipo` int(11) NOT NULL,
  `activo` decimal(1,0) DEFAULT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  PRIMARY KEY (`Persona_idPersona`,`Equipos_idEquipo`,`tempodada_idTemporada`),
  KEY `fk_Prestamos_Persona1_idx` (`Persona_idPersona`),
  KEY `fk_Prestamos_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_Prestamos_Temporada1_idx` (`tempodada_idTemporada`),
  CONSTRAINT `fk_Prestamos_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamos_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamos_Temporada1` FOREIGN KEY (`tempodada_idTemporada`) REFERENCES `temporada` (`idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `idRoles` int(11) NOT NULL AUTO_INCREMENT,
  `nombreRol` varchar(45) DEFAULT NULL,
  `descripcionRol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idRoles`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor` (
  `idSponsor` int(11) NOT NULL AUTO_INCREMENT,
  `nombreSponsor` varchar(45) DEFAULT NULL,
  `descripcionSponsor` varchar(45) DEFAULT NULL,
  `contratoFijo` float DEFAULT NULL,
  `Division_idDivision` int(11) NOT NULL,
  `clase` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`idSponsor`),
  KEY `fk_Sponsor_Division1_idx` (`Division_idDivision`),
  CONSTRAINT `fk_Sponsor_Division1` FOREIGN KEY (`Division_idDivision`) REFERENCES `division` (`idDivision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sponsor_has_concepto`
--

DROP TABLE IF EXISTS `sponsor_has_concepto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor_has_concepto` (
  `Sponsor_idSponsor` int(11) NOT NULL,
  `Concepto_idConcepto` int(11) NOT NULL,
  PRIMARY KEY (`Sponsor_idSponsor`,`Concepto_idConcepto`),
  KEY `fk_Sponsor_has_Concepto_Concepto1_idx` (`Concepto_idConcepto`),
  KEY `fk_Sponsor_has_Concepto_Sponsor1_idx` (`Sponsor_idSponsor`),
  CONSTRAINT `fk_Sponsor_has_Concepto_Concepto1` FOREIGN KEY (`Concepto_idConcepto`) REFERENCES `conceptosponsor` (`idConcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sponsor_has_Concepto_Sponsor1` FOREIGN KEY (`Sponsor_idSponsor`) REFERENCES `sponsor` (`idSponsor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temporada`
--

DROP TABLE IF EXISTS `temporada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temporada` (
  `idTemporada` int(11) NOT NULL AUTO_INCREMENT,
  `NombreTemporada` varchar(100) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Liga_idLiga` int(11) NOT NULL,
  PRIMARY KEY (`idTemporada`),
  KEY `Liga_idLiga_idx` (`Liga_idLiga`),
  CONSTRAINT `fk_Temporada_Liga1` FOREIGN KEY (`Liga_idLiga`) REFERENCES `liga` (`idLiga`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoconcepto`
--

DROP TABLE IF EXISTS `tipoconcepto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoconcepto` (
  `idTipoConcepto` int(11) NOT NULL AUTO_INCREMENT,
  `codigoConcepto` varchar(45) DEFAULT NULL,
  `descripcionConcepto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoConcepto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoimagen`
--

DROP TABLE IF EXISTS `tipoimagen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoimagen` (
  `idTipoImagen` int(11) NOT NULL AUTO_INCREMENT,
  `codigoImagen` varchar(45) DEFAULT NULL,
  `descripcionimagen` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoImagen`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipotorneo`
--

DROP TABLE IF EXISTS `tipotorneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipotorneo` (
  `idtipoTorneo` int(11) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipoTorneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `torneo`
--

DROP TABLE IF EXISTS `torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `torneo` (
  `idtorneo` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTorneo` varchar(45) DEFAULT NULL,
  `tempodada_idTemporada` int(11) NOT NULL,
  `tipoTorneo_idtipoTorneo` int(11) NOT NULL,
  PRIMARY KEY (`idtorneo`),
  KEY `fk_torneo_tipoTorneo1_idx` (`tipoTorneo_idtipoTorneo`),
  KEY `fk_torneo_tempodada1_idx` (`tempodada_idTemporada`),
  CONSTRAINT `fk_torneo_tempodada1` FOREIGN KEY (`tempodada_idTemporada`) REFERENCES `temporada` (`idTemporada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_torneo_tipoTorneo1` FOREIGN KEY (`tipoTorneo_idtipoTorneo`) REFERENCES `tipotorneo` (`idtipoTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `userName` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pass` varchar(250) DEFAULT NULL,
  `idequipo` int(11) DEFAULT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios_has_roles`
--

DROP TABLE IF EXISTS `usuarios_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios_has_roles` (
  `Usuarios_userName` varchar(45) NOT NULL,
  `Roles_idRoles` int(11) NOT NULL,
  PRIMARY KEY (`Usuarios_userName`,`Roles_idRoles`),
  KEY `fk_Usuarios_has_Roles_Roles1_idx` (`Roles_idRoles`),
  KEY `fk_Usuarios_has_Roles_Usuarios1_idx` (`Usuarios_userName`),
  CONSTRAINT `fk_Usuarios_has_Roles_Roles1` FOREIGN KEY (`Roles_idRoles`) REFERENCES `roles` (`idRoles`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Roles_Usuarios1` FOREIGN KEY (`Usuarios_userName`) REFERENCES `usuarios` (`userName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-14 14:09:56
