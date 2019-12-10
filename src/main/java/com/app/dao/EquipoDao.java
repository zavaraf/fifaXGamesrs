package com.app.dao;

import java.util.List;

import com.app.modelo.Division;
import com.app.modelo.Equipo;

public interface EquipoDao {
	
	Equipo findById(long id);
	List<Equipo> buscarTodos(long idTemporada);
	void createEquipo(Equipo equipo);
	void updateEquipo(Equipo currentEquipo);
	List<Division> buscarDivision();
	Equipo findByIdAll(long id, int idTemporada);
	Equipo findEquipoByIdAll(long id, int idTemporada);
	List<Equipo> findEquiposByDivision(int idTemporada,int idDivision) ;
	List<Equipo> findEquiposByTorneo(int idTemporada,int idT) ;
	

}
