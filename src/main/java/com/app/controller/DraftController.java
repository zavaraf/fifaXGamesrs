package com.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

import com.app.enums.CodigoResponse;
import com.app.modelo.JugadorDraft;
import com.app.modelo.ResponseData;
import com.app.modelo.User;
import com.app.service.DraftService;
import com.app.service.UserService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/draft")
public class DraftController {
	
	@Autowired
	DraftService draftService;
	@Autowired 
	UserService userService;
	
	
	@RequestMapping(value="/buscarTodos/{idTorneo}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listJugadoresPrestados(@PathVariable("idTorneo") int idTorneo){
		
		List<User> listJugadores = draftService.buscarTodos(idTorneo);
		
		if(listJugadores.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listJugadores, HttpStatus.OK);
	}
	@RequestMapping(value="/buscarTodos/{idEquipo}/{idTorneo}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listJugadoresPrestadosByIdEquipo(@PathVariable("idEquipo") long id,
			@PathVariable("idTorneo") int idTorneo){
		
		List<User> listJugadores = draftService.buscarTodosByidEquipo(id, idTorneo);
		
		if(listJugadores.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listJugadores, HttpStatus.OK);
	}
	
	 @RequestMapping(value = "/{idEquipo}/{idTorneo}", method = RequestMethod.POST)
	    public ResponseEntity<Void> createPrestamo(@PathVariable("idEquipo") long id,
	    										@PathVariable("idTorneo") int idTorneo,
	    										@RequestBody User jugador,    
	    										UriComponentsBuilder ucBuilder) {
	        System.out.println("Creating Prestamo " +jugador.toString());
	        System.out.println("Creating Prestamo Equpo]: " +id);
	        System.out.println("Creating Prestamo IDTorneo]: " +idTorneo);
	  
	        draftService.crearPrestamo(jugador,id,idTorneo);
	  
	        HttpHeaders headers = new HttpHeaders();
	        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(jugador.getId()).toUri());
	        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	    }
	 
	 @RequestMapping(value = "/player/{id}", method = RequestMethod.DELETE)
	    public ResponseEntity<User> deleteUser(@PathVariable("id") long id) {
	        System.out.println("Fetching & Deleting User with id " + id);
	  
	        User user = userService.findById(id);
	        if (user == null) {
	            System.out.println("Unable to delete. User with id " + id + " not found");
	            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
	        }
	  
	        draftService.deletePresById(id,user.getEquipo().getId());
	        return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
	    }
	 
	 
	 
	 
	 /*     Draft PC
	  * 
	  */
	 
	 
	 @RequestMapping(value="/pc/findAllPC/{idTorneo}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<JugadorDraft>> listJugadoresDraft(
				@PathVariable("idTorneo") int idTorneo){
			
			List<JugadorDraft> listJugadores = draftService.findJugadoresDraft(idTorneo);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		}
	 @RequestMapping(value="/pc/findAll/{idEquipo}/{idTorneo}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<JugadorDraft>> listJugadoresDrafByIdEquipo(
				@PathVariable("idEquipo") int idEquipo,
				@PathVariable("idTorneo") int idTorneo){
			
			List<JugadorDraft> listJugadores = draftService.findJugadoresDraftByIdEquipo(idEquipo, idTorneo);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		}
	 
	 @RequestMapping(value="/pc/initialDraft/{idJugador}/{monto}/{namager}/{observaciones}/{idEquipo}/{idTorneo}",
			 method = RequestMethod.POST,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<ResponseData> initialDraft(
				@PathVariable("idJugador") long id,
				@PathVariable("monto") int monto,
				@PathVariable("namager") String manager,
				@PathVariable("observaciones") String observaciones,
				@PathVariable("idEquipo") int idEquipo,
				@PathVariable("idTorneo") int idTorneo
				){
			
		 ResponseData response = new ResponseData();	
		 try{
			 
//			 System.out.println(request.getUserPrincipal().getName());
		 
			response = draftService.initialDraft(id,monto,manager,observaciones,idEquipo, idTorneo);
		 }catch(Exception e){
			 System.out.println("Error]:"+e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
			
			return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
		}
	 @RequestMapping(value="/pc/updateDraft/{idJugador}/{monto}/{namager}/{observaciones}/{montoInicial}/{idEquipo}/{idTorneo}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> updateDraft(
			 @PathVariable("idJugador") long id,
			 @PathVariable("monto") int monto,
			 @PathVariable("namager") String manager,
			 @PathVariable("observaciones") String observaciones,
			 @PathVariable("montoInicial") int montoInicial,
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("idTorneo") int idTorneo
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 
			 response = draftService.updateDraft(id,monto,manager,observaciones,montoInicial,idEquipo,  idTorneo);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/pc/confirmPlayer/{idJugador}/{idEquipo}/{idTorneo}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> confirmPlayer(
			 @PathVariable("idJugador") long id,
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("idTorneo") int idTorneo
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "jugador:"+id+" Equipo]:"+idEquipo);
			 response = draftService.confirmPlayer(id,idEquipo,idTorneo);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 
	 
	 
	 @RequestMapping(value="/test",method = RequestMethod.GET,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> testData(){
		 
		 List<User> listJugadores = draftService.buscarTodosByidEquipo(2,1);
		 ResponseData response = new ResponseData();
		 
		 if(listJugadores.isEmpty()){
//				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			 response.setStatus(1);
			 response.setMensaje("Error");
			 response.setData(null);
		 }
		 response.setStatus(1);
		 response.setMensaje("Error");
		 response.setData(listJugadores);
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }

}
