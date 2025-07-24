package com.app.controller;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.app.modelo.login.UserForm;
import com.app.modelo.login.UserInfo;
import com.app.service.login.UserService;
import com.app.validator.SignupValidator;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;



@CrossOrigin(origins = "http://localhost:3000", allowedHeaders = "*")
@Controller
@RequestMapping("/usermanager")
public class UserManagerController {

	@Autowired
	SignupValidator signupValidator;

	@Autowired
	UserService userService;
	
	private static final Key SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);

	@RequestMapping(value = "/api/login", method = RequestMethod.POST)
	public ResponseEntity<?> login(@RequestBody UserInfo userForm) {
	    // Validar credenciales usando el username y password de UserForm
		UserInfo user = userService.authenticate(userForm.getUsername(), userForm.getPassword());
	    if (user!= null) {
	        // Generar un token JWT
	        String token = generateToken(userForm.getUsername());

	        // Devolver el token en la respuesta
	        user.setPassword("");
	        Map<String, Object> response = new HashMap<>();
	        response.put("token", token);
	        response.put("user", user);
	        return ResponseEntity.ok(response);
	    } else {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas");
	    }
	}

	// Método para generar un token JWT
	private String generateToken(String username) {
	    long expirationTime = 1000L * 60 * 60; // 1 hora en milisegundos
	    return Jwts.builder()
	            .setSubject(username) // Establece el usuario como sujeto del token
	            .setIssuedAt(new Date()) // Fecha de emisión
	            .setExpiration(new Date(System.currentTimeMillis() + expirationTime)) // Fecha de expiración
	            .signWith(SECRET_KEY, SignatureAlgorithm.HS256) // Firma con la clave secreta
	            .compact();
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView model = new ModelAndView("user/list");
		model.addObject("list", userService.list());

		return model;
	}

	@RequestMapping(value = "/listTest", method = RequestMethod.GET)
	public List listTest() {		

		return userService.list();
	}

	@RequestMapping(value = "/changePass/{username}", method = RequestMethod.GET)
	public ModelAndView changePass(@PathVariable("username") String username) {
		ModelAndView model = new ModelAndView("user/change_pass");
		model.addObject("user", userService.findUserByUsername(username));

		return model;
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("user") UserInfo user) {
		ModelAndView model = changePass(user.getUsername());
		userService.update(user.getUsername(), user.getPassword());
		model.addObject("msg", "Your password has been changed successfully!");

		return model;
	}

//	@RequestMapping(value = "/signup", method = RequestMethod.GET)
//	public ModelAndView signup() {
//		ModelAndView model = new ModelAndView("signup");
//		model.addObject("userForm", new UserForm());
//
//		return model;
//	}
	
	@RequestMapping(value="/signup", method = RequestMethod.GET)
	 public ModelAndView draftPCAngularRequest(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("signup");
		 m.addObject("userForm", new UserForm());
		 return m;
	 }

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("userForm") UserForm userForm, BindingResult result,
			RedirectAttributes redirectAttributes) {

		signupValidator.validate(userForm, result);

		if (result.hasErrors()) {
			return "/usermanager/signup";
		} else {
			userService.add(userForm.getUsername(), userForm.getPassword());
			redirectAttributes.addFlashAttribute("msg", "Your account has been created successfully!");

			return "redirect:/";
		}
	}

}
