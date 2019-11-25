package com.app.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.AdminUserDao;
import com.app.enums.CodigoResponse;
import com.app.modelo.ResponseData;
import com.app.modelo.RoleUser;
import com.app.modelo.login.UserInfo;
import com.app.service.AdminUserService;

@Service
public class AdminUserServiceImpl implements AdminUserService{
	
	@Autowired
	AdminUserDao userDao;

	@Override
	public List<UserInfo> findAllUsers() {
		return userDao.findAllUsers();
	}

	@Override
	public List<RoleUser> findAllRoles() {
		return userDao.findAllRoles();
	}

	@Override
	public ResponseData updateUserAdmin(String usuario, String idEquipo, String roles) {

		HashMap<String, String> map = new HashMap<String, String>();
		ResponseData response = new ResponseData();
		
		map= userDao.pdateUserAdmin( usuario,  idEquipo,  roles);
		if (map == null || map.isEmpty()) {
			response.setStatus(CodigoResponse.ERROR.getCodigo());
			response.setMensaje(CodigoResponse.ERROR.getMensaje());
		} else {
			String status = map.get("status");
			response.setStatus(Integer.parseInt(status));
			response.setMensaje(map.get("mensaje"));
		}
		return response;
	}

}
