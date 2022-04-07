package com.app.dao;

import java.util.List;

import com.app.modelo.User;

public interface UserDao {
	
	List<User> findAllPlayers(int idTemporadad);

	void savePlayer(User player,int idTemporada);

	void updatePlayer(User currentUser,int idTemporada);

	User findById(long id);
	
	List<User> findAllPlayersByIdEquipo(long idEquipo, int idTemporada);
	
	List<User> findAllPlayersByIdEquipo(long idEquipo, long idEquipoVisita, int idTemporada);
	
	List<User> findAllBajasByIdEquipo(long idEquipo, int idTemporada);
	List<User> findAllAltasByIdEquipo(long idEquipo, int idTemporada);
	
	User findByIdAnterior(long id, int idTemporada);

}
