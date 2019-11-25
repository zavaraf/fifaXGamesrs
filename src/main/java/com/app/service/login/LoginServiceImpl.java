package com.app.service.login;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.app.dao.login.LoginDao;
import com.app.modelo.login.UserInfo;
import com.spring.model.User;

@Service
public class LoginServiceImpl implements UserDetailsService {

	LoginDao loginDao;

	@Autowired
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserInfo userInfo = loginDao.findUserInfo(username);

		if (userInfo == null) {
			throw new UsernameNotFoundException("username was not found in the database");
		}

		ArrayList<String> roles = loginDao.getUserRoles(username);

		List<SimpleGrantedAuthority> grantList = new java.util.ArrayList<SimpleGrantedAuthority>();

		if (roles != null) {
			for (int i=0;i< roles.size(); i++) {
				System.out.println("Antas--->");
				String role = "ROLE_"+roles.get(i);
				System.out.println("------->Role]:"+role);
				 
//				GrantedAuthority authority = new SimpleGrantedAuthority(role);
				grantList.add(new SimpleGrantedAuthority(role));
			}
		}
		userInfo.setRols(roles);
		System.out.println("user]:"+userInfo.getUsername()+" Pass]:"+userInfo.getPassword()+" Equipo:"+userInfo.getNombreEquipo());
		User usuario = new User(userInfo.getUsername(), userInfo.getPassword(), grantList,
				userInfo.getIdEquipo(),userInfo.getNombreEquipo(),userInfo.getRols());
		
//			UserDetails userDetails = usuario;

		return usuario;
	}

}
