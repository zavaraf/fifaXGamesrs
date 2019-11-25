package com.app.modelo;

import java.util.List;

public class Jornadas {
	
	private int idJornda;
	private int activa;
	private int numeroJornada;
	
	private List<Jornada> jornada;

	public int getIdJornda() {
		return idJornda;
	}

	public void setIdJornda(int idJornda) {
		this.idJornda = idJornda;
	}

	public List<Jornada> getJornada() {
		return jornada;
	}

	public void setJornada(List<Jornada> jornada) {
		this.jornada = jornada;
	}

	public int getActiva() {
		return activa;
	}

	public void setActiva(int activa) {
		this.activa = activa;
	}

	public int getNumeroJornada() {
		return numeroJornada;
	}

	public void setNumeroJornada(int numeroJornada) {
		this.numeroJornada = numeroJornada;
	}
	
	
	
	

}
