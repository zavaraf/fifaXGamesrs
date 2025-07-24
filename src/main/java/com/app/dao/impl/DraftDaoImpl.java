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

import com.app.dao.DraftDao;
import com.app.modelo.Equipo;
import com.app.modelo.JugadorDraft;
import com.app.modelo.Temporada;
import com.app.modelo.User;
import com.app.utils.MyStoredProcedure;

@Component
public class DraftDaoImpl implements DraftDao {
	@Autowired
	JdbcTemplate jdbcTemplate;

	public List<User> buscarTodos(int idTemporada) {

		List<User> listJuadores = new ArrayList<User>();
		String query = "  select  "
				+"  persona.idPersona,  "
				+"  persona.NombreCompleto,  "
				+"  persona.sobrenombre,  "
				+"  persona.img,  "
				+"  persona.raiting,  "
				+"  persona.prestamo,  "
				+"  prestamos.Equipos_idEquipo as idEquipo,  "
				+"  (case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo "
				+"  else equipos_has_temporada.nombreEquipo end) as nombreEquipo ,  "
				+"  equipopres.Equipos_idEquipo as idEquipoPres,  "
				+"   (case when equipopres.nombreEquipo is null then equiposP.nombreEquipo "
				+"   else equipopres.nombreEquipo end) as nombreEquipoPres  "
				+"  from prestamos  "
				+"  join persona on persona.idPersona = prestamos.Persona_idPersona "
				+"  join persona_has_temporada  on prestamos.Persona_idPersona = persona_has_temporada.persona_idPersona  "
				+"  	 and persona_has_temporada.temporada_idTemporada = prestamos.tempodada_idTemporada "
				+"  join equipos_has_temporada on prestamos.Equipos_idEquipo = equipos_has_temporada.Equipos_idEquipo "
				+"       and persona_has_temporada.temporada_idTemporada = prestamos.tempodada_idTemporada  "
				+"  join equipos on equipos.idEquipo = prestamos.Equipos_idEquipo "
				+"  join equipos_has_temporada equipopres on equipopres.Equipos_idEquipo = persona_has_temporada.Equipos_idEquipo  "
				+"        and equipopres.tempodada_idTemporada = persona_has_temporada.temporada_idTemporada "
				+"  join equipos equiposP on equiposP.idEquipo = equipopres.Equipos_idEquipo "
				+"  where prestamos.activo = 1 and prestamos.tempodada_idTemporada =  " + idTemporada
				+"  and equipos_has_temporada.tempodada_idTemporada =  "+ idTemporada
				+"  and equipopres.tempodada_idTemporada =  "+ idTemporada
				;

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				User jugador = new User();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setPrestamo(rs.getInt("prestamo"));
				jugador.setImg(rs.getString("img"));
				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));

				jugador.setEquipo(equipo);

				Equipo equipoPres = new Equipo();

				equipoPres.setId(rs.getLong("idEquipoPres"));
				equipoPres.setNombre(rs.getNString("nombreEquipoPres"));

				jugador.setEquipoPres(equipoPres);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((User) jugador);
		}

		return listJuadores;
	}

	public void crearPrestamo(User jugador, long id,int idTemporada) {
		//System.out.println("Crear prestamo call createPrestamo(" + jugador.getId() + "," + id + ",);"+idTemporada);
		//ULtimo parametro opcion para eliminar(2) o crear(1)

		String query = "call  createPrestamo(?,?,?,1)";

		jdbcTemplate.update(query, jugador.getId(), id,idTemporada);

	}

	public void deletePresById(long id, long idEquipo,int idTemporada) {
		//System.out.println("Crear prestamo call createPrestamo(" + id + "," + idEquipo + ",2);");

		String query = "call  createPrestamo(?,?,?,2)";

		jdbcTemplate.update(query, id, idEquipo,idTemporada);

	}

	public List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada) {
		List<User> listJuadores = new ArrayList<User>();
		String query = " select  " 
		        + " persona.idPersona, " 
				+ " persona.NombreCompleto, " 
		        + " persona.sobrenombre, "
		        +"  persona.img,  "
				+ " persona.raiting, " 
		        + " persona.prestamo, " 
				+ " equipos.idEquipo, " 
		        + " equipos.nombreEquipo, "
				+ " equipopres.idEquipo as idEquipoPres, " 
		        + " equipopres.nombreEquipo as nombreEquipoPres "
				+ " from prestamos " 
		        + " join persona on prestamos.Persona_idPersona = persona.idPersona "
				+ " join equipos on equipos.idEquipo = prestamos.Equipos_idEquipo "
				+ " join equipos equipopres on equipopres.idEquipo = persona.Equipos_idEquipo "
				+ " where prestamos.activo = 1 " + " and prestamos.Equipos_idEquipo = " + idEquipo
				+ " and prestamos.tempodada_idTemporada = "+ idTemporada;

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				User jugador = new User();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setPrestamo(rs.getInt("prestamo"));
				jugador.setImg(rs.getString("img"));
				
				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));

				jugador.setEquipo(equipo);

				Equipo equipoPres = new Equipo();

				equipoPres.setId(rs.getLong("idEquipoPres"));
				equipoPres.setNombre(rs.getNString("nombreEquipoPres"));

				jugador.setEquipoPres(equipoPres);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((User) jugador);
		}

		return listJuadores;
	}

	/*
	 * Draft PC
	 * 
	 * @see com.companyname.springapp.dao.DraftDao#findJugadoresDraft()
	 */
	public List<JugadorDraft> findJugadoresDraft(int idTemporada) {
		List<JugadorDraft> listJuadores = new ArrayList<JugadorDraft>();
		String query = " select persona.idPersona, " 
				+ " persona.NombreCompleto, " 
				+ " persona.sobrenombre, "
				+ " persona.img, "
				+ " persona.raiting, "
				+ " persona.link, "
				+ " equipos.idEquipo, " 
				+ " equipos.nombreEquipo, " 
				+ " draftpc.fechaCompra, "
				+ " draftpc.oferta, " 
				+ " draftpc.ofertaFinal, " 
				+ " draftpc.usuarioOferta, " 
				+ " draftpc.comentarios, "
				+ " draftpc.abierto, " 
				+ " draftpc.idEquipo as idEquipoOferta, " 
				+ " temporada.idTemporada, " 
				+ " temporada.NombreTemporada,"
				+ " equipos_has_imagen.imagen  " 
				+ " from draftpc "
				+ " join persona on persona.idPersona = draftpc.Persona_idPersona "
				+ " join equipos on equipos.idEquipo = persona.Equipos_idEquipo "
				+ " join temporada on temporada.idTemporada = draftpc.tempodada_idTemporada " 
				+ " left join equipos_has_imagen on draftpc.idEquipo = equipos_has_imagen.equipos_idEquipo "
				+ "     and equipos_has_imagen.idTemporada = " + idTemporada
		        + "     and equipos_has_imagen.tipoImagen_idTipoImagen = 2 "
				+ " where draftpc.abierto = 1 and temporada.idTemporada = " + idTemporada;

		//System.out.println("------->Entrando a hacer consulta DraftPC");
		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				JugadorDraft jugador = new JugadorDraft();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setLink(rs.getString("link"));
				jugador.setImg(rs.getString("img"));

				jugador.setMontoOferta(rs.getInt("oferta"));
				jugador.setAbierto(rs.getBoolean("abierto"));
				jugador.setFecha(rs.getString("fechaCompra"));
				jugador.setManager(rs.getString("usuarioOferta"));
				jugador.setComentarios(rs.getString("comentarios"));
				jugador.setOfertaFinal(rs.getInt("ofertaFinal"));
				jugador.setIdEquipoOferta(rs.getInt("idEquipoOferta"));

				Temporada temporada = new Temporada();

				temporada.setId(rs.getInt("idTemporada"));
				temporada.setNombre(rs.getString("NombreTemporada"));

				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));
				equipo.setImg(rs.getString("imagen"));
				equipo.setTemporada(temporada);

				jugador.setEquipo(equipo);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((JugadorDraft) jugador);
		}

		return listJuadores;
	}

	public HashMap<String, String> initialDraft(long id, int monto, String manager, String observaciones,
			int idEquipo, int idTemporada) {

		String query = "createInitialDraft";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJugador = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter montoOferta = new SqlParameter("montoOferta", Types.INTEGER);
		SqlParameter manager1 = new SqlParameter("manager", Types.VARCHAR);
		SqlParameter observaciones1 = new SqlParameter("observaciones", Types.VARCHAR);
		SqlParameter idEquipoOferta = new SqlParameter("idEquipoOferta", Types.VARCHAR);
		SqlParameter idTemporadaOferta = new SqlParameter("idTemporada", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJugador, montoOferta, manager1, observaciones1, idEquipoOferta,idTemporadaOferta, isError,
				message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id, monto, manager, observaciones, idEquipo,idTemporada);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}

	public HashMap<String, String> updateDraft(long id, int monto, String manager, String observaciones,
			int montoInicial, int idEquipo, int idTemporada) {

		//System.out.println("----->updateDraft]:" + idEquipo);
		String query = "updateDraft";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJugador = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter montoInicial1 = new SqlParameter("montoInicial", Types.INTEGER);
		SqlParameter montoOferta = new SqlParameter("montoOferta", Types.INTEGER);
		SqlParameter manager1 = new SqlParameter("manager", Types.VARCHAR);
		SqlParameter observaciones1 = new SqlParameter("observaciones", Types.VARCHAR);
		SqlParameter idEquipoOferta = new SqlParameter("idEquipoOferta", Types.VARCHAR);
		SqlParameter idTemporadaOferta = new SqlParameter("idTemporada", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		System.out.println("------->[updateDraft]\t id:" +id +"\t montoInicial:" +montoInicial +"\t monto:" +monto +"\t manager:" +manager +"\t observaciones:" +observaciones +"\t idEquipo:" +idEquipo +"\t idTemporada:" +idTemporada);
		SqlParameter[] paramArray = { idJugador, montoInicial1, montoOferta, manager1, observaciones1, idEquipoOferta,idTemporadaOferta,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id, montoInicial, monto, manager, observaciones, idEquipo,idTemporada);
		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}
	public HashMap<String, String> updateDraftAdmin(long id, int monto, String manager, String observaciones,
			int montoInicial, int idEquipo, int idTemporada) {

		//System.out.println("----->updateDraftCorreccion]:" + idEquipo);
		String query = "updateDraftCorreccion";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJugador = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter montoInicial1 = new SqlParameter("montoInicial", Types.INTEGER);
		SqlParameter montoOferta = new SqlParameter("montoOferta", Types.INTEGER);
		SqlParameter manager1 = new SqlParameter("manager", Types.VARCHAR);
		SqlParameter observaciones1 = new SqlParameter("observaciones", Types.VARCHAR);
		SqlParameter idEquipoOferta = new SqlParameter("idEquipoOferta", Types.VARCHAR);
		SqlParameter idTemporadaOferta = new SqlParameter("idTemporada", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		System.out.println("------->[updateDraftCorreccion]\t id:" +id +"\t montoInicial:" +montoInicial +"\t monto:" +monto +"\t manager:" +manager +"\t observaciones:" +observaciones +"\t idEquipo:" +idEquipo +"\t idTemporada:" +idTemporada);
		SqlParameter[] paramArray = { idJugador, montoInicial1, montoOferta, manager1, observaciones1, idEquipoOferta,idTemporadaOferta,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id, montoInicial, monto, manager, observaciones, idEquipo,idTemporada);
		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}

	@Override
	public List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTemporada) {
		List<JugadorDraft> listJuadores = new ArrayList<JugadorDraft>();
		String query = " select persona.idPersona,  " 
				+ " persona.NombreCompleto,  " 
				+ " persona.sobrenombre,  "
				+ " persona.raiting,  " 
				+ " equipos.idEquipo,  " 
				+ " equipos.nombreEquipo,  "
				+ " draftpc.fechaCompra,  " 
				+ " draftpc.oferta,  " 
				+ " draftpc.ofertaFinal,  "
				+ " draftpc.usuarioOferta,  " 
				+ " draftpc.comentarios,  " 
				+ " draftpc.abierto,  "
				+ " draftpc.idEquipo as idEquipoOferta, " 
				+ " temporada.idTemporada,  " 
				+ " temporada.NombreTemporada  " 
				+ " from draftpc  "
				+ " join persona on persona.idPersona = draftpc.Persona_idPersona  "
				+ " join equipos on equipos.idEquipo = persona.Equipos_idEquipo  "
				+ " join temporada on temporada.idTemporada = draftpc.tempodada_idTemporada  " + " where draftpc.abierto = 1 "
				+ " and draftpc.tempodada_idTemporada = " + idTemporada
				+ " and draftpc.Persona_idPersona in (select DraftPC_Persona_idPersona from historicodraft "
				+ " where historicodraft.tempodada_idTemporada = " + idTemporada
				+ " and historicodraft.idEquipo = " + idEquipo + ")";

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				JugadorDraft jugador = new JugadorDraft();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setIdEquipoOferta(rs.getInt("idEquipoOferta"));
				jugador.setMontoOferta(rs.getInt("oferta"));
				jugador.setAbierto(rs.getBoolean("abierto"));
				jugador.setFecha(rs.getString("fechaCompra"));
				jugador.setManager(rs.getString("usuarioOferta"));
				jugador.setComentarios(rs.getString("comentarios"));
				jugador.setOfertaFinal(rs.getInt("ofertaFinal"));

				Temporada temporada = new Temporada();

				temporada.setId(rs.getInt("idTemporada"));
				temporada.setNombre(rs.getString("NombreTemporada"));

				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));
				equipo.setTemporada(temporada);

				jugador.setEquipo(equipo);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((JugadorDraft) jugador);
		}

		return listJuadores;
	}

	@Override
	public HashMap<String, String> confirmPlayer(long id, int idEquipo, int idTemporada) {

		System.out.println("----->confirmPlayer]:" +id+ "  -  "+ idEquipo+ "  -  "+idTemporada);
		String query = "confirmPlayer";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJugador = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter idEquipoOferta = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlParameter idTemporadaOferta = new SqlParameter("idTemporada", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJugador, idEquipoOferta,idTemporadaOferta,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id, idEquipo,idTemporada);

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}
	
	public List<JugadorDraft> getHistoricoDraft( int idDraft,int idJugador, int idTemporada) {
		List<JugadorDraft> listJuadores = new ArrayList<JugadorDraft>();
		String query = " select persona.NombreCompleto, "
				+" persona.sobrenombre, "
				+" persona.link, "
				+" persona.raiting,"
				+" DraftPC_idDraftPC , "
				+" fechaOferta, "
				+" updateDate, "
				+" oferta, "
				+" ofertaFinal, "
				+" usuarioOferta, "
				+" DraftPC_Persona_idPersona, "
				+" comentarios, "
				+" equipos.idEquipo, "
				+" equipos.nombreEquipo "
				+" from historicodraft "
				+" join persona on persona.idPersona = historicodraft.DraftPC_Persona_idPersona "
				+" join equipos on equipos.idEquipo = historicodraft.idEquipo " 
				+" where "
				+" persona.idPersona =  "+ idJugador 
				+" and historicodraft.tempodada_idTemporada = " +idTemporada;

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				JugadorDraft jugador = new JugadorDraft();
				jugador.setId(rs.getLong("DraftPC_Persona_idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setIdEquipoOferta(rs.getInt("idEquipo"));
				jugador.setMontoOferta(rs.getInt("oferta"));
				
				jugador.setFecha(rs.getString("updateDate"));
				jugador.setManager(rs.getString("usuarioOferta"));
				jugador.setComentarios(rs.getString("comentarios"));
				jugador.setOfertaFinal(rs.getInt("ofertaFinal"));

//				Temporada temporada = new Temporada();
//
//				temporada.setId(rs.getInt("idTemporada"));
//				temporada.setNombre(rs.getString("NombreTemporada"));

				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));
//				equipo.setTemporada(temporada);

				jugador.setEquipo(equipo);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((JugadorDraft) jugador);
		}

		return listJuadores;
	}
	
	public List<JugadorDraft> getAllMov(int idTemporada) {
		List<JugadorDraft> listJuadores = new ArrayList<JugadorDraft>();
		String query = " select persona.idPersona,   "
				+"        persona.sobrenombre,   "
				+"          persona.idsofifa,   "
				+"          persona.img,  "
				+ "     persona_has_temporada.costo, "
				+"          persona.link,   "
				+"          persona.NombreCompleto,   "
				+"          persona_has_temporada.rating,   "
				+"          pres.equipos_idEquipo,   "
				+"          pres.temporada_idTemporada, "
				+"          case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end as nombreEquipo   , "
				+"          equipos_has_imagen.imagen, "
				+"          persona_has_temporada.equipos_idEquipo as equipos_idEquipo2, "
				+"          case when eqt.nombreEquipo is null then eq.nombreEquipo else eqt.nombreEquipo end as nombreEquipo2   , "
				+"          eqim.imagen as imagen2, "
				+"          persona_has_temporada.temporada_idTemporada as temporada_idTemporada2 "
				+" from persona "
				+" join persona_has_temporada on persona_has_temporada.persona_idPersona = persona.idPersona "
				+" join persona_has_temporada pres on pres.persona_idPersona = persona_has_temporada.persona_idPersona  "
				+"      and pres.temporada_idTemporada = (select max(idTemporada)    "
				+"                 from temporada     "
				+"                 where temporada.idTemporada <  "+idTemporada+" ) and pres.equipos_idEquipo > 1 "
				+" join equipos on equipos.idEquipo = pres.equipos_idEquipo "
				+" join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = pres.equipos_idEquipo and equipos_has_temporada.tempodada_idTemporada = pres.temporada_idTemporada "
				+" join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = pres.equipos_idEquipo  and equipos_has_imagen.idTemporada = pres.temporada_idTemporada  "
				+"          and equipos_has_imagen.tipoImagen_idTipoImagen = 1 "
				+" join equipos eq on eq.idEquipo = persona_has_temporada.Equipos_idEquipo  "
				+" join equipos_has_temporada eqt on eqt.Equipos_idEquipo = eq.idEquipo and eqt.tempodada_idTemporada = persona_has_temporada.temporada_idTemporada "
				+"  join equipos_has_imagen eqim on eqim.equipos_idEquipo = eq.idEquipo and eqim.idTemporada = persona_has_temporada.temporada_idTemporada "
				+"      and eqim.tipoImagen_idTipoImagen = 1 "
				+" where persona_has_temporada.temporada_idTemporada =  " + idTemporada
				+ "  and persona_has_temporada.equipos_idEquipo> 1 "
				+" and persona_has_temporada.equipos_idEquipo != pres.equipos_idEquipo ";

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				JugadorDraft jugador = new JugadorDraft();
				User player = new User();
				
				player.setId(rs.getInt("idPersona"));
				player.setNombreCompleto(rs.getString("NombreCompleto"));
				player.setSobrenombre(rs.getString("sobrenombre"));
				player.setImg(rs.getString("img"));
				player.setCosto(rs.getDouble("costo"));
				
				jugador.setPlayer(player);

				Equipo equipo = new Equipo();

				equipo.setId(rs.getLong("equipos_idEquipo"));
				equipo.setNombre(rs.getNString("nombreEquipo"));
				equipo.setImg(rs.getString("imagen"));

				jugador.setEquipo(equipo);
				
				Equipo equipoNew = new Equipo();

				equipoNew.setId(rs.getLong("equipos_idEquipo2"));
				equipoNew.setNombre(rs.getNString("nombreEquipo2"));
				equipoNew.setImg(rs.getString("imagen2"));

				jugador.setEquipoNew(equipoNew);

				return jugador;
			}
		});

		for (Object jugador : jugadores) {
			listJuadores.add((JugadorDraft) jugador);
		}

		return listJuadores;
	}

}
