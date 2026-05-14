package com.app.controller;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
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
	
	// Nuevo endpoint para validación externa
	@RequestMapping(value = "/api/login/validate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> validateLogin(@RequestBody Map<String, String> request) {
		String username = request.get("username");
		String password = request.get("password");
		String sessionid = request.get("sessionid");
		System.out.println("[validateLogin] request recibido. username=" + username + ", sessionid=" + sessionid);
        
		// 1. Reutilizar la misma autenticación del login actual
		UserInfo user = authenticateUser(username, password);
		if (user == null) {
			System.out.println("[validateLogin] autenticacion fallida para username=" + username);
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas");
		}
		System.out.println("[validateLogin] autenticacion correcta para username=" + username);
        
		// 2. Obtener teléfono (ajusta el método si tu modelo es diferente)
		String phone = user.getTelefono();
		System.out.println("[validateLogin] telefono recuperado=" + phone);
		if (phone == null || phone.isEmpty()) {
			System.out.println("[validateLogin] usuario sin telefono registrado. username=" + username);
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El usuario no tiene teléfono registrado");
		}
        
		// 3. Consumir API externa
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> externalRequest = new HashMap<>();
		externalRequest.put("session_id", sessionid);
		externalRequest.put("phone", phone);
		externalRequest.put("liga_token", "test-token123456"); // Ajusta según tu lógica
		externalRequest.put("liga_user_id", username);
		externalRequest.put("liga_username", username);
		externalRequest.put("liga_team_id", "24"); // Ajusta según tu lógica
        
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(externalRequest, headers);
        
		String externalUrl = "https://minus-allocated-first-ensure.trycloudflare.com/api/auth/callback";
		ResponseEntity<String> externalResponse;
		System.out.println("[validateLogin] enviando callback externo a " + externalUrl);
		System.out.println("[validateLogin] payload json:\n" + toJsonPayload(externalRequest));
		try {
			externalResponse = restTemplate.postForEntity(
				externalUrl,
				entity,
				String.class
			);
		} catch (Exception e) {
			System.out.println("[validateLogin] error en callback externo: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body("Error al conectar con el servicio externo: " + e.getMessage());
		}
        
		// 4. Devolver respuesta externa
		System.out.println("[validateLogin] respuesta externa status=" + externalResponse.getStatusCode() + ", body=" + externalResponse.getBody());
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
