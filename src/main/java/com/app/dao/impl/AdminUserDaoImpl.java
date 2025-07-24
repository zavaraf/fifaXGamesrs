package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Component;

import com.app.dao.AdminUserDao;
import com.app.modelo.RoleUser;
import com.app.modelo.login.UserInfo;
import com.app.utils.MyStoredProcedure;

@Component
public class AdminUserDaoImpl implements AdminUserDao {
	
	@Autowired
    JdbcTemplate jdbcTemplate;

	@Override
	public List<UserInfo> findAllUsers() {
		List<UserInfo> listUsuarios = new ArrayList<UserInfo>();
		String query = " select usuarios.username,  "
				+ " usuarios.pass as password,  "
				+ " usuarios.email,  "
				+ " equipos_has_temporada.nombreEquipo,  "
				+ " equipos_has_temporada.Equipos_idEquipo as idEquipo , "
				+ " GROUP_CONCAT(DISTINCT roles.descripcionRol "
				+ "           ORDER BY roles.descripcionRol ASC "
				+ "           SEPARATOR ' - ') as roles "
				+ " from usuarios  "
				+ " join usuarios_has_roles uhr on uhr.Usuarios_userName = usuarios.userName "
				+ " join roles on uhr.Roles_idRoles = roles.idRoles "
//				+ " left join equipos on usuarios.idequipo = equipos.idEquipo"
				+ " left join equipos_has_temporada on usuarios.idequipo = equipos_has_temporada.Equipos_idEquipo "
				+ "              and equipos_has_temporada.tempodada_idTemporada = (select max(idTemporada) from temporada) "
				+ " group by usuarios.userName,nombreEquipo ";
		System.out.println("------>user]"+query);

		Collection users = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                       UserInfo user = new UserInfo();
                       
                       user.setUsername(rs.getString("username"));
                       user.setPassword(rs.getString("password"));
                       user.setIdEquipo(rs.getString("idEquipo"));
                       user.setNombreEquipo(rs.getString("nombreEquipo"));
                       user.setRolesDes(rs.getString("roles"));
                       
                       
                       return user;
                    }
                });
		
			
		
		
		for (Object user : users) {
			UserInfo userA = (UserInfo) user;
//			List<RoleUser> roles = findAllRolesByID(userA.getUsername());
//			userA.setRoles(roles);
            listUsuarios.add(userA);
            
            
        }
		
		return listUsuarios;
		

	}

	@Override
	public List<RoleUser> findAllRoles() {
		List<RoleUser> listRoles = new ArrayList<RoleUser>();
		String query = " select idRoles, nombreRol, descripcionRol from roles";
		//System.out.println("------>user]"+query);

		Collection users = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                    	RoleUser user = new RoleUser();
                       
                       user.setId(rs.getInt("idRoles"));
                       user.setRol(rs.getString("nombreRol"));
                       user.setDescripcion(rs.getString("descripcionRol"));
                       
                       
                       
                       return user;
                    }
                });
		
			
		
		
		for (Object user : users) {
            listRoles.add((RoleUser) user);
            
        }
		
		return listRoles;
	}
	
	
	public List<RoleUser> findAllRolesByID(String username) {
		List<RoleUser> listRoles = new ArrayList<RoleUser>();
		String query = " select idRoles, nombreRol, descripcionRol "
				+" from roles"
				+" join usuarios_has_roles uhr on uhr.Roles_idRoles = roles.idRoles"
				+" where uhr.Usuarios_userName = '"+ username+"'";
		//System.out.println("------>user]"+query);

		Collection users = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                    	RoleUser user = new RoleUser();
                       
                       user.setId(rs.getInt("idRoles"));
                       user.setRol(rs.getString("nombreRol"));
                       user.setDescripcion(rs.getString("descripcionRol"));
                       
                       
                       
                       return user;
                    }
                });
		
			
		
		
		for (Object user : users) {
            listRoles.add((RoleUser) user);
        }
		
		return listRoles;
	}

	@Override
	public HashMap<String, String> pdateUserAdmin(String usuario, String idEquipo, String roles) {
		
		//System.out.println("----->confirmPlayer]:" + idEquipo);
		String query = "updateUserManager";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idUsuario         = new SqlParameter("idUsuario", Types.VARCHAR);
		SqlParameter idEquipoOferta    = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlParameter rolesJson         = new SqlParameter("rolesJson", Types.VARCHAR);
		
		SqlOutParameter isError        = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message        = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idUsuario, idEquipoOferta,rolesJson,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(usuario, idEquipo,roles);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}

}
