package com.app.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.app.modelo.DatosJornadas;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Grupos;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.SalonFama;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;
import com.app.modelo.Torneo;

public interface TemporadaDao {

	List<Temporada> buscarTodos();
	List<TablaGeneral> getTablaGeneral(int idTemporada, int idDivision);
	Torneo getTorneoGeneral(int idTemporada, int idDivision, int idEquipo);
	List<Jornadas> getJornadas(int idTemporada, int idDivision,int activa);
	List<GolesJornadas> getGolesJornadas(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	List<DatosJornadas> getDatosJornadas(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita,
			int tipoDato);
	
	List<DatosJornadas> getDatosJornadaEquipos(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita,
			int idTemporada
			);
	
	Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita, int idTemporada);
	List<String>getImagenes(String idJornada,String id);
	
	List<Jornadas> getArmarJornadasInicial(int idTemporada, int idDivision);
	
	HashMap<String, String> addJuegosLiguilla(int idTemporada, int idTorneo, String jornadas);
	
	HashMap<String, String> addGol(int idJugador,int idEquipo,int id,int idJornada);
	HashMap<String, String> addResultJornada(int id,int idJornada,String jornada, String username);
	
	HashMap<String, String> addImagen(int idEquipo,int id,int idJornada,String img);
//	HashMap<String, String> addJornada(int idTemporada, int idDivision, Jornada juegos,int activa,int cerrada);
	HashMap<String, String> addJornadasGrupos(int idTemporada, String nombre , String grupos, int idCat);
	HashMap<String, String> crearTorneo(int idTemporada, String nombre );
	List<Grupos> getGruposTorneo(int idTemporada, int idTorneo);
	List<SalonFama> getSalonFama(boolean detalle);
	
	List<Torneo> getCatTorneo();
	HashMap<String, String> addJornada(int idTemporada, int idDivision, Jornada juego, int activa, int cerrada,
			Date fechaIni, Date fechaFin);
	
	HashMap<String, String> delJuegoJornada(int id);
	
	HashMap<String, String> editJuegoJornada(int id, int idEquipoLocal, int idEquipoVisita);


}
