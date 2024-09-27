package com.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.enums.CodigoResponse;
import com.app.modelo.Castigo;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.JugadoresCSV;
import com.app.modelo.ResponseData;
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
	
	@RequestMapping(value="/updateCatalogos/{nombre}/{descripcion}/{tipo}",method = {RequestMethod.POST,RequestMethod.GET},
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<ResponseData> updateUserAdmin(
			@PathVariable("nombre") String nombre,
			@PathVariable("descripcion") String description,
			@PathVariable("tipo") int tipo){
		
		 ResponseData response = new ResponseData();	
		 try{
			
			 response = catalogService.updateCatalogos(nombre, description, tipo);
		 }catch(Exception e){
			
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/findAllCastigos/{idTemporada}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Castigo>> listAllCastigos(@PathVariable("idTemporada") int idTemporada){
		
		List<Castigo> listCatalogs = catalogService.listAllCastigos(idTemporada);
		
		if(listCatalogs.isEmpty()){
			return new ResponseEntity<List<Castigo>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Castigo>>(listCatalogs, HttpStatus.OK);
	}
	
	@RequestMapping(value="/updateCastigo/{idTemporada}",method = {RequestMethod.POST,RequestMethod.GET},
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<ResponseData> updateCastigo(
			@PathVariable("idTemporada") int idTemporada,
			@RequestBody Castigo castigo){
		
		 ResponseData response = new ResponseData();	
		 try{
			 
			 response = catalogService.updateCastigo(castigo, idTemporada);
		 }catch(Exception e){
			 
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/confirmarJugadores/{idTemporada}",method = {RequestMethod.POST},
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<ResponseData> confirmarJugadores(
			@PathVariable("idTemporada") int idTemporada,
			@RequestBody List<JugadoresCSV> jugadores){
		
		 ResponseData response = new ResponseData();	
		 try{
			 response = catalogService.confirmarJugadoresString(jugadores, idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value="/confirmarJugadoresTemp",method = {RequestMethod.POST},
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<ResponseData> confirmarJugadoresTemp(
			@RequestParam("idTemporada") int idTemporada,
			@RequestBody List<JugadoresCSV> jugadores){
		
		 ResponseData response = new ResponseData();	
		 try{
			 response = catalogService.confirmarJugadoresString(jugadores, idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
}
