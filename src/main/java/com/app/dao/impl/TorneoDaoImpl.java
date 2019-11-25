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

import com.app.dao.TorneoDao;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Torneo;
import com.app.utils.MyStoredProcedure;

@Component
public class TorneoDaoImpl implements TorneoDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public List<Torneo> buscarTodos() {
		List<Torneo> torneoList = new ArrayList<Torneo>();
		String query = "  SELECT idTorneo, " +
					   " NombreTorneo, " +
					   " Descripcion " +
					" FROM fifaxgamersbd.torneos";
		Collection torneos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Torneo torneo = new Torneo();
                    	torneo.setId(rs.getInt("idTorneo"));
                    	torneo.setNombre(rs.getString("NombreTorneo"));
                    	torneo.setDescripcion(rs.getString("Descripcion"));
                    	return torneo;
                    }
                });
		 for (Object torneo : torneos) {
	            System.out.println(torneo.toString());
	            torneoList.add( (Torneo)torneo);
	        }
	        
		return torneoList;
	}
	
	public List<TablaGeneral> getTablaGeneral(int idTorneo, int idDivision) {
		List<TablaGeneral> tablaGeneralList = new ArrayList<TablaGeneral>();
		String query = "  SELECT "
				+"  tablaGeneral.id, "
				+"  tablaGeneral.division_idDivision, "
				+"  tablaGeneral.torneos_idTorneo, "
				+"  tablaGeneral.idEquipo,  "
				+"  tablaGeneral.nombreEquipo, "
				+"  tablaGeneral.pj, "
				+"  tablaGeneral.pg,  "
				+"  tablaGeneral.pe, "
				+"  tablaGeneral.pp, "
				+"  tablaGeneral.gf, "
				+"  tablaGeneral.ge, "
				+"  tablaGeneral.dif, "
				+"  tablaGeneral.pts "
				+"   "
				+"  from ( "
				+"   "
				+"  SELECT "
				+"  tablaGeneral.id, "
				+"  tablaGeneral.division_idDivision, "
				+"  tablaGeneral.torneos_idTorneo, "
				+"  tablaGeneral.idEquipo,  "
				+"  tablaGeneral.nombreEquipo, "
				+"  sum(tablaGeneral.pj) as pj, "
				+"  sum(tablaGeneral.pg) as pg,  "
				+"  sum(tablaGeneral.pe) as pe, "
				+"  sum(tablaGeneral.pp) as pp, "
				+"  sum(tablaGeneral.gf) as gf, "
				+"  sum(tablaGeneral.ge) as ge, "
				+"  (sum(tablaGeneral.gf) - sum(tablaGeneral.ge)) as dif, "
				+"  ((sum(tablaGeneral.pg) * 3) + sum(tablaGeneral.pe)) as pts "
				+"  from "
				+"  ( "
				+"   "
				+"   "
				+"  ( "
				+"  /* PARTIDOS GANADOS LOCAL  */ "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  jhe.equipos_idEquipoLocal as idEquipo,  "
				+"  equipos.nombreEquipo, "
				+"  0 as pj, "
				+"  count(jhe.equipos_idEquipoLocal) as pg,  "
				+"  0 as pp, "
				+"  0 as pe, "
				+"  sum(jhe.golesLocal) as gf, "
				+"  sum(jhe.golesVisita) as ge "
				+"   "
				+"  from jornadas_has_equipos jhe "
				+"  join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada "
				+"  where jhe.golesLocal > jhe.golesVisita "
				+"  group by jhe.equipos_idEquipoLocal "
				+"  order by equipos.idEquipo "
				+"  ) "
				+"   "
				+"  UNION "
				+"   "
				+"   "
				+"  ( "
				+"  /* PARTIDOS GANADOS VISITA */ "
				+"       "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  jhe.equipos_idEquipoVisita as idEquipo,  "
				+"  equipos.nombreEquipo, "
				+"  0 as pj, "
				+"  count(jhe.equipos_idEquipoVisita) as pg, "
				+"  0 as pp, "
				+"  0 as pe, "
				+"  sum(jhe.golesVisita) as gf,  "
				+"  sum(jhe.golesLocal) as ge "
				+"  from jornadas_has_equipos jhe "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada "
				+"  join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita "
				+"  where "
				+"  jhe.golesVisita> jhe.golesLocal "
				+"   "
				+"  group by jhe.equipos_idEquipoLocal "
				+"  order by equipos.idEquipo "
				+"  ) "
				+"   "
				+"  UNION "
				+"  /* PARTIDOS EMPATADOS */ "
				+"  ( "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  equipos.idEquipo as idEquipo, "
				+"  equipos.nombreEquipo, "
				+"  0 as pj, "
				+"  0 as pg, "
				+"  0 as pp, "
				+"  count(equipos.idEquipo) as pe, "
				+"  sum(jhe.golesLocal) as gf,  "
				+"  sum(jhe.golesVisita) as ge "
				+"  from jornadas_has_equipos jhe "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada, "
				+"  equipos "
				+"  	  "
				+"  where (equipos.idEquipo = jhe.equipos_idEquipoVisita  "
				+"  or equipos.idEquipo = jhe.equipos_idEquipoLocal) "
				+"  and "
				+"  jhe.golesVisita = jhe.golesLocal and jhe.golesLocal is not null "
				+"   "
				+"  group by equipos.idEquipo "
				+"  order by equipos.idEquipo "
				+"  ) "
				+"   "
				+"  UNION "
				+"   "
				+"  ( "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  equipos.idEquipo as idEquipo,  "
				+"  equipos.nombreEquipo,  "
				+"  count(equipos.idEquipo) as pj, "
				+"  0 as pg, "
				+"  0 as pp, "
				+"  0 as pe, "
				+"  0 as gf, "
				+"  0 as ge "
				+"  from jornadas_has_equipos jhe "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada, "
				+"  equipos  "
				+"  where (jhe.equipos_idEquipoLocal = equipos.idEquipo "
				+"  or jhe.equipos_idEquipoVisita = equipos.idEquipo) "
				+"  and jornadas.activa = 1 "
				+"   "
				+"  group by equipos.idEquipo "
				+"  order by equipos.idEquipo "
				+"   "
				+"  ) "
				+"       "
				+"  UNION  "
				+"  ( "
				+"  /* PARTIDOS PERDIDOS LOCAL  */ "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  jhe.equipos_idEquipoLocal as idEquipo,  "
				+"  equipos.nombreEquipo, "
				+"  0 as pj, "
				+"  0 as pg, "
				+"  count(jhe.equipos_idEquipoLocal) as pp,  "
				+"  0 as pe, "
				+"  0 as gf, "
				+"  sum(jhe.golesVisita) as ge "
				+"   "
				+"  from jornadas_has_equipos jhe "
				+"  join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada "
				+"  where jhe.golesLocal < jhe.golesVisita "
				+"  group by jhe.equipos_idEquipoLocal "
				+"  order by equipos.idEquipo "
				+"  ) "
				+"       "
				+"  UNION "
				+"  ( "
				+"  /* PARTIDOS PERDIDOS VISITA */ "
				+"       "
				+"  select jhe.id, "
				+"  jornadas.division_idDivision, "
				+"  jornadas.torneos_idTorneo, "
				+"  jhe.equipos_idEquipoVisita as idEquipo,  "
				+"  equipos.nombreEquipo, "
				+"  0 as pj, "
				+"  0 as pg, "
				+"  count(jhe.equipos_idEquipoVisita) as pp, "
				+"  0 as pe, "
				+"  0 gf,  "
				+"  sum(jhe.golesLocal) as ge "
				+"  from jornadas_has_equipos jhe "
				+"  join jornadas on jornadas.idJornada = jhe.jornadas_idJornada "
				+"  join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita "
				+"  where "
				+"  jhe.golesVisita < jhe.golesLocal "
				+"   "
				+"  group by jhe.equipos_idEquipoLocal "
				+"  order by equipos.idEquipo "
				+"       "
				+"       "
				+"  ) "
				+"       "
				+"  )tablaGeneral "
				+"   "
				+" where tablaGeneral.division_idDivision =   " + idDivision
				+" and   tablaGeneral.torneos_idTorneo =  " + idTorneo
				+"   "
				+"  group by tablaGeneral.idEquipo "
				+"  ) tablaGeneral "
				+"  order by tablaGeneral.pts desc, "
				+"  tablaGeneral.dif desc " ;
			
		Collection tablaGeneral = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	TablaGeneral tablaG = new TablaGeneral();
                    	
                    	tablaG.setIdEquipo(rs.getInt("idEquipo"));
                    	tablaG.setNombreEquipo(rs.getString("nombreEquipo"));
                    	tablaG.setPj(rs.getInt("pj"));
                    	tablaG.setPg(rs.getInt("pg"));
                    	tablaG.setPe(rs.getInt("pe"));
                    	tablaG.setPp(rs.getInt("pp"));
                    	tablaG.setGf(rs.getInt("gf"));
                    	tablaG.setGe(rs.getInt("ge"));
                    	tablaG.setDif(rs.getInt("dif"));
                    	tablaG.setPts(rs.getInt("pts"));
                    	
                    	return tablaG;
                    }
                });
		 for (Object tablaG : tablaGeneral) {
	           
	            tablaGeneralList.add( (TablaGeneral)tablaG);
	        }
	        
		return tablaGeneralList;
	}
	
	public List<Jornadas> getJornadas(int idTorneo, int idDivision,int activa) {
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		String queryAddActiva = "";
		if (activa == 1){
			queryAddActiva = "  and jornadas.activa = 1 ";
		}
		String query = "  select tabla.idJornada, tabla.id, tabla.numeroJornada, "
					+"  tabla.equipos_idEquipoLocal, "
					+ " tabla.activa, "
					+"  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal, "
					+"  tabla.golesLocal, "
					+"  tabla.golesVisita, "
					+"   "
					+"  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoVisita) equipoVisita, "
					+"  tabla.equipos_idEquipoVisita "
					+"   "
					+"  from ( "
					+"   "
					+"  select jornadas.idJornada, "
					+ " je.id, jornadas.numeroJornada,"
					+ " jornadas.activa,"
					+"  je.equipos_idEquipoLocal, "
					+"  je.golesLocal, "
					+"  je.golesVisita, "
					+"  je.equipos_idEquipoVisita "
					+"  from jornadas "
					+"  join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada "
					+"  where jornadas.division_idDivision =  " + idDivision
					+"  and  jornadas.torneos_idTorneo =  " + idTorneo
					+"  " +queryAddActiva
					+"  ) tabla order by tabla.idJornada asc "

;
		Collection jornadas = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Jornada jornada = new Jornada();
                    	jornada.setId(rs.getInt("id"));
                    	jornada.setIdJornada(rs.getInt("idJornada"));
                    	jornada.setIdEquipoLocal(rs.getInt("equipos_idEquipoLocal"));
                    	jornada.setNombreEquipoLocal(rs.getString("equipoLocal"));
                    	jornada.setIdEquipoVisita(rs.getInt("equipos_idEquipoVisita"));
                    	jornada.setNombreEquipoVisita(rs.getString("equipoVisita"));
                    	jornada.setNumeroJornada(rs.getInt("numeroJornada"));
                    	jornada.setActiva(rs.getInt("activa"));	
                    	try{
                    	
                    	jornada.setGolesLocal(Integer.parseInt(rs.getString("golesLocal")));
                    	jornada.setGolesVisita(Integer.parseInt(rs.getString("golesVisita")));
                    	}catch(Exception e){
                    		                    		
                    	}
                    	
                    	return jornada;
                    }
                });
		List<Jornada> ListJornada = new ArrayList<Jornada>();
		 for (Object jornada : jornadas) {
			 ListJornada.add( (Jornada)jornada);		 
	        }
		 
		HashMap<Integer,Integer> mapJornadas = getMapaJornadas(ListJornada);
	
		
		for (Map.Entry<Integer, Integer> entry : mapJornadas.entrySet()) {
			Jornadas jorn = new Jornadas();
		    System.out.println("idJornada=" + entry.getKey() + ", NumeroJornada=" + entry.getValue());
		    List<Jornada> juegos = getJuegos(ListJornada, entry.getKey());
		    
		    if(juegos.size()>0){
		    	
		    	jorn.setActiva(juegos.get(0).getActiva());
		    	jorn.setIdJornda(juegos.get(0).getIdJornada());
		    	jorn.setNumeroJornada(juegos.get(0).getNumeroJornada());
		    	jorn.setJornada(juegos);
		    	
		    	jornadasList.add(jorn);
		    }
		    
		    
		}
		 
	        
		return jornadasList;
	}
	
	public List<Jornada> getJuegos(List<Jornada> juegos,int idJornada){
		List<Jornada> juegosJornada = new ArrayList<Jornada>();
		
		for(Jornada ju : juegos){
			if(ju.getIdJornada() == idJornada){
				juegosJornada.add(ju);
			}
		}
		
		
		return juegosJornada;
	}
	public HashMap<Integer,Integer> getMapaJornadas(List<Jornada> juegos){
		HashMap<Integer,Integer> jornadas = new HashMap<Integer,Integer>();
		
		try{
			for(Jornada jor : juegos){
				jornadas.put(jor.getIdJornada(), jor.getNumeroJornada());
			}
		}catch(Exception e){}
		
		return jornadas;
	}
	
	public List<Jornadas> getArmarJornadasInicial(int idTorneo, int idDivision) {
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		
		return jornadasList;
	}
	
	
	
	public List<GolesJornadas> getGolesJornadas(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita) {
		List<GolesJornadas> golesList = new ArrayList<GolesJornadas>();
		String query ="  select equipos.idEquipo, " +
				"  equipos.nombreEquipo, " +
				"  persona.idPersona, " +
				"  persona.sobrenombre, " +
				"  persona.NombreCompleto " +
				"  from golesjornadas " +
				"  join persona on persona.idPersona = golesjornadas.persona_idPersona " +
				"  join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo " +
				"  where golesjornadas.jornadas_has_equipos_jornadas_idJornada =  "+ idJornada +
				"  and equipos.idEquipo in ( "+ idEquipoLocal+","+idEquipoVisita+")";
		Collection goles = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	GolesJornadas goles = new GolesJornadas();
                    	goles.setIdEquipo(rs.getInt("idEquipo"));
                    	goles.setIdPersona(rs.getInt("idPersona"));
                    	goles.setNombreCompleto(rs.getString("NombreCompleto"));
                    	goles.setNombreEquipo(rs.getString("nombreEquipo"));
                    	goles.setSobrenombre(rs.getString("sobrenombre"));
                    	return goles;
                    }
                });
		 for (Object gol : goles) {
	           
	            golesList.add( (GolesJornadas)gol);
	        }
	        
		return golesList;
	}
	
	public Jornada getJornada(String idJornada,String id,	String idEquipoLocal,	String idEquipoVisita){
		
	Jornada jornada = new Jornada();
	String query = "  select tabla.idJornada, tabla.id, tabla.numeroJornada,"
				+"  tabla.equipos_idEquipoLocal, "
				+"  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal, "
				+"  tabla.golesLocal, "
				+"  tabla.golesVisita, "
				+"   "
				+"  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoVisita) equipoVisita, "
				+"  tabla.equipos_idEquipoVisita "
				+"   "
				+"  from ( "
				+"   "
				+"  select jornadas.idJornada, je.id, jornadas.numeroJornada,"
				+"  je.equipos_idEquipoLocal, "
				+"  je.golesLocal, "
				+"  je.golesVisita, "
				+"  je.equipos_idEquipoVisita "
				+"  from jornadas "
				+"  join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada "
				+"  ) tabla "
				+"  where tabla.idJornada = "+idJornada+" and tabla.id = "+id
				+ " order by tabla.idJornada asc "

;
	Collection jornadas = jdbcTemplate.query(
            query
            , new RowMapper() {

                public Object mapRow(ResultSet rs, int arg1)
                        throws SQLException {
                    
                	Jornada jornada = new Jornada();
                	jornada.setId(rs.getInt("id"));
                	jornada.setIdJornada(rs.getInt("idJornada"));
                	jornada.setIdEquipoLocal(rs.getInt("equipos_idEquipoLocal"));
                	jornada.setNombreEquipoLocal(rs.getString("equipoLocal"));
                	jornada.setIdEquipoVisita(rs.getInt("equipos_idEquipoVisita"));
                	jornada.setNombreEquipoVisita(rs.getString("equipoVisita"));
                	jornada.setNumeroJornada(rs.getInt("numeroJornada"));
                	try{
                	jornada.setGolesLocal(Integer.parseInt(rs.getString("golesLocal")));
                	jornada.setGolesVisita(Integer.parseInt(rs.getString("golesVisita")));
                	}catch(Exception e){
                		                    		
                	}
                	
                	return jornada;
                }
            });
	
	 for (Object jor : jornadas) {
		 jornada =  (Jornada)jor;		 
        }
	 
	        
		return jornada;
	}
	
	public List<String> getImagenes(String idJornada,String id){
		
		List<String> imagenesList = new ArrayList<String>();
		String query = "  	select imgJornada " 
					+" from imagenesjornadas "
					+" where imagenesjornadas.jornadas_has_equipos_id = "+ id
					+" and imagenesjornadas.jornadas_has_equipos_jornadas_idJornada =  "+ idJornada;

	
		Collection imagenes = jdbcTemplate.query(
	            query
	            , new RowMapper() {

	                public Object mapRow(ResultSet rs, int arg1)
	                        throws SQLException {
	                    
	                	String imggen = rs.getString("imgJornada");
	                	
	                	
	                	return imggen;
	                }
	            });
		
		 for (Object img : imagenes) {
			 imagenesList.add(img.toString());		 
	        }
		 
		        
			return imagenesList;
		}
	
	@Override
	public HashMap<String, String> addGol(int idJugador,int idEquipo,int id,int idJornada) {

		System.out.println("----->addGoles]:" + idJugador+",idEqupo]:"+idEquipo+",id]:"+id+",idJonada]:"+idJornada);
		String query = "addGoles";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJornadaVar = new SqlParameter("idJornada", Types.VARCHAR);
		SqlParameter idJornadaID = new SqlParameter("id", Types.VARCHAR);
		SqlParameter idJugadorVar = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter idEquipoVar = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJornadaVar, idJornadaID,idJugadorVar,idEquipoVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(idJornada, id, idJugador, idEquipo);

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}
	
	@Override
	public HashMap<String, String> addImagen(int idEquipo,int id,int idJornada,String img) {

		System.out.println("----->addImagen]:" + img+",idEqupo]:"+idEquipo+",id]:"+id+",idJonada]:"+idJornada);
		String query = "addImagen";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJornadaVar = new SqlParameter("idJornada", Types.VARCHAR);
		SqlParameter idJornadaID = new SqlParameter("id", Types.VARCHAR);
		SqlParameter idEquipoVar = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlParameter imgVar = new SqlParameter("img", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJornadaVar,idJornadaID,idEquipoVar,imgVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(idJornada, id,  idEquipo,img);

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}

	@Override
	public HashMap<String, String> addJornada(int idTorneo, int idDivision, Jornada juego,int activa) {
		System.out.println("----->equipoLocal]:" + juego.getIdEquipoLocal()+","
				+ "equipoVisita]:"+juego.getIdEquipoVisita()+
				",numJornada]:"+juego.getId()+",torneo]:"+idTorneo+",division]:"+idDivision+
				",liga]:1"+",activa]:"+juego.getActiva()+",id]:"+juego.getId());
		String query = "crearJornada";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter equipoLocal    = new SqlParameter("equipoLocal", Types.INTEGER);
		SqlParameter equipoVisita    = new SqlParameter("equipoVisita", Types.INTEGER);
		SqlParameter numJornada      = new SqlParameter("numJornada", Types.INTEGER);
		SqlParameter torneo          = new SqlParameter("torneo", Types.INTEGER);
		SqlParameter division        = new SqlParameter("division", Types.INTEGER);
		SqlParameter liga            = new SqlParameter("liga", Types.INTEGER);
		SqlParameter activaV          = new SqlParameter("activa", Types.INTEGER);
		SqlParameter id          = new SqlParameter("id", Types.INTEGER);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { equipoLocal,equipoVisita,numJornada,
				torneo,division,liga,activaV,id,isError ,message};

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(juego.getIdEquipoLocal(),juego.getIdEquipoVisita(),
				juego.getNumeroJornada(),idTorneo,idDivision,1,activa,juego.getId());

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}

}
