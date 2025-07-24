DELIMITER $$

-- Procedimiento para diagnosticar problemas de zona horaria
DROP PROCEDURE IF EXISTS diagnosticarZonaHoraria$$
CREATE PROCEDURE diagnosticarZonaHoraria()
BEGIN
    -- Mostrar información de zona horaria del servidor
    SELECT 
        NOW() as hora_servidor_actual,
        UTC_TIMESTAMP() as hora_utc,
        TIMESTAMPDIFF(HOUR, UTC_TIMESTAMP(), NOW()) as diferencia_utc_horas,
        @@session.time_zone as zona_horaria_sesion,
        @@global.time_zone as zona_horaria_global,
        
        -- Pruebas de ajuste
        DATE_ADD(NOW(), INTERVAL 1 HOUR) as mas_1_hora,
        DATE_SUB(NOW(), INTERVAL 1 HOUR) as menos_1_hora,
        DATE_ADD(NOW(), INTERVAL 6 HOUR) as mas_6_horas,
        DATE_SUB(NOW(), INTERVAL 6 HOUR) as menos_6_horas,
        DATE_ADD(NOW(), INTERVAL 7 HOUR) as mas_7_horas,
        DATE_SUB(NOW(), INTERVAL 7 HOUR) as menos_7_horas;
        
    -- Mostrar ejemplo de datos de draft actuales
    SELECT 
        'Ejemplo de fechas en draftpc' as tipo,
        fechaCompra,
        NOW() as ahora,
        TIMESTAMPDIFF(HOUR, fechaCompra, NOW()) as horas_transcurridas,
        TIMESTAMPDIFF(MINUTE, fechaCompra, NOW()) as minutos_transcurridos
    FROM draftpc 
    ORDER BY fechaCompra DESC 
    LIMIT 5;
    
END$$

DELIMITER ;
