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
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.Sponsor;
import com.app.service.SponsorService;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/sponsor")
public class SponsorController {

	@Autowired 
	SponsorService sponsorService;
	@Autowired
	DatosFinancierosDao datos;
	
	@RequestMapping(value="/buscarTodos",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Sponsor>> ListEquipos(){
		
		List<Sponsor> listEquipos = sponsorService.buscarTodos();
		
		if(listEquipos.isEmpty()){
			return new ResponseEntity<List<Sponsor>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Sponsor>>(listEquipos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/datos",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Sponsor>> getDatos(){
		
		datos.test();
		List<Sponsor> listEquipos = null;
		
		if(listEquipos.isEmpty()){
			return new ResponseEntity<List<Sponsor>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Sponsor>>(listEquipos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/division/{id}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Sponsor>> ListSponsorByDivision(@PathVariable("id") long id){
		
		List<Sponsor> listSponsor = sponsorService.buscarAllByDivision(id);
		
		if(listSponsor.isEmpty()){
			return new ResponseEntity<List<Sponsor>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Sponsor>>(listSponsor, HttpStatus.OK);
	}
	
	@RequestMapping(value="/{id}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Sponsor> ListSponsorByID(@PathVariable("id") long id){
		
		Sponsor sponsor = sponsorService.buscarSponsorByID(id);
		
		if(sponsor==null){
			return new ResponseEntity<Sponsor>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Sponsor>(sponsor, HttpStatus.OK);
	}
	@RequestMapping(value="/{id}/{opcional}/{idSponsor}",method = RequestMethod.POST,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Void> createDatosFinancieros(
													@PathVariable("id") long id,
													@PathVariable("opcional") boolean opcional,
													@PathVariable("idSponsor") long idSponsor,
													UriComponentsBuilder ucBuilder) {
        System.out.println("Creating Sponsor " +id + " spongor:"+idSponsor+ " opcional:"+opcional);
		
        sponsorService.crearDatosFinancieros(id,idSponsor,opcional);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(id).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	}
	
	@RequestMapping(value="/catalogoFinanzas",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<CatalogoFinanciero>> ListCatalogoFinanzas(){
		
		List<CatalogoFinanciero> listCatalogo = sponsorService.getCatalogoFinanzas();
		
		if(listCatalogo.isEmpty()){
			return new ResponseEntity<List<CatalogoFinanciero>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<CatalogoFinanciero>>(listCatalogo, HttpStatus.OK);
	}
	
	@RequestMapping(value="finanzas/{idCatalogo}/{monto}/{idTorneo}",method = RequestMethod.POST,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Void> createFinanzas(@RequestBody Equipo equipo,
													@PathVariable("idCatalogo") long id,
													@PathVariable("monto") long monto,
													@PathVariable("idTorneo") int idTorneo,
													UriComponentsBuilder ucBuilder) {
        System.out.println("Creating CAtalogoFinanzas " +id );
		
        sponsorService.crearfinanzas(equipo,id,monto,idTorneo);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(id).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	}
	@RequestMapping(value="finanzas/presupuesto/{monto}/{idTorneo}",method = RequestMethod.POST,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Void> createPresupuesto(@RequestBody Equipo equipo,
													@PathVariable("monto") long monto,
													@PathVariable("idTorneo") int idTorneo,
													UriComponentsBuilder ucBuilder) {
        System.out.println("Creating createPresupuesto " +monto );
		
        sponsorService.createPresupuesto(equipo,monto,idTorneo);
        
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{monto}").buildAndExpand(monto).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	}
	@RequestMapping(value="finanzas/presupuesto/objetivos/{id}/{idTorneo}",method = RequestMethod.POST,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<Void> updateObjetivosByIdEquipo(@RequestBody String objetivos,
			@PathVariable("id") long id,
			@PathVariable("idTorneo") int idTorneo,
			UriComponentsBuilder ucBuilder) {
		System.out.println("Creating updateObjetivosByIdEquipo " +id );
		System.out.println("Creating updateObjetivosByIdEquipo  objetivos]: " +objetivos );
		
		sponsorService.updateObjetivosByIdEquipo(id,objetivos,idTorneo);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(ucBuilder.path("/{monto}").buildAndExpand(id).toUri());
		return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	}
}
