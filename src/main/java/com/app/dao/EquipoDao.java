package com.app.dao;

import java.util.List;

import com.app.modelo.Division;
import com.app.modelo.Equipo;

public interface EquipoDao {
	
	Equipo findById(long id);
	List<Equipo> buscarTodos(long idtorneo);
	void createEquipo(Equipo equipo);
	void updateEquipo(Equipo currentEquipo);
	List<Division> buscarDivision();
	Equipo findByIdAll(long id, int idTorneo);
	Equipo findEquipoByIdAll(long id, int idTorneo);
	List<Equipo> findEquiposByDivision(int idTorneo,int idDivision) ;
	

}
