package com.app.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import com.app.modelo.Equipo;
import com.app.modelo.Grupos;
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
	        //System.out.println("Round " + (i + 1));
	        //System.out.println(Arrays.asList(rounds[i]));
	        //System.out.println();
	    }
		
		
		return jornadas;
	}
	
	public HashMap<Integer,List<String>> generarJornadasIdaYVuelta(int teams,int vuelta){
		
		HashMap<Integer,List<String>> jornadas = new HashMap<Integer,List<String>>();
		
		int totalRounds = (teams - 1)*1;
	    int matchesPerRound = teams / 2;
	    String[][] rounds = new String[totalRounds][matchesPerRound];
	    
	    // Arrays para contar cuántas veces cada equipo juega como local y visitante
	    int[] contadorLocal = new int[teams];
	    int[] contadorVisitante = new int[teams];
	    
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
	            
	            // Estrategia de balanceo mejorada para distribuir mejor local/visitante
	            // Verificar cuántas veces cada equipo ha jugado como local
	            if (round > 0) {
	                // Si home ha jugado más veces como local que away, intercambiar
	                if (contadorLocal[home] > contadorLocal[away] + 1) {
	                    int temp = home;
	                    home = away;
	                    away = temp;
	                }
	                // También considerar el balance total (local - visitante)
	                else if ((contadorLocal[home] - contadorVisitante[home]) > 
	                        (contadorLocal[away] - contadorVisitante[away]) + 1) {
	                    int temp = home;
	                    home = away;
	                    away = temp;
	                }
	            }
	            
	            // Incrementar contadores
	            contadorLocal[home]++;
	            contadorVisitante[away]++;

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
		            ////System.out.println("home]:"+home+ " away:"+away);
		            
	
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
	        //System.out.println("Round " + (i + 1));
	        //System.out.println(Arrays.asList(rounds[i]));
	        //System.out.println();
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
	
		
		// Usar el nuevo método balanceado en lugar del original
		//HashMap<Integer,List<String>> jornadas = generarJornadasBalanceadas(numero,vuelta);
		// Alternativa: usar el método circular
		 HashMap<Integer,List<String>> jornadas = generarJornadasCirculares(numero,vuelta);
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
				
//				//System.out.println("->Jornada]:"+jornada+" Juego]:"+j+ " :::::  "+equipoLcoal.getNombre()+" - "+equipoVisita.getNombre());
//				Ordenar local y visitas
				if(jornada > 0 && grupos.size()<= 2  ){
//					//System.out.println("grupos enttro ]:"+grupos.size());
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
				
				//System.out.println("Jornada]:"+jornada+" Juego]:"+j+ " :::::  "+equipoLcoal.getNombre()+" - "+equipoVisita.getNombre());
				
				
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
		int mitad = equipos.size() / 2;
		
//		if(mitad > 5 && vuelta != 2) {
//			balancearJornadas(mitad, equipos, jornadasList);		
//		}
		
		return jornadasList;
		
	}
	
	public void balancearJornadas(int mitad, List<Equipo> equipos, List<Jornadas> jornadasList) {
		HashMap <String, Integer> map = new HashMap<String, Integer>(); 
		
		for(Equipo e: equipos){
			int cont = 0;
			for (Jornadas jo : jornadasList) {
				for (Jornada juego : jo.getJornada()) {
					if(juego.getIdEquipoLocal() == e.getId()) {
						cont++;
					}
				}
			}
			//System.out.println(cont  + "\t = "+ e.getNombre());
			map.put(e.getNombre(), cont);
		};
		
		
		if((mitad%2) ==0 ){
			
			
			
			cambiarJuegoLocalVisita(jornadasList, equipos.get(0), equipos.get(1));
			for(int i = mitad+2 ; i < equipos.size(); i= i+2) {
				
				cambiarJuegoLocalVisita(jornadasList, equipos.get(i-1), equipos.get(i));
				
			}
			
		}else {
			
			
			
			for(int i = 1 ; i < equipos.size()-1; i=i+2) {
				int cu = map.get(equipos.get(i).getNombre());
				
				int cua = map.get(equipos.get(i+1).getNombre()); 
				
				
				
				if(cu < cua && cu < mitad) {
					//System.out.println(cu +"-------------"+cua);
					cambiarJuegoLocalVisita(jornadasList, equipos.get(i), equipos.get(i+1));
				}
				if(cu > cua && cu < mitad-1) {
					//System.out.println(cu +"<------------->"+cua);
					cambiarJuegoLocalVisita(jornadasList, equipos.get(i),equipos.get(i+1));
				}
				
				
			}
			
			HashMap <String, Integer> mapa = obtenerMap(equipos, jornadasList, mitad);
			
			
			Iterator<String> it = mapa.keySet().iterator();

			while(it.hasNext()){
			    String clave = it.next();
			    int valor = mapa.get(clave);		    
			    //System.out.println("Clave: " + clave + ", valor: " + valor);
			    String clave2 = null;
			    int valor2 = 0;
			    if(it.hasNext()) {
			    	clave2 = it.next();
			    	valor2 = mapa.get(clave2);
			    	//System.out.println("Clave: " + clave2 + ", valor: " + valor2);
			    }
			    
			    
			    Equipo equipo1 = null;
			    Equipo equipo2 = null;
			    for(Equipo eq : equipos) {
			    	if(equipo1 == null && eq.getNombre().equals(clave)) {
			    		equipo1 = eq;
			    	}else if( eq.getNombre().equals(clave2)) {
			    		equipo2 = eq;
			    	}
			    }
			    if(valor2 > valor)
			    	cambiarJuegoLocalVisita(jornadasList, equipo1, equipo2);
			    else
			    	cambiarJuegoLocalVisita(jornadasList, equipo2, equipo1);
			}
			
			
			
		}
		

		
		//System.out.println("--------------------------------------------------->>>>>");
		for(Equipo e : equipos) {
			int cont = 0;
			for (Jornadas jo : jornadasList) {
				for (Jornada juego : jo.getJornada()) {
					if(juego.getIdEquipoLocal() == e.getId()) {
						cont++;
					}
				}
			}
			//System.out.println(cont  + "\t = "+ e.getNombre());
			
		}
	}
	
	public HashMap <String, Integer> obtenerMap(List<Equipo> equipos,List<Jornadas> jornadasList, int mitad) {
		HashMap <String, Integer> map = new HashMap<String, Integer>(); 
		
		for(Equipo e : equipos){
			int cont = 0;
			for (Jornadas jo : jornadasList) {
				for (Jornada juego : jo.getJornada()) {
					if(juego.getIdEquipoLocal() == e.getId()) {
						cont++;
					}
				}
			}
//			//System.out.println(cont  + "\t = "+ e.getNombre());
			if(cont > mitad || cont < mitad-1)
				map.put(e.getNombre(), cont);
		}
		
		
		
		return map;
	}
	
	public void cambiarJuegoLocalVisita(List<Jornadas> jornadasList, Equipo equipo, Equipo equipoCambio) {
		boolean encontre = false;
		for (Jornadas jo : jornadasList) {
			for (Jornada juego : jo.getJornada()) {
				if(juego.getIdEquipoLocal() == equipoCambio.getId() && juego.getIdEquipoVisita() == equipo.getId()) {
					
					juego.setIdEquipoLocal((int) equipo.getId());
					juego.setNombreEquipoLocal(equipo.getNombre());
					juego.setIdEquipoVisita((int) equipoCambio.getId());
					juego.setNombreEquipoVisita(equipoCambio.getNombre());
					juego.setImgLocal(equipo.getImg());
					juego.setImgVisita(equipoCambio.getImg());
//					Jornada jor = new Jornada();
//					
//					jor.setIdJornada(juego.getIdJornada());
//					jor.setNumeroJornada(juego.getNumeroJornada());
//					jor.setId(juego.getId());
//					jor.setIdEquipoLocal((int) juego.getIdEquipoVisita());
//					jor.setNombreEquipoLocal(juego.getNombreEquipoVisita());
//					jor.setIdEquipoVisita((int) juego.getIdEquipoLocal());
//					jor.setNombreEquipoVisita(juego.getNombreEquipoLocal());
//					jor.setImgLocal(juego.getImgVisita());
//					jor.setImgVisita(juego.getImgLocal());
//					
//					juego = jor;
					
					
					
					encontre = true ;
					break;

				}
				
				if(juego.getIdEquipoLocal() == equipo.getId() && juego.getIdEquipoVisita() == equipoCambio.getId()) {
					
					
					Jornada jor = new Jornada();
					
					jor.setIdJornada(juego.getIdJornada());
					jor.setNumeroJornada(juego.getNumeroJornada());
					jor.setId(juego.getId());
					jor.setIdEquipoLocal((int) juego.getIdEquipoVisita());
					jor.setNombreEquipoLocal(juego.getNombreEquipoVisita());
					jor.setIdEquipoVisita((int) juego.getIdEquipoLocal());
					jor.setNombreEquipoVisita(juego.getNombreEquipoLocal());
					jor.setImgLocal(juego.getImgVisita());
					jor.setImgVisita(juego.getImgLocal());
					
					juego = jor;

					encontre = true ;
					break;
				}
			}
			
			if(encontre == true)
				break;
		}
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
		       //System.out.println(resultado[i]);
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
//			
			if(i==0){
				int endArray = (i+1)*grupos;
				int startArray = i;
				arrayE = getEquiposGru(equipos, i, (i+1)*grupos, true);
				
				mapEquipos.put(i, arrayE);
				//System.out.println(startArray+" - "+endArray + " Grupo]:"+i+" Equipos"+ arrayE);

				
			}else{
				
				int endArray = (i+1)*grupos;
				int startArray = i * grupos;
		//		//System.out.println(startArray+" - "+endArray);
				arrayE = getEquiposGru(equipos, startArray , endArray , false);
				mapEquipos.put(i, arrayE);
				//System.out.println(startArray+" - "+endArray + " Grupo]:"+i+" Equipos"+ arrayE);
			}
//			else{
////				int endArray = (grupos*numEquipos) - ((i-1)*grupos);
////				int startArray = (numEquipos*grupos)-(i*grupos);
//				
//				int endArray = (grupos*numEquipos) - ((i-1)*grupos);
//				int startArray = (numEquipos*grupos)-(i*grupos);
////				//System.out.println(startArray+" - "+endArray);
//				arrayE = getEquiposGru(equipos, startArray , endArray , false);
//				mapEquipos.put(i, arrayE);
//				//System.out.println(startArray+" - "+endArray + " Grupo]:"+i+" Equipos"+ arrayE);
//			}
//			//System.out.println("grupo:"+i);
//			
//			for(int j=0; j<arrayE.size();j++){
//				//System.out.println("grupo:"+i + " equpos:"+arrayE.get(j));
//				arrayEquipos.add(arrayE.get(j));
//			}
			
		}
		try{
		for (int i=0 ; i<grupos;i++){
			for(int j = 0; j< numEquipos;j++){
//				//System.out.println(i +" ---- "+j+" Equipo]:");
				//System.out.println(i +" ---- "+j+" Equipo]:"+mapEquipos.get(j).get(i).getNombre());
				arrayEquipos.add(mapEquipos.get(j).get(i));
			}
		}
		}catch(Exception e){}
		
		//System.out.println("Ordenado---->"+arrayEquipos);
		return arrayEquipos;
	}
	public List<Equipo> getEquiposGru(List<Equipo> equipos,int startArray, int endArray, boolean isOrder){

		List<Equipo> arrayEquipos= new ArrayList<Equipo>();
		
		if(isOrder){
			for(int i = startArray; i < endArray; i++ ){
				arrayEquipos.add(equipos.get(i));
			}
		}else{
//			for(int i = endArray; i > startArray; i--){
//				arrayEquipos.add(equipos.get(i-1));
//			}
			for(int i = startArray; i < endArray; i++ ){
				arrayEquipos.add(equipos.get(i));
			}
			
		}
		
		
		return arrayEquipos;
		
	}
	
	
	public List<Grupos> generarGrupos(List<Equipo> equipos, int numero){
		
		List<Grupos> grupos = new ArrayList<Grupos>();
		
		
		int numeroGrupo = equipos.size()/numero;
		
		
		
		//System.out.println("Grupos]:"+numeroGrupo+" Equipos]:"+equipos.size()+" NumeroGrupos]:"+numero);
		
		for (int i=0; i< numeroGrupo; i++) {
			int startArray =0;
			if(i>0) {
				startArray = i * numero;
			}
			
			Grupos grupo = new Grupos();
			List<Equipo> equiposGrupo = new ArrayList<Equipo>();
			//System.out.println("Grupo]:"+i+ " StayArry]:"+startArray+ " End]:"+(i+1)*numero);
			for(int j=startArray; j < (i+1)*numero ; j++) {
					
					grupo.setNumero(i+1);
					
					equiposGrupo.add(equipos.get(j));
					
					
					
				}
			grupo.setEquipos(equiposGrupo);
			grupos.add(grupo);
				
				
			}
			
		
		
		//System.out.println("Grupos Generados]:"+grupos.size());
		
		
		return grupos;
	}
	
	
	
	/**
	 * Método alternativo para generar jornadas con mejor balance usando Round Robin optimizado
	 * Este método garantiza una distribución más equitativa de partidos como local y visitante
	 */
	public HashMap<Integer,List<String>> generarJornadasBalanceadas(int teams, int vuelta) {
		HashMap<Integer,List<String>> jornadas = new HashMap<Integer,List<String>>();
		
		if (teams % 2 != 0) {
			teams++; // Agregar equipo "fantasma" si es impar
		}
		
		int totalRounds = teams - 1;
		int matchesPerRound = teams / 2;
		
		// Lista de equipos (0 a teams-1)
		List<Integer> equipos = new ArrayList<Integer>();
		for (int i = 0; i < teams; i++) {
			equipos.add(i);
		}
		
		// Primera vuelta
		for (int round = 0; round < totalRounds; round++) {
			List<String> juegos = new ArrayList<String>();
			
			for (int match = 0; match < matchesPerRound; match++) {
				int home, away;
				
				if (match == 0) {
					// El primer equipo (0) siempre está fijo
					home = 0;
					away = equipos.get(teams - 1 - round);
				} else {
					// Los demás equipos rotan
					int homeIndex = (round + match - 1) % (teams - 1) + 1;
					int awayIndex = (round - match + teams - 1) % (teams - 1) + 1;
					
					home = equipos.get(homeIndex);
					away = equipos.get(awayIndex);
				}
				
				// Alternar local/visitante cada cierta cantidad de rondas para balancear
				if ((round + match) % 2 == 1) {
					int temp = home;
					home = away;
					away = temp;
				}
				
				// Solo agregar si no es contra el equipo "fantasma" (teams-1 si era impar)
				if (home < teams - 1 && away < teams - 1) {
					String juego = (home + 1) + "-" + (away + 1);
					juegos.add(juego);
				}
			}
			
			if (!juegos.isEmpty()) {
				jornadas.put(round, juegos);
			}
		}
		
		// Segunda vuelta si se requiere
		if (vuelta == 2) {
			int baseRounds = jornadas.size();
			
			for (int round = 0; round < totalRounds; round++) {
				if (jornadas.containsKey(round)) {
					List<String> juegosPrimeraVuelta = jornadas.get(round);
					List<String> juegosSegundaVuelta = new ArrayList<String>();
					
					// Invertir local y visitante para la segunda vuelta
					for (String juego : juegosPrimeraVuelta) {
						String[] equiposJuego = juego.split("-");
						String juegoInvertido = equiposJuego[1] + "-" + equiposJuego[0];
						juegosSegundaVuelta.add(juegoInvertido);
					}
					
					jornadas.put(baseRounds + round, juegosSegundaVuelta);
				}
			}
		}
		
		return jornadas;
	}
	
	/**
	 * Método alternativo con algoritmo "Circle Method" para máximo balance
	 */
	public HashMap<Integer,List<String>> generarJornadasCirculares(int teams, int vuelta) {
		HashMap<Integer,List<String>> jornadas = new HashMap<Integer,List<String>>();
		
		boolean equipoImpar = false;
		if (teams % 2 != 0) {
			teams++;
			equipoImpar = true;
		}
		
		int totalRounds = teams - 1;
		
		// Crear matriz circular
		int[][] schedule = new int[totalRounds][teams/2 * 2];
		
		// Llenar la matriz usando el método circular
		for (int round = 0; round < totalRounds; round++) {
			int col = 0;
			
			for (int i = 0; i < teams/2; i++) {
				int home = (round + i) % (teams - 1);
				int away = (teams - 1 - i + round) % (teams - 1);
				
				// El último equipo se mantiene fijo en la primera posición cada ronda
				if (i == 0) {
					away = teams - 1;
				}
				
				// Estrategia de balance: alternar cada 2 rondas
				if ((round / 2) % 2 == 1) {
					int temp = home;
					home = away;
					away = temp;
				}
				
				schedule[round][col++] = home;
				schedule[round][col++] = away;
			}
		}
		
		// Convertir matriz a HashMap
		for (int round = 0; round < totalRounds; round++) {
			List<String> juegos = new ArrayList<String>();
			
			for (int match = 0; match < teams/2; match++) {
				int home = schedule[round][match * 2];
				int away = schedule[round][match * 2 + 1];
				
				// Filtrar el equipo "fantasma" si había número impar
				if (equipoImpar && (home == teams - 1 || away == teams - 1)) {
					continue;
				}
				
				String juego = (home + 1) + "-" + (away + 1);
				juegos.add(juego);
			}
			
			if (!juegos.isEmpty()) {
				jornadas.put(round, juegos);
			}
		}
		
		// Segunda vuelta
		if (vuelta == 2) {
			int baseRounds = jornadas.size();
			
			for (int round = 0; round < baseRounds; round++) {
				if (jornadas.containsKey(round)) {
					List<String> juegosPrimeraVuelta = jornadas.get(round);
					List<String> juegosSegundaVuelta = new ArrayList<String>();
					
					for (String juego : juegosPrimeraVuelta) {
						String[] equiposJuego = juego.split("-");
						String juegoInvertido = equiposJuego[1] + "-" + equiposJuego[0];
						juegosSegundaVuelta.add(juegoInvertido);
					}
					
					jornadas.put(baseRounds + round, juegosSegundaVuelta);
				}
			}
		}
		
		return jornadas;
	}
}
