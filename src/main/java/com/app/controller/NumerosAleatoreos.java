package com.app.controller;

import java.util.Random;

public class NumerosAleatoreos {
	
	public static void main(String args[]){
		int n = 20;
		int k = n;
		int[] resultado = new int[n];
		int[] numeros=new int[n];       
		Random rnd = new Random();
		int res;
		       
		for(int i=0;i<n;i++){
		    numeros[i]=i+1;
		}
		       
		for(int i=0;i<n;i++){
		    res = rnd.nextInt(k);           
		        resultado[i]=numeros[res];
		        numeros[res]=numeros[k-1];
		        k--;           
		}
		for(int i = 0; i<n; i++){
//		       //System.out.println(resultado[i]);
		}
	}

}
