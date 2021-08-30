-- -----------------------------------------------------
-- Table `fifaxgamersbd`.`persona_has_temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifaxgamersbd`.`persona_has_temporada` (
`persona_idPersona` INT(11) NOT NULL,
`temporada_idTemporada` INT(11) NOT NULL,
`rating` VARCHAR(45) NULL,
`equipos_idEquipo` INT(11) NOT NULL,
PRIMARY KEY (`persona_idPersona`, `temporada_idTemporada`, `equipos_idEquipo`),
INDEX `fk_persona_has_temporada_temporada1_idx` (`temporada_idTemporada` ASC),
INDEX `fk_persona_has_temporada_persona1_idx` (`persona_idPersona` ASC),
INDEX `fk_persona_has_temporada_equipos1_idx` (`equipos_idEquipo` ASC),
CONSTRAINT `fk_persona_has_temporada_persona1`
  FOREIGN KEY (`persona_idPersona`)
  REFERENCES `fifaxgamersbd`.`persona` (`idPersona`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
CONSTRAINT `fk_persona_has_temporada_temporada1`
  FOREIGN KEY (`temporada_idTemporada`)
  REFERENCES `fifaxgamersbd`.`temporada` (`idTemporada`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
CONSTRAINT `fk_persona_has_temporada_equipos1`
  FOREIGN KEY (`equipos_idEquipo`)
  REFERENCES `fifaxgamersbd`.`equipos` (`idEquipo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


ALTER TABLE `fifaxgamersbd`.`equipos_has_temporada` 
ADD COLUMN `nombreEquipo` VARCHAR(100) NULL AFTER `tempodada_idTemporada`,
ADD COLUMN `idDivision` INT(11) NULL AFTER `nombreEquipo`,
ADD COLUMN `linksofifa` VARCHAR(200) NULL AFTER `idDivision`;



ALTER TABLE `fifaxgamersbd`.`equipos_has_imagen` 
ADD COLUMN `idTemporada` INT(11) NULL AFTER `imagen`;


UPDATE `fifaxgamersbd`.`equipos_has_imagen`
SET
equipos_has_imagen.idTemporada = 8
WHERE 
equipos_has_imagen.equipos_idEquipo  != 0 ;


ALTER TABLE `fifaxgamersbd`.`equipos_has_imagen` 
CHANGE COLUMN `idTemporada` `idTemporada` INT(11) NOT NULL DEFAULT 8 ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`equipos_idEquipo`, `tipoImagen_idTipoImagen`, `idTemporada`),
ADD INDEX `fk_euipos_has_tipoImagen_temporadad1_idx` (`idTemporada` ASC);
ALTER TABLE `fifaxgamersbd`.`equipos_has_imagen` 
ADD CONSTRAINT `fk_euipos_has_tipoImagen_temporadad1`
  FOREIGN KEY (`idTemporada`)
  REFERENCES `fifaxgamersbd`.`temporada` (`idTemporada`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



INSERT INTO `fifaxgamersbd`.`persona_has_temporada`
(`persona_idPersona`,
`temporada_idTemporada`,
`rating`,
`equipos_idEquipo`)
(select 
persona.idPersona,
8, 
persona.raiting,
persona.Equipos_idEquipo 
from persona);





-- -----------------------------------------------------
-- Table `fifaxgamersbd`.`castigos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS castigos (
  `idcastigos` INT NOT NULL AUTO_INCREMENT,
  `idEquipo` INT(11) NOT NULL,
  `idTemporada` INT(11) NOT NULL,
  `observaciones` VARCHAR(450) NULL,
  `valor` INT NULL,
  `tipo` VARCHAR(45) NULL,
  `torneo_idtorneo` INT NOT NULL,
  PRIMARY KEY (`idcastigos`, `idEquipo`, `idTemporada`),
  INDEX `fk_castigos_equipos_has_temporada1_idx` (`idEquipo` ASC, `idTemporada` ASC),
  INDEX `fk_castigos_torneo1_idx` (`torneo_idtorneo` ASC),
  CONSTRAINT `fk_castigos_equipos_has_temporada1`
    FOREIGN KEY (`idEquipo` , `idTemporada`)
    REFERENCES `fifaxgamersbd`.`equipos_has_temporada` (`Equipos_idEquipo` , `tempodada_idTemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_castigos_torneo1`
    FOREIGN KEY (`torneo_idtorneo`)
    REFERENCES `fifaxgamersbd`.`torneo` (`idtorneo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


DROP PROCEDURE IF EXISTS createOrUpdateCastigo;

SELECT idcastigos,
    idEquipo,
    idTemporada,
    observaciones,
    valor,
    tipo
FROM castigos
where castigos.idTemporada = 10;

call createOrUpdateCastigo(0,2,11,-3,'por salirse del partido','puntos',86 ,@isErr,@islll);
call createOrUpdateCastigo(0,2,11,-3,'por salirse del partido', 'puntos',86 ,@isErr,@islll);

select sum(valor) ptsMenos from castigos 
where castigos.idEquipo =2 
and castigos.idTemporada = 11 
and castigos.torneo_idtorneo = 86
and castigos.tipo = 'puntos';

select * from equipos_has_temporada 
where equipos_has_temporada.Equipos_idEquipo = 2 
and equipos_has_temporada.tempodada_idTemporada = 11;

select * from castigos;

select * from torneo;
select * from temporada;




-- -----------------------------------------------------
-- Table `fifaxgamersbd`.`tipoDatoJornada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifaxgamersbd`.`tipoDatoJornada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fifaxgamersbd`.`datosJornadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fifaxgamersbd`.`datosJornadas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `persona_idPersona` INT(11) NOT NULL,
  `updatedate` DATE NULL,
  `equipos_idEquipo` INT(11) NOT NULL,
  `jornadas_has_equipos_id` INT NOT NULL,
  `jornadas_has_equipos_jornadas_idJornada` INT NOT NULL,
  `activa` INT(1) NULL,
  `tipoDatoJornada_id` INT NOT NULL,
  INDEX `fk_golesJornadas_persona1_idx` (`persona_idPersona` ASC),
  INDEX `fk_golesJornadas_equipos1_idx` (`equipos_idEquipo` ASC),
  INDEX `fk_golesJornadas_jornadas_has_equipos1_idx` (`jornadas_has_equipos_id` ASC, `jornadas_has_equipos_jornadas_idJornada` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_datosJornadas_tipoDatoJornada1_idx` (`tipoDatoJornada_id` ASC),
  CONSTRAINT `fk_golesJornadas_persona100`
    FOREIGN KEY (`persona_idPersona`)
    REFERENCES `fifaxgamersbd`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_golesJornadas_equipos100`
    FOREIGN KEY (`equipos_idEquipo`)
    REFERENCES `fifaxgamersbd`.`equipos` (`idEquipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_golesJornadas_jornadas_has_equipos100`
    FOREIGN KEY (`jornadas_has_equipos_id` , `jornadas_has_equipos_jornadas_idJornada`)
    REFERENCES `fifaxgamersbd`.`jornadas_has_equipos` (`id` , `jornadas_idJornada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datosJornadas_tipoDatoJornada1`
    FOREIGN KEY (`tipoDatoJornada_id`)
    REFERENCES `fifaxgamersbd`.`tipoDatoJornada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `fifaxgamersbd`.`tipodatojornada`
(`id`,
`codigo`,
`descripcion`)
VALUES
(1,
'tarjeta',
'Tarjeta');

INSERT INTO `fifaxgamersbd`.`tipodatojornada`
(`id`,
`codigo`,
`descripcion`)
VALUES
(2,
'lesion',
'Lesion');



--------------------------------------------------------------------------


-- -actualiza Campeonatos alters


CREATE TABLE `fifaxgam_fifaxgamersbd`.`cat_torneo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


ALTER TABLE `fifaxgam_fifaxgamersbd`.`torneo` 
ADD COLUMN `cat_torneo` INT NULL DEFAULT NULL AFTER `tipoTorneo_idtipoTorneo`;


INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Primera','Primera');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Segunda','Segunda');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Superliga','Superliga');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Champions','Champions');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Superliga','Superliga');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Euro','Euro');

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Juveniles','Juveniles');

UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/NFc5P2gj/Primera.png' WHERE `id`='1';
UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/fyc4ryzw/Europa-Leage.png' WHERE `id`='6';
UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/xCrzjtmT/Champions.png' WHERE `id`='4';
UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/rw0RskYc/Super-Liga1.png' WHERE `id`='5';
UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/VNv8kzRR/Superliga.png' WHERE `id`='7';
UPDATE `fifaxgam_fifaxgamersbd`.`cat_torneo` SET `img`='https://i.postimg.cc/rw0RskYc/Super-Liga1.png' WHERE `id`='3';





CREATE TABLE `fifaxgam_fifaxgamersbd`.`cat_salon_fama` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NULL,
  `nombreEquipo` VARCHAR(45) NULL,
  `img` VARCHAR(45) NULL,
  `idtorneo` INT NOT NULL,
  `idtemporada` INT NOT NULL,
  `campeon` INT NOT NULL,
  PRIMARY KEY (`id`, `idtorneo`, `idtemporada`, `campeon`),
  INDEX `fk_torneo_n1_idx` (`idtorneo` ASC),
  CONSTRAINT `fk_torneo_n1`
    FOREIGN KEY (`idtorneo`)
    REFERENCES `fifaxgam_fifaxgamersbd`.`torneo` (`idtorneo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


  ALTER TABLE `fifaxgam_fifaxgamersbd`.`cat_salon_fama` 
ADD COLUMN `idequipo` INT NULL AFTER `campeon`;

ALTER TABLE `fifaxgam_fifaxgamersbd`.`cat_salon_fama` 
CHANGE COLUMN `img` `img` VARCHAR(450) NULL DEFAULT NULL ;



ALTER TABLE `fifaxgam_fifaxgamersbd`.`cat_torneo` 
ADD COLUMN `img` VARCHAR(450) NULL AFTER `descripcion`;


ALTER TABLE `fifaxgam_fifaxgamersbd`.`cat_salon_fama` 
ADD COLUMN `idcat_torneo` INT NULL AFTER `idequipo`,
ADD COLUMN `nombretorneo` VARCHAR(450) NULL AFTER `idcat_torneo`,
ADD COLUMN `nombretemporada` VARCHAR(450) NULL AFTER `nombretorneo`;


ALTER TABLE `fifaxgam_fifaxgamersbd`.`cat_salon_fama` 
ADD COLUMN `img_torneo` VARCHAR(450) NULL AFTER `nombretemporada`;


update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 58; --	1ra división LM
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 59; --	2da division
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 61; --	Youth League
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 62; --	CHAMPIONS LEAGUE
update torneo set torneo.cat_torneo = 6 where torneo.idtorneo = 63; --	EUROPA LEAGUE
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 64; --	SUPERLIGA
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 65; --	LM YOUTH LEAGUE
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 66; --	CHAMPIONS LM
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 70; --	SUPERLIGA
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 75; --	YOUTH LEAGUE
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 76; --	CHAMPIONS LEAGUE
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 80; --	Superliga
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 81; --	Youth League
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 82; --	Champions League
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 83; --	Primera
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 84; --	Segunda
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 85; --	Juveniles
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 86; --	LM CHAMPIONS LEAGUE
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 87; --	Liguilla Segunda
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 88; --	Liguilla Primera
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 89; --	Priimera
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 90; --	Segunda
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 91; --	Juveniles
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 92; --	LM CHAMPIONS LEAGUE
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 94; --	PRIMERA
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 95; --	SEGUNDA
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 96; --	Youth League
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 97; --	CHAMPIONS
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 98; --	Primera
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 99; --	Segunda
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 100; --	Juveniles
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 101; --	Champions
