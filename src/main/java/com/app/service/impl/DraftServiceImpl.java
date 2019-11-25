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

	public List<User> buscarTodos(int idTorneo) {
		return draftDao.buscarTodos( idTorneo);
	}

	public void crearPrestamo(User jugador, long id, int idTorneo) {
		draftDao.crearPrestamo(jugador, id,idTorneo);

	}

	public void deletePresById(long id, long idEquipo) {
		draftDao.deletePresById(id, idEquipo);

	}

	public List<User> buscarTodosByidEquipo(long idEquipo,int idTorneo) {

		return draftDao.buscarTodosByidEquipo(idEquipo, idTorneo);
	}

	public List<JugadorDraft> findJugadoresDraft(int idTorneo) {

		return draftDao.findJugadoresDraft(idTorneo);
	}

	public ResponseData initialDraft(long id, int monto, String manager, 
			String observaciones, int idEquipo, int idTorneo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.initialDraft(id, monto, manager, observaciones, idEquipo, idTorneo);

		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {
			String status = map.get("status");
			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();

				equipoBD = equipoDao.findByIdAll(idEquipo, idTorneo);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTorneo);
				}
			}
		}

		return response;
	}

	public ResponseData updateDraft(long id, int monto, String manager, String observaciones, int montoFinal,
			int idEquipo, int idTorneo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.updateDraft(id, monto, manager, observaciones, montoFinal, idEquipo,idTorneo);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();

				equipoBD = equipoDao.findByIdAll(idEquipo,idTorneo);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTorneo);
				}
			}
		}

		return response;
	}

	@Override
	public List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTorneo) {
		return draftDao.findJugadoresDraftByIdEquipo(idEquipo,  idTorneo);
	}

	@Override
	public ResponseData confirmPlayer(long id, int idEquipo, int idTorneo) {
		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();

		map = draftDao.confirmPlayer(id, idEquipo,idTorneo);
		
		

		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {

			String status = map.get("status");

			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
			if(status.equals("0")){
				Equipo equipoBD = new Equipo();
				
				equipoBD = equipoDao.findByIdAll(idEquipo,idTorneo);
				if (equipoBD.getDatosFinancieros() != null) {
					
					sponsorService.createPresupuesto(equipoBD, equipoBD.getDatosFinancieros().getPresupuestoInicial(),idTorneo);
				}
			}
		}
		return response;
	}

}
