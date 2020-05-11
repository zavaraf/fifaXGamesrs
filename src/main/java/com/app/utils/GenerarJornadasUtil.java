package com.app.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.app.enums.TipoTorneoEnum;
import com.app.modelo.Equipo;
import com.app.modelo.Grupos;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.Torneo;

public class GenerarJornadasUtil {
	
	public HashMap<Integer,List<String>> generarJornadas(int teams){
		
		HashMap<Integer,List<String>> jornadas = new HashMap<Integer,List<String>>();
		
		int totalRounds = (teams - 1)*1;
	    int matchesPerRound = teams / 2;
	    String[][] rounds = new String[totalRounds][matchesPerRound];

	    for (int round = 0; round < totalRounds; round++) {
	    	List<String> juegos = new ArrayList<String>();
	        for (int match = 0; match < matchesPerRound; match++) {
	            int home = (round + match) % (teams - 1);
	            int away = (teams - 1 - match + round) % (teams - 1);

	            // Last team stays in the same place while the others
	            // rotate around it.
	            if (match == 0) {
	                away = teams - 1;
	            }

	            // Add one so teams are number 1 to teams not 0 to teams - 1
	            // upon display.
	            rounds[round][match] = ("" + (home + 1) + "-" + (away + 1));
	            String juego = (home+1) +"-" + (away + 1);
	            juegos.add(juego);
	            
	        }
	        jornadas.put((round), juegos);
	    }

	    // Display the rounds    
	    for (int i = 0; i < rounds.length; i++) {
	        System.out.println("Round " + (i + 1));
	        System.out.println(Arrays.asList(rounds[i]));
	        System.out.println();
	    }
		
		
		return jornadas;
	}
	
	public HashMap<Integer,List<String>> generarJornadasIdaYVuelta(int teams,int vuelta){
		
		HashMap<Integer,List<String>> jornadas = new HashMap<Integer,List<String>>();
		
		int totalRounds = (teams - 1)*1;
	    int matchesPerRound = teams / 2;
	    String[][] rounds = new String[totalRounds][matchesPerRound];
	    
	    for (int round = 0; round < totalRounds; round++) {
	    	List<String> juegos = new ArrayList<String>();
	        for (int match = 0; match < matchesPerRound; match++) {
	            int home = (round + match) % (teams - 1);
	            int away = (teams - 1 - match + round) % (teams - 1);

	            // Last team stays in the same place while the others
	            // rotate around it.
	            if (match == 0) {
	                away = teams - 1;
	            }

	            // Add one so teams are number 1 to teams not 0 to teams - 1
	            // upon display.
	            rounds[round][match] = ("" + (home + 1) + "-" + (away + 1));
	            String juego = (home+1) +"-" + (away + 1);
	            juegos.add(juego);
	            
	        }
	        jornadas.put((round), juegos);
	    }
	    
	    if (vuelta == 2){
		    int totalRounds1 = (teams - 1)*1;
		    int matchesPerRound1 = teams / 2;
		    String[][] rounds1 = new String[totalRounds][matchesPerRound];
		    
		    for (int round = totalRounds1-1; round >=0 ; round--) {
		    	List<String> juegos = new ArrayList<String>();
		        for (int match = 0; match < matchesPerRound1; match++) {
		            int home = (round + match) % (teams - 1);
		            int away = (teams - 1 - match + round) % (teams - 1);
	
		      
		            // Last team stays in the same place while the others
		            // rotate around it.
		            if (match == 0) {
		                away = teams -1;
		            }
		            //System.out.println("home]:"+home+ " away:"+away);
		            
	
		            // Add one so teams are number 1 to teams not 0 to teams - 1
		            // upon display.
		            rounds1[round][match] = ("" + (away + 1) + "-" + (home + 1));
		            String juego = (away+1) +"-" + (home + 1);
		            juegos.add(juego);
		        }
		        jornadas.put((round+totalRounds1), juegos);
		    }
	    }
	    
	    // Display the rounds    
	    for (int i = 0; i < rounds.length; i++) {
	        System.out.println("Round " + (i + 1));
	        System.out.println(Arrays.asList(rounds[i]));
	        System.out.println();
	    }
		
		
		return jornadas;
	}
	public Jornada getJuegoAnterior(List<Jornadas> jornadasList, Equipo local, Equipo visita, List<Equipo> equipos){
		
		List<Jornada> juegosList = jornadasList.get(jornadasList.size()-1).getJornada();
		
		for(Jornada juego : juegosList){
			if((juego.getIdEquipoLocal() == local.getId() || juego.getIdEquipoVisita() == local.getId()) || 
				((juego.getIdEquipoLocal() == visita.getId() || juego.getIdEquipoVisita() == visita.getId())) ){
				
				return juego;
			}
		}
		
		return null;
		
	}
	public List<Jornadas> getJornadasIdaYVuelta(List<Equipo> equiposL, int vuelta, List<Grupos> grupos){
		
		List<Equipo> equipos = equiposL;
		
		
		
		int numero = equipos.size();
		
		if((numero%2) !=0 ){
			Equipo eq = new Equipo();
			eq.setId(-1);
			eq.setNombre("Descanso");
			
			equipos.add(eq);
			
			numero = equipos.size();
		}
	
		
		HashMap<Integer,List<String>> jornadas = generarJornadasIdaYVuelta(numero,vuelta);
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		
		for(int jornada = 0; jornada<jornadas.size(); jornada++){
			List<Jornada> juegosList = new ArrayList<Jornada>();
			for(int j=0 ;j< jornadas.get(jornada).size(); j++){
				
				String juego = jornadas.get(jornada).get(j);
				String [] match = juego.split("-");
				
				int local = Integer.parseInt(match[0]);
				int visita = Integer.parseInt(match[1]);
				
				
				
				Equipo equipoLcoal = equipos.get(local-1);
				Equipo equipoVisita = equipos.get(visita-1);
				
//				System.out.println("->Jornada]:"+jornada+" Juego]:"+j+ " :::::  "+equipoLcoal.getNombre()+" - "+equipoVisita.getNombre());
				if(jornada > 0 && grupos.size()== 1){
//					System.out.println("grupos enttro ]:"+grupos.size());
					Jornada juegoAnterior = getJuegoAnterior(jornadasList, equipoLcoal, equipoLcoal, equipos);
					Jornada juegoAnteriorVisita = getJuegoAnterior(jornadasList, equipoVisita, equipoVisita, equipos);
					
					if(juegoAnterior!= null && juegoAnterior.getIdEquipoLocal() == equipoLcoal.getId()){
						equipoLcoal = equipos.get(visita-1);
						equipoVisita = equipos.get(local-1);						
					}else
					if(juegoAnteriorVisita != null && juegoAnteriorVisita.getIdEquipoVisita() == equipoVisita.getId()){
						equipoLcoal = equipos.get(visita-1);
						equipoVisita = equipos.get(local-1);						
					}
									
				}
				
				System.out.println("Jornada]:"+jornada+" Juego]:"+j+ " :::::  "+equipoLcoal.getNombre()+" - "+equipoVisita.getNombre());
				
				Jornada jo = new Jornada();
				
				jo.setIdJornada(jornada+1);
				jo.setNumeroJornada(jornada+1);
				jo.setId(j+1);
				jo.setIdEquipoLocal((int) equipoLcoal.getId());
				jo.setNombreEquipoLocal(equipoLcoal.getNombre());
				jo.setIdEquipoVisita((int) equipoVisita.getId());
				jo.setNombreEquipoVisita(equipoVisita.getNombre());
				jo.setImgLocal(equipoLcoal.getImg());
				jo.setImgVisita(equipoVisita.getImg());
				
				
				
				juegosList.add(jo);				
				
			}
			Jornadas jor = new Jornadas();
			jor.setIdJornda(jornada+1);
			jor.setNumeroJornada(jornada+1);
			jor.setJornada(juegosList);
			
			jornadasList.add(jor);
			
		}
		
		
		return jornadasList;
		
	}

	public List<Jornadas> getJornadas(List<Equipo> equiposL){
		
		List<Equipo> equipos = agruparArreglo(equiposL);
		
		int numero = equipos.size();
		
		if((numero%2) !=0 ){
			Equipo eq = new Equipo();
			eq.setId(-1);
			eq.setNombre("Descanso");
			
			equipos.add(eq);
		}
		
		HashMap<Integer,List<String>> jornadas = generarJornadas(equipos.size());
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		
		for(int jornada = 0; jornada<jornadas.size(); jornada++){
			List<Jornada> juegosList = new ArrayList<Jornada>();
			for(int j=0 ;j< jornadas.get(jornada).size(); j++){
				
				String juego = jornadas.get(jornada).get(j);
				String [] match = juego.split("-");
				
				int local = Integer.parseInt(match[0]);
				int visita = Integer.parseInt(match[1]);
				
				Equipo equipoLcoal = equipos.get(local-1);
				Equipo equipoVisita = equipos.get(visita-1);
				
								
				if(jornada > 0 ){
					
					Jornada juegoAnterior = getJuegoAnterior(jornadasList, equipoLcoal, equipoLcoal, equipos);
					Jornada juegoAnteriorVisita = getJuegoAnterior(jornadasList, equipoVisita, equipoVisita, equipos);
					
					if(juegoAnterior!= null && juegoAnterior.getIdEquipoLocal() == equipoLcoal.getId()){
						equipoLcoal = equipos.get(visita-1);
						equipoVisita = equipos.get(local-1);						
					}else
					if(juegoAnteriorVisita != null && juegoAnteriorVisita.getIdEquipoVisita() == equipoVisita.getId()){
						equipoLcoal = equipos.get(visita-1);
						equipoVisita = equipos.get(local-1);						
					}
									
				}
				
				Jornada jo = new Jornada();
				
				jo.setIdJornada(jornada+1);
				jo.setNumeroJornada(jornada+1);
				jo.setId(j+1);
				jo.setIdEquipoLocal((int) equipoLcoal.getId());
				jo.setNombreEquipoLocal(equipoLcoal.getNombre());
				jo.setIdEquipoVisita((int) equipoVisita.getId());
				jo.setNombreEquipoVisita(equipoVisita.getNombre());
				jo.setImgLocal(equipoLcoal.getImg());
				jo.setImgVisita(equipoVisita.getImg());
				
				juegosList.add(jo);				
				
			}
			Jornadas jor = new Jornadas();
			jor.setIdJornda(jornada+1);
			jor.setNumeroJornada(jornada+1);
			jor.setJornada(juegosList);
			
			jornadasList.add(jor);
			
		}
		
		
		return jornadasList;
		
	}
public List<Equipo> agruparArreglo(List<Equipo> equipos){
		
		List<Equipo> arrayEquipos= new ArrayList<Equipo>();
		if(equipos== null || equipos.size()==0){
			return null;
		}
		
		int n = equipos.size();
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
		       System.out.println(resultado[i]);
		       arrayEquipos.add(equipos.get(resultado[i]-1));
		}
		return arrayEquipos;
	}
	
	public List<Equipo> agruparArreglo(List<Equipo> equipos,int numEquipos){
		
		List<Equipo> arrayEquipos= new ArrayList<Equipo>();
		if(equipos== null || equipos.size()==0){
			return null;
		}
		int grupos = equipos.size()/numEquipos;
		
		HashMap<Integer,List<Equipo>> mapEquipos = new HashMap<Integer,List<Equipo>>();
		
		for (int i=0 ; i<numEquipos;i++){
			
			List<Equipo> arrayE= new ArrayList<Equipo>();
			
			if(i==0){
				int endArray = (i+1)*grupos;
				int startArray = i;
				arrayE = getEquiposGru(equipos, i, (i+1)*grupos, true);
				
				mapEquipos.put(i, arrayE);
				System.out.println(startArray+" - "+endArray + " Grupo]:"+i+" Equipos"+ arrayE);

				
			}
			else{
				int endArray = (grupos*numEquipos) - ((i-1)*grupos);
				int startArray = (numEquipos*grupos)-(i*grupos);
//				System.out.println(startArray+" - "+endArray);
				arrayE = getEquiposGru(equipos, startArray , endArray , false);
				mapEquipos.put(i, arrayE);
				System.out.println(startArray+" - "+endArray + " Grupo]:"+i+" Equipos"+ arrayE);
			}
//			System.out.println("grupo:"+i);
//			
//			for(int j=0; j<arrayE.size();j++){
//				System.out.println("grupo:"+i + " equpos:"+arrayE.get(j));
//				arrayEquipos.add(arrayE.get(j));
//			}
			
		}
		try{
		for (int i=0 ; i<grupos;i++){
			for(int j = 0; j< numEquipos;j++){
				System.out.println(i +" ---- "+j+" Equipo]:");
				System.out.println(i +" ---- "+j+" Equipo]:"+mapEquipos.get(j).get(i).getNombre());
				arrayEquipos.add(mapEquipos.get(j).get(i));
			}
		}
		}catch(Exception e){}
		
		System.out.println("Ordenado---->"+arrayEquipos);
		return arrayEquipos;
	}
	public List<Equipo> getEquiposGru(List<Equipo> equipos,int startArray, int endArray, boolean isOrder){

		List<Equipo> arrayEquipos= new ArrayList<Equipo>();
		
		if(isOrder){
			for(int i = startArray; i < endArray; i++ ){
				arrayEquipos.add(equipos.get(i));
			}
		}else{
			for(int i = endArray; i > startArray; i--){
				arrayEquipos.add(equipos.get(i-1));
			}
		}
		
		
		return arrayEquipos;
		
	}
	
	
	public List<Grupos> generarGrupos(List<Equipo> equipos, int numero){
		
		List<Grupos> grupos = new ArrayList<Grupos>();
		
		
		int numeroGrupo = equipos.size()/numero;
		
		
		
		System.out.println("Grupos]:"+numeroGrupo+" Equipos]:"+equipos.size()+" NumeroGrupos]:"+numero);
		
		for (int i=0; i< numeroGrupo; i++) {
			int startArray =0;
			if(i>0) {
				startArray = i * numero;
			}
			
			Grupos grupo = new Grupos();
			List<Equipo> equiposGrupo = new ArrayList<Equipo>();
			System.out.println("Grupo]:"+i+ " StayArry]:"+startArray+ " End]:"+(i+1)*numero);
			for(int j=startArray; j < (i+1)*numero ; j++) {
					
					grupo.setNumero(i+1);
					
					equiposGrupo.add(equipos.get(j));
					
					
					
				}
			grupo.setEquipos(equiposGrupo);
			grupos.add(grupo);
				
				
			}
			
		
		
		System.out.println("Grupos Generados]:"+grupos.size());
		
		
		return grupos;
	}
	
	public static void main(String[] args) {

	    //obtain the number of teams from user input
	    Scanner input = new Scanner(System.in);
	    System.out.print("How many teams should the fixture table have?");

	    int teams;
	    teams = input.nextInt();


	    // Generate the schedule using round robin algorithm.
	    int totalRounds = (teams - 1)*1;
	    int matchesPerRound = teams / 2;
	    String[][] rounds = new String[totalRounds][matchesPerRound];

	    for (int round = 0; round < totalRounds; round++) {
	        for (int match = 0; match < matchesPerRound; match++) {
	            int home = (round + match) % (teams - 1);
	            int away = (teams - 1 - match + round) % (teams - 1);

	            // Last team stays in the same place while the others
	            // rotate around it.
	            if (match == 0) {
	                away = teams - 1;
	            }

	            // Add one so teams are number 1 to teams not 0 to teams - 1
	            // upon display.
	            rounds[round][match] = ("" + (home + 1) + "-" + (away + 1));
	        }
	    }

	    // Display the rounds  
	    for (int i = 0; i < rounds.length; i++) {
	        System.out.println("Round " + (i + 1));
	        System.out.println(Arrays.asList(rounds[i]));
	        System.out.println();
	    }
	    
	   
	    
	  System.out.println("Total de Jornadas:"+totalRounds);
	  System.out.println("Total de Juegos:"+matchesPerRound);
	  String[][] rounds1 = new String[totalRounds][matchesPerRound];

	    for (int round = totalRounds-1; round >=0 ; round--) {
	        for (int match = 0; match < matchesPerRound; match++) {
	            int home = (round + match) % (teams - 1);
	            int away = (teams - 1 - match + round) % (teams - 1);

	      
	            // Last team stays in the same place while the others
	            // rotate around it.
	            if (match == 0) {
	                away = teams -1;
	            }
	            //System.out.println("home]:"+home+ " away:"+away);
	            

	            // Add one so teams are number 1 to teams not 0 to teams - 1
	            // upon display.
	            rounds1[round][match] = ("" + (away + 1) + "-" + (home + 1));
	        }
	    }

	    
	    for (int i = 0; i < rounds1.length; i++) {
	        System.out.println("Round Vuelta " + (i + 1));
	        System.out.println("IDA]:"+Arrays.asList(rounds[i])+" vUELTA"+Arrays.asList(rounds1[i]));
	        System.out.println();
	    }

	}
	
	
	
	
	

}
