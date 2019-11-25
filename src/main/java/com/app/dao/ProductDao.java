package com.app.dao;

import java.util.List;

import com.app.modelo.Product;

public interface ProductDao {
	
	public List<Product> getProductList();

    public void saveProduct(Product prod);

}
