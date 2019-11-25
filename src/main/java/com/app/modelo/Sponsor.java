package com.app.modelo;

import java.util.List;

public class Sponsor {
	
	private int id;
	private String nombreSponsor;
	private String descripcion;
	private int contratoFijo;
	private String clase;
	private boolean sponsorSelect;
	private List<ObjetivosSponsor> objetivos;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombreSponsor() {
		return nombreSponsor;
	}
	public void setNombreSponsor(String nombreSponsor) {
		this.nombreSponsor = nombreSponsor;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getContratoFijo() {
		return contratoFijo;
	}
	public void setContratoFijo(int contratoFijo) {
		this.contratoFijo = contratoFijo;
	}
	public String getClase() {
		return clase;
	}
	public void setClase(String clase) {
		this.clase = clase;
	}
	public List<ObjetivosSponsor> getObjetivos() {
		return objetivos;
	}
	public void setObjetivos(List<ObjetivosSponsor> objetivos) {
		this.objetivos = objetivos;
	}
	public boolean getSponsorSelect() {
		return sponsorSelect;
	}
	public void setSponsorSelect(boolean sponsorSelect) {
		this.sponsorSelect = sponsorSelect;
	}
	
	
	
	

}
