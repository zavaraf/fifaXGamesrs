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
public class CatalogoServiceImpl implements CatalogoService{
	
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
		
		map= catalogoDao.updateCatalogos(nombre, description, tipo);
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
		
		map= catalogoDao.updateCastigos(castigo.getCastigoId(), 
				castigo.getIdEquipo(), 
				idTemporada, 
				castigo.getNumero(), 
				castigo.getObservaciones(), 
				castigo.getCastigo(),
				castigo.getIdTorneo());
		
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
		
		map= catalogoDao.confirmarJugadores(json,idTemporada);
		
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
