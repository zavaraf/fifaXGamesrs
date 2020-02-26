package com.app.enums;

import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

public enum TipoTorneoEnum {

	FINAL(1,"FINAL"),
	SEMIFINAL(2,"SEMIFINAL"),
	CUARTOS_DE_FINAL(3,"CUARTOS"),
	OCTAVOS_DE_FINAL(4,"OCTAVOS");
	


	
	
	
	int tipo ;
	String descripcion;
	
	
	private TipoTorneoEnum(int tipo, String descripcion) {
		this.tipo = tipo;
		this.descripcion = descripcion;
	}


	public int getTipo() {
		return tipo;
	}


	public void setTipo(int tipo) {
		this.tipo = tipo;
	}


	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	} 
	
	
	public static TipoTorneoEnum get(int code) { 
	
		switch(code){
			case 1 :  return  FINAL;
			case 2 :  return  SEMIFINAL;
			case 3 :  return  CUARTOS_DE_FINAL;
			case 4 :  return  OCTAVOS_DE_FINAL;
		}
		
		return null;
	}

	
	
}
