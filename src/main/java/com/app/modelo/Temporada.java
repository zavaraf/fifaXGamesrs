package com.app.modelo;

import java.util.List;

public class Temporada {
	
	private int id;
	private String nombre;
	private String descripcion;
	private List<Torneo> torneos;
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
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public List<Torneo> getTorneos() {
		return torneos;
	}
	public void setTorneos(List<Torneo> torneos) {
		this.torneos = torneos;
	}
	
	

}
