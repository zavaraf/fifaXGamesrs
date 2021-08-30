package com.app.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.EquipoDao;
import com.app.dao.TemporadaDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.DatosJornadas;
import com.app.modelo.Equipo;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Grupos;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.SalonFama;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;
import com.app.modelo.Torneo;
import com.app.service.TemporadaService;
import com.app.utils.GenerarJornadasUtil;
import com.google.gson.Gson;

@Service
public class TemporadaServiceImpl implements TemporadaService {
	@Autowired
	TemporadaDao temporadaDao;
	@Autowired
	EquipoDao equipoDao;

	public List<Temporada> buscarTodos() {

		return temporadaDao.buscarTodos();
	}

	public List<TablaGeneral> getTablaGeneral(int idTemporada, int idDivision) {

		return temporadaDao.getTablaGeneral(idTemporada, idDivision);
	}

	public Torneo getTorneoGeneral(int idTemporada, int idDivision, int idEquipo) {

		return temporadaDao.getTorneoGeneral(idTemporada, idDivision, idEquipo);
	}

	public List<Jornadas> getJornadas(int idTemporada, int idDivision, int activa) {

		return temporadaDao.getJornadas(idTemporada, idDivision, activa);
	}

	public List<Jornadas> getArmarJornadasInicial(int idTemporada, int idTorneo) {

		List<Equipo> equipos = equipoDao.findEquiposByTorneo(idTemporada, idTorneo);

		GenerarJornadasUtil generarJornadas = new GenerarJornadasUtil();

		List<Jornadas> jornadasList = generarJornadas.getJornadas(equipos);

		return jornadasList;
	}

	public List<Grupos> getArmarJornadasGrupos(int idTemporada, int idTorneo, int numGrupos, List<Equipo> equiposL,
			int vuelta, int confAle) {

		GenerarJornadasUtil generarJornadas = new GenerarJornadasUtil();

		List<Equipo> equipos = null;

		if (confAle == 1) {
			equipos = generarJornadas.agruparArreglo(equiposL);
		} else {
			equipos = generarJornadas.agruparArreglo(equiposL, numGrupos);
			// equipos = equiposL; //TODO QUITAR ESTA LINEA

		}

		List<Grupos> grupos = generarJornadas.generarGrupos(equipos, numGrupos);

		for (Grupos grupo : grupos) {
			List<Jornadas> jornadas = generarJornadas.getJornadasIdaYVuelta(grupo.getEquipos(), vuelta, grupos);
			grupo.setJornadas(jornadas);
		}
		// List<Jornadas> jornadasList = generarJornadas.getJornadas(equipos);

		return grupos;
	}

	public ResponseData addJuegosLiguilla(int idTemporada, int idTorneo, List<Jornadas> jornadas) {

		// Torneo torneoCompleto = getTorneoGeneral(idTemporada, idTorneo);

		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		Gson gson = new Gson();

		String json = gson.toJson(jornadas);

		map = temporadaDao.addJuegosLiguilla(idTemporada, idTorneo, json);

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {
			List<Jornadas> jornadasList = temporadaDao.getJornadas(idTemporada, idTorneo, 0);
			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			response.setData(jornadasList);

		}
		return response;

	}

	public List<GolesJornadas> getGolesJornadas(String idJornada, String id, String idEquipoLocal,
			String idEquipoVisita) {

		return temporadaDao.getGolesJornadas(idJornada, id, idEquipoLocal, idEquipoVisita);
	}

	public Jornada getJornada(String idJornada, String id, String idEquipoLocal, String idEquipoVisita,
			int idTemporada) {

		Jornada jornada = new Jornada();

		jornada = temporadaDao.getJornada(idJornada, id, idEquipoLocal, idEquipoVisita, idTemporada);

		List<GolesJornadas> goles = temporadaDao.getGolesJornadas(idJornada, id, idEquipoLocal, idEquipoVisita);
		List<String> imagenes = temporadaDao.getImagenes(idJornada, id);

		List<DatosJornadas> lesiones = temporadaDao.getDatosJornadas(idJornada, id, idEquipoLocal, idEquipoVisita, 2);
		List<DatosJornadas> tarjetas = temporadaDao.getDatosJornadas(idJornada, id, idEquipoLocal, idEquipoVisita, 1);

		List<DatosJornadas> datosActivos = temporadaDao.getDatosJornadaEquipos(idJornada, id, idEquipoLocal,
				idEquipoVisita, idTemporada);

		List<HashMap<String, String>> mapaImg = new ArrayList<HashMap<String, String>>();

		for (Object img : imagenes) {
			HashMap<String, String> mapa = new HashMap<String, String>();

			mapa.put("img", img.toString());
			mapaImg.add(mapa);

		}

		jornada.setGolesJornada(goles);
		jornada.setImagenes(mapaImg);
		jornada.setLesionesJornada(lesiones);
		jornada.setTarjetasJornada(tarjetas);
		jornada.setDatosActivosJornada(datosActivos);

		return jornada;

	}

	@Override
	public ResponseData addGol(int idJugador, int idEquipo, int id, int idJornada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = temporadaDao.addGol(idJugador, idEquipo, id, idJornada);

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

	public ResponseData addResultJornada(int idTorneo, int idTemporada, Jornada jornada, int idEquipo,
			String username) {

		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		Gson gson = new Gson();

		String json = gson.toJson(jornada);

		System.out.println(json);

		map = temporadaDao.addResultJornada(idTorneo, idTemporada, json, username);

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());

		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));

			Torneo torneo = temporadaDao.getTorneoGeneral(idTemporada, idTorneo, idEquipo);
			response.setData(torneo);

		}

		return response;
	}

	public ResponseData addImagen(int idEquipo, int id, int idJornada, String img) {

		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = temporadaDao.addImagen(idEquipo, id, idJornada, img);

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
	public ResponseData addJornadas(int idTemporada, int idDivision, List<Jornadas> jornadas, int tipoTorneo) {

		ResponseData response = new ResponseData();
		HashMap<String, String> map = new HashMap<String, String>();

		for (Jornadas jornada : jornadas) {
			for (Jornada juegos : jornada.getJornada()) {
				if (juegos.getIdEquipoLocal() != -1 && juegos.getIdEquipoVisita() != -1) {
					map = temporadaDao.addJornada(idTemporada, idDivision, juegos, jornada.getActiva(),
							jornada.getCerrada());
				}
				if (tipoTorneo == 2) {
					break;
				}
			}
			// if(tipoTorneo == 2){
			// break;
			// }
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

	public ResponseData addJornadasGrupos(int idTemporada, String nombre, String grupos,int confTor, int idCat){
		ResponseData response = new ResponseData();
		HashMap<String, String> map = new HashMap<String, String>();
		
		if(confTor == 2){
			map = temporadaDao.addJornadasGrupos(idTemporada, nombre, grupos, idCat);
			System.out.println(grupos);//TODO DESCOMENTAR 
		}else {
			map = temporadaDao.crearTorneo(idTemporada, nombre);
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

	public List<Grupos> getGruposTorneo(int idTemporada, int idTorneo) {

		List<Grupos> grupos = temporadaDao.getGruposTorneo(idTemporada, idTorneo);

		return grupos;

	}

	public List<Grupos> generarJornadasGruposTorneos(int idTemporada, int idTorneo, int vuelta, String nombre) {

		List<Grupos> grupos = temporadaDao.getGruposTorneo(idTemporada, idTorneo);

		GenerarJornadasUtil generarJornadas = new GenerarJornadasUtil();

		for (Grupos grupo : grupos) {
			List<Jornadas> jornadas = generarJornadas.getJornadasIdaYVuelta(grupo.getEquipos(), vuelta, grupos);
			grupo.setJornadas(jornadas);
		}

		HashMap<String, String> map = new HashMap<String, String>();

		Gson json = new Gson();

		map = temporadaDao.addJornadasGrupos(idTemporada, nombre, json.toJson(grupos),1);

		return grupos;

	}

	@Override
	public ResponseData getSalonFama() {
		ResponseData response = new ResponseData();
		HashMap<String, List<SalonFama>> map = new HashMap<String, List<SalonFama>>();
		List<SalonFama> list = new ArrayList<SalonFama>();
		List<SalonFama> listd = new ArrayList<SalonFama>();

		list = temporadaDao.getSalonFama(false);

		listd = temporadaDao.getSalonFama(true);

		map.put("resumen", list);
		map.put("detalle", listd);

		response.setStatus(1);
		response.setMensaje("OK");

		response.setData(map);

		return response;
	}

	@Override
	public ResponseData getCatTorneo() {
		ResponseData response = new ResponseData();
		HashMap<String, List<Torneo>> map = new HashMap<String, List<Torneo>>();
		List<Torneo> list = new ArrayList<Torneo>();

		list = temporadaDao.getCatTorneo();

		map.put("catTorneo", list);

		response.setStatus(1);
		response.setMensaje("OK");

		response.setData(map);

		return response;
	}

}
