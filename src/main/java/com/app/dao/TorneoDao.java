package com.app.dao;

import java.util.HashMap;
import java.util.List;

import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Torneo;

public interface TorneoDao {

	List<Torneo> buscarTodos();
	List<TablaGeneral> getTablaGeneral(int idTorneo, int idDivision);
	List<Jornadas> getJornadas(int idTorneo, int idDivision,int activa);
	List<GolesJornadas> getGolesJornadas(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	List<String>getImagenes(String idJornada,String id);
	
	List<Jornadas> getArmarJornadasInicial(int idTorneo, int idDivision);
	
	HashMap<String, String> addGol(int idJugador,int idEquipo,int id,int idJornada);
	HashMap<String, String> addImagen(int idEquipo,int id,int idJornada,String img);
	HashMap<String, String> addJornada(int idTorneo, int idDivision, Jornada juegos,int activa);

}
