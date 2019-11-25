package com.app.dao.impl;
//package com.companyname.springapp.dao.implement;
//
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.jdbc.core.RowMapper;
//import org.springframework.stereotype.Component;
//
//import com.companyname.springapp.dao.ProductDao;
//import com.companyname.springapp.domain.Product;
//
//@Component
//public class JPAProductDao implements ProductDao {
//	
//	@Autowired
//    JdbcTemplate jdbcTemplate;
//	
//	 	    
//	    public List<Product> getProductList() {
//	    	List<Product> products = new ArrayList<Product>();	    	
//	    	// Realizacmos la consulta
//	        Collection personas = jdbcTemplate.query(
//	                "SELECT idproduct,    description, price FROM product", new RowMapper() {
//
//	                    public Object mapRow(ResultSet rs, int arg1)
//	                            throws SQLException {
//	                        Product pro = new Product();
//	                        pro.setId(rs.getInt("idproduct"));
//	                        pro.setDescription(rs.getString("description"));
//	                        pro.setPrice(rs.getDouble("price"));
//	                        return pro;
//	                    }
//	                });
//
//	        // Escribimos en pantalla los datos leidos
//	        for (Object persona : personas) {
//	            System.out.println(persona.toString());
//	            products.add((Product)persona);
//	        }
//	        return products;
//	    }
//
//	    
//	    public void saveProduct(Product prod) {
//	        System.out.println("Guardado");
//	    }
//
//}
