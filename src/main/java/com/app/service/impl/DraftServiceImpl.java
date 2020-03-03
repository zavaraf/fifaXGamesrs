package com.app.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.app.dao.DraftDao;
import com.app.dao.EquipoDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Equipo;
import com.app.modelo.JugadorDraft;
import com.app.modelo.ResponseData;
import com.app.modelo.User;
import com.app.service.DraftService;

@Service
public class DraftServiceImpl implements DraftService {

	@Autowired
	DraftDao draftDao;
	@Autowired
	EquipoDao equipoDao;
	@Autowired
	SponsorServiceImpl sponsorService;

	public List<User> buscarTodos(int idTemporada) {
		return draftDao.buscarTodos( idTemporada);
	}

	public void crearPrestamo(User jugador, long id, int idTemporada) {
		draftDao.crearPrestamo(jugador, id,idTemporada);

	}

	public void deletePresById(long id, long idEquipo,int idTemporada) {
		draftDao.deletePresById(id, idEquipo, idTemporada);

	}

	public List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada) {

		return draftDao.buscarTodosByidEquipo(idEquipo, idTemporada);
	}

	public List<JugadorDraft> findJugadoresDraft(int idTemporada) {

		return draftDao.findJugadoresDraft(idTemporada);
	}

	public ResponseData initialDraft(long id, int monto, String manager, 
			String observaciones, int idEquipo, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.initialDraft(id, monto, manager, observaciones, idEquipo, idTemporada);

		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {
			String status = map.get("status");
			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();

				equipoBD = equipoDao.findByIdAll(idEquipo, idTemporada);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTemporada);
				}
				
				response.setData(draftDao.findJugadoresDraft(idTemporada));
			}
		}

		return response;
	}

	public ResponseData updateDraft(long id, int monto, String manager, String observaciones, int montoFinal,
			int idEquipo, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.updateDraft(id, monto, manager, observaciones, montoFinal, idEquipo,idTemporada);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();

				equipoBD = equipoDao.findByIdAll(idEquipo,idTemporada);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTemporada);
				}
				response.setData(draftDao.findJugadoresDraft(idTemporada));
			}
		}

		return response;
	}
	public ResponseData updateDraftAdmin(long id, int monto, String manager, String observaciones, int montoFinal,
			int idEquipo, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.updateDraftAdmin(id, monto, manager, observaciones, montoFinal, idEquipo,idTemporada);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();

				equipoBD = equipoDao.findByIdAll(idEquipo,idTemporada);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTemporada);
				}
				response.setData(draftDao.findJugadoresDraft(idTemporada));
			}
		}

		return response;
	}

	@Override
	public List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTemporada) {
		return draftDao.findJugadoresDraftByIdEquipo(idEquipo,  idTemporada);
	}

	@Override
	public ResponseData confirmPlayer(long id, int idEquipo, int idTemporada) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.confirmPlayer(id, idEquipo,idTemporada);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();
				
				equipoBD = equipoDao.findByIdAll(idEquipo,idTemporada);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTemporada);
				}
			}
		}
		return response;
	}
	
	public List<JugadorDraft> getHistoricoDraft(int idDraft,int idJugador, int idTemporada){

		return draftDao.getHistoricoDraft(idDraft, idJugador, idTemporada);
	}

}
