package com.app.dao;

import java.util.HashMap;
import java.util.List;

import com.app.modelo.RoleUser;
import com.app.modelo.login.UserInfo;

public interface AdminUserDao {

	List<UserInfo> findAllUsers();

	List<RoleUser> findAllRoles();

	HashMap<String, String> pdateUserAdmin(String usuario, String idEquipo, String roles);


}
