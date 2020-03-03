package com.app.service;

import java.util.List;

import com.app.modelo.ResponseData;
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

		ResponseData savePlayer(User user,int idTemporada);

		ResponseData updatePlayer(User currentUser,int idTemporada);

		List<User> findAllPlayersByIdEquipo(long id);
		List<User> findAllPlayersByIdEquipo(long id,long idVisita);

}
