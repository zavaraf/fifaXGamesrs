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

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping(value="/rest/equipo")
public class EquiposController {
	@Autowired 
	EquipoService equipoService;
	
	@RequestMapping(value="/buscarTodos/{idTorneo}",method = RequestMethod.GET,
			headers="Accept=application/json")
	@ResponseBody
	public ResponseEntity<List<Equipo>> ListEquipos(@PathVariable("idTorneo") long idtorneo){
		
		List<Equipo> listEquipos = equipoService.buscarTodos(idtorneo);
		
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
	@RequestMapping(value = "/team/{id}/{idTorneo}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Equipo> getTeam(
    		@PathVariable("id") long id,
    		@PathVariable("idTorneo") int idTorneo
    		) {
        System.out.println("Fetching User with id " + id);
        Equipo equipo = equipoService.findByIdAll(id, idTorneo);
        if (equipo == null) {
            System.out.println("Equipo with id " + id + " not found");
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
    }
	@RequestMapping(value = "/team/all/{id}/{idTorneo}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Equipo> getTeamAll(@PathVariable("id") long id,
    		@PathVariable("idTorneo") int idTorneo) {
		System.out.println("Fetching User with id " + id);
		Equipo equipo = equipoService.findEquipoByIdAll(id, idTorneo);
		if (equipo == null) {
			System.out.println("Equipo with id " + id + " not found");
			return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
	}
	
	
	
    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Equipo> getEquipo(@PathVariable("id") long id) {
        System.out.println("Fetching User with id " + id);
        Equipo equipo = equipoService.findById(id);
        if (equipo == null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Equipo>(equipo, HttpStatus.OK);
    }
  
      
      
    //-------------------Create a User--------------------------------------------------------
      
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ResponseEntity<Void> createEquipo(@RequestBody Equipo equipo,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating User " +equipo.toString());
  
//        if (equipoService.isUserExist(user)) {
//            System.out.println("A User with name " + user.getUsername() + " already exist");
//            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
//        }
  
        equipoService.crearEquipo(equipo);
  
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(equipo.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Equipo> updateEquipo(@PathVariable("id") long id, @RequestBody Equipo equipo) {
        System.out.println("Updating User " + id);
          
        Equipo currentEquipo = equipoService.findById(id);
          
        if (currentEquipo==null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<Equipo>(HttpStatus.NOT_FOUND);
        }
  
        currentEquipo.setNombre(equipo.getNombre());
        currentEquipo.setDescripcion(equipo.getDescripcion());
        currentEquipo.setDivision(equipo.getDivision());
        
        
          
        equipoService.updateUser(currentEquipo);
        return new ResponseEntity<Equipo>(currentEquipo, HttpStatus.OK);
    }
  

}
