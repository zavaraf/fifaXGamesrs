package com.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.modelo.CatalogoFinanciero;
import com.app.service.CatalogoService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/catalogs")
public class CatalogosController {

	@Autowired
	CatalogoService catalogService;
	
	@RequestMapping(value="/findAllCatalogs",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<CatalogoFinanciero>> listAllCatalogs(){
		
		List<CatalogoFinanciero> listCatalogs = catalogService.listAllCatalogs();
		
		if(listCatalogs.isEmpty()){
			return new ResponseEntity<List<CatalogoFinanciero>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<CatalogoFinanciero>>(listCatalogs, HttpStatus.OK);
	}
}
