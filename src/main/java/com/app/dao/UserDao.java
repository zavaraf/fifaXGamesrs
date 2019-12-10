package com.app.dao;

import java.util.List;

import com.app.modelo.User;

public interface UserDao {
	
	List<User> findAllPlayers();

	void savePlayer(User player,int idTemporada);

	void updatePlayer(User currentUser,int idTemporada);

	User findById(long id);
	
	List<User> findAllPlayersByIdEquipo(long idEquipo);
	
	List<User> findAllPlayersByIdEquipo(long idEquipo, long idEquipoVisita);

}
