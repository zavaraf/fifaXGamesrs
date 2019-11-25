package com.app.modelo;

public class DatosFinancieros {
	
	private int id;
	private int idEquipo;
	private int idSponsor;
	private int presupuestoInicial;
	private int presupuestoFinal;
	private int presupuestoFinalSponsor;
	private boolean isOpcional;
	private Torneo torneo;
	private Sponsor sponsor;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdEquipo() {
		return idEquipo;
	}
	public void setIdEquipo(int idEquipo) {
		this.idEquipo = idEquipo;
	}
	public int getIdSponsor() {
		return idSponsor;
	}
	public void setIdSponsor(int idSponsor) {
		this.idSponsor = idSponsor;
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
	public boolean isOpcional() {
		return isOpcional;
	}
	public void setOpcional(boolean isOpcional) {
		this.isOpcional = isOpcional;
	}
	public Torneo getTorneo() {
		return torneo;
	}
	public void setTorneo(Torneo torneo) {
		this.torneo = torneo;
	}
	public Sponsor getSponsor() {
		return sponsor;
	}
	public void setSponsor(Sponsor sponsor) {
		this.sponsor = sponsor;
	}
	public int getPresupuestoFinalSponsor() {
		return presupuestoFinalSponsor;
	}
	public void setPresupuestoFinalSponsor(int presupuestoFinalSponsor) {
		this.presupuestoFinalSponsor = presupuestoFinalSponsor;
	}

	
	
}
