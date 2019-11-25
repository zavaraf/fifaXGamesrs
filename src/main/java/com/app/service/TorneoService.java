package com.app.service;

import java.util.List;

import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Torneo;

public interface TorneoService {

	List<Torneo> buscarTodos();
	List<TablaGeneral> getTablaGeneral(int idTorneo, int idDivision);
	List<Jornadas> getJornadas(int idTorneo, int idDivision,int activa);
	List<GolesJornadas> getGolesJornadas(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	
	List<Jornadas> getArmarJornadasInicial(int idTorneo, int idDivision);
	
	ResponseData addGol(int idJugador,int idEquipo,int id,int idJornada);
	
	ResponseData addImagen(int idEquipo,int id,int idJornada,String img);
	ResponseData addJornadas(int idTorneo, int idDivision, List<Jornadas> jornadas);
	

}
