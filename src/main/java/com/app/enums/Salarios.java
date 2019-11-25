package com.app.enums;

public enum Salarios {

	SALARIO_PRIMERA  (1,"Salario Primera",2.42f),
	SALARIO_SEGUNDA  (1,"Salario Primera",2.38f);

	
	private int id;
	private String des;
	private float pago;	
	
	
	private Salarios(int id, String des, float pago) {
		this.id = id;
		this.des = des;
		this.pago = pago;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public float getPago() {
		return pago;
	}
	public void setPago(float pago) {
		this.pago = pago;
	}
	
	
}
