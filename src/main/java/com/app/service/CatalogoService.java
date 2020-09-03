package com.app.service;

import java.util.List;

import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.ResponseData;

public interface CatalogoService {
	
	public List<CatalogoFinanciero> listAllCatalogs();
	
	ResponseData updateCatalogos(String nombre, String description, int tipo);

}
