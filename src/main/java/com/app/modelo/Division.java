package com.app.modelo;

public class Division {

	private String id;
	private String nombre;
	private String descripcion;
	
	
	@Override
	public String toString() {
		return "Division [id=" + id + ", nombre=" + nombre + ", descripcion=" + descripcion + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
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
	
	
}
