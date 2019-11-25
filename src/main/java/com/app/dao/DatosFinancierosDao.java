package com.app.dao;

import com.app.modelo.DatosFinancieros;
import com.app.modelo.Equipo;

public interface DatosFinancierosDao {
	
	DatosFinancieros getDatosFinancieros(Equipo idEquipo);
	void test();

}
