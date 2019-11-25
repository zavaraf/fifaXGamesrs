package com.app.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.EquipoDao;
import com.app.dao.TorneoDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Equipo;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Torneo;
import com.app.service.TorneoService;
import com.app.utils.GenerarJornadasUtil;

@Service
public class TorneoServiceImpl implements TorneoService{
	@Autowired
	TorneoDao torneoDao;
	@Autowired
	EquipoDao equipoDao;
	
	public List<Torneo> buscarTodos() {

		return torneoDao.buscarTodos();
	}
	
	public List<TablaGeneral> getTablaGeneral(int idTorneo, int idDivision){
		
		return torneoDao.getTablaGeneral(idTorneo,idDivision);
	}
	
	public List<Jornadas> getJornadas(int idTorneo, int idDivision,int activa){
		
		return torneoDao.getJornadas(idTorneo,idDivision,activa);
	}
	
	public List<Jornadas> getArmarJornadasInicial(int idTorneo, int idDivision){
		
		List<Equipo> equipos = equipoDao.findEquiposByDivision(idTorneo, idDivision);
		
		Collections.sort(equipos, new Comparator() {
		
//			@Override
//			public int compare(Equipo p1, Equipo p2) {
//				return return new Integer((int)p1.getId()).compareTo(new Integer ((int)p2.getId()));
//			}

			@Override
			public int compare(Object o1, Object o2) {
				Equipo p1 = (Equipo)o1;
				Equipo p2 = (Equipo)o2;
				return new Integer((int)p2.getId()).compareTo(new Integer ((int)p1.getId()));
			}

		});
		
		GenerarJornadasUtil generarJornadas = new GenerarJornadasUtil();
		
		
		List<Jornadas> jornadasList = generarJornadas.getJornadas(equipos);		
		
		
		return jornadasList;
	}
	public List<GolesJornadas> getGolesJornadas(String idJornada,String id,
		String idEquipoLocal,
		String idEquipoVisita){
		
		return torneoDao.getGolesJornadas( idJornada, id, idEquipoLocal, idEquipoVisita);
	}
	
	public Jornada getJornada(String idJornada,String id,String idEquipoLocal,String idEquipoVisita){
		
		Jornada jornada = new Jornada();
		
		jornada = torneoDao.getJornada( idJornada, id, idEquipoLocal, idEquipoVisita);
		
		List<GolesJornadas> goles = torneoDao.getGolesJornadas( idJornada, id, idEquipoLocal, idEquipoVisita);
		List<String> imagenes = torneoDao.getImagenes(idJornada, id);
		
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

		map = torneoDao.addGol(idJugador, idEquipo,id,idJornada);
		
		

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

		map = torneoDao.addImagen( idEquipo,id,idJornada,img);
		
		

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
	public ResponseData addJornadas(int idTorneo, int idDivision, List<Jornadas> jornadas) {
		
		
		ResponseData response = new ResponseData();
		HashMap<String, String> map = new HashMap<String, String>();
		
		for(Jornadas jornada : jornadas ){
			for(Jornada juegos : jornada.getJornada()){
				if(juegos.getIdEquipoLocal() != -1 && juegos.getIdEquipoVisita() !=-1){
					map = torneoDao.addJornada( idTorneo,idDivision,juegos,jornada.getActiva());
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
