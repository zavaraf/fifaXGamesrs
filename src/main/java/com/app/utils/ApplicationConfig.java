package com.app.utils;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
@ComponentScan(basePackages = "com.technicalkeeda")
@PropertySource(value = { "classpath:application.properties" })
public class ApplicationConfig {
	
	@Autowired
	private Environment  env;
	
	@Bean
	public DataSource dataSource(){
		System.out.println(env.getRequiredProperty("jdbc.url"));
		
		String url = env.getRequiredProperty("jdbc.url");
		String userName = env.getRequiredProperty("jdbc.userName");
		String pass = env.getRequiredProperty("jdbc.pass");
		
		if(!env.getRequiredProperty("isProd").equals("false")){
			System.out.println("isProduccioon------------>]:"+env.getRequiredProperty("jdbc.url"));
			 url = env.getRequiredProperty("prod.jdbc.url");
			 userName = env.getRequiredProperty("prod.jdbc.userName");
			 pass = env.getRequiredProperty("prod.jdbc.pass");
		}
		
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getRequiredProperty("jdbc.driverClassName"));
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(pass);
		
		return dataSource;
	}
	
	@Bean
	public JdbcTemplate jdbcTemplate(DataSource dataSource){
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		jdbcTemplate.setResultsMapCaseInsensitive(true);
		
		return jdbcTemplate;
	}

}
