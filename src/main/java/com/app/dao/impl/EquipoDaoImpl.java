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
import com.app.modelo.Torneo;
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
                +"FROM fifaxgamersbd.equipos where equipos.idEquipo = "+id, new RowMapper() {

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
	public List<Equipo> buscarTodos(long idtorneo) {
		List<Equipo> equiposList = new ArrayList<Equipo>();
		String query = " SELECT  "
				+ " equipos.idEquipo,  "
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
				+ " FROM fifaxgamersbd.equipos  "
				+ " join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  "
				+ " left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo,dat.presupuestoInicial, dat.presupuestoFinal "
				+ "        from fifaxgamersbd.persona   "
				+ "        join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+ "        join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  "
				+ "        join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+ "        join fifaxgamersbd.equipos_has_torneos et on et.Equipos_idEquipo = equipos.idEquipo  "
				+ "        join fifaxgamersbd.torneos on torneos.idTorneo = et.Torneos_idTorneo "
				+ "        left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo and dat.Torneos_idTorneo = torneos.idTorneo "
				+ "        where roles.nombreRol = 'Jugador' and torneos.idTorneo = " + idtorneo
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
			    "INSERT INTO fifaxgamersbd.equipos (idEquipo,NombreEquipo,DescripcionEquipo,activo,Division_idDivision)"
				+"VALUES(?,?,?,?,?)",
			    null, equipo.getNombre(),equipo.getDescripcion(),1,equipo.getDivision().getId()
			  );
	}
	public void updateEquipo(Equipo currentEquipo) {
		System.out.println("-->Equipo Modificar]:"+currentEquipo.toString());
		System.out.println("-->Division Modificar]:"+currentEquipo.getDivision().toString());
		String updateQuery = "update fifaxgamersbd.equipos "
				+ "set NombreEquipo = ?, "
				+ "DescripcionEquipo = ?, "
				+ "Division_idDivision = ? "
				+ " where idEquipo = ? ";
		jdbcTemplate.update(updateQuery,
				currentEquipo.getNombre(),
				currentEquipo.getDescripcion(), 
				Integer.parseInt(currentEquipo.getDivision().getId()),
				currentEquipo.getId());
		
	}
	public List<Division> buscarDivision() {
		List<Division> divisionesList = new ArrayList<Division>();
		Collection divisiones = jdbcTemplate.query(
                "select divi.idDivision, divi.nombre, divi.descripcion, divi.activo from fifaxgamersbd.division divi where divi.activo =1;" 
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
	public Equipo findByIdAll(long id, int idTorneo) {
		System.out.println("findByIdAll");
		String query = " SELECT  "
				+" equipos.idEquipo,  "
				+" equipos.NombreEquipo,  "
				+" equipos.DescripcionEquipo,  "
				+" equipos.activo ,  "
				+" equipos.Division_idDivision, "
				+" division.nombre as nombreDivision, "
				+" division.descripcion as descripcionDivision , "
				+" tot.totalJugadores, "
				+" tot.totalRaiting , "
				+" torneos.idTorneo,  "
				+" torneos.NombreTorneo "
				+" FROM fifaxgamersbd.equipos 			 "
				+"  join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  "
				+"  join equipos_has_torneos equitor on equitor.Equipos_idEquipo = equipos.idEquipo  "
				+" 					and equitor.Torneos_idTorneo = " + idTorneo + " "
				+"  join torneos on torneos.idTorneo = equitor.Torneos_idTorneo  "
				+"  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo "
				+"              from fifaxgamersbd.persona   "
				+"              join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+"              join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  "
				+"              join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
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
                         
                         Division division= new Division();
                         division.setId(rs.getString("Division_idDivision"));
                         division.setNombre(rs.getString("nombreDivision"));
                         division.setDescripcion(rs.getString("descripcionDivision"));
                         equipo.setDivision(division);
                         equipo.setSalarios(obtenerSalario(division.getId(), equipo.getTotalRaiting()));
                         Torneo torneo = new Torneo();
                         torneo.setId(rs.getInt("idTorneo"));
                         torneo.setNombre(rs.getString("NombreTorneo"));
                         equipo.setTorneo(torneo);
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
	public Equipo findEquipoByIdAll(long id, int idTorneo) {
		
		String query = " SELECT  "
				+" equipos.idEquipo,  "
				+" equipos.NombreEquipo,  "
				+" equipos.DescripcionEquipo,  "
				+" equipos.activo ,  "
				+" equipos.Division_idDivision, "
				+" division.nombre as nombreDivision, "
				+" division.descripcion as descripcionDivision , "
				+" tot.totalJugadores, "
				+" tot.totalRaiting  "
				+" FROM fifaxgamersbd.equipos 			 "
				+"  join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  "
				+"  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo "
				+"              from fifaxgamersbd.persona   "
				+"              join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  "
				+"              join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  "
				+"              join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
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
				
				Division division= new Division();
				division.setId(rs.getString("Division_idDivision"));
				division.setNombre(rs.getString("nombreDivision"));
				division.setDescripcion(rs.getString("descripcionDivision"));
				equipo.setDivision(division);
				equipo.setSalarios(obtenerSalario(division.getId(), equipo.getTotalRaiting()));
//				Torneo torneo = new Torneo();
//				torneo.setId(rs.getInt("idTorneo"));
//				torneo.setNombre(rs.getString("NombreTorneo"));
//				equipo.setTorneo(torneo);
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
			System.out.println(equipo.toString());
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
	
	public List<Equipo> findEquiposByDivision(int idTorneo,int idDivision) {
		
		List<Equipo> equiposList = new ArrayList<Equipo>();
		String query = "  SELECT  "
				+"   equipos.idEquipo,  "
				+"   equipos.nombreEquipo,  "
				+"   equipos.descripcionEquipo,  "
				+"   equipos.activo ,  "
				+"   equipos.Division_idDivision, "
				+"   division.nombre as nombreDivision, "
				+"   division.descripcion as descripcionDivision "
				+"   FROM fifaxgamersbd.equipos  "
				+"   join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  "
				+"   join equipos_has_torneos eht on eht.Equipos_idEquipo = equipos.idEquipo"
				+"   where division.idDivision =  "+idDivision
				+"   and eht.Torneos_idTorneo= "+idTorneo
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
