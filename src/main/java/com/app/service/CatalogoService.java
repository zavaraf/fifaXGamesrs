package com.app.service;

import java.util.List;

import com.app.modelo.Castigo;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.JugadoresCSV;
import com.app.modelo.ResponseData;

public interface CatalogoService {
	
	public List<CatalogoFinanciero> listAllCatalogs();
	
	ResponseData updateCatalogos(String nombre, String description, int tipo);

	List<Castigo> listAllCastigos(int idTemporada);


	public ResponseData updateCastigo(Castigo castigo, int idTemporada);
	
	public ResponseData confirmarJugadores(List<JugadoresCSV> judadores, int idTemporada);

}
