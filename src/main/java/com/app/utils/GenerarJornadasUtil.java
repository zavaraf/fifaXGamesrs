package com.app.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import com.app.modelo.Equipo;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;

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
	
	public List<Jornadas> getJornadas(List<Equipo> equipos){
		
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
				
				Jornada jo = new Jornada();
				
				jo.setIdJornada(jornada+1);
				jo.setNumeroJornada(jornada+1);
				jo.setId(j+1);
				jo.setIdEquipoLocal((int) equipoLcoal.getId());
				jo.setNombreEquipoLocal(equipoLcoal.getNombre());
				jo.setIdEquipoVisita((int) equipoVisita.getId());
				jo.setNombreEquipoVisita(equipoVisita.getNombre());
				
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
	
//	public static void main(String[] args) {
//
//	    //obtain the number of teams from user input
//	    Scanner input = new Scanner(System.in);
//	    System.out.print("How many teams should the fixture table have?");
//
//	    int teams;
//	    teams = input.nextInt();
//
//
//	    // Generate the schedule using round robin algorithm.
//	    int totalRounds = (teams - 1)*1;
//	    int matchesPerRound = teams / 2;
//	    String[][] rounds = new String[totalRounds][matchesPerRound];
//
//	    for (int round = 0; round < totalRounds; round++) {
//	        for (int match = 0; match < matchesPerRound; match++) {
//	            int home = (round + match) % (teams - 1);
//	            int away = (teams - 1 - match + round) % (teams - 1);
//
//	            // Last team stays in the same place while the others
//	            // rotate around it.
//	            if (match == 0) {
//	                away = teams - 1;
//	            }
//
//	            // Add one so teams are number 1 to teams not 0 to teams - 1
//	            // upon display.
//	            rounds[round][match] = ("" + (home + 1) + "-" + (away + 1));
//	        }
//	    }
//
//	    // Display the rounds    
//	    for (int i = 0; i < rounds.length; i++) {
//	        System.out.println("Round " + (i + 1));
//	        System.out.println(Arrays.asList(rounds[i]));
//	        System.out.println();
//	    }
//
//	}

}
