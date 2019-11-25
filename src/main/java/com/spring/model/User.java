package com.spring.model;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

public class User extends org.springframework.security.core.userdetails.User{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public String idEquipo;
	public String nombreEquipo;
	public List<String> roles;

	public User(String username, String password, 
			Collection<? extends GrantedAuthority> authorities, String idEquipo,String nombreEquipo,List<String> roles) {
		super(username, password, authorities);
		this.idEquipo = idEquipo;
		this.nombreEquipo = nombreEquipo;
		this.roles = roles;
	}

	public String getIdEquipo() {
		return idEquipo;
	}

	public void setIdEquipo(String idEquipo) {
		this.idEquipo = idEquipo;
	}

	public String getNombreEquipo() {
		return nombreEquipo;
	}

	public void setNombreEquipo(String nombreEquipo) {
		this.nombreEquipo = nombreEquipo;
	}

	public List<String> getRoles() {
		return roles;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}
	
	
	

}
