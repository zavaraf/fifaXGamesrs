package com.app.modelo;

import java.io.Serializable;

//@Entity
//@Table(name="product") 
public class Product implements Serializable {

	private static final long serialVersionUID = 1L;
	
//	@Id
//    @Column(name = "idproduct")
//    @GeneratedValue(strategy = GenerationType.AUTO)
	private Integer idProduct;
	
	private String description;
	
	private Double price;
	
	public Integer getId(){
		return idProduct;
	}

	public void setId(Integer id){
	    this.idProduct = id;
	} 

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	public String toString(){
		StringBuffer buffer =  new StringBuffer();
		buffer.append("Description: "+ description);
		buffer.append("Price: "+ price);
		
		return buffer.toString();	
		
	}
}
