package com.app.modelo;

import java.util.List;

public class EventoPartido {
	
	int idEvento;
	Equipo equipo;
	int tipoEvento;
	String fecha;
	int jornada;
	int tipo;
	int activa;
	String nombreTorneo;
	String sobrenombre;
	
	
	
	public String getSobrenombre() {
		return sobrenombre;
	}
	public void setSobrenombre(String sobrenombre) {
		this.sobrenombre = sobrenombre;
	}
	public int getIdEvento() {
		return idEvento;
	}
	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}
	public Equipo getEquipo() {
		return equipo;
	}
	public void setEquipo(Equipo equipo) {
		this.equipo = equipo;
	}
	public int getTipoEvento() {
		return tipoEvento;
	}
	public void setTipoEvento(int tipoEvento) {
		this.tipoEvento = tipoEvento;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public int getJornada() {
		return jornada;
	}
	public void setJornada(int jornada) {
		this.jornada = jornada;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	public int getActiva() {
		return activa;
	}
	public void setActiva(int activa) {
		this.activa = activa;
	}
	public String getNombreTorneo() {
		return nombreTorneo;
	}
	public void setNombreTorneo(String nombreTorneo) {
		this.nombreTorneo = nombreTorneo;
	}
	
	
	
	
	
}
