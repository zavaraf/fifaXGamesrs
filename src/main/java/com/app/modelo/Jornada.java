package com.app.modelo;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class Jornada {
	
	private int idJornada;
	private int id;
	private int activa;
	private int cerrada;
	private int numeroJornada;
	private String nombreJornada;
	private int tipoJornada;
	private int idEquipoLocal;
	private String nombreEquipoLocal;
	private int idEquipoVisita;
	private String nombreEquipoVisita;
	private Integer golesLocal;
	private Integer golesVisita;
	private List<GolesJornadas> golesJornada;
	private List<HashMap<String,String>> imagenes;
	private String imgLocal;
	private String imgVisita;
	private String username;
	private String date;
	private List<DatosJornadas> lesionesJornada;
	private List<DatosJornadas> tarjetasJornada;
	private List<DatosJornadas> datosActivosJornada;
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
	public int getCerrada() {
		return cerrada;
	}
	public void setCerrada(int cerrada) {
		this.cerrada = cerrada;
	}
	public String getImgLocal() {
		return imgLocal;
	}
	public void setImgLocal(String imgLocal) {
		this.imgLocal = imgLocal;
	}
	public String getImgVisita() {
		return imgVisita;
	}
	public void setImgVisita(String imgVisita) {
		this.imgVisita = imgVisita;
	}
	public String getNombreJornada() {
		return nombreJornada;
	}
	public void setNombreJornada(String nombreJornada) {
		this.nombreJornada = nombreJornada;
	}
	public int getTipoJornada() {
		return tipoJornada;
	}
	public void setTipoJornada(int tipoJornada) {
		this.tipoJornada = tipoJornada;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public List<DatosJornadas> getLesionesJornada() {
		return lesionesJornada;
	}
	public void setLesionesJornada(List<DatosJornadas> lesionesJornada) {
		this.lesionesJornada = lesionesJornada;
	}
	public List<DatosJornadas> getTarjetasJornada() {
		return tarjetasJornada;
	}
	public void setTarjetasJornada(List<DatosJornadas> tarjetasJornada) {
		this.tarjetasJornada = tarjetasJornada;
	}
	public List<DatosJornadas> getDatosActivosJornada() {
		return datosActivosJornada;
	}
	public void setDatosActivosJornada(List<DatosJornadas> datosActivosJornada) {
		this.datosActivosJornada = datosActivosJornada;
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
	
	
	
	
	
	

}
