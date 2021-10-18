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

	public List<User> findAllPlayers(int idTemporada) {

		
			List<User> playersList = new ArrayList<User>();
			String query = " SELECT persona_has_temporada.persona_idPersona as idPersona,  "
					+" persona.nombre,  "
					+" persona.apellidoPaterno,  "
					+" persona.apellidoMaterno,  "
					+" persona.nombreCompleto,  "
					+" persona.sobrenombre,  "
					+" persona.fehaNacimiento,  "
					+" persona_has_temporada.rating,  "
					+" persona.potencial,  "
					+" persona_has_temporada.equipos_idEquipo,  "
					+" persona.activo,  "
					+" persona.userManager,  "
					+" persona.prestamo, "
					+" persona.link, "
					+" persona.idsofifa, "
					+" (CASE WHEN equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo "
					+"                                       ELSE equipos_has_temporada.nombreEquipo  "
					+"                                 END )as nombreEquipo  "
					+" FROM  persona_has_temporada "
					+" JOIN persona on persona.idPersona = persona_has_temporada.persona_idPersona "
					+" JOIN equipos on equipos.idEquipo = persona_has_temporada.equipos_idEquipo "
					+" JOIN equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = equipos.idEquipo   "
					+"       and persona_has_temporada.temporada_idTemporada = equipos_has_temporada.tempodada_idTemporada  "
					+" where persona_has_temporada.temporada_idTemporada =  " + idTemporada;
			Collection players = jdbcTemplate.query(query, new RowMapper() {
	                    public Object mapRow(ResultSet rs, int arg1)
	                            throws SQLException {
	                        User player = new User();
	                        player.setId(rs.getLong("idPersona"));
	                        player.setNombreCompleto(rs.getString("nombreCompleto"));
	                        player.setSobrenombre(rs.getString("sobrenombre"));
	                        player.setRaiting(rs.getInt("rating"));
	                        player.setLink(rs.getString("link"));
	                        player.setIdsofifa(rs.getInt("idsofifa"));
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
	
	public List<User> findAllPlayersByIdEquipo(long idEquipo, int idTemporada) {

		
		List<User> playersList = new ArrayList<User>();
		String query = " SELECT persona.idPersona,  "
				+"      persona.nombre,  "
				+"      persona.apellidoPaterno,  "
				+"      persona.apellidoMaterno,  "
				+"      persona.nombreCompleto,  "
				+"      persona.sobrenombre,  "
				+"      persona.fehaNacimiento,  "
				+"      persona_has_temporada.rating,  "
				+"      persona.potencial,  "
				+"      persona_has_temporada.equipos_idEquipo,  "
				+"      persona.activo,  "
				+"      persona.userManager,  "
				+"      persona.prestamo, "
				+"      persona.link,  "
				+"      persona.idsofifa, "
				+"      (CASE WHEN equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo "
				+"                                       ELSE equipos_has_temporada.nombreEquipo  "
				+"                                 END )as nombreEquipo  "
				+"      from  persona_has_temporada    "
				+"      join  persona on persona.idPersona = persona_has_temporada.persona_idPersona    "
				+"  JOIN  equipos on equipos.idEquipo = persona_has_temporada.equipos_idEquipo   "
				+"  join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = equipos.idEquipo   "
				+"       and persona_has_temporada.temporada_idTemporada = equipos_has_temporada.tempodada_idTemporada  "
				+"  WHERE   equipos.idEquipo =  " + idEquipo
				+"  and persona_has_temporada.temporada_idTemporada = " + idTemporada 
				;
		
		System.out.println(query);
		Collection players = jdbcTemplate.query(query, new RowMapper() {
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User player = new User();
                        player.setId(rs.getLong("idPersona"));
                        player.setNombreCompleto(rs.getString("nombreCompleto"));
                        player.setSobrenombre(rs.getString("sobrenombre"));
                        player.setRaiting(rs.getInt("rating"));
                        player.setPrestamo(rs.getInt("prestamo"));
                        player.setLink(rs.getString("link"));
                        player.setIdsofifa(rs.getInt("idsofifa"));
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getLong("equipos_idEquipo"));
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
	
	public List<User> findAllBajasByIdEquipo(long idEquipo, int idTemporada) {

		
		List<User> playersList = new ArrayList<User>();
		String query = "  select persona.idPersona, "
				+"  	   persona.sobrenombre, "
				+"         persona.idPersona, "
				+"         persona.idsofifa, "
				+"         persona.link, "
				+"         persona.NombreCompleto, "
				+"  	   persona_has_temporada.rating, "
				+"         peract.equipos_idEquipo, "
				+"         peract.temporada_idTemporada, "
				+"         case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end as nombreEquipo  "
				+"  	from persona_has_temporada "
				+"      join persona on persona.idPersona = persona_has_temporada.persona_idPersona "
				+"      join persona_has_temporada peract on peract.persona_idPersona = persona_has_temporada.persona_idPersona  "
				+"                         and peract.temporada_idTemporada =  "+idTemporada
				+"  	join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = peract.equipos_idEquipo  "
				+"                         and equipos_has_temporada.tempodada_idTemporada =  " + idTemporada
				+"  	join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo "
				+"  	where persona_has_temporada.equipos_idEquipo =  "+idEquipo+"        "
				+"      and persona_has_temporada.temporada_idTemporada = (  "
				+"  	select max(idTemporada)  "
				+"  	from temporada   "
				+"  	where temporada.idTemporada != "+idTemporada+" )   "
				+"      and persona_has_temporada.persona_idPersona not in (  "
				+"  	select persona_idPersona   "
				+"  		from persona_has_temporada  "
				+"  		where persona_has_temporada.temporada_idTemporada = "+idTemporada+" "
				+"  		and persona_has_temporada.equipos_idEquipo =  "+idEquipo+"  )  " ;
		
		System.out.println(query);
		Collection players = jdbcTemplate.query(query, new RowMapper() {
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User player = new User();
                        player.setId(rs.getLong("idPersona"));
                        player.setNombreCompleto(rs.getString("nombreCompleto"));
                        player.setSobrenombre(rs.getString("sobrenombre"));
                        player.setRaiting(rs.getInt("rating"));
                        
                        player.setLink(rs.getString("link"));
                        player.setIdsofifa(rs.getInt("idsofifa"));
                        
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getLong("equipos_idEquipo"));
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
	
public List<User> findAllPlayersByIdEquipo(long idEquipo,long idEquipoVisita, int idTemporada) {

		
		List<User> playersList = new ArrayList<User>();
		String query = " SELECT persona.idPersona, "
				+"     persona.nombre, "
				+"     persona.apellidoPaterno, "
				+"     persona.apellidoMaterno, "
				+"     persona.nombreCompleto, "
				+"     persona.sobrenombre, "
				+"     persona.fehaNacimiento, "
				+"     persona_has_temporada.rating, "
				+"     persona.potencial, "
				+"     persona_has_temporada.equipos_idEquipo, "
				+"     persona.activo, "
				+"     persona.userManager, "
				+"     persona.prestamo,"
				+ "    persona.link, "
				+"     persona.idsofifa, "
				+ "    equipos.NombreEquipo as nombreEquipo "
				+"     from  persona_has_temporada   "
				+"     join  persona on persona.idPersona = persona_has_temporada.persona_idPersona   "
				+" JOIN  equipos on equipos.idEquipo = persona_has_temporada.equipos_idEquipo  "
				+ " WHERE   equipos.idEquipo in( "+ idEquipo+","+idEquipoVisita+")"
				+" and persona_has_temporada.temporada_idTemporada = " + idTemporada
				;
		
		System.out.println(query);
		Collection players = jdbcTemplate.query(query, new RowMapper() {
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        User player = new User();
                        player.setId(rs.getLong("idPersona"));
                        player.setNombreCompleto(rs.getString("nombreCompleto"));
                        player.setSobrenombre(rs.getString("sobrenombre"));
                        player.setRaiting(rs.getInt("rating"));
                        player.setPrestamo(rs.getInt("prestamo"));
                        player.setLink(rs.getString("link"));
                        player.setIdsofifa(rs.getInt("idsofifa"));
                        player.setEquipos_idEquipo(rs.getInt("equipos_idEquipo"));
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

	public void savePlayer(User player,int idTemporada) {
		System.out.println("Plyer]:"+player.toString());
		System.out.println("Equipo]:"+player.toString());
		//NOmbre
		//Sobrenombre
		//Raiting
		//Equipo
		String insert = "call  crearJugador(?,?, ?,?,?,?,?)";
				
		
		jdbcTemplate.update(insert,
			    player.getNombreCompleto(),
			    player.getSobrenombre(),
			    player.getRaiting(),
			    player.getEquipo().getId(),
			    player.getLink(),
			    player.getIdsofifa(),
			    idTemporada
			  );
		
		
	}

	public void updatePlayer(User currentUser, int idTemporada) {
		
		System.out.println("------->Plyer]:"+currentUser.toString());
		System.out.println("Equipo]:"+currentUser.toString());
		//NOmbre
		//Sobrenombre
		//Raiting
		//Equipo
		String insert = "call  modificarJugador(?,?, ?,?,?,?,?,?)";
				
		
		jdbcTemplate.update(insert,
				currentUser.getNombreCompleto(),
				currentUser.getSobrenombre(),
				currentUser.getRaiting(),
				currentUser.getEquipo().getId(),
				currentUser.getId(),
				currentUser.getLink(),
				currentUser.getIdsofifa(),
				idTemporada
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
				+"     persona.idsofifa, "
				+ "    equipos.NombreEquipo as nombreEquipo "
				+" FROM  persona "
				+" JOIN  equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
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
                        user.setIdsofifa(rs.getInt("idsofifa"));
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
