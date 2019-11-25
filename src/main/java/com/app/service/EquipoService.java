package com.app.service;

import java.util.List;

import com.app.modelo.Division;
import com.app.modelo.Equipo;

public interface EquipoService {
	
	List<Equipo> buscarTodos(long idtorneo);

	Equipo findById(long id);
	
	void crearEquipo(Equipo equipo);

	void updateUser(Equipo currentEquipo);

	List<Division> buscarDivision();

	Equipo findByIdAll(long id, int idTorneo);

	Equipo findEquipoByIdAll(long id,int idTorneo);

}
