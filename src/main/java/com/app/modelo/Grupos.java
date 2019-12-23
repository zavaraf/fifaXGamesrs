package com.app.modelo;

import java.util.List;

public class Grupos {
	
	List<Equipo> equipos;
	int numero;
	List<Jornadas> jornadas;
	
	
	public List<Equipo> getEquipos() {
		return equipos;
	}
	public void setEquipos(List<Equipo> equipos) {
		this.equipos = equipos;
	}
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public List<Jornadas> getJornadas() {
		return jornadas;
	}
	public void setJornadas(List<Jornadas> jornadas) {
		this.jornadas = jornadas;
	}

	
}
