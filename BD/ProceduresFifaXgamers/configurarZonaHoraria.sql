-- **CONFIGURACIONES DE ZONA HORARIA PARA MÉXICO**

-- OPCIÓN 1: Ajustar la zona horaria de la sesión (RECOMENDADO)
SET time_zone = '-06:00';  -- Hora Central de México (CST)
-- O durante horario de verano:
-- SET time_zone = '-05:00';  -- Hora Central de México (CDT)

-- OPCIÓN 2: Si necesitas ajuste en el código, usar:
-- Para obtener hora local México desde BD que está en UTC+1:
-- DATE_SUB(NOW(), INTERVAL 6 HOUR)  -- Si BD está en UTC+1 y México en UTC-6 (diferencia de 7 horas)

-- OPCIÓN 3: Configurar zona horaria a nivel global (requiere permisos admin)
-- SET GLOBAL time_zone = '-06:00';

-- VERIFICAR LA CONFIGURACIÓN ACTUAL:
SELECT 
    NOW() as hora_servidor,
    UTC_TIMESTAMP() as hora_utc,
    @@session.time_zone as zona_sesion,
    @@global.time_zone as zona_global;
