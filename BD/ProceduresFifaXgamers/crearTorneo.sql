DELIMITER $$
DROP PROCEDURE IF EXISTS crearTorneo$$
CREATE PROCEDURE crearTorneo  (IN nombreTorneo varchar(45),
							   in idTemporada int,
                               in tipoTorneo int,
                               out isError int, 
                               out message varchar(200))
BEGIN

declare isTorneo int;

declare torneoval int; 

set isError = 1 ;
set message = 'El torneo ya Existe';

if tipotorneo = 1 then 
	select nombre into nombreTorneo	
	from division where idDivision = 1;
end if;

select torneo.idtorneo into isTorneo 
from torneo
where torneo.tempodada_idTemporada = idTemporada
and torneo.nombreTorneo = nombreTorneo;

if isTorneo is null then 

if tipotorneo = 1 then

INSERT INTO `fifaxgamersbd`.`torneo`
(`idtorneo`,
`nombreTorneo`,
`tempodada_idTemporada`,
`tipoTorneo_idtipoTorneo`)

(select null, nombre,idTemporada,tipotorneo from division);

 	  
	  INSERT INTO `fifaxgamersbd`.`grupos_torneo`
		(`torneo_idtorneo`,
		`equipos_idEquipo`,
		`nombreGrupo`)
		
		(select idTorneo, idEquipo,null
		from torneo,division, equipos
		where torneo.nombreTorneo = division.nombre 
		and equipos.Division_idDivision = division.idDivision and equipos.idEquipo!=1
		and torneo.tempodada_idTemporada = idTemporada);
       
 
else  


select nombreTorneo,
idTemporada,
tipotorneo;

INSERT INTO `fifaxgamersbd`.`torneo`
(`idtorneo`,
`nombreTorneo`,
`tempodada_idTemporada`,
`tipoTorneo_idtipoTorneo`)
VALUES
(null,
nombreTorneo,
idTemporada,
tipotorneo);



end if;


end if;

set isError = 0 ;
set message = 'OK';



END $$
DELIMITER ;