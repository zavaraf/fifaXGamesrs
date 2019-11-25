package com.app.dao.login;

import java.util.ArrayList;

import com.app.modelo.login.UserInfo;

public interface LoginDao {
	
	UserInfo findUserInfo(String username);
	 
	 ArrayList<String> getUserRoles(String username);
	

}
