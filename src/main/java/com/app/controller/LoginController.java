package com.app.controller;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.app.modelo.login.UserInfo;
import com.app.service.login.UserService;
import com.app.validator.SignupValidator;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@CrossOrigin(origins = "http://localhost:3000", allowedHeaders = "*")
@Controller
@RequestMapping("/rest")
public class LoginController {
	
	
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
	
	@RequestMapping(value = "/api/test", method = RequestMethod.GET)
	public ResponseEntity<?> test() {
	    

	       
	        Map<String, Object> response = new HashMap<>();
	        response.put("data", "OK");
	        return ResponseEntity.ok(response);
	    
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

}
