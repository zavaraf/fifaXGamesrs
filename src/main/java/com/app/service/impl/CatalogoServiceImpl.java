package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.CatalogoDao;
import com.app.modelo.CatalogoFinanciero;
import com.app.service.CatalogoService;

@Service
public class CatalogoServiceImpl implements CatalogoService{
	
	@Autowired
	CatalogoDao catalogoDao;

	@Override
	public List<CatalogoFinanciero> listAllCatalogs() {
		return catalogoDao.listAllCatalogs();
	}
	
	

}
