package com.app.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.CatalogoDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.ResponseData;
import com.app.service.CatalogoService;

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
	
	

}
