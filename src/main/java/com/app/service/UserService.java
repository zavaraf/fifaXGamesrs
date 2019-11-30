package com.app.service;

import java.util.List;

import com.app.modelo.User;

public interface UserService {
	
	    List<User> findAllUsers();
	    
	    User findById(long id);
	
	    User findByName(String name);
     
	    void saveUser(User user);
	     
	    void updateUser(User user);
	     
	    void deleteUserById(long id);
	     
	    void deleteAllUsers();
	     
	    public boolean isUserExist(User user);

		List<User> findAllPlayers();

		void savePlayer(User user,int idTorneo);

		void updatePlayer(User currentUser,int idTorneo);

		List<User> findAllPlayersByIdEquipo(long id);
		List<User> findAllPlayersByIdEquipo(long id,long idVisita);

}
