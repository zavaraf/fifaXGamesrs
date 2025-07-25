package com.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

import com.app.modelo.Division;
import com.app.modelo.Equipo;
import com.app.service.EquipoService;

@CrossOrigin(origins = "http://localhost:3000", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/equipo")
public class EquiposController {
	@Autowired 
	EquipoService equipoService;
	
	@RequestMapping(value="/buscarTodos/{idTemporada}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Equipo>> ListEquipos(@PathVariable("idTemporada") long idTemporada){
		
		List<Equipo> listEquipos = equipoService.buscarTodos(idTemporada);
		
		if(listEquipos.isEmpty()){
			return new ResponseEntity<List<Equipo>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Equipo>>(listEquipos, HttpStatus.OK);
	}
	
	@RequestMapping(value="/buscarDivisiones",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Division>> ListDivisiones(){
		
		List<Division> listEquipos = equipoService.buscarDivision();
		
		if(listEquipos.isEmpty()){
			return new ResponseEntity<List<Division>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Division>>(listEquipos, HttpStatus.OK);
	}
	
//-------------------Retrieve Single User--------------------------------------------------------
	@RequestMapping(value = "/team/{id}/{idTemporada}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Equipo> getTeam(
    		@PathVariable("id") long id,
    		@PathVariable("idTemporada") int idTemporada
    		) {
        Equipo equipo = equipoService.findByIdAll(id, idTemporada);
        if (equipo == null) {
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
    }
	@RequestMapping(value = "/team/all/{id}/{idTemporada}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Equipo> getTeamAll(@PathVariable("id") long id,
    		@PathVariable("idTemporada") int idTemporada) {
		Equipo equipo = equipoService.findEquipoByIdAll(id, idTemporada);
		if (equipo == null) {
			return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
	}
	
	
	
    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Equipo> getEquipo(@PathVariable("id") long id) {
        Equipo equipo = equipoService.findById(id);
        if (equipo == null) {
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
    }
  
      
      
    //-------------------Create a User--------------------------------------------------------
      
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ResponseEntity<Void> createEquipo(@RequestBody Equipo equipo,    UriComponentsBuilder ucBuilder) {
  
//        if (equipoService.isUserExist(user)) {
//            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
//        }
  
        equipoService.crearEquipo(equipo);
  
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(equipo.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
    
    @RequestMapping(value = "/{id}/{idTemporada}", method = RequestMethod.PUT)
    public ResponseEntity<Equipo> updateEquipo(
    		@PathVariable("id") long id,
    		@PathVariable("idTemporada") int idTemporada,
    		@RequestBody Equipo equipo) {
          
        Equipo currentEquipo = equipoService.findById(id);
          
        if (currentEquipo==null) {
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
  
        currentEquipo.setNombre(equipo.getNombre());
        currentEquipo.setDescripcion(equipo.getDescripcion());
        currentEquipo.setDivision(equipo.getDivision());
        currentEquipo.setLinksofifa(equipo.getLinksofifa());
        currentEquipo.setImg(equipo.getImg());
        currentEquipo.setImg2(equipo.getImg2());
        
        
          
        equipoService.updateUser(currentEquipo,idTemporada);
        return new ResponseEntity<Equipo>(currentEquipo, HttpStatus.OK);
    }
  

}
