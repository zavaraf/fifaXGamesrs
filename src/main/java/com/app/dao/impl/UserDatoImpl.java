package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.app.dao.UserDao;
import com.app.modelo.Equipo;
import com.app.modelo.User;

@Component
public class UserDatoImpl implements UserDao{
	@Autowired
    JdbcTemplate jdbcTemplate;

	public List<User> findAllPlayers() {

		
			List<User> playersList = new ArrayList<User>();
			String query = " SELECT persona.idPersona, "
					+"     persona.nombre, "
					+"     persona.apellidoPaterno, "
					+"     persona.apellidoMaterno, "
					+"     persona.nombreCompleto, "
					+"     persona.sobrenombre, "
					+"     persona.fehaNacimiento, "
					+"     persona.raiting, "
					+"     persona.potencial, "
					+"     persona.Equipos_idEquipo, "
					+"     persona.activo, "
					+"     persona.userManager, "
					+"     persona.prestamo,"
					+"     persona.link,"
					+ "    equipos.NombreEquipo as nombreEquipo "
					+" FROM fifaxgamersbd.persona "
					+" JOIN fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  ";
			Collection players = jdbcTemplate.query(query, new RowMapper() {
	                    public Object mapRow(ResultSet rs, int arg1)
	                            throws SQLException {
	                        User player = new User();
	                        player.setId(rs.getLong("idPersona"));
	                        player.setNombreCompleto(rs.getString("nombreCompleto"));
	                        player.setSobrenombre(rs.getString("sobrenombre"));
	                        player.setRaiting(rs.getInt("raiting"));
	                        player.setLink(rs.getString("link"));
	                        Equipo equipo = new Equipo();
	                        equipo.setId(rs.getLong("Equipos_idEquipo"));
	                        equipo.setNombre(rs.getString("nombreEquipo"));
	                        player.setEquipo(equipo);
	                        return player;
	                    }
	                });
			 for (Object player : players) {
//		            System.out.println(((User)player).toString());
		            playersList.add( (User)player);
		        }
		        
			return playersList;
		
	}
	
	public List<User> findAllPlayersByIdEquipo(long idEquipo) {

		
		List<User> playersList = new ArrayList<User>();
		String query = " SELECT persona.idPersona, "
				+"     persona.nombre, "
				+"     persona.apellidoPaterno, "
				+"     persona.apellidoMaterno, "
				+"     persona.nombreCompleto, "
				+"     persona.sobrenombre, "
				+"     persona.fehaNacimiento, "
				+"     persona.raiting, "
				+"     persona.potencial, "
				+"     persona.Equipos_idEquipo, "
				+"     persona.activo, "
				+"     persona.userManager, "
				+"     persona.prestamo,"
				+ "    persona.link, "
				+ "    equipos.NombreEquipo as nombreEquipo "
				+" FROM fifaxgamersbd.persona "
				+" JOIN fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+ "WHERE  fifaxgamersbd.equipos.idEquipo = "+ idEquipo;
		Collection players = jdbcTemplate.query(query, new RowMapper() {
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User player = new User();
                        player.setId(rs.getLong("idPersona"));
                        player.setNombreCompleto(rs.getString("nombreCompleto"));
                        player.setSobrenombre(rs.getString("sobrenombre"));
                        player.setRaiting(rs.getInt("raiting"));
                        player.setPrestamo(rs.getInt("prestamo"));
                        player.setLink(rs.getString("link"));
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getLong("Equipos_idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        player.setEquipo(equipo);
                        return player;
                    }
                });
		 for (Object player : players) {
//	            System.out.println(((User)player).toString());
	            playersList.add( (User)player);
	        }
	        
		return playersList;
	
}
	
public List<User> findAllPlayersByIdEquipo(long idEquipo,long idEquipoVisita) {

		
		List<User> playersList = new ArrayList<User>();
		String query = " SELECT persona.idPersona, "
				+"     persona.nombre, "
				+"     persona.apellidoPaterno, "
				+"     persona.apellidoMaterno, "
				+"     persona.nombreCompleto, "
				+"     persona.sobrenombre, "
				+"     persona.fehaNacimiento, "
				+"     persona.raiting, "
				+"     persona.potencial, "
				+"     persona.Equipos_idEquipo, "
				+"     persona.activo, "
				+"     persona.userManager, "
				+"     persona.prestamo,"
				+ "    persona.link, "
				+ "    equipos.NombreEquipo as nombreEquipo "
				+" FROM fifaxgamersbd.persona "
				+" JOIN fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+ "WHERE  fifaxgamersbd.equipos.idEquipo in( "+ idEquipo+","+idEquipoVisita+")";
		Collection players = jdbcTemplate.query(query, new RowMapper() {
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User player = new User();
                        player.setId(rs.getLong("idPersona"));
                        player.setNombreCompleto(rs.getString("nombreCompleto"));
                        player.setSobrenombre(rs.getString("sobrenombre"));
                        player.setRaiting(rs.getInt("raiting"));
                        player.setPrestamo(rs.getInt("prestamo"));
                        player.setLink(rs.getString("link"));
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getLong("Equipos_idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        player.setEquipo(equipo);
                        return player;
                    }
                });
		 for (Object player : players) {
//	            System.out.println(((User)player).toString());
	            playersList.add( (User)player);
	        }
	        
		return playersList;
	
}

	public void savePlayer(User player) {
		System.out.println("Plyer]:"+player.toString());
		System.out.println("Equipo]:"+player.toString());
		//NOmbre
		//Sobrenombre
		//Raiting
		//Equipo
		String insert = "call fifaxgamersbd.crearJugador(?,?, ?,?,?)";
				
		
		jdbcTemplate.update(insert,
			    player.getNombreCompleto(),
			    player.getSobrenombre(),
			    player.getRaiting(),
			    player.getEquipo().getId(),
			    player.getLink()
			  );
		
		
	}

	public void updatePlayer(User currentUser) {
		
		System.out.println("------->Plyer]:"+currentUser.toString());
		System.out.println("Equipo]:"+currentUser.toString());
		//NOmbre
		//Sobrenombre
		//Raiting
		//Equipo
		String insert = "call fifaxgamersbd.modificarJugador(?,?, ?,?,?,?)";
				
		
		jdbcTemplate.update(insert,
				currentUser.getNombreCompleto(),
				currentUser.getSobrenombre(),
				currentUser.getRaiting(),
				currentUser.getEquipo().getId(),
				currentUser.getId(),
				currentUser.getLink()
			  );
	}

	public User findById(long id) {
		
		String query = " SELECT persona.idPersona, "
				+"     persona.nombre, "
				+"     persona.apellidoPaterno, "
				+"     persona.apellidoMaterno, "
				+"     persona.nombreCompleto, "
				+"     persona.sobrenombre, "
				+"     persona.fehaNacimiento, "
				+"     persona.raiting, "
				+"     persona.potencial, "
				+"     persona.Equipos_idEquipo, "
				+"     persona.activo, "
				+"     persona.userManager, "
				+"     persona.prestamo,"
				+"     persona.link,"
				+ "    equipos.NombreEquipo as nombreEquipo "
				+" FROM fifaxgamersbd.persona "
				+" JOIN fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+" WHERE persona.idPersona =  "+ id;
		
	
		Collection users = jdbcTemplate.query(query, new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User user = new User();
                        user.setId(rs.getLong("idPersona"));
                        user.setNombre(rs.getString("nombre"));
                        user.setApellidoPaterno(rs.getString("apellidoPaterno"));
                        user.setApellidoMaterno(rs.getString("apellidoMaterno"));
                        user.setNombreCompleto(rs.getString("nombreCompleto"));
                        user.setSobrenombre(rs.getString("sobrenombre"));
                        user.setFehaNacimiento(rs.getString("fehaNacimiento"));
                        String raiting = rs.getString("raiting");
                        user.setLink(rs.getString("link"));
                        user.setRaiting(raiting != null ? Integer.parseInt(raiting): 0);
                        String pot = rs.getString("potencial");
                        user.setPotencial(pot!= null ? Integer.parseInt(pot): 0);
                        user.setEquipos_idEquipo(rs.getInt("Equipos_idEquipo"));
                        user.setActivo(rs.getInt("activo"));
                        user.setUserManager(rs.getString("userManager"));
                        String pres = rs.getString("prestamo");
                        user.setPrestamo(pres != null ? Integer.parseInt(pres): 0);
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getInt("Equipos_idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        user.setEquipo(equipo);
                        return user;
                    }
                });
		 for (Object user : users) {
	            System.out.println(user.toString());
	            return (User)user;
	        }
	        
		return null;
	}



}
