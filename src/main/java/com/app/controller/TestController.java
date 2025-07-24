package com.app.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.app.modelo.Temporada;
import com.app.service.TemporadaService;
import com.app.service.login.UserService;
import com.app.utils.ApplicationConfig;
import com.mysql.jdbc.Connection;



@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class TestController {
	
	@Autowired
	UserService userService;
	@Autowired 
	TemporadaService temporadaService;
	
	@RequestMapping(value="/test",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>test(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
//		//System.out.println(map);
		
		return map;
	}
	@RequestMapping(value="/test/te",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>test1(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
//		//System.out.println(map);
		
		ApplicationConfig ap = new ApplicationConfig();
//		
		Connection con = ap.getRemoteConnection();
		
//		//System.out.println("HOla");
		
		DataSource data = ap.dataSource1();
		
		JdbcTemplate jdbcTemplate  = ap.jdbcTemplate(data);
		
		String user  = ap.findUserInfo("zavaraf", jdbcTemplate);
		
//		//System.out.println("user");
		
		map.put("2", user);
		return map;
	}
	
	@RequestMapping(value="/test/tes",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public HashMap<String,String>tests1(){
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("1", "OK");
		
//		//System.out.println(map);
		
		ApplicationConfig ap = new ApplicationConfig();
//		
		Connection conn = null;
		
//		//System.out.println("HOla");
		String  results = "";
		
		  try {
			  
			  conn = ap.getRemoteConnection();
			    
			    
			    Statement  readStatement = conn.createStatement();
			    ResultSet  resultSet = readStatement.executeQuery("SELECT username FROM usuarios;");

			    while(resultSet.next()){
			    	
			    	results += ", " + resultSet.getString("username");
			    }
//			    resultSet.first();
//			    results = resultSet.getString("username");
//			    resultSet.next();
			    
			    resultSet.close();
			    readStatement.close();
			    conn.close();

			  } catch (SQLException ex) {
			    // Handle any errors
//			    //System.out.println("SQLException: " + ex.getMessage());
//			    //System.out.println("SQLState: " + ex.getSQLState());
//			    //System.out.println("VendorError: " + ex.getErrorCode());
			  }
		
		if(conn != null )
			map.put("2", results);
		
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
	
	
	@RequestMapping(value="test/buscarTemporada",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Temporada>> ListEquipos(){
		
		List<Temporada> listTemporada = temporadaService.buscarTodos();
		
		if(listTemporada.isEmpty()){
			return new ResponseEntity<List<Temporada>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Temporada>>(listTemporada, HttpStatus.OK);
	}


}
