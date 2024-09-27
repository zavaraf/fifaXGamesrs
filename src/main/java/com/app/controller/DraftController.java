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
	
	
	@RequestMapping(value="/buscarTodos/{idTemporada}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listJugadoresPrestados(@PathVariable("idTemporada") int idTemporada){
		
		List<User> listJugadores = draftService.buscarTodos(idTemporada);
		
		if(listJugadores.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listJugadores, HttpStatus.OK);
	}
	@RequestMapping(value="/buscarTodos/{idEquipo}/{idTemporada}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<User>> listJugadoresPrestadosByIdEquipo(@PathVariable("idEquipo") long id,
			@PathVariable("idTemporada") int idTemporada){
		
		List<User> listJugadores = draftService.buscarTodosByidEquipo(id, idTemporada);
		
		if(listJugadores.isEmpty()){
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<User>>(listJugadores, HttpStatus.OK);
	}
	
	 @RequestMapping(value = "/{idEquipo}/{idTemporada}", method = RequestMethod.POST)
	    public ResponseEntity<Void> createPrestamo(@PathVariable("idEquipo") long id,
	    										@PathVariable("idTemporada") int idTemporada,
	    										@RequestBody User jugador,    
	    										UriComponentsBuilder ucBuilder) {
	  
	        draftService.crearPrestamo(jugador,id,idTemporada);
	  
	        HttpHeaders headers = new HttpHeaders();
	        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(jugador.getId()).toUri());
	        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	    }
	 
	 @RequestMapping(value = "/player/{id}/{idTemporada}", method = RequestMethod.DELETE)
	    public ResponseEntity<User> deleteUser(@PathVariable("id") long id,
	    						@PathVariable("idTemporada") int idTemporada) {
//	        //System.out.println("Fetching & Deleting User with id " + id);
	  
	        User user = userService.findById(id);
	        if (user == null) {
//	            //System.out.println("Unable to delete. User with id " + id + " not found");
	            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
	        }
	  
	        draftService.deletePresById(id,user.getEquipo().getId(),idTemporada);
	        return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
	    }
	 
	 
	 
	 
	 /*     Draft PC
	  * 
	  */
	 
	 
	 @RequestMapping(value="/pc/findAllPC/{idTemporada}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<JugadorDraft>> listJugadoresDraft(
				@PathVariable("idTemporada") int idTemporada){
			
			List<JugadorDraft> listJugadores = draftService.findJugadoresDraft(idTemporada);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		}
	 @RequestMapping(value="/pc/findAll/{idEquipo}/{idTemporada}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<JugadorDraft>> listJugadoresDrafByIdEquipo(
				@PathVariable("idEquipo") int idEquipo,
				@PathVariable("idTemporada") int idTemporada){
			
			List<JugadorDraft> listJugadores = draftService.findJugadoresDraftByIdEquipo(idEquipo, idTemporada);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		}
	 
	 @RequestMapping(value="/pc/initialDraft/{idJugador}/{monto}/{namager}/{observaciones}/{idEquipo}/{idTemporada}",
			 method = RequestMethod.POST,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<ResponseData> initialDraft(
				@PathVariable("idJugador") long id,
				@PathVariable("monto") int monto,
				@PathVariable("namager") String manager,
				@PathVariable("observaciones") String observaciones,
				@PathVariable("idEquipo") int idEquipo,
				@PathVariable("idTemporada") int idTemporada
				){
			
		 ResponseData response = new ResponseData();	
		 try{
			 
		 
			response = draftService.initialDraft(id,monto,manager,observaciones,idEquipo, idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
			
			return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
		}
	 @RequestMapping(value="/pc/updateDraft/{idJugador}/{monto}/{namager}/{observaciones}/{montoInicial}/{idEquipo}/{idTemporada}",
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
			 @PathVariable("idTemporada") int idTemporada
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 
			 response = draftService.updateDraft(id,monto,manager,observaciones,montoInicial,idEquipo,  idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/pc/confirmPlayer/{idJugador}/{idEquipo}/{idTemporada}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> confirmPlayer(
			 @PathVariable("idJugador") long id,
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("idTemporada") int idTemporada
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 response = draftService.confirmPlayer(id,idEquipo,idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 
	 @RequestMapping(value="/pc/getHistorico/{idDraft}/{idJugador}/{idTemporada}",
			 method = RequestMethod.GET,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<List<JugadorDraft>> getHistoricoDraft(
			 @PathVariable("idDraft") int idDraft,
			 @PathVariable("idJugador") int idJugador,
			 @PathVariable("idTemporada") int idTemporada
			 ){
	List<JugadorDraft> listJugadores = draftService.getHistoricoDraft(idDraft, idJugador, idTemporada);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		 
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
	 
	 @RequestMapping(value="/pc/updateDraftAdmin/{idJugador}/{monto}/{namager}/{observaciones}/{montoInicial}/{idEquipo}/{idTemporada}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> updateDraftAdmin(
			 @PathVariable("idJugador") long id,
			 @PathVariable("monto") int monto,
			 @PathVariable("namager") String manager,
			 @PathVariable("observaciones") String observaciones,
			 @PathVariable("montoInicial") int montoInicial,
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("idTemporada") int idTemporada
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 
			 response = draftService.updateDraftAdmin(id,monto,manager,observaciones,montoInicial,idEquipo,  idTemporada);
		 }catch(Exception e){
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 
	 @RequestMapping(value="/pc/getAllMov/{idTemporada}",
			 method = RequestMethod.GET,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<List<JugadorDraft>> getAllMov(
			 @PathVariable("idTemporada") int idTemporada
			 ){
	List<JugadorDraft> listJugadores = draftService.getAllMov(idTemporada);
			
			if(listJugadores.isEmpty()){
				return new ResponseEntity<List<JugadorDraft>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<JugadorDraft>>(listJugadores, HttpStatus.OK);
		 
	 }

}
