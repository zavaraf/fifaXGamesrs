package com.app.modelo;

import java.util.HashMap;
import java.util.List;

public class Jornada {
	
	private int idJornada;
	private int id;
	private int activa;
	private int numeroJornada;
	private int idEquipoLocal;
	private String nombreEquipoLocal;
	private int idEquipoVisita;
	private String nombreEquipoVisita;
	private Integer golesLocal;
	private Integer golesVisita;
	private List<GolesJornadas> golesJornada;
	private List<HashMap<String,String>> imagenes;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdJornada() {
		return idJornada;
	}
	public void setIdJornada(int idJornada) {
		this.idJornada = idJornada;
	}
	public int getIdEquipoLocal() {
		return idEquipoLocal;
	}
	public void setIdEquipoLocal(int idEquipoLocal) {
		this.idEquipoLocal = idEquipoLocal;
	}
	public String getNombreEquipoLocal() {
		return nombreEquipoLocal;
	}
	public void setNombreEquipoLocal(String nombreEquipoLocal) {
		this.nombreEquipoLocal = nombreEquipoLocal;
	}
	public int getIdEquipoVisita() {
		return idEquipoVisita;
	}
	public void setIdEquipoVisita(int idEquipoVisita) {
		this.idEquipoVisita = idEquipoVisita;
	}
	public String getNombreEquipoVisita() {
		return nombreEquipoVisita;
	}
	public void setNombreEquipoVisita(String nombreEquipoVisita) {
		this.nombreEquipoVisita = nombreEquipoVisita;
	}
	public Integer getGolesLocal() {
		return golesLocal;
	}
	public void setGolesLocal(Integer golesLocal) {
		this.golesLocal = golesLocal;
	}
	public Integer getGolesVisita() {
		return golesVisita;
	}
	public void setGolesVisita(Integer golesVisita) {
		this.golesVisita = golesVisita;
	}
	public List<GolesJornadas> getGolesJornada() {
		return golesJornada;
	}
	public void setGolesJornada(List<GolesJornadas> golesJornada) {
		this.golesJornada = golesJornada;
	}
	public List<HashMap<String, String>> getImagenes() {
		return imagenes;
	}
	public void setImagenes(List<HashMap<String, String>> imagenes) {
		this.imagenes = imagenes;
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
