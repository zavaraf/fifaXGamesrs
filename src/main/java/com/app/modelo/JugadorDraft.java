package com.app.modelo;

public class JugadorDraft extends User {
	
	private int montoOferta;
	private int ofertaFinal;
	private int idEquipoOferta;
	private String manager;
	private String observaciones;
	private String fecha;
	private String comentarios;
	private boolean abierto;
	private boolean contraofertar;
	
	private User player;
	private Equipo equipoNew;
	
	
	public int getMontoOferta() {
		return montoOferta;
	}
	public void setMontoOferta(int montoOferta) {
		this.montoOferta = montoOferta;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getComentarios() {
		return comentarios;
	}
	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}
	public boolean isAbierto() {
		return abierto;
	}
	public void setAbierto(boolean abierto) {
		this.abierto = abierto;
	}
	public int getOfertaFinal() {
		return ofertaFinal;
	}
	public void setOfertaFinal(int ofertaFinal) {
		this.ofertaFinal = ofertaFinal;
	}
	public int getIdEquipoOferta() {
		return idEquipoOferta;
	}
	public void setIdEquipoOferta(int idEquipoOferta) {
		this.idEquipoOferta = idEquipoOferta;
	}
	public boolean isContraofertar() {
		return contraofertar;
	}
	public void setContraofertar(boolean contraofertar) {
		this.contraofertar = contraofertar;
	}
	public User getPlayer() {
		return player;
	}
	public void setPlayer(User player) {
		this.player = player;
	}
	
	public Equipo getEquipoNew() {
		return equipoNew;
	}
	public void setEquipoNew(Equipo equipoNew) {
		this.equipoNew = equipoNew;
	}
	
	

}
