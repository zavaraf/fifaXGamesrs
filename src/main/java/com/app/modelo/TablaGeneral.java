package com.app.modelo;

import java.util.List;

public class TablaGeneral {
	
	private int idEquipo;
	private String img;
	private String nombreEquipo;
	private String nombreGrupo;
	private int pj;
	private int pg;
	private int pe;
	private int pp;
	private int gf;
	private int ge;
	private int dif;
	private int pts;
	private List<GolesJornadas> golesTemporada;
	public int getIdEquipo() {
		return idEquipo;
	}
	public void setIdEquipo(int idEquipo) {
		this.idEquipo = idEquipo;
	}
	public String getNombreEquipo() {
		return nombreEquipo;
	}
	public void setNombreEquipo(String nombreEquipo) {
		this.nombreEquipo = nombreEquipo;
	}
	public int getPj() {
		return pj;
	}
	public void setPj(int pj) {
		this.pj = pj;
	}
	public int getPg() {
		return pg;
	}
	public void setPg(int pg) {
		this.pg = pg;
	}
	public int getPe() {
		return pe;
	}
	public void setPe(int pe) {
		this.pe = pe;
	}
	public int getPp() {
		return pp;
	}
	public void setPp(int pp) {
		this.pp = pp;
	}
	public int getGf() {
		return gf;
	}
	public void setGf(int gf) {
		this.gf = gf;
	}
	public int getGe() {
		return ge;
	}
	public void setGe(int ge) {
		this.ge = ge;
	}
	public int getDif() {
		return dif;
	}
	public void setDif(int dif) {
		this.dif = dif;
	}
	public int getPts() {
		return pts;
	}
	public void setPts(int pts) {
		this.pts = pts;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getNombreGrupo() {
		return nombreGrupo;
	}
	public void setNombreGrupo(String nombreGrupo) {
		this.nombreGrupo = nombreGrupo;
	}
	public List<GolesJornadas> getGolesTemporada() {
		return golesTemporada;
	}
	public void setGolesTemporada(List<GolesJornadas> golesTemporada) {
		this.golesTemporada = golesTemporada;
	}
	
	

}
