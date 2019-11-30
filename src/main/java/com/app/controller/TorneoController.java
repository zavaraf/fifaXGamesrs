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

import com.app.dao.DatosFinancierosDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.Equipo;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Torneo;
import com.app.service.TorneoService;

@CrossOrigin(origins = "*",allowedHeaders = "*", methods= {RequestMethod.GET,RequestMethod.POST})
@Controller
@RequestMapping(value="/rest/torneos")
public class TorneoController {
	
	@Autowired 
	TorneoService torneosService;
	@Autowired
	DatosFinancierosDao datos;
	
	@RequestMapping(value = "/", method = RequestMethod.POST)
    public ResponseEntity<Void> createEquipo(@RequestBody Equipo equipo,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating torneo " +equipo.toString());

  
//        equipoService.crearTorneo(equipo);
  
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(equipo.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
	
	@RequestMapping(value="/buscarTorneos",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Torneo>> ListEquipos(){
		
		List<Torneo> listTorneos = torneosService.buscarTodos();
		
		if(listTorneos.isEmpty()){
			return new ResponseEntity<List<Torneo>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Torneo>>(listTorneos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getTablaGeneral/{idTorneo}/{idDivision}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<TablaGeneral>> getTablaGeneral(@PathVariable("idTorneo") int idTorneo,
			@PathVariable("idDivision") int idDivision){
		
		List<TablaGeneral> listTorneos = torneosService.getTablaGeneral(idTorneo,idDivision);
		
		if(listTorneos.isEmpty()){
			return new ResponseEntity<List<TablaGeneral>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<TablaGeneral>>(listTorneos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getJornadas/{idTorneo}/{idDivision}/{activa}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Jornadas>> getJornadas(@PathVariable("idTorneo") int idTorneo,
			@PathVariable("idDivision") int idDivision,
			@PathVariable("activa") int activa){
		
		List<Jornadas> listTorneos = torneosService.getJornadas(idTorneo,idDivision,activa);
		
		if(listTorneos.isEmpty()){
			return new ResponseEntity<List<Jornadas>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Jornadas>>(listTorneos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/lm/getJornadas/goles/{idJornada}/{id}/{idEquipoLocal}/{idEquipoVisita}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<GolesJornadas>> getGolesJornada(@PathVariable("idJornada") String idJornada,
			@PathVariable("id") String id,
			@PathVariable("idEquipoLocal") String idEquipoLocal,
			@PathVariable("idEquipoVisita") String idEquipoVisita){
		
		List<GolesJornadas> listTorneos = torneosService.getGolesJornadas(idJornada, id, idEquipoLocal, idEquipoVisita);
		
		if(listTorneos.isEmpty()){
			return new ResponseEntity<List<GolesJornadas>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<GolesJornadas>>(listTorneos, HttpStatus.OK);
	}
	@RequestMapping(value="/lm/getJornada/{idJornada}/{id}/{idEquipoLocal}/{idEquipoVisita}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Jornada> getJornada(@PathVariable("idJornada") String idJornada,
			@PathVariable("id") String id,
			@PathVariable("idEquipoLocal") String idEquipoLocal,
			@PathVariable("idEquipoVisita") String idEquipoVisita){
		
		Jornada jornada = torneosService.getJornada(idJornada, id, idEquipoLocal, idEquipoVisita);
		
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
			 response = torneosService.addGol(idJugador,idEquipo,id,idJornada);
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
			 response = torneosService.addImagen(idEquipo,id,idJornada,img);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 @RequestMapping(value="/lm/getArmarJornadasInicial/{idTorneo}/{idDivision}",method = RequestMethod.GET,
				headers="Accept=application/json")
		@ResponseBody
		public ResponseEntity<List<Jornadas>> getArmarJornadasInicial(@PathVariable("idTorneo") int idTorneo,
				@PathVariable("idDivision") int idDivision){
			
			List<Jornadas> listTorneos = torneosService.getArmarJornadasInicial(idTorneo,idDivision);
			
			if(listTorneos.isEmpty()){
				return new ResponseEntity<List<Jornadas>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<Jornadas>>(listTorneos, HttpStatus.OK);
		}

	 
	 @RequestMapping(value="/lm/addJornadas/{idTorneo}/{idDivision}",
			 method = RequestMethod.POST,
			 headers="Accept=application/json")
	 @ResponseBody
	 public ResponseEntity<ResponseData> addJornadas(
			 @PathVariable("idTorneo") int idTorneo,
			 @PathVariable("idDivision") int idDivision,
			 @RequestBody List<Jornadas> jornadas
			 ){
		 
		 ResponseData response = new ResponseData();	
		 try{
			 System.out.println( "idTorneo:"+idTorneo+" idDivision]:"+idDivision);
			 response = torneosService.addJornadas(idTorneo,idDivision,jornadas);
		 }catch(Exception e){
			 System.out.println(e.getMessage());
			 response.setStatus(CodigoResponse.ERROR_INESPERADO.getCodigo());
			 response.setMensaje(CodigoResponse.ERROR_INESPERADO.getMensaje());
			 
		 }
		 
		 return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	 }
	 
	 
}
