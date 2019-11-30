CREATE DATABASE  IF NOT EXISTS `fifaxgamersbd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fifaxgamersbd`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: fifaxgamersbd
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
  `DatosFinancieros_Torneos_idTorneo` int(11) NOT NULL,
  PRIMARY KEY (`idConceptosFinancieros`,`CatalogoConceptos_idCatalogoConceptos`,`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`DatosFinancieros_Torneos_idTorneo`),
  KEY `fk_ConceptosFinancieros_CatalogoConceptos1_idx` (`CatalogoConceptos_idCatalogoConceptos`),
  KEY `fk_ConceptosFinancieros_DatosFinancieros1_idx` (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`DatosFinancieros_Torneos_idTorneo`),
  CONSTRAINT `fk_ConceptosFinancieros_CatalogoConceptos1` FOREIGN KEY (`CatalogoConceptos_idCatalogoConceptos`) REFERENCES `catalogoconceptos` (`idCatalogoConceptos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConceptosFinancieros_DatosFinancieros1` FOREIGN KEY (`DatosFinancieros_idDatosFinancieros`, `DatosFinancieros_Equipos_idEquipo`, `DatosFinancieros_Torneos_idTorneo`) REFERENCES `datosfinancieros` (`idDatosFinancieros`, `Equipos_idEquipo`, `Torneos_idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
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
  `DatosFinancieros_Torneos_idTorneo` int(11) NOT NULL,
  `Sponsor_idSponsor` int(11) NOT NULL,
  `ConceptoSponsor_idConcepto` int(11) NOT NULL,
  `cumplio` bit(1) DEFAULT NULL,
  PRIMARY KEY (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`DatosFinancieros_Torneos_idTorneo`,`Sponsor_idSponsor`,`ConceptoSponsor_idConcepto`),
  KEY `fk_DadosFinancierosSponsor_DatosFinancieros1_idx` (`DatosFinancieros_idDatosFinancieros`,`DatosFinancieros_Equipos_idEquipo`,`DatosFinancieros_Torneos_idTorneo`),
  KEY `fk_DadosFinancierosSponsor_Sponsor1_idx` (`Sponsor_idSponsor`),
  KEY `fk_DadosFinancierosSponsor_ConceptoSponsor1_idx` (`ConceptoSponsor_idConcepto`),
  CONSTRAINT `fk_DadosFinancierosSponsor_ConceptoSponsor1` FOREIGN KEY (`ConceptoSponsor_idConcepto`) REFERENCES `conceptosponsor` (`idConcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DadosFinancierosSponsor_DatosFinancieros1` FOREIGN KEY (`DatosFinancieros_idDatosFinancieros`, `DatosFinancieros_Equipos_idEquipo`, `DatosFinancieros_Torneos_idTorneo`) REFERENCES `datosfinancieros` (`idDatosFinancieros`, `Equipos_idEquipo`, `Torneos_idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
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
  `Torneos_idTorneo` int(11) NOT NULL,
  `sponsorOpcional` bit(1) DEFAULT NULL,
  `presupuestoFinalSponsor` float DEFAULT NULL,
  PRIMARY KEY (`idDatosFinancieros`,`Equipos_idEquipo`,`Torneos_idTorneo`),
  KEY `fk_DatosFinancieros_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_DatosFinancieros_Torneos1_idx` (`Torneos_idTorneo`),
  CONSTRAINT `fk_DatosFinancieros_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DatosFinancieros_Torneos1` FOREIGN KEY (`Torneos_idTorneo`) REFERENCES `torneos` (`idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `Torneos_idTorneo` int(11) NOT NULL,
  `comentarios` varchar(200) DEFAULT NULL,
  `abierto` bit(1) DEFAULT NULL,
  `ofertaFinal` int(11) DEFAULT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDraftPC`,`Persona_idPersona`,`Torneos_idTorneo`),
  KEY `fk_DraftPC_Persona1_idx` (`Persona_idPersona`),
  KEY `fk_DraftPC_Torneos1_idx` (`Torneos_idTorneo`),
  CONSTRAINT `fk_DraftPC_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DraftPC_Torneos1` FOREIGN KEY (`Torneos_idTorneo`) REFERENCES `torneos` (`idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `equipos_has_torneos`
--

DROP TABLE IF EXISTS `equipos_has_torneos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos_has_torneos` (
  `Equipos_idEquipo` int(11) NOT NULL,
  `Torneos_idTorneo` int(11) NOT NULL,
  PRIMARY KEY (`Equipos_idEquipo`,`Torneos_idTorneo`),
  KEY `fk_Equipos_has_Torneos_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_Equipos_has_Torneos_Torneos1_idx` (`Torneos_idTorneo`),
  CONSTRAINT `fk_Equipos_has_Torneos_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipos_has_Torneos_Torneos1` FOREIGN KEY (`Torneos_idTorneo`) REFERENCES `torneos` (`idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
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
  `Torneos_idTorneo` int(11) NOT NULL,
  `comentarios` varchar(200) DEFAULT NULL,
  `ofertaFinal` int(11) DEFAULT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idHistoricoDraft`,`DraftPC_idDraftPC`,`DraftPC_Persona_idPersona`,`Torneos_idTorneo`),
  KEY `fk_HistoricoDraft_DraftPC1_idx` (`DraftPC_idDraftPC`,`DraftPC_Persona_idPersona`,`Torneos_idTorneo`),
  CONSTRAINT `fk_HistoricoDraft_DraftPC1` FOREIGN KEY (`DraftPC_idDraftPC`, `DraftPC_Persona_idPersona`, `Torneos_idTorneo`) REFERENCES `draftpc` (`idDraftPC`, `Persona_idPersona`, `Torneos_idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jornadas`
--

DROP TABLE IF EXISTS `jornadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jornadas` (
  `idJornada` int(11) NOT NULL AUTO_INCREMENT,
  `torneos_idTorneo` int(11) NOT NULL,
  `division_idDivision` int(11) NOT NULL,
  `numeroJornada` int(11) DEFAULT NULL,
  `liga_idLiga` int(11) NOT NULL,
  `activa` int(1) DEFAULT NULL,
  `cerrada` int(1) DEFAULT NULL,
  PRIMARY KEY (`idJornada`,`division_idDivision`),
  KEY `fk_jornadas_torneos1_idx` (`torneos_idTorneo`),
  KEY `fk_jornadas_division1_idx` (`division_idDivision`),
  KEY `fk_jornadas_liga1_idx` (`liga_idLiga`),
  CONSTRAINT `fk_jornadas_division1` FOREIGN KEY (`division_idDivision`) REFERENCES `division` (`idDivision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jornadas_liga1` FOREIGN KEY (`liga_idLiga`) REFERENCES `liga` (`idLiga`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jornadas_torneos1` FOREIGN KEY (`torneos_idTorneo`) REFERENCES `torneos` (`idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=475 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=6991 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=1247 DEFAULT CHARSET=utf8;
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
  `Torneos_idTorneo` int(11) NOT NULL,
  PRIMARY KEY (`Persona_idPersona`,`Equipos_idEquipo`,`Torneos_idTorneo`),
  KEY `fk_Prestamos_Persona1_idx` (`Persona_idPersona`),
  KEY `fk_Prestamos_Equipos1_idx` (`Equipos_idEquipo`),
  KEY `fk_Prestamos_Torneos1_idx` (`Torneos_idTorneo`),
  CONSTRAINT `fk_Prestamos_Equipos1` FOREIGN KEY (`Equipos_idEquipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamos_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prestamos_Torneos1` FOREIGN KEY (`Torneos_idTorneo`) REFERENCES `torneos` (`idTorneo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `torneos`
--

DROP TABLE IF EXISTS `torneos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `torneos` (
  `idTorneo` int(11) NOT NULL AUTO_INCREMENT,
  `NombreTorneo` varchar(100) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Liga_idLiga` int(11) NOT NULL,
  PRIMARY KEY (`idTorneo`),
  KEY `Liga_idLiga_idx` (`Liga_idLiga`),
  CONSTRAINT `fk_Torneos_Liga1` FOREIGN KEY (`Liga_idLiga`) REFERENCES `liga` (`idLiga`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
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

--
-- Dumping routines for database 'fifaxgamersbd'
--
/*!50003 DROP PROCEDURE IF EXISTS `addGoles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addGoles`(IN idJornada int ,
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


INSERT INTO `fifaxgamersbd`.`golesjornadas`
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
/*!50003 DROP PROCEDURE IF EXISTS `addImagen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addImagen`(IN idJornada int ,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `confirmPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmPlayer`(IN idJugador INT,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crearJornada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearJornada`(IN equipoLocal int , 
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
`activa`,
`cerrada`)
VALUES
(null,
torneo,
division,
numJornada,
liga,
activa,
cerrada
);

else if idjornadaVal is not null then

UPDATE `fifaxgamersbd`.`jornadas`
SET
`activa` = activa,
`cerrada` = cerrada

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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crearJugador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearJugador`(IN nombreCompleto varchar(200) , 
							   IN sobrenonbre varchar(200),
                               IN raiting INT,
                               IN idEquipo INT,
                               IN link varchar(200),
                               IN idTorneo INT
                               )
BEGIN

DECLARE idEquipoVar INT;

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


select Equipos_idEquipo into idEquipoVar 
 from equipos_has_torneos eht 
 where eht.Equipos_idEquipo = idEquipo and eht.Torneos_idTorneo = idTorneo;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO `fifaxgamersbd`.`equipos_has_torneos`
(`Equipos_idEquipo`,
`Torneos_idTorneo`)
VALUES
(idEquipo,
idTorneo);

 
 end if ;


        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createInitialDraft` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createInitialDraft`(IN idJugador INT,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createOrUpdateDatosFinancieros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrUpdateDatosFinancieros`(IN idDatos INT, IN monto INT,IN idEquipo INT)
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createOrUpdateDatosSponsor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrUpdateDatosSponsor`(IN idEquipo INT, IN idSponsor INT, IN opcionales INT)
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createOrUpdateObjetivos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrUpdateObjetivos`(IN `json` JSON,IN idEquipo INT, IN idSponsor INT,IN idTorneo INT)
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createOrUpdatePresupuesto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrUpdatePresupuesto`(IN idEquipo INT,  IN monto INT, IN montoFinal INT,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createPrestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPrestamo`(IN idJugador INT,IN idEquipo INT,IN idTorneo INT,IN opcion INT)
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createTorneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createTorneo`( IN nombreTorneo varchar(200) , IN descripcionTorneo varchar(200))
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificarJugador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarJugador`(IN nombreCompleto varchar(200) , 
								   IN sobrenonbre varchar(200),
                                   IN raiting INT,
                                   IN idEquipo INT, 
                                   IN idJugador INT,
                                   IN link varchar(300),
                                   IN idTorneo INT
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
 from equipos_has_torneos eht 
 where eht.Equipos_idEquipo = idEquipo and eht.Torneos_idTorneo = idTorneo;
 
 if idEquipoVar is null and idEquipo != 1 then
 
 INSERT INTO `fifaxgamersbd`.`equipos_has_torneos`
(`Equipos_idEquipo`,
`Torneos_idTorneo`)
VALUES
(idEquipo,
idTorneo);

 
 end if ;
       

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spTest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spTest`()
BEGIN


select * from equipos;
select * from conceptosponsor;

 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateDraft` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDraft`(IN idJugador INT,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateResultadoJornada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateResultadoJornada`(IN idJornada int ,
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUserManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserManager`(IN idUsuario VARCHAR(30), 
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-30 11:12:16