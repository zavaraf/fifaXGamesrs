package com.app.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.EquipoDao;
import com.app.modelo.Division;
import com.app.modelo.Equipo;
import com.app.service.EquipoService;

@Service
public class EquipoServiceImpl implements EquipoService{
	@Autowired
	EquipoDao equipoDao;

	public List<Equipo> buscarTodos(long idTemporada) {
		List<Equipo> equipos = new ArrayList<Equipo>();
		
//		equipos.add(new Equipo(1L,"B. Dormund","zavaraf","El mejor de todos",25,1600,40000));
//		equipos.add(new Equipo(2L,"Napoli","putito","Puto",25,1700,50000));
//		equipos.add(new Equipo(2L,"Man. City","DAVIES","Manchester City",25,3700,20000));
//		equipos.add(new Equipo(2L,"Man. United","TJ CARLOS","Manchester United",25,1700,45000));
//		equipos.add(new Equipo(2L,"Arsenal","PANTERA","Arsenal",25,1200,30000));
		return equipoDao.buscarTodos(idTemporada);
				
//		return equipos;
	}

	public Equipo findById(long id) {
		
		return equipoDao.findById(id);
	}

	public void crearEquipo(Equipo equipo) {
		equipoDao.createEquipo(equipo);		
	}

	public void updateUser(Equipo currentEquipo) {
		equipoDao.updateEquipo(currentEquipo);	
		
	}

	public List<Division> buscarDivision() {
		return equipoDao.buscarDivision();
	}

	public Equipo findByIdAll(long id, int idTemporada) {
		return equipoDao.findByIdAll(id, idTemporada);
	}

	public Equipo findEquipoByIdAll(long id,int idTemporada) {

		return equipoDao.findEquipoByIdAll(id, idTemporada);

	}
	
	

}
