package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.EquipoDao;
import com.app.dao.SponsorDao;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.Sponsor;
import com.app.service.SponsorService;
import com.app.utils.EquipoUtil;
@Service
public class SponsorServiceImpl implements SponsorService {
	@Autowired
	SponsorDao sponsorDao;
	@Autowired
	EquipoDao equipoDao;
	@Autowired
	EquipoUtil equipoUtil;

	public List<Sponsor> buscarTodos() {

		return sponsorDao.buscarTodos();
	}

	public List<Sponsor> buscarAllByDivision(long id) {

		return sponsorDao.buscarAllByDivision(id);
	}

	public Sponsor buscarSponsorByID(long id) {

		return sponsorDao.buscarSponsorByID(id);
	}

	public void crearDatosFinancieros(long idEquipo,long idSponsor, boolean opcional) {
		sponsorDao.crearDatosFinancieros(idEquipo,idSponsor,opcional);		
	}

	public List<CatalogoFinanciero> getCatalogoFinanzas() {
		return sponsorDao.getCatalogoFinanzas();
	}

	public void crearfinanzas(Equipo equipo, long id, long monto, int idTemporada) {
		sponsorDao.crearFinanzas(equipo,id,monto);
		
		Equipo equipoBD = new Equipo();
		
		equipoBD = equipoDao.findByIdAll(equipo.getId(),idTemporada);
		if(equipoBD.getDatosFinancieros() != null){
			createPresupuesto(equipoBD,equipoBD.getDatosFinancieros().getPresupuestoInicial(), idTemporada);
		}
		
	}

	public void createPresupuesto(Equipo equipo, long monto, int idTemporada) {

		
		Equipo equipoBD = new Equipo();
		
		equipoBD = equipoDao.findByIdAll(equipo.getId(),idTemporada);
		
		int montoFinal = equipoUtil.getPresupuestoFinal(equipoBD, (int) monto);
		int montoFinalSponsor = equipoUtil.getPresupuestoFinalSponsor(equipoBD, (int) monto);
		
		sponsorDao.createPresupuesto(equipoBD,monto,montoFinal,montoFinalSponsor,idTemporada);
		
	}

	public void updateObjetivosByIdEquipo(long id, String objetivos,int idTemporada) {
		Equipo equipoBD = new Equipo();
		
		equipoBD = equipoDao.findByIdAll(id,idTemporada);
		
		sponsorDao.updateObjetivosByIdEquipo(equipoBD,objetivos);
		
		createPresupuesto(equipoBD,equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTemporada);
		
		
		
	}

}
