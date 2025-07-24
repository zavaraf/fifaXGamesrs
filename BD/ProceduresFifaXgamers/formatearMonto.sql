DELIMITER $$

-- Función para formatear montos con máscara de pesos
DROP FUNCTION IF EXISTS formatearMonto$$
CREATE FUNCTION formatearMonto(monto BIGINT) 
RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(50);
    DECLARE montoStr VARCHAR(50);
    DECLARE longitud INT;
    DECLARE i INT;
    DECLARE contador INT DEFAULT 0;
    
    -- Manejar casos especiales
    IF monto IS NULL THEN
        RETURN '$0';
    END IF;
    
    IF monto = 0 THEN
        RETURN '$0';
    END IF;
    
    -- Convertir a string sin signo
    SET montoStr = CAST(ABS(monto) AS CHAR);
    SET longitud = CHAR_LENGTH(montoStr);
    SET resultado = '';
    SET i = longitud;
    
    -- Construir el número con separadores de miles
    WHILE i > 0 DO
        SET resultado = CONCAT(SUBSTRING(montoStr, i, 1), resultado);
        SET contador = contador + 1;
        
        -- Agregar coma cada 3 dígitos (excepto al final)
        IF contador MOD 3 = 0 AND i > 1 THEN
            SET resultado = CONCAT(',', resultado);
        END IF;
        
        SET i = i - 1;
    END WHILE;
    
    -- Agregar signo de peso y signo negativo si es necesario
    IF monto < 0 THEN
        SET resultado = CONCAT('-$', resultado);
    ELSE
        SET resultado = CONCAT('$', resultado);
    END IF;
    
    RETURN resultado;
END$$

DELIMITER ;
