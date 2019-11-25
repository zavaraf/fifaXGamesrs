package com.app.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.app.modelo.Torneo;
import com.app.service.TorneoService;
import com.app.service.login.UserService;


@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class TestController {
	
	@Autowired
	UserService userService;
	@Autowired 
	TorneoService torneosService;
	
	@RequestMapping(value="/test",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>test(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
		System.out.println(map);
		
		return map;
	}
	@RequestMapping(value="/test/te",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>test1(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
		System.out.println(map);
		
		return map;
	}
	
//	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@RequestMapping(value = "/test/listTest", method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,Object> listTest() {	
		HashMap<String, Object> map = new HashMap<String,Object>();
		try{
			map.put("prueba", userService.list());
		}catch(Exception e){
			map.put("Error", e.getMessage());
		}

		return map;
	}
	
	
	@RequestMapping(value="test/buscarTorneos",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Torneo>> ListEquipos(){
		
		List<Torneo> listTorneos = torneosService.buscarTodos();
		
		if(listTorneos.isEmpty()){
			return new ResponseEntity<List<Torneo>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Torneo>>(listTorneos, HttpStatus.OK);
	}


}
