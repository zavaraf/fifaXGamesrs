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

import com.app.dao.DatosFinancierosDao;
import com.app.dao.EquipoDao;
import com.app.dao.SponsorDao;
import com.app.dao.UserDao;
import com.app.enums.Salarios;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Division;
import com.app.modelo.Equipo;
import com.app.modelo.Temporada;
import com.app.modelo.User;

@Component
public class EquipoDaoImpl implements EquipoDao{

	@Autowired
    JdbcTemplate jdbcTemplate;
	@Autowired
	UserDao userDao;
	@Autowired
	DatosFinancierosDao datosFinancierosDao;
	@Autowired
	SponsorDao sponsorDao;
	
	public Equipo findById(long id) {
		System.out.println("findById");
		Collection equipos = jdbcTemplate.query(
                "SELECT equipos.idEquipo, "
                + "equipos.nombreEquipo, "
                + "equipos.descripcionEquipo, "
                + "equipos.activo, "
                + "equipos.Division_idDivision " 
                +"FROM  equipos where equipos.idEquipo = "+id, new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getInt("idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        equipo.setDescripcion(rs.getString("descripcionEquipo"));
                        Division division= new Division();
                        division.setId(rs.getString("Division_idDivision"));
                        equipo.setDivision(division);
                        return equipo;
                    }
                });
		 for (Object equipo : equipos) {
	            System.out.println(equipo.toString());
	            return (Equipo)equipo;
	        }
	        
		return null;
	}
	public List<Equipo> buscarTodos(long idTemporada) {
		System.out.println("buscarTodos");
		List<Equipo> equiposList = new ArrayList<Equipo>();
		String query = " SELECT  "
				+ " equipos.idEquipo, equipos.linksofifa, "
				+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,"
				+ " equipos.nombreEquipo,  "
				+ " equipos.descripcionEquipo,  "
				+ " equipos.activo ,  "
				+ " equipos.Division_idDivision, "
				+ " division.nombre as nombreDivision, "
				+ " division.descripcion as descripcionDivision , "
				+ " tot.totalJugadores, "
				+ " tot.totalRaiting,  "
				+ " tot.presupuestoInicial,  "
				+ " tot.presupuestoFinal  "
				+ " FROM  equipos  "
				+ " join  division on equipos.Division_idDivision = division.idDivision  "
				+ " left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo,dat.presupuestoInicial, dat.presupuestoFinal "
				+ "        from  persona   "
				+ "        join  persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+ "        join  roles on roles.idRoles = pero.Roles_idRoles  "
				+ "        join  equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+ "        join  equipos_has_temporada et on et.Equipos_idEquipo = equipos.idEquipo  "
				+ "        join  temporada on temporada.idTemporada = et.tempodada_idTemporada "
				+ "        left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo and dat.tempodada_idTemporada = temporada.idTemporada "
				+ "        where roles.nombreRol = 'Jugador' and temporada.idTemporada = " + idTemporada
				+ "        group by  equipos.idEquipo ,dat.presupuestoInicial ,equipos.idEquipo,dat.presupuestoFinal  ) tot on tot.idEquipo = equipos.idEquipo " ;
		Collection equipos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getInt("idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        equipo.setDescripcion(rs.getString("descripcionEquipo"));
                        equipo.setTotalJugadores(rs.getInt("totalJugadores"));
                        equipo.setTotalRaiting(rs.getInt("totalRaiting"));
                        equipo.setPresupuestoInicial(rs.getInt("presupuestoInicial"));
                        equipo.setPresupuestoFinal(rs.getInt("presupuestoFinal"));
                        equipo.setImg(rs.getString("img"));
                        equipo.setLinksofifa(rs.getString("linksofifa"));
                        
                        Division division= new Division();
                        division.setId(rs.getString("Division_idDivision"));
                        division.setNombre(rs.getString("nombreDivision"));
                        division.setDescripcion(rs.getString("descripcionDivision"));
                        equipo.setDivision(division);
                        
                        
                        
                        equipo.setSalarios(obtenerSalario(division.getId(), equipo.getTotalRaiting()));
                        
                        return equipo;
                    }
                });
		 for (Object equipo : equipos) {
	            System.out.println(equipo.toString());
	            equiposList.add( (Equipo)equipo);
	        }
	        
		return equiposList;
	}
	
	public void createEquipo(Equipo equipo){
		System.out.println("Division]:"+equipo.getDivision().getId());
		jdbcTemplate.update(
			    "INSERT INTO  equipos (idEquipo,NombreEquipo,DescripcionEquipo,activo,Division_idDivision)"
				+"VALUES(?,?,?,?,?)",
			    null, equipo.getNombre(),equipo.getDescripcion(),1,equipo.getDivision().getId()
			  );
	}
	public void updateEquipo(Equipo currentEquipo) {
		System.out.println("-->Equipo Modificar]:"+currentEquipo.toString());
		System.out.println("-->Division Modificar]:"+currentEquipo.getDivision().toString());
		String updateQuery = "update  equipos "
				+ "set NombreEquipo = ?, "
				+ "DescripcionEquipo = ?, "
				+ "Division_idDivision = ?, "
				+ "linksofifa = ? "
				+ " where idEquipo = ? ";
		jdbcTemplate.update(updateQuery,
				currentEquipo.getNombre(),
				currentEquipo.getDescripcion(), 
				Integer.parseInt(currentEquipo.getDivision().getId()),
				currentEquipo.getLinksofifa(),
				currentEquipo.getId());
		
	}
	public List<Division> buscarDivision() {
		List<Division> divisionesList = new ArrayList<Division>();
		Collection divisiones = jdbcTemplate.query(
                "select divi.idDivision, divi.nombre, divi.descripcion, divi.activo from  division divi where divi.activo =1;" 
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Division division = new Division();
                        division.setId(rs.getString("idDivision"));
                        division.setNombre(rs.getString("nombre"));
                        division.setDescripcion(rs.getString("descripcion"));
//                        division.setActivo(rs.getI("activo"));
                        return division;
                    }
                });
		 for (Object division : divisiones) {
	            System.out.println(division.toString());
	            divisionesList.add( (Division)division);
	        }
	        
		return divisionesList;
	}
	public Equipo findByIdAll(long id, int idTemporada) {
		System.out.println("findByIdAll");
		String query = " SELECT  "
				+" equipos.idEquipo, equipos.linksofifa, "
				+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=1 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,"
				+" equipos.NombreEquipo,  "
				+" equipos.DescripcionEquipo,  "
				+" equipos.activo ,  "
				+" equipos.Division_idDivision, "
				+" division.nombre as nombreDivision, "
				+" division.descripcion as descripcionDivision , "
				+" tot.totalJugadores, "
				+" tot.totalRaiting , "
				+" temporada.idTemporada,  "
				+" temporada.NombreTemporada "
				+" FROM  equipos 			 "
				+"  join  division on equipos.Division_idDivision = division.idDivision  "
				+"  join equipos_has_temporada equitor on equitor.Equipos_idEquipo = equipos.idEquipo  "
				+" 					and equitor.tempodada_idTemporada = " + idTemporada + " "
				+"  join temporada on temporada.idTemporada = equitor.tempodada_idTemporada  "
				+"  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo "
				+"              from  persona   "
				+"              join  persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+"              join  roles on roles.idRoles = pero.Roles_idRoles  "
				+"              join  equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+"              where roles.nombreRol = 'Jugador'   "
				+"              group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo  "
				
				+" Where equipos.idEquipo = " + id;
		
		Collection equipos = jdbcTemplate.query(query, new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                    	 Equipo equipo = new Equipo();
                         equipo.setId(rs.getInt("idEquipo"));
                         equipo.setNombre(rs.getString("NombreEquipo"));
                         equipo.setDescripcion(rs.getString("DescripcionEquipo"));
                         equipo.setTotalJugadores(rs.getInt("totalJugadores"));
                         equipo.setTotalRaiting(rs.getInt("totalRaiting"));
                         equipo.setImg(rs.getString("img"));
                         equipo.setLinksofifa(rs.getString("linksofifa"));
                         
                         Division division= new Division();
                         division.setId(rs.getString("Division_idDivision"));
                         division.setNombre(rs.getString("nombreDivision"));
                         division.setDescripcion(rs.getString("descripcionDivision"));
                         equipo.setDivision(division);
                         equipo.setSalarios(obtenerSalario(division.getId(), equipo.getTotalRaiting()));
                         Temporada temporada = new Temporada();
                         temporada.setId(rs.getInt("idTemporada"));
                         temporada.setNombre(rs.getString("NombreTemporada"));
                         equipo.setTemporada(temporada);
                         equipo.setDatosFinancieros(datosFinancierosDao.getDatosFinancieros(equipo));
                         if(equipo.getDatosFinancieros()!=null ){
                        	 List<CatalogoFinanciero> catalogoFinanzas = new ArrayList<CatalogoFinanciero>();
                        	 catalogoFinanzas = sponsorDao.getCatalogoFinanzasByID(equipo);
                        	 equipo.setFinanzas(catalogoFinanzas);
                         }
                        return equipo;
                    }
                });
		 for (Object equipo : equipos) {
	            System.out.println(equipo.toString());
	            List<User> listPlayer = userDao.findAllPlayersByIdEquipo(id);
	            Equipo team = (Equipo)equipo;
	            team.setJugadores(listPlayer);
	            return team;
	        }
	        
		return null;
	}
	public Equipo findEquipoByIdAll(long id, int idTemporada) {
		System.out.println("findEquipoByIdAll Buscar todos");
		
		String query = " SELECT  "
				+" equipos.idEquipo,  "
				+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=1 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,"
				+" equipos.NombreEquipo,  "
				+" equipos.DescripcionEquipo,  "
				+" equipos.activo ,  "
				+" equipos.Division_idDivision, "
				+" division.nombre as nombreDivision, "
				+" division.descripcion as descripcionDivision , "
				+" tot.totalJugadores, "
				+" tot.totalRaiting  "
				+" FROM  equipos 			 "
				+"  join  division on equipos.Division_idDivision = division.idDivision  "
				+"  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo "
				+"              from  persona   "
				+"              join  persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+"              join  roles on roles.idRoles = pero.Roles_idRoles  "
				+"              join  equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+"              where roles.nombreRol = 'Jugador'   "
				+"              group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo  "
				+" Where equipos.idEquipo = " + id;
		
		Collection equipos = jdbcTemplate.query(query, new RowMapper() {
			
			public Object mapRow(ResultSet rs, int arg1)
					throws SQLException {
				Equipo equipo = new Equipo();
				equipo.setId(rs.getInt("idEquipo"));
				equipo.setNombre(rs.getString("NombreEquipo"));
				equipo.setDescripcion(rs.getString("DescripcionEquipo"));
				equipo.setTotalJugadores(rs.getInt("totalJugadores"));
				equipo.setTotalRaiting(rs.getInt("totalRaiting"));
				equipo.setImg(rs.getString("img"));
				
				Division division= new Division();
				division.setId(rs.getString("Division_idDivision"));
				division.setNombre(rs.getString("nombreDivision"));
				division.setDescripcion(rs.getString("descripcionDivision"));
				equipo.setDivision(division);
				equipo.setSalarios(obtenerSalario(division.getId(), equipo.getTotalRaiting()));
//				Temporada temporada = new Temporada();
//				temporada.setId(rs.getInt("idTemporada"));
//				temporada.setNombre(rs.getString("NombreTemporada"));
//				equipo.setTemporada(temporada);
//				equipo.setDatosFinancieros(datosFinancierosDao.getDatosFinancieros(equipo));
//				if(equipo.getDatosFinancieros()!=null && equipo.getDatosFinancieros().getSponsor()!=null){
//					List<CatalogoFinanciero> catalogoFinanzas = new ArrayList<CatalogoFinanciero>();
//					catalogoFinanzas = sponsorDao.getCatalogoFinanzasByID(equipo);
//					equipo.setFinanzas(catalogoFinanzas);
//				}
				return equipo;
			}
		});
		for (Object equipo : equipos) {
			System.out.println("->"+equipo.toString());
			List<User> listPlayer = userDao.findAllPlayersByIdEquipo(id);
			Equipo team = (Equipo)equipo;
			team.setJugadores(listPlayer);
			return team;
		}
		
		return null;
	}
	
	public int obtenerSalario(String division, int raiting){
		double salario = 0;
		int salarioAux = 0;
		double salAux = 0;
        if(division.equals("1")){
         salario =  Math.pow(raiting, Salarios.SALARIO_PRIMERA.getPago());
       	 salAux = salario /1000000; 
       	 salarioAux = (int) Math.round(salAux);
       	 salario = salarioAux * 1000000;
        }else{
       	 salario = (int) Math.pow(raiting, Salarios.SALARIO_SEGUNDA.getPago());
       	 salAux = salario /1000000; 
      	 salarioAux = (int) Math.round(salAux);
      	 salario = salarioAux * 1000000;
        }
       return (int) salario;
	}
	
	public List<Equipo> findEquiposByDivision(int idTemporada,int idDivision) {
		System.out.println("findEquiposByDivision");
		List<Equipo> equiposList = new ArrayList<Equipo>();
		String query = "  SELECT  "
				+"   equipos.idEquipo,  "
				+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,"
				+"   equipos.nombreEquipo,  "
				+"   equipos.descripcionEquipo,  "
				+"   equipos.activo ,  "
				+"   equipos.Division_idDivision, "
				+"   division.nombre as nombreDivision, "
				+"   division.descripcion as descripcionDivision "
				+"   FROM  equipos  "
				+"   join  division on equipos.Division_idDivision = division.idDivision  "
				+"   join equipos_has_temporada eht on eht.Equipos_idEquipo = equipos.idEquipo"
				+"   where division.idDivision =  "+idDivision
				+"   and eht.tempodada_idTemporada= "+idTemporada
			    +"   and equipos.idEquipo != 1 ";
		
		Collection equipos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getInt("idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        equipo.setDescripcion(rs.getString("descripcionEquipo"));
                        equipo.setImg(rs.getString("img"));
                        Division division= new Division();
                        division.setId(rs.getString("Division_idDivision"));
                        division.setNombre(rs.getString("nombreDivision"));
                        division.setDescripcion(rs.getString("descripcionDivision"));
                        equipo.setDivision(division);
                        
                        return equipo;
                    }
                });
		 for (Object equipo : equipos) {
	            System.out.println(equipo.toString());
	            equiposList.add( (Equipo)equipo);
	        }
	        
		return equiposList;
	}
	public List<Equipo> findEquiposByTorneo(int idTemporada,int idTorneo) {
		System.out.println("findEquiposByDivision");
		List<Equipo> equiposList = new ArrayList<Equipo>();
		String query = "  SELECT  "
				+"   equipos.idEquipo,  "
				+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,"
				+"   equipos.nombreEquipo,  "
				+"   equipos.descripcionEquipo,  "
				+"   equipos.activo ,  "
				+"   equipos.Division_idDivision, "
				+"   division.nombre as nombreDivision, "
				+"   division.descripcion as descripcionDivision "
				+"   FROM  equipos  "
				+"   join  division on equipos.Division_idDivision = division.idDivision  "
				+"   join equipos_has_temporada eht on eht.Equipos_idEquipo = equipos.idEquipo" 
				+"   join grupos_torneo on grupos_torneo.equipos_idEquipo = equipos.idEquipo "
				+" where grupos_torneo.torneo_idtorneo = " + idTorneo			
				+"   and eht.tempodada_idTemporada= "+idTemporada
			    +"   and equipos.idEquipo != 1 ";
		
		Collection equipos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Equipo equipo = new Equipo();
                        equipo.setId(rs.getInt("idEquipo"));
                        equipo.setNombre(rs.getString("nombreEquipo"));
                        equipo.setDescripcion(rs.getString("descripcionEquipo"));
                        equipo.setImg(rs.getString("img"));
                        Division division= new Division();
                        division.setId(rs.getString("Division_idDivision"));
                        division.setNombre(rs.getString("nombreDivision"));
                        division.setDescripcion(rs.getString("descripcionDivision"));
                        equipo.setDivision(division);
                        
                        return equipo;
                    }
                });
		 for (Object equipo : equipos) {
	            System.out.println(equipo.toString());
	            equiposList.add( (Equipo)equipo);
	        }
	        
		return equiposList;
	}

}
