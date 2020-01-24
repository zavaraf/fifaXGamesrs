package com.app.controller;

import java.util.ArrayList;
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

import com.app.dao.DatosFinancierosDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Equipo;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Grupos;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;
import com.app.modelo.Torneo;
import com.app.service.TemporadaService;

@CrossOrigin(origins = "*",allowedHeaders = "*", methods= {RequestMethod.GET,RequestMethod.POST})
@Controller
@RequestMapping(value="/rest/temporada")
public class TemporadaController {
	
	@Autowired 
	TemporadaService temporadaService;
	@Autowired
	DatosFinancierosDao datos;
	
	@RequestMapping(value = "/", method = RequestMethod.POST)
    public ResponseEntity<Void> createEquipo(@RequestBody Equipo equipo,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating temporada " +equipo.toString());

  
//        equipoService.crearTemporada(equipo);
  
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(equipo.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
	
	@RequestMapping(value="/buscarTemporada",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Temporada>> ListEquipos(){
		
		List<Temporada> listTemporada = temporadaService.buscarTodos();
		
		if(listTemporada.isEmpty()){
			return new ResponseEntity<List<Temporada>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Temporada>>(listTemporada, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getTablaGeneral/{idTemporada}/{idDivision}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<TablaGeneral>> getTablaGeneral(@PathVariable("idTemporada") int idTemporada,
			@PathVariable("idDivision") int idDivision){
		
		List<TablaGeneral> listTemporada = temporadaService.getTablaGeneral(idTemporada,idDivision);
		
		if(listTemporada.isEmpty()){
			return new ResponseEntity<List<TablaGeneral>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<TablaGeneral>>(listTemporada, HttpStatus.OK);
	}
	@RequestMapping(value="/lm/getTorneoGeneral/{idTemporada}/{idDivision}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Torneo> getTorneoGeneral(@PathVariable("idTemporada") int idTemporada,
			@PathVariable("idDivision") int idDivision){
		
		Torneo listTorneo = temporadaService.getTorneoGeneral(idTemporada,idDivision);
		
		if(listTorneo == null){
			return new ResponseEntity<Torneo>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Torneo>(listTorneo, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getJornadas/{idTemporada}/{idDivision}/{activa}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Jornadas>> getJornadas(@PathVariable("idTemporada") int idTemporada,
			@PathVariable("idDivision") int idDivision,
			@PathVariable("activa") int activa){
		
		List<Jornadas> listTemporada = temporadaService.getJornadas(idTemporada,idDivision,activa);
		
		if(listTemporada.isEmpty()){
			return new ResponseEntity<List<Jornadas>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Jornadas>>(listTemporada, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getJornadas/goles/{idJornada}/{id}/{idEquipoLocal}/{idEquipoVisita}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<GolesJornadas>> getGolesJornada(@PathVariable("idJornada") String idJornada,
			@PathVariable("id") String id,
			@PathVariable("idEquipoLocal") String idEquipoLocal,
			@PathVariable("idEquipoVisita") String idEquipoVisita){
		
		List<GolesJornadas> listTemporada = temporadaService.getGolesJornadas(idJornada, id, idEquipoLocal, idEquipoVisita);
		
		if(listTemporada.isEmpty()){
			return new ResponseEntity<List<GolesJornadas>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<GolesJornadas>>(listTemporada, HttpStatus.OK);
	}
	@RequestMapping(value="/lm/getJornada/{idJornada}/{id}/{idEquipoLocal}/{idEquipoVisita}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Jornada> getJornada(@PathVariable("idJornada") String idJornada,
			@PathVariable("id") String id,
			@PathVariable("idEquipoLocal") String idEquipoLocal,
			@PathVariable("idEquipoVisita") String idEquipoVisita){
		
		Jornada jornada = temporadaService.getJornada(idJornada, id, idEquipoLocal, idEquipoVisita);
		
		if(jornada == null){
			return new ResponseEntity<Jornada>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Jornada>(jornada, HttpStatus.OK);
	}
	
	 @RequestMapping(value="/lm/addGoles/{idJugador}/{idEquipo}/{id}/{idJornada}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> addGoles(
			 @PathVariable("idJugador") int idJugador,
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("id") int id,
			 @PathVariable("idJornada") int idJornada
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "jugador:"+id+" Equipo]:"+idEquipo);
			 response = temporadaService.addGol(idJugador,idEquipo,id,idJornada);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/lm/addImg/{idEquipo}/{id}/{idJornada}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> addImagen(			 
			 @PathVariable("idEquipo") int idEquipo,
			 @PathVariable("id") int id,
			 @PathVariable("idJornada") int idJornada,
			 @RequestBody String img
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "jugador:"+id+" Equipo]:"+idEquipo);
			 response = temporadaService.addImagen(idEquipo,id,idJornada,img);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/lm/getArmarJornadasInicial/{idTemporada}/{idTorneo}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<Jornadas>> getArmarJornadasInicial(@PathVariable("idTemporada") int idTemporada,
				@PathVariable("idTorneo") int idTorneo){
			
			List<Jornadas> listTemporada = temporadaService.getArmarJornadasInicial(idTemporada,idTorneo);
			
			if(listTemporada.isEmpty()){
				return new ResponseEntity<List<Jornadas>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<Jornadas>>(listTemporada, HttpStatus.OK);
		}
	 
	 @RequestMapping(value="/lm/getArmarJornadasGrupos/{idTemporada}/{idTorneo}/{numGrupos}/{confJor}/{conAle}",method = RequestMethod.POST,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<Grupos>> getArmarJornadasGrupos(
				@PathVariable("idTemporada") int idTemporada,
				@PathVariable("idTorneo") int idTorneo,
				@PathVariable("numGrupos") int numGrupos,
				 @PathVariable("confJor") int confJor,
				 @PathVariable("conAle") int conAle,
				@RequestBody List<Equipo> equipos){
			
			List<Grupos> listTemporada = temporadaService.getArmarJornadasGrupos(idTemporada,idTorneo,numGrupos,equipos,confJor,conAle);
			
			if(listTemporada.isEmpty()){
				return new ResponseEntity<List<Grupos>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<Grupos>>(listTemporada, HttpStatus.OK);
		}

	 
	 @RequestMapping(value="/lm/addJornadas/{idTemporada}/{idDivision}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> addJornadas(
			 @PathVariable("idTemporada") int idTemporada,
			 @PathVariable("idDivision") int idDivision,
			 @RequestBody List<Jornadas> jornadas
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "idTemporada:"+idTemporada+" idDivision]:"+idDivision);
			 response = temporadaService.addJornadas(idTemporada,idDivision,jornadas);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/lm/addJornadasGrupos/{idTemporada}/{nombreTorneo}/{confTor}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> addJornadasGrupos(
			 @PathVariable("idTemporada") int idTemporada,
			 @PathVariable("nombreTorneo") String nombreTorneo,
			 @PathVariable("confTor") int confTor,
			 @RequestBody String grupos
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "idTemporada:"+idTemporada+" idDivision]:"+idTemporada);
			 response = temporadaService.addJornadasGrupos(idTemporada,nombreTorneo,grupos,confTor);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/lm/getGruposTorneo/{idTemporada}/{idTorneo}",
			 method = RequestMethod.GET,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<List<Grupos>> getGruposTorneo(
			 @PathVariable("idTemporada") int idTemporada,
			 @PathVariable("idTorneo") int idTorneo
			 ){
		 
		 List<Grupos> response = new ArrayList<Grupos>();	
		 try{
			 System.out.println( "idTemporada:"+idTemporada+" idDivision]:"+idTemporada);
			 response = temporadaService.getGruposTorneo(idTemporada, idTorneo);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 
		 }
		 if(response.isEmpty()){
				return new ResponseEntity<List<Grupos>>(HttpStatus.NO_CONTENT);
			}
		 
		 return new ResponseEntity<List<Grupos>>(response, HttpStatus.OK);
	 }
	
	 
	 
}
