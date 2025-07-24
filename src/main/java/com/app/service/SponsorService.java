package com.app.service;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.Sponsor;

public interface SponsorService {

	List<Sponsor> buscarTodos();

	List<Sponsor> buscarAllByDivision(long id);

	Sponsor buscarSponsorByID(long id);

	void crearDatosFinancieros(long idEquipo,long idSponsor, boolean opcional);

	List<CatalogoFinanciero> getCatalogoFinanzas();

	void crearfinanzas(Equipo equipo, long id, long monto,int idTemporada);

	void createPresupuesto(Equipo equipo, long monto, int idTemporada);

	void updateObjetivosByIdEquipo(long id, String objetivos,int idTemporada);

	void createPresupuestoId(int idEquipo, long monto, int idTemporada);

}
