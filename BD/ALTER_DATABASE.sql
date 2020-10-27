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