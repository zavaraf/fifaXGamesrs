package com.app.modelo;

import java.util.List;

public class Torneo {
	
	private int id;
	private String nombre;
	private int tipoTorneo;
	private String img;
	private List<GolesJornadas> golesTorneo;
	private List<TablaGeneral> tablaGeneral;
	private List<Jornadas>  jornadas;
	private List<GolesJornadas> golesTorneoEquipo;
	private List<EventoPartido> eventos;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public int getTipoTorneo() {
		return tipoTorneo;
	}
	public void setTipoTorneo(int tipoTorneo) {
		this.tipoTorneo = tipoTorneo;
	}
	public List<GolesJornadas> getGolesTorneo() {
		return golesTorneo;
	}
	public void setGolesTorneo(List<GolesJornadas> golesTorneo) {
		this.golesTorneo = golesTorneo;
	}
	public List<TablaGeneral> getTablaGeneral() {
		return tablaGeneral;
	}
	public void setTablaGeneral(List<TablaGeneral> tablaGeneral) {
		this.tablaGeneral = tablaGeneral;
	}
	public List<Jornadas> getJornadas() {
		return jornadas;
	}
	public void setJornadas(List<Jornadas> jornadas) {
		this.jornadas = jornadas;
	}
	public List<GolesJornadas> getGolesTorneoEquipo() {
		return golesTorneoEquipo;
	}
	public void setGolesTorneoEquipo(List<GolesJornadas> golesTorneoEquipo) {
		this.golesTorneoEquipo = golesTorneoEquipo;
	}
	public List<EventoPartido> getEventos() {
		return eventos;
	}
	public void setEventos(List<EventoPartido> eventos) {
		this.eventos = eventos;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
	

}
