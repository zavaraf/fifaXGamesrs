package com.app.dao.login;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.app.modelo.Equipo;
import com.app.modelo.User;
import com.app.modelo.login.UserInfo;

@Repository
public class LoginDaoImpl implements LoginDao {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public UserInfo findUserInfo(String username) {
		// String query = "select username, pass as password from usuarios where
		// username = '"+username+"'";
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
				+ " join roles on uhr.Roles_idRoles = roles.idRoles and roles.nombreRol = 'Admin'"
				+ " left join equipos_has_temporada on usuarios.idequipo = equipos_has_temporada.Equipos_idEquipo "
				+ "              and equipos_has_temporada.tempodada_idTemporada = (select max(idTemporada) from temporada) "
				+ " where usuarios.userName = '"
				+ username + "'" + " group by equipos_has_temporada.nombreEquipo ";
		//System.out.println("------>user]" + query);

		Collection users = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
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
			return (UserInfo) user;
		}

		return null;
	}

	public ArrayList<String> getUserRoles(String username) {
		String query = "select roles.nombreRol as role " + " from usuarios_has_roles ushas "
				+ " join roles on roles.idRoles = ushas.Roles_idRoles " + " where ushas.Usuarios_userName =  '"
				+ username + "'";

		// List roles1 = namedParameterJdbcTemplate.queryForList(sql,
		// getSqlParameterSource(username, ""), String.class);
		ArrayList<String> listaRoles = new ArrayList<String>();
		Collection roles = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {

				//System.out.println(rs.getString("role"));
				return rs.getString("role");

			}
		});
		//System.out.println("Entro roles");
		for (Object rol : roles) {
			//System.out.println("------>" + rol.toString());
			listaRoles.add(rol.toString());
		}
		//System.out.println("Sali roles");
		return listaRoles;
	}

}
