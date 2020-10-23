package com.app.utils;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.app.modelo.login.UserInfo;
import com.mysql.jdbc.Connection;

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
			System.out.println("isProduccioon------------>]:"+env.getRequiredProperty("prod.jdbc.url"));
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
	
	public DataSource dataSource1(){
		System.out.println(System.getProperty("jdbc.url"));
		
		String url = "jdbc:mysql://database-1.c5pfdjducnqe.us-east-2.rds.amazonaws.com/fifaxgamersbd";
		String userName ="admin";
		String pass ="FifaRoot";
		
	
		
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(pass);
		
		return dataSource;
	}
	
	public String findUserInfo(String username, JdbcTemplate jdbcTemplate ) {
		// String query = "select username, pass as password from usuarios where
		// username = '"+username+"'";
		String query = " select usuarios.username,  " + " usuarios.pass as password,  " + " usuarios.email,  "
				+ " equipos.nombreEquipo,  " + " equipos.idEquipo , " + " GROUP_CONCAT(DISTINCT roles.descripcionRol "
				+ "           ORDER BY roles.descripcionRol ASC " + "           SEPARATOR ' - ') as roles "
				+ " from usuarios  " + " join usuarios_has_roles uhr on uhr.Usuarios_userName = usuarios.userName "
				+ " join roles on uhr.Roles_idRoles = roles.idRoles "
				+ " left join equipos on usuarios.idequipo = equipos.idEquipo" + " where usuarios.userName = '"
				+ username + "'" + " group by equipos.nombreEquipo ";
		System.out.println("------>user]" + query);

		Collection users = jdbcTemplate.query(query, new RowMapper() {

			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				
				String user = "";
				
				user += " [username]:"+rs.getString("username");
				user += " [password]:"+rs.getString("password");
				

				System.out.println(rs.getString("username"));
				System.out.println(rs.getString("password"));
				System.out.println(rs.getString("idEquipo"));
				System.out.println(rs.getString("nombreEquipo"));
				System.out.println(rs.getString("roles"));

				return user;
			}
		});

		for (Object user : users) {
			return  (String) user;
		}
		
		System.out.println("Fin Cosulta");
		return "null";
	}
	
	public static Connection getRemoteConnection() {
	    
	      try {
	      Class.forName("com.mysql.jdbc.Driver");
	      String dbName = "fifaxgamersbd";
	      String userName = "admin";
	      String password = "FifaRoot";
	      String hostname = "database-1.c5pfdjducnqe.us-east-2.rds.amazonaws.com";
	      String port = "3306";
	      String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName + "?user=" + userName + "&password=" + password;
	      System.out.println("Getting remote connection with connection string from environment variables.");
	      Connection con = (Connection) DriverManager.getConnection(jdbcUrl);
	      System.out.println("Remote connection successful.");
	      return con;
	    }
	    catch (ClassNotFoundException e) { System.out.println(e.toString());}
	    catch (SQLException e) { System.out.println(e.toString());}
	    
	    return null;
	  }
	
//	public static void main(String args[]){
//		
//		ApplicationConfig ap = new ApplicationConfig();
//		
//		Connection con = ap.getRemoteConnection();
//		
//		System.out.println("HOla");
//		
//		DataSource data = ap.dataSource1();
//		
//		JdbcTemplate jdbcTemplate  = ap.jdbcTemplate(data);
//		
//		ap.findUserInfo("zavaraf", jdbcTemplate);
//		
//		System.out.println("Fin");
//		
//	}

}
