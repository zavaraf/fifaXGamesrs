DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateEquipo$$
CREATE PROCEDURE createOrUpdateEquipo (IN nombreEquipo varchar(200) , 
								   IN descripcion varchar(200),
                                   IN idDivision INT,
                                   IN linksofifa varchar(200), 
                                   IN idEquipo INT,
                                   IN idTemporada INT,
                                   IN img varchar(200), 
                                   IN img2 varchar(200),
                               out isError int, 
                               out message varchar(200)
                                   )
BEGIN

declare  idEquipoVar int;
declare idEquipoIni int;
declare isImg int;
declare isImg2 int;

set isError = 1 ;
set message = 'No se pudo agregar';

select equipos.idEquipo into idEquipoIni
from equipos
where equipos.idEquipo = idEquipo;

if idEquipoIni is null and idEquipo != 1 then

	INSERT INTO `fifaxgamersbd`.`equipos`
	(`idEquipo`,
	`nombreEquipo`,
	`descripcionEquipo`,
	`activo`,
	`Division_idDivision`,
	`linksofifa`)
	VALUES
	(null,
	nombreEquipo,
	descripcion,
	1,
	idDivision,
	linksofifa);
    
    ELSE if idEquipoIni is not null then 
    
		UPDATE `fifaxgamersbd`.`equipos`
		SET
		`Division_idDivision` = idDivision
		
		WHERE equipos.idEquipo = idEquipoIni ;
    end if;
    
end if;



select equipos_has_temporada.Equipos_idEquipo into idEquipoVar
from equipos_has_temporada
where equipos_has_temporada.Equipos_idEquipo = idEquipo
and equipos_has_temporada.tempodada_idTemporada = idTemporada;

 select idEquipoVar;
 if idEquipoVar is null and idEquipo != 1 then
 
	INSERT INTO `fifaxgamersbd`.`equipos_has_temporada`
	(`Equipos_idEquipo`,
	`tempodada_idTemporada`,
	`nombreEquipo`,
	`idDivision`,
	`linksofifa`)
	VALUES
	(idEquipo,
	idTemporada,
	nombreEquipo,
	idDivision,
	linksofifa);

	else if idEquipoVar  is not null then
    UPDATE `fifaxgamersbd`.`equipos_has_temporada`
	SET
	
	`nombreEquipo` = nombreEquipo,
	`idDivision` = idDivision,
	`linksofifa` = linksofifa
	WHERE `Equipos_idEquipo` = idEquipo AND `tempodada_idTemporada` = idTemporada;

    

	end  if;
 
 end if  ;
       
       
select equipos_has_imagen.equipos_idEquipo into isImg
from equipos_has_imagen
where equipos_has_imagen.equipos_idEquipo = idEquipo
and equipos_has_imagen.idTemporada = idTemporada
and equipos_has_imagen.tipoImagen_idTipoImagen = 2;

select isImg;

if isImg is null then

INSERT INTO `fifaxgamersbd`.`equipos_has_imagen`
(`equipos_idEquipo`,
`tipoImagen_idTipoImagen`,
`imagen`,
`idTemporada`)
VALUES
(idEquipo,
2,
img,
idTemporada);

else if isImg is not null then

UPDATE `fifaxgamersbd`.`equipos_has_imagen`
SET

`imagen` = img

WHERE `equipos_idEquipo` = idEquipo AND `tipoImagen_idTipoImagen` = 2
and equipos_has_imagen.idTemporada = idTemporada;


end if;


end if;

select equipos_has_imagen.equipos_idEquipo into isImg2
from equipos_has_imagen
where equipos_has_imagen.equipos_idEquipo = idEquipo
and equipos_has_imagen.idTemporada = idTemporada
and equipos_has_imagen.tipoImagen_idTipoImagen = 1;

select isImg2;

if isImg2 is null then

INSERT INTO `fifaxgamersbd`.`equipos_has_imagen`
(`equipos_idEquipo`,
`tipoImagen_idTipoImagen`,
`imagen`,
`idTemporada`)
VALUES
(idEquipo,
1,
img2,
idTemporada);

else if isImg2 is not null then

UPDATE `fifaxgamersbd`.`equipos_has_imagen`
SET

`imagen` = img2

WHERE `equipos_idEquipo` = idEquipo AND `tipoImagen_idTipoImagen` = 1
and equipos_has_imagen.idTemporada = idTemporada;


end if;
end if;

set isError = 0 ;
set message = 'OK';

END $$
DELIMITER ;