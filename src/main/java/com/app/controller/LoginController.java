package com.app.controller;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

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

	@RequestMapping(value = "/api/login/validate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> validateLogin(@RequestBody Map<String, String> request) {
		String username = request.get("username");
		String password = request.get("password");
		String sessionid = request.get("sessionid");
		String phone = request.get("phone");
		System.out.println("[validateLogin] request recibido. username=" + username + ", sessionid=" + sessionid + ", phone=" + phone);

		UserInfo user = authenticateUser(username, password);
		if (user == null) {
			System.out.println("[validateLogin] autenticacion fallida para username=" + username);
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas");
		}
		System.out.println("[validateLogin] autenticacion correcta para username=" + username);

		if (phone == null || phone.isEmpty()) {
			System.out.println("[validateLogin] no se recibió phone en el request. username=" + username);
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El teléfono es requerido");
		}

		String token = generateToken(username);
		System.out.println("[validateLogin] token generado para username=" + username);

		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> externalRequest = new HashMap<>();
		externalRequest.put("session_id", sessionid);
		externalRequest.put("phone", phone);
		externalRequest.put("liga_token", token);
		externalRequest.put("liga_user_id", username);
		externalRequest.put("liga_username", username);
		externalRequest.put("liga_team_id", user.getIdEquipo());

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(externalRequest, headers);

		String externalUrl = "https://fc-tracker-pro-production.up.railway.app/api/auth/callback";
		ResponseEntity<String> externalResponse;
		System.out.println("[validateLogin] enviando callback externo a " + externalUrl);
		System.out.println("[validateLogin] payload json:\n" + toJsonPayload(externalRequest));
		try {
			externalResponse = restTemplate.postForEntity(externalUrl, entity, String.class);
		} catch (Exception e) {
			System.out.println("[validateLogin] error en callback externo: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
				.body("Error al conectar con el servicio externo: " + e.getMessage());
		}

		System.out.println("[validateLogin] respuesta externa status=" + externalResponse.getStatusCode() + ", body=" + externalResponse.getBody());
		
		if (externalResponse.getStatusCode() == HttpStatus.OK) {
			return ResponseEntity.ok()
				.contentType(MediaType.TEXT_HTML)
				.body(externalResponse.getBody());
		}
		return ResponseEntity.status(externalResponse.getStatusCode()).body(externalResponse.getBody());
	}

	@RequestMapping(value = "/api/login", method = RequestMethod.POST)
	public ResponseEntity<?> login(@RequestBody UserInfo userForm) {
		System.out.println("[login] request recibido. username=" + userForm.getUsername());
	    // Validar credenciales usando el username y password de UserForm
		UserInfo user = authenticateUser(userForm.getUsername(), userForm.getPassword());
	    if (user!= null) {
	        System.out.println("[login] autenticacion correcta para username=" + userForm.getUsername());
	        // Generar un token JWT
	        String token = generateToken(userForm.getUsername());

	        // Devolver el token en la respuesta
	        user.setPassword("");
	        Map<String, Object> response = new HashMap<>();
	        response.put("token", token);
	        response.put("user", user);
	        System.out.println("[login] respuesta generada para username=" + userForm.getUsername());
	        return ResponseEntity.ok(response);
	    } else {
	    	System.out.println("[login] autenticacion fallida para username=" + userForm.getUsername());
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas");
	    }
	}

	private UserInfo authenticateUser(String username, String password) {
		return userService.authenticate(username, password);
	}

	private String toJsonPayload(Map<String, Object> payload) {
		StringBuilder json = new StringBuilder();
		json.append("{\n");
		int index = 0;
		for (Map.Entry<String, Object> entry : payload.entrySet()) {
			json.append("  \"")
				.append(escapeJson(entry.getKey()))
				.append("\": ");

			Object value = entry.getValue();
			if (value == null) {
				json.append("null");
			} else {
				json.append("\"")
					.append(escapeJson(String.valueOf(value)))
					.append("\"");
			}

			if (index < payload.size() - 1) {
				json.append(",");
			}
			json.append("\n");
			index++;
		}
		json.append("}");
		return json.toString();
	}

	private String escapeJson(String value) {
		return value.replace("\\", "\\\\").replace("\"", "\\\"");
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
