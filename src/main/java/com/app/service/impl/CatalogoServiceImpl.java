package com.app.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.CatalogoDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Castigo;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.JugadoresCSV;
import com.app.modelo.ResponseData;
import com.app.service.CatalogoService;
import com.google.gson.Gson;

@Service
public class CatalogoServiceImpl implements CatalogoService {

	@Autowired
	CatalogoDao catalogoDao;

	@Override
	public List<CatalogoFinanciero> listAllCatalogs() {
		return catalogoDao.listAllCatalogs();
	}

	@Override
	public ResponseData updateCatalogos(String nombre, String description, int tipo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = catalogoDao.updateCatalogos(nombre, description, tipo);
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
	public List<Castigo> listAllCastigos(int idTemporada) {
		return catalogoDao.listAllCastigos(idTemporada);
	}

	@Override
	public ResponseData updateCastigo(Castigo castigo, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = catalogoDao.updateCastigos(castigo.getCastigoId(), castigo.getIdEquipo(), idTemporada,
				castigo.getNumero(), castigo.getObservaciones(), castigo.getCastigo(), castigo.getIdTorneo());

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
	public ResponseData confirmarJugadores(List<JugadoresCSV> jugadores, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		Gson gson = new Gson();

		String json = gson.toJson(jugadores);

		map = catalogoDao.confirmarJugadores(json, idTemporada);

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
	public ResponseData confirmarJugadoresString(List<JugadoresCSV> jugadores, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		Gson gson = new Gson();

		String json = gson.toJson(jugadores);

		StringBuilder sql = new StringBuilder();

//		for (JugadoresCSV obj : jugadores) {
//			String update = "" + " UPDATE persona_has_temporada " + " SET rating = " + obj.Overall
//					+ " where persona_idPersona = "
//					+ "    (select persona.idPersona from persona  where persona.idsofifa = " + obj.ID + "    limit 1 )"
//					+ " AND temporada_idTemporada = " + idTemporada + ";";
//
//			sql.append(update);
//		}
		
		
		sql.append( "Call confirmarJugadores('"+ json+"', 33 ,@Error, @mensaje)" );

//		map= catalogoDao.confirmarJugadores(sql,idTemporada);

//		if (map == null || map.isEmpty()) {
//			response.setStatus(CodigoResponse.ERROR.getCodigo());
//			response.setMensaje(CodigoResponse.ERROR.getMensaje());
//		} else {
//			String status = map.get("status");
//			response.setStatus(Integer.parseInt(status));
//			response.setMensaje(map.get("mensaje"));
//		}
		response.setStatus(CodigoResponse.OK.getCodigo());
		response.setMensaje(sql.toString());
		return response;
	}

}
