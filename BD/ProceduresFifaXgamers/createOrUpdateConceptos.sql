DELIMITER $$
DROP PROCEDURE IF EXISTS createOrUpdateConceptos$$
CREATE PROCEDURE createOrUpdateConceptos(
                            IN codigo varchar(100),
                            IN descripcion varchar(100), 
                            IN tipo INT,
                            out isError int, 
                            out message varchar(200))
BEGIN

DECLARE idConcepto int;
DECLARE idConceptoIn int;

set isError = 1 ;
  set message = 'Error al intentar modificar';
  
select idCatalogoConceptos into idConcepto
 from catalogoconceptos
where catalogoconceptos.nombre = codigo;	 
	
if idConcepto is null then 

select max(idCatalogoConceptos)+1 into idConceptoIn
from catalogoconceptos;

select idConceptoIn;

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(idConceptoIn,
codigo,
descripcion,
tipo);

else if idConcepto is not null then 

UPDATE `fifaxgamersbd`.`catalogoconceptos`
SET
`nombre` = codigo,
`descripcion` = descripcion,
`TipoConcepto_idTipoConcepto` =tipo
WHERE `idCatalogoConceptos` = idConcepto ;


end if;


end if;    

    
    set isError = 0 ;
	set message = 'OK';
    
    


END $$
DELIMITER ;