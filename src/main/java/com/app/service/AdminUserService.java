package com.app.service;

import java.util.List;

import com.app.modelo.ResponseData;
import com.app.modelo.RoleUser;
import com.app.modelo.login.UserInfo;

public interface AdminUserService {

	List<UserInfo> findAllUsers();

	List<RoleUser> findAllRoles();

	ResponseData updateUserAdmin(String usuario, String idEquipo, String roles);

}
