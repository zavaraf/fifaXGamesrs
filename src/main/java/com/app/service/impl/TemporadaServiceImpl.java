package com.app.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.EquipoDao;
import com.app.dao.TemporadaDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Equipo;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;
import com.app.service.TemporadaService;
import com.app.utils.GenerarJornadasUtil;

@Service
public class TemporadaServiceImpl implements TemporadaService{
	@Autowired
	TemporadaDao temporadaDao;
	@Autowired
	EquipoDao equipoDao;
	
	public List<Temporada> buscarTodos() {

		return temporadaDao.buscarTodos();
	}
	
	public List<TablaGeneral> getTablaGeneral(int idTemporada, int idDivision){
		
		return temporadaDao.getTablaGeneral(idTemporada,idDivision);
	}
	
	public List<Jornadas> getJornadas(int idTemporada, int idDivision,int activa){
		
		return temporadaDao.getJornadas(idTemporada,idDivision,activa);
	}
	
	public List<Jornadas> getArmarJornadasInicial(int idTemporada, int idTorneo){
		
		List<Equipo> equipos = equipoDao.findEquiposByTorneo(idTemporada, idTorneo);
		
		
		
		GenerarJornadasUtil generarJornadas = new GenerarJornadasUtil();
		
		
		List<Jornadas> jornadasList = generarJornadas.getJornadas(equipos);		
		
		
		return jornadasList;
	}
	public List<GolesJornadas> getGolesJornadas(String idJornada,String id,
		String idEquipoLocal,
		String idEquipoVisita){
		
		return temporadaDao.getGolesJornadas( idJornada, id, idEquipoLocal, idEquipoVisita);
	}
	
	public Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita){
		
		Jornada jornada = new Jornada();
		
		jornada = temporadaDao.getJornada( idJornada, id, idEquipoLocal, idEquipoVisita);
		
		List<GolesJornadas> goles = temporadaDao.getGolesJornadas( idJornada, id, idEquipoLocal, idEquipoVisita);
		List<String> imagenes = temporadaDao.getImagenes(idJornada, id);
		
		List<HashMap<String,String>> mapaImg = new ArrayList<HashMap<String,String>>();
		
		for(Object img : imagenes){
			HashMap<String,String> mapa = new HashMap<String,String>();
			
			mapa.put("img", img.toString());
			mapaImg.add(mapa);
			
		}
		
		
		jornada.setGolesJornada(goles);
		jornada.setImagenes(mapaImg);
		
		return jornada;
		
		
		
	}

	
	@Override
	public ResponseData addGol(int idJugador,int idEquipo,int id,int idJornada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = temporadaDao.addGol(idJugador, idEquipo,id,idJornada);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
		
		}
		return response;
	}
	
	public ResponseData addImagen(int idEquipo,int id,int idJornada,String img){
		
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = temporadaDao.addImagen( idEquipo,id,idJornada,img);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
		
		}
		return response;
		
	}

	@Override
	public ResponseData addJornadas(int idTemporada, int idDivision, List<Jornadas> jornadas) {
		
		
		ResponseData response = new ResponseData();
		HashMap<String, String> map = new HashMap<String, String>();
		
		for(Jornadas jornada : jornadas ){
			for(Jornada juegos : jornada.getJornada()){
				if(juegos.getIdEquipoLocal() != -1 && juegos.getIdEquipoVisita() !=-1){
					map = temporadaDao.addJornada( idTemporada,idDivision,juegos,jornada.getActiva(),jornada.getCerrada());
				}
			}
		}
		
		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
		
		}
		
		return response;
	}
}
