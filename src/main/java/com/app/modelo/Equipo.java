package com.app.modelo;

import java.util.List;

public class Equipo {
	
	
	private long id;
	private String nombre;
	private String manager;
	private String descripcion;
	private int totalJugadores;
	private int totalRaiting;
	private int salarios;
	private Division division;
	private List<User> jugadores;
	private List<User> bajas;
	private List<User> altas;
	private DatosFinancieros datosFinancieros;
	private Temporada temporada;
	private List<CatalogoFinanciero> finanzas;
	private int presupuestoInicial;
	private int presupuestoFinal;
	private String img;
	private String img2;
	private String linksofifa;
	
	@Override
	public String toString() {
		return "Equipo [id=" + id + ", nombre=" + nombre + ", manager=" + manager + ", descripcion=" + descripcion
				+ ", totalJugadores=" + totalJugadores + ", totalRaiting=" + totalRaiting + ", salarios=" + salarios
				+ ", Division_idDivision=" + (division != null ?  division.getId() : "null") + "]";
	}

	public Equipo() {
		super();
	}

	public Equipo(long id, String nombre,String manager ,String descripcion, int totalJugadores, int totalRaiting, int salarios) {
		this.id = id;
		this.nombre = nombre;
		this.manager = manager;
		this.descripcion = descripcion;
		this.totalJugadores = totalJugadores;
		this.totalRaiting = totalRaiting;
		this.salarios = salarios;
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getNombre() {
		return this.nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getManager() {
		return this.manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getDescripcion() {
		return this.descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getTotalJugadores() {
		return totalJugadores;
	}
	public void setTotalJugadores(int totalJugadores) {
		this.totalJugadores = totalJugadores;
	}

	public int getTotalRaiting() {
		return totalRaiting;
	}

	public void setTotalRaiting(int totalRaiting) {
		this.totalRaiting = totalRaiting;
	}

	public int getSalarios() {
		return salarios;
	}

	public void setSalarios(int salarios) {
		this.salarios = salarios;
	}

	public Division getDivision() {
		return division;
	}

	public void setDivision(Division division) {
		this.division = division;
	}

	public List<User> getJugadores() {
		return jugadores;
	}

	public void setJugadores(List<User> jugadores) {
		this.jugadores = jugadores;
	}

	public DatosFinancieros getDatosFinancieros() {
		return datosFinancieros;
	}

	public void setDatosFinancieros(DatosFinancieros datosFinancieros) {
		this.datosFinancieros = datosFinancieros;
	}

	public Temporada getTemporada() {
		return temporada;
	}

	public void setTemporada(Temporada temporada) {
		this.temporada = temporada;
	}

	public List<CatalogoFinanciero> getFinanzas() {
		return finanzas;
	}

	public void setFinanzas(List<CatalogoFinanciero> finanzas) {
		this.finanzas = finanzas;
	}

	public int getPresupuestoInicial() {
		return presupuestoInicial;
	}

	public void setPresupuestoInicial(int presupuestoInicial) {
		this.presupuestoInicial = presupuestoInicial;
	}

	public int getPresupuestoFinal() {
		return presupuestoFinal;
	}

	public void setPresupuestoFinal(int presupuestoFinal) {
		this.presupuestoFinal = presupuestoFinal;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getLinksofifa() {
		return linksofifa;
	}

	public void setLinksofifa(String linksofifa) {
		this.linksofifa = linksofifa;
	}

	public String getImg2() {
		return img2;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public List<User> getBajas() {
		return bajas;
	}

	public void setBajas(List<User> bajas) {
		this.bajas = bajas;
	}
	
	public List<User> getAltas() {
		return altas;
	}

	public void setAltas(List<User> altas) {
		this.altas = altas;
	}
	
	

}
