package com.app.modelo;

public class Castigo {
	
	public int castigoId;
	public String castigo;
	public int numero;
	public String observaciones;
	public int idEquipo;
	public int idTemporada;
	public int idTorneo;
	public Equipo equipo;
	public Torneo torneo;
	
	
	public int getCastigoId() {
		return castigoId;
	}
	public void setCastigoId(int castigoId) {
		this.castigoId = castigoId;
	}
	public String getCastigo() {
		return castigo;
	}
	public void setCastigo(String castigo) {
		this.castigo = castigo;
	}
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public int getIdEquipo() {
		return idEquipo;
	}
	public void setIdEquipo(int idEquipo) {
		this.idEquipo = idEquipo;
	}
	public int getIdTemporada() {
		return idTemporada;
	}
	public void setIdTemporada(int idTemporada) {
		this.idTemporada = idTemporada;
	}
	public int getIdTorneo() {
		return idTorneo;
	}
	public void setIdTorneo(int idTorneo) {
		this.idTorneo = idTorneo;
	}
	public Equipo getEquipo() {
		return equipo;
	}
	public void setEquipo(Equipo equipo) {
		this.equipo = equipo;
	}
	public Torneo getTorneo() {
		return torneo;
	}
	public void setTorneo(Torneo torneo) {
		this.torneo = torneo;
	}
	
	

}
