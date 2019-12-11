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
		String query = " select  " 
				+ " persona.idPersona, " 
				+ " persona.NombreCompleto, " 
				+ " persona.sobrenombre, "
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
				+ " where prestamos.activo = 1 and prestamos.tempodada_idTemporada="+idTemporada;

		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				User jugador = new User();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));
				jugador.setPrestamo(rs.getInt("prestamo"));
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
		System.out.println("Crear prestamo call createPrestamo(" + jugador.getId() + "," + id + ",);"+idTemporada);
		//ULtimo parametro opcion para eliminar(2) o crear(1)

		String query = "call fifaxgamersbd.createPrestamo(?,?,?,1)";

		jdbcTemplate.update(query, jugador.getId(), id,idTemporada);

	}

	public void deletePresById(long id, long idEquipo,int idTemporada) {
		System.out.println("Crear prestamo call createPrestamo(" + id + "," + idEquipo + ",2);");

		String query = "call fifaxgamersbd.createPrestamo(?,?,?,2)";

		jdbcTemplate.update(query, id, idEquipo,idTemporada);

	}

	public List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada) {
		List<User> listJuadores = new ArrayList<User>();
		String query = " select  " 
		        + " persona.idPersona, " 
				+ " persona.NombreCompleto, " 
		        + " persona.sobrenombre, "
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
				+ " persona.raiting, " 
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
				+ " temporada.NombreTemporada " 
				+ " from draftpc "
				+ " join persona on persona.idPersona = draftpc.Persona_idPersona "
				+ " join equipos on equipos.idEquipo = persona.Equipos_idEquipo "
				+ " join temporada on temporada.idTemporada = draftpc.tempodada_idTemporada " 
				+ " where draftpc.abierto = 1 and temporada.idTemporada = " + idTemporada;

		System.out.println("------->Entrando a hacer consulta DraftPC");
		Collection jugadores = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				JugadorDraft jugador = new JugadorDraft();
				jugador.setId(rs.getLong("idPersona"));
				jugador.setNombreCompleto(rs.getString("NombreCompleto"));
				jugador.setSobrenombre(rs.getString("sobrenombre"));
				jugador.setRaiting(rs.getInt("raiting"));

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

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}

	public HashMap<String, String> updateDraft(long id, int monto, String manager, String observaciones,
			int montoInicial, int idEquipo, int idTemporada) {

		System.out.println("----->updateDraft]:" + idEquipo);
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

		System.out.println("----->confirmPlayer]:" + idEquipo);
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

}
