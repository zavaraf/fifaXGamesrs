package com.spring;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.app.service.login.LoginServiceImpl;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class ConfiguracionSpringSecurity extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;
	@Autowired
	LoginServiceImpl loginServiceImpl;
	
	@Autowired
	public void configureGlobalSecurity(AuthenticationManagerBuilder auth,PasswordEncoder pe) throws Exception {
		
//		auth.userDetailsService(userDetailsService());
		
		auth.userDetailsService(loginServiceImpl);
		auth.authenticationProvider(authenticationProvider());
				
	}	

	 @Bean
	 public DaoAuthenticationProvider authenticationProvider(){
	  DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
	  authenticationProvider.setUserDetailsService(loginServiceImpl);
	  authenticationProvider.setPasswordEncoder(passwordEncoder());
	  
	  return authenticationProvider;
	 }
	 @Bean
	 public PasswordEncoder passwordEncoder(){
	  return new BCryptPasswordEncoder();
	 }
	 
	
	
//	public UserDetailsService userDetailsService(){
//        Properties usuarios = new Properties();
//		usuarios.put("Fernando","1234,ROLE_AGENTE,enabled");
//		usuarios.put("Mulder"  ,"fox,ROLE_AGENTE_ESPECIAL,enabled");
//		usuarios.put("Scully"  ,"dana,ROLE_AGENTE_ESPECIAL,enabled");
//		usuarios.put("Skinner" ,"walter,ROLE_DIRECTOR,enabled");
//        
//		return new InMemoryUserDetailsManager(usuarios);
//	}

	
	 
	@Override
	protected void configure(HttpSecurity http) throws Exception {
	
		
		http
		.authorizeRequests()
			.antMatchers("/imagenes/*").permitAll()
			.antMatchers("/paginas/*").permitAll()
			.antMatchers("/css/*").permitAll()
			
			.antMatchers("/test/**").permitAll()
//			.antMatchers("/rest/**").permitAll()
			.antMatchers("/usermanager/**").permitAll()
			.antMatchers("/**").access("hasAnyRole('Admin','Manager','Usuario')")
			.antMatchers("/index.jsp/**").access("hasAnyRole('Usuario')")
		
		    
		    ;
		
		http
		.formLogin()
			.loginPage("/paginas/login.jsp")
			.failureUrl("/paginas/login.jsp?login_error");

		http
		.logout()
			.logoutSuccessUrl("/paginas/desconectado.jsp");


		http
			.csrf().disable();
		
//		http
//		.rememberMe().key("uniqueAndSecret");
		
		http.rememberMe() 
		.rememberMeParameter("remember-me-param")
		.rememberMeCookieName("my-remember-me")
		.tokenValiditySeconds(864000);
//		
		http
		.logout()
			.logoutSuccessUrl("/paginas/desconectado.jsp")
			.deleteCookies("JSESSIONID");


		http
		.sessionManagement()
		.invalidSessionUrl("/paginas/sesion-expirada.jsp")
		.maximumSessions(1)
		.maxSessionsPreventsLogin(false);
		
		http.sessionManagement()
	    .sessionFixation().migrateSession();
		
		
//		http.cors();
		
					
	}
	
	
}