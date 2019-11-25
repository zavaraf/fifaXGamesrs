package com.app.enums;

public enum CodigoResponse {
	
	OK(0,"OK"),
	ERROR(1,"ERROR"),
	ERROR_INESPERADO(5,"ERROR INESPERADO");
	
	int codigo;
	String mensaje;
	
	
	private CodigoResponse(int codigo, String mensaje) {
		this.codigo = codigo;
		this.mensaje = mensaje;
	}
	
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
	

}
