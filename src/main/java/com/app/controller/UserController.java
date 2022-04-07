package com.app.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

import com.app.modelo.ResponseData;
import com.app.modelo.User;
import com.app.service.UserService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/user/findAllUser",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listAllUsert(){
		
		List<User> listUser = userService.findAllUsers();
		
		if(listUser.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listUser, HttpStatus.OK);
	}
	@RequestMapping(value="/user/findAllPlayers/{idTemporada}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listAllPlayers(@PathVariable("idTemporada") int idTemporada){
		
		List<User> listPlayes = userService.findAllPlayers(idTemporada);
		
		if(listPlayes.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listPlayes, HttpStatus.OK);
	}
	
	@RequestMapping(value="/user/test",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>test(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
		return map;
	}
	
	//-------------------Retrieve Single User--------------------------------------------------------
    
    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> getUser(@PathVariable("id") long id) {
        System.out.println("Fetching User with id " + id);
        User user = userService.findById(id);
        if (user == null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<User>(user, HttpStatus.OK);
    }
  

	@RequestMapping(value = "/user/player/{idEquipo}/{idTemporada}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<User>> getPlayersByIdEquipo(@PathVariable("idEquipo") long id,
			@PathVariable("idTemporada") int idTemporada) {
		System.out.println("Fetching Players by idEquipo " + id+" idtemporada]:"+idTemporada);
		List<User> players = userService.findAllPlayersByIdEquipo(id,idTemporada);
		if (players.isEmpty()) {
			System.out.println("Equipo with id " + id + " not found Players");
			return new ResponseEntity<List<User>>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<List<User>>(players, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/user/player/{idEquipo}/{idEquipoVisita}/{idTemporada}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<User>> getPlayersByIdEquipo(@PathVariable("idEquipo") long id,
			@PathVariable("idEquipoVisita") long idVisita,
			@PathVariable("idTemporada") int idTemporada) {
		System.out.println("Fetching Players by idEquipo " + id + " Visita]:"+idVisita+" temporada]:"+idTemporada);
		List<User> players = userService.findAllPlayersByIdEquipo(id,idVisita, idTemporada);
		if (players.isEmpty()) {
			System.out.println("Equipo with id " + id + " not found Players");
			return new ResponseEntity<List<User>>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<List<User>>(players, HttpStatus.OK);
	}
	
      
      
    //-------------------Create a User--------------------------------------------------------
      
    @RequestMapping(value = "/user/", method = RequestMethod.POST)
    public ResponseEntity<Void> createUser(@RequestBody User user,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating User " + user.getNombre());
  
        if (userService.isUserExist(user)) {
            System.out.println("A User with name " + user.getNombre() + " already exist");
            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
        }
  
        userService.saveUser(user);
  
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
    @RequestMapping(value = "/user/player/{idTemporada}", method = RequestMethod.POST)
    public ResponseEntity<ResponseData> createPlayer(@PathVariable int idTemporada,@RequestBody User user,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating User " + user.getNombre());
  
        if (userService.isUserExist(user)) {
            System.out.println("A User with name " + user.getNombre() + " already exist");
            return new ResponseEntity<ResponseData>(HttpStatus.CONFLICT);
        }
  
        ResponseData response = new ResponseData();
        
        
        response = userService.savePlayer(user,idTemporada); 
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
        return new ResponseEntity<ResponseData>(response, HttpStatus.CREATED);
    }
  
     
      
    //------------------- Update a User --------------------------------------------------------
      
    @RequestMapping(value = "/user/{id}", method = RequestMethod.PUT)
    public ResponseEntity<User> updateUser(@PathVariable("id") long id, @RequestBody User user) {
        System.out.println("Updating User " + id);
          
        User currentUser = userService.findById(id);
          
        if (currentUser==null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
  
        currentUser.setNombre(user.getNombre());
        currentUser.setApellidoPaterno(user.getApellidoPaterno());
        currentUser.setApellidoMaterno(user.getApellidoMaterno());
        currentUser.setLink(user.getLink());
          
        userService.updateUser(currentUser);
        return new ResponseEntity<User>(currentUser, HttpStatus.OK);
    }
    @RequestMapping(value = "/user/playerUpdate/{id}/{idTemporada}", method = RequestMethod.POST)
    public ResponseEntity<ResponseData> updatePlayer(@PathVariable("id") long id,@PathVariable("idTemporada") int idTemporada, @RequestBody User user) {
        System.out.println("Updating User " + id);
          
        User currentUser = userService.findById(id);
          
        if (currentUser==null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<ResponseData>(HttpStatus.NOT_FOUND);
        }
  
        currentUser.setNombreCompleto(user.getNombreCompleto());
        currentUser.setSobrenombre(user.getSobrenombre());
        currentUser.setRaiting(user.getRaiting());
        currentUser.setEquipo(user.getEquipo());
        currentUser.setLink(user.getLink());
        currentUser.setIdsofifa(user.getIdsofifa());
        currentUser.setImg(user.getImg());
        currentUser.setEquipoPago(user.getEquipoPago());
        currentUser.setCosto(user.getCosto());
        
        
        ResponseData response = userService.updatePlayer(currentUser,idTemporada);
        
        return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
    }
  
     
     
    //------------------- Delete a User --------------------------------------------------------
      
    @RequestMapping(value = "/user/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<User> deleteUser(@PathVariable("id") long id) {
        System.out.println("Fetching & Deleting User with id " + id);
  
        User user = userService.findById(id);
        if (user == null) {
            System.out.println("Unable to delete. User with id " + id + " not found");
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
  
        userService.deleteUserById(id);
        return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
    }
  
      
     
    //------------------- Delete All Users --------------------------------------------------------
      
    @RequestMapping(value = "/user/", method = RequestMethod.DELETE)
    public ResponseEntity<User> deleteAllUsers() {
        System.out.println("Deleting All Users");
  
        userService.deleteAllUsers();
        return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
    }
	

}
