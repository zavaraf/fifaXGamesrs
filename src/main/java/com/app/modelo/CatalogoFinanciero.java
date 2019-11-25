package com.app.modelo;

public class CatalogoFinanciero {
	
	private int id;
	private String codigo;
	private String descripcion;
	private TipoConcepto tipoconcepto;
	private int monto;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public TipoConcepto getTipoconcepto() {
		return tipoconcepto;
	}
	public void setTipoconcepto(TipoConcepto tipoconcepto) {
		this.tipoconcepto = tipoconcepto;
	}
	public int getMonto() {
		return monto;
	}
	public void setMonto(int monto) {
		this.monto = monto;
	}
	
	

}
