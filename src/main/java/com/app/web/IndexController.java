package com.app.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller

public class IndexController {
	
	 @RequestMapping(value="/UserManagement", method = RequestMethod.GET)
	 public ModelAndView demoAngularRequest(HttpServletRequest request,
		            HttpServletResponse response, Model model) throws Exception {
		    ModelAndView m = new ModelAndView("UserManagement");
		    return m;
	    }
	 
	 @RequestMapping(value="/Equipos", method = RequestMethod.GET)
	 public ModelAndView equiposAngularRequest(HttpServletRequest request,
		            HttpServletResponse response, Model model) throws Exception {
		    ModelAndView m = new ModelAndView("EquiposMundial");
		    return m;
	    }
	 @RequestMapping(value="/Menu", method = RequestMethod.GET)
	 public ModelAndView menuAngularRequest(HttpServletRequest request,
		            HttpServletResponse response, Model model) throws Exception {
		    ModelAndView m = new ModelAndView("Menu");
		    return m;
	    }
	 @RequestMapping(value="/Jugadores", method = RequestMethod.GET)
	 public ModelAndView jugadoresAngularRequest(HttpServletRequest request,
		            HttpServletResponse response, Model model) throws Exception {
		    ModelAndView m = new ModelAndView("Jugadores");
		    return m;
	    }
	 @RequestMapping(value="/Team", method = RequestMethod.GET)
	 public ModelAndView teamAngularRequest(HttpServletRequest request,
		            HttpServletResponse response, Model model) throws Exception {
		    ModelAndView m = new ModelAndView("ViewTeam");
		    return m;
	    }
	 @RequestMapping(value="/Draft", method = RequestMethod.GET)
	 public ModelAndView draftAngularRequest(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("Draft");
		 return m;
	 }
	 @RequestMapping(value="/DraftPC", method = RequestMethod.GET)
	 public ModelAndView draftPCAngularRequest(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("DraftPC");
		 return m;
	 }
	 @RequestMapping(value="/AdminUsuarios", method = RequestMethod.GET)
	 public ModelAndView adminUsuariosAngularRequest(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("AdminUsuarios");
		 return m;
	 }
	 @RequestMapping(value="/DemoAngular", method = RequestMethod.GET)
	 public ModelAndView demoAngular(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("demoAngular");
		 return m;
	 }
	 @RequestMapping(value="/Conceptos", method = RequestMethod.GET)
	 public ModelAndView catalogoConceptos(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("catalogoConceptos");
		 return m;
	 }
	 @RequestMapping(value="/Torneo", method = RequestMethod.GET)
	 public ModelAndView temporada(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("torneo");
		 return m;
	 }
	 @RequestMapping(value="/adminTorneo", method = RequestMethod.GET)
	 public ModelAndView adminTemporada(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("adminTorneo");
		 return m;
	 }
	 @RequestMapping(value="/castigos", method = RequestMethod.GET)
	 public ModelAndView castigos(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("castigos");
		 return m;
	 }
	 @RequestMapping(value="/salonFama", method = RequestMethod.GET)
	 public ModelAndView salonFama(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("salonFama");
		 return m;
	 }
	
}
