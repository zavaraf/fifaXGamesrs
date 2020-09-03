package com.app.dao;

import java.util.HashMap;
import java.util.List;

import com.app.modelo.CatalogoFinanciero;

public interface CatalogoDao {
	
	public List<CatalogoFinanciero> listAllCatalogs();

	HashMap<String, String> updateCatalogos(String nombre, String description, int tipo);

}
