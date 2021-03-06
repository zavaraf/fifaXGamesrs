package com.app.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.UserDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.ResponseData;
import com.app.modelo.User;
import com.app.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;
	
	private static final AtomicLong counter = new AtomicLong();
    
    private static List<User> users;
     
    static{
        users= populateDummyUsers();
    }

	public List<User> findAllUsers() {
		
		return users;
	}
	
	 public User findById(long id) {
		 User user = userDao.findById(id);
	        
            if(user!= null && user.getId() == id){
                return user;        
	        }
	        return null;
	    }
	     
	    public User findByName(String name) {
	        for(User user : users){
	            if(user.getNombre().equalsIgnoreCase(name)){
	                return user;
	            }
	        }
	        return null;
	    }
	     
	    public void saveUser(User user,int idTemporada) {
	        user.setId(counter.incrementAndGet());
	        users.add(user);
	    }
	 
	    public void updateUser(User user) {
	        int index = users.indexOf(user);
	        users.set(index, user);
	    }
	 
	    public void deleteUserById(long id) {
	         
	        for (Iterator<User> iterator = users.iterator(); iterator.hasNext(); ) {
	            User user = iterator.next();
	            if (user.getId() == id) {
	                iterator.remove();
	            }
	        }
	    }
	 
	    public boolean isUserExist(User user) {
	        return findByName(user.getNombre())!=null;
	    }
	     
	    public void deleteAllUsers(){
	        users.clear();
	    }
	    
	    private static List<User> populateDummyUsers(){
	        List<User> users = new ArrayList<User>();
//	        users.add(new User(1L,"Sam", "NY", "sam@abc.com"));
//	        users.add(new User(2L,"Tomy", "ALBAMA", "tomy@abc.com"));
//	        users.add(new User(3L,"Kelly", "NEBRASKA", "kelly@abc.com"));
	        return users;
	    }

		public List<User> findAllPlayers(int idTemporada) {
			return userDao.findAllPlayers(idTemporada);
		}

		public ResponseData savePlayer(User user,int idTemporada) {
			userDao.savePlayer(user,idTemporada);
			
			ResponseData response = new ResponseData();
			response.setStatus(CodigoResponse.OK.getCodigo());
			response.setMensaje(CodigoResponse.OK.getMensaje());
			response.setData(userDao.findAllPlayers(idTemporada));
			
			return response;
		}

		public ResponseData updatePlayer(User currentUser,int idTemporada) {
			userDao.updatePlayer(currentUser,idTemporada);
			
			ResponseData response = new ResponseData();
			
			response.setStatus(CodigoResponse.OK.getCodigo());
			response.setMensaje(CodigoResponse.OK.getMensaje());
			response.setData(userDao.findAllPlayers(idTemporada));
			
			return response;
					
					
		}

		public List<User> findAllPlayersByIdEquipo(long id,int idTemporada) {
			return userDao.findAllPlayersByIdEquipo(id,idTemporada);
		}
		
		public List<User> findAllPlayersByIdEquipo(long id, long idVisita, int idTemporada) {
			return userDao.findAllPlayersByIdEquipo(id, idVisita,idTemporada);
		}

		@Override
		public void saveUser(User user) {
			// TODO Auto-generated method stub
			
		}

		

}
