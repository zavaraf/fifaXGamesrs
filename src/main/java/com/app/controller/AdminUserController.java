package com.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.enums.CodigoResponse;
import com.app.modelo.ResponseData;
import com.app.modelo.RoleUser;
import com.app.modelo.login.UserInfo;
import com.app.service.AdminUserService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/adminUser")
public class AdminUserController {
	
	
	@Autowired
	AdminUserService userService;
	
	@RequestMapping(value="/findAllUsers",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<UserInfo>> listAllUsert(){
		
		List<UserInfo> listUser = userService.findAllUsers();
		
		if(listUser.isEmpty()){
			return new ResponseEntity<List<UserInfo>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<UserInfo>>(listUser, HttpStatus.OK);
	}
	@RequestMapping(value="/findAllRoles",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<RoleUser>> listRoles(){
		
		List<RoleUser> listRoles = userService.findAllRoles();
		
		if(listRoles.isEmpty()){
			return new ResponseEntity<List<RoleUser>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<RoleUser>>(listRoles, HttpStatus.OK);
	}
	
	
	@Secured("ROLE_Admin")
	@RequestMapping(value="/updateUserAdmin",method = {RequestMethod.POST,RequestMethod.GET},
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<ResponseData> updateUserAdmin(
			@RequestParam("idUsuario") String usuario,
			@RequestParam("idEquipo") String idEquipo,
			@RequestBody String roles){
		
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println("---->User]:authentication.name");
			 response = userService.updateUserAdmin(usuario,idEquipo,roles);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}

}
