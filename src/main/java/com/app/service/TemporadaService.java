package com.app.service;

import java.util.List;

import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;

public interface TemporadaService {

	List<Temporada> buscarTodos();
	List<TablaGeneral> getTablaGeneral(int idTemporada, int idDivision);
	List<Jornadas> getJornadas(int idTemporada, int idDivision,int activa);
	List<GolesJornadas> getGolesJornadas(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita);
	
	List<Jornadas> getArmarJornadasInicial(int idTemporada, int idTorneo);
	
	ResponseData addGol(int idJugador,int idEquipo,int id,int idJornada);
	
	ResponseData addImagen(int idEquipo,int id,int idJornada,String img);
	ResponseData addJornadas(int idTemporada, int idDivision, List<Jornadas> jornadas);
	

}