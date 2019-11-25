package com.app.modelo.login;

import java.util.List;

import com.app.modelo.RoleUser;

public class UserInfo {
	 private String username;
	 private String password;
	 private String email;
	 private String idEquipo;
	 private String nombreEquipo;
	 private String rolesDes;
	 private List<RoleUser> roles;
	 private List<String> rols;
	 
	 public UserInfo() {
		  super();
		 }
	 
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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

	public String getRolesDes() {
		return rolesDes;
	}

	public void setRolesDes(String rolesDes) {
		this.rolesDes = rolesDes;
	}

	public List<RoleUser> getRoles() {
		return roles;
	}

	public void setRoles(List<RoleUser> roles) {
		this.roles = roles;
	}

	public List<String> getRols() {
		return rols;
	}

	public void setRols(List<String> rols) {
		this.rols = rols;
	}
	
	
	 
	 

}
