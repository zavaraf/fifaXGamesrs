DELIMITER $$
DROP PROCEDURE IF EXISTS updateUserManager$$
CREATE PROCEDURE updateUserManager(IN idUsuario VARCHAR(30), 
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

END $$
DELIMITER ;