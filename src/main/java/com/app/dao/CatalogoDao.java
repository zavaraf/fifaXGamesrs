package com.app.dao;

import java.util.HashMap;
import java.util.List;

import com.app.modelo.Castigo;
import com.app.modelo.CatalogoFinanciero;

public interface CatalogoDao {
	
	public List<CatalogoFinanciero> listAllCatalogs();

	HashMap<String, String> updateCatalogos(String nombre, String description, int tipo);

	List<Castigo> listAllCastigos(int idTemporada);

	HashMap<String, String> updateCastigos(int id, int idEquipo, int idTemporada, int valor, String observaciones,
			String tipo, int idTorneo);

	public HashMap<String, String> confirmarJugadores(String json, int idTemporada);

}
