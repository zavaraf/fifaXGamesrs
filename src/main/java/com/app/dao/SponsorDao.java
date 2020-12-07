package com.app.dao;

import java.util.List;

import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.Sponsor;

public interface SponsorDao {

	List<Sponsor> buscarTodos();

	List<Sponsor> buscarAllByDivision(long id);

	Sponsor buscarSponsorByID(long id);

	void crearDatosFinancieros(long idEquipo,long idSponsor, boolean opcional);

	List<CatalogoFinanciero> getCatalogoFinanzas();

	void crearFinanzas(Equipo equipo, long id, long monto, int idTemporada);
	
	public List<CatalogoFinanciero> getCatalogoFinanzasByID(Equipo equipo);

	void createPresupuesto(Equipo equipo, long monto,long montoFinal,long montoFinalSponsor, int idTemporada);

	void updateObjetivosByIdEquipo(Equipo equipoBD, String objetivos);

}
