package com.app.modelo;

import java.util.Date;
import java.util.List;

public class Jornadas {
	
	private int idJornda;
	private int activa;
	private int cerrada;
	private int numeroJornada;
	private int tipoJornada;
	private String nombreJornada;
	private Date fechaInicio;
	private Date fechaFin;
	private String fechaInicioString;
	private String fechaFinString;
	
	
	public String getFechaInicioString() {
		return fechaInicioString;
	}

	public void setFechaInicioString(String fechaInicioString) {
		this.fechaInicioString = fechaInicioString;
	}

	public String getFechaFinString() {
		return fechaFinString;
	}

	public void setFechaFinString(String fechaFinString) {
		this.fechaFinString = fechaFinString;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}

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

	public int getCerrada() {
		return cerrada;
	}

	public void setCerrada(int cerrada) {
		this.cerrada = cerrada;
	}

	public int getTipoJornada() {
		return tipoJornada;
	}

	public void setTipoJornada(int tipoJornada) {
		this.tipoJornada = tipoJornada;
	}

	public String getNombreJornada() {
		return nombreJornada;
	}

	public void setNombreJornada(String nombreJornada) {
		this.nombreJornada = nombreJornada;
	}

	
	
	
	
	

}
