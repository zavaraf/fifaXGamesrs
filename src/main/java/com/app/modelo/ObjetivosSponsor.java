package com.app.modelo;

public class ObjetivosSponsor {
	
	private int id;
	private String nombre;
	private String descripcion;
	private int monto;
	private int penalizacion;
	private boolean opcional;
	private boolean cumplido;
	
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
	public int getMonto() {
		return monto;
	}
	public void setMonto(int monto) {
		this.monto = monto;
	}
	public int getPenalizacion() {
		return penalizacion;
	}
	public void setPenalizacion(int penalizacion) {
		this.penalizacion = penalizacion;
	}
	public boolean isOpcional() {
		return opcional;
	}
	public void setOpcional(boolean opcional) {
		this.opcional = opcional;
	}
	public boolean isCumplido() {
		return cumplido;
	}
	public void setCumplido(boolean cumplido) {
		this.cumplido = cumplido;
	}
	
	

}
