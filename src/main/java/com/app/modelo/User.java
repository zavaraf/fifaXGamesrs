package com.app.modelo;

public class User {
	
	private long id;
    
	private String nombre;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String nombreCompleto;
	private String sobrenombre;
	private String fehaNacimiento;
	private int raiting;
	private int potencial;
	private String link;
	

	private int Equipos_idEquipo;
	private int activo;
	private String userManager;
	private int prestamo;
	private Equipo equipo;
	private Equipo equipoPres;
 
	
    @Override
	public String toString() {
		return  "User [id=" + id + ", nombre=" + (nombre !=null? nombre : "null")  
		+ ", apellidoPaterno=" + (apellidoPaterno !=null? apellidoPaterno : "null") 
		+ ", apellidoMaterno=" + (apellidoMaterno !=null? apellidoMaterno : "null") 
		+ ", NombreCompleto=" + (nombreCompleto !=null? nombreCompleto : "null") 
		+ ", sobrenombre=" + (sobrenombre !=null? sobrenombre : "null") 
		+ ", fehaNacimiento=" + (fehaNacimiento !=null? fehaNacimiento : "null") 
		+ ", Raiting=" + raiting + ", potencial=" + potencial +", link=" + link  
		+ ", Equipos_idEquipo=" + Equipos_idEquipo 
		+ ", activo=" + activo + ", userManager=" + (userManager !=null? userManager : "null") 
		+ ", prestamo=" + prestamo  + ", equipo=" + (equipo !=null? equipo : "null");
	}

	public User() {
		super();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidoPaterno() {
		return apellidoPaterno;
	}

	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	public String getApellidoMaterno() {
		return apellidoMaterno;
	}

	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}

	public String getNombreCompleto() {
		return this.nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getSobrenombre() {
		return sobrenombre;
	}

	public void setSobrenombre(String sobrenombre) {
		this.sobrenombre = sobrenombre;
	}

	public String getFehaNacimiento() {
		return fehaNacimiento;
	}

	public void setFehaNacimiento(String fehaNacimiento) {
		this.fehaNacimiento = fehaNacimiento;
	}

	public int getRaiting() {
		return this.raiting;
	}

	public void setRaiting(int raiting) {
		this.raiting = raiting;
	}

	public int getPotencial() {
		return potencial;
	}

	public void setPotencial(int potencial) {
		this.potencial = potencial;
	}

	public int getEquipos_idEquipo() {
		return Equipos_idEquipo;
	}

	public void setEquipos_idEquipo(int equipos_idEquipo) {
		Equipos_idEquipo = equipos_idEquipo;
	}

	public int getActivo() {
		return activo;
	}

	public void setActivo(int activo) {
		this.activo = activo;
	}

	public String getUserManager() {
		return userManager;
	}

	public void setUserManager(String userManager) {
		this.userManager = userManager;
	}

	public int getPrestamo() {
		return prestamo;
	}

	public void setPrestamo(int prestamo) {
		this.prestamo = prestamo;
	}
	

	public Equipo getEquipo() {
		return equipo;
	}

	public void setEquipo(Equipo equipo) {
		this.equipo = equipo;
	}
	

	public Equipo getEquipoPres() {
		return equipoPres;
	}

	public void setEquipoPres(Equipo equipoPres) {
		this.equipoPres = equipoPres;
	}
	

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	@Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (id ^ (id >>> 32));
        return result;
    }
 
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (!(obj instanceof User))
            return false;
        User other = (User) obj;
        if (id != other.id)
            return false;
        return true;
    }
 
}
