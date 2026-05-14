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
	
	public HashMap<Integer, List<String>> generarRoundRobinIdaYVuelta(int teams, int vuelta) {
	    HashMap<Integer, List<String>> jornadas = new HashMap<Integer, List<String>>();

	    int totalRounds = teams - 1;
	    int matchesPerRound = teams / 2;

	    List<Integer> rotacion = new ArrayList<Integer>();
	    for (int i = 0; i < teams; i++) {
	        rotacion.add(i);
	    }

	    for (int round = 0; round < totalRounds; round++) {
	        List<String> juegos = new ArrayList<String>();

	        for (int match = 0; match < matchesPerRound; match++) {
	            int a = rotacion.get(match);
	            int b = rotacion.get(teams - 1 - match);

	            int local;
	            int visita;

	            if (match == 0) {
	                if (round % 2 == 0) {
	                    local = a;
	                    visita = b;
	                } else {
	                    local = b;
	                    visita = a;
	                }
	            } else {
	                if (match % 2 == 0) {
	                    local = a;
	                    visita = b;
	                } else {
	                    local = b;
	                    visita = a;
	                }
	            }

	            juegos.add((local + 1) + "-" + (visita + 1));
	        }

	        jornadas.put(round, juegos);

	        int ultimo = rotacion.remove(rotacion.size() - 1);
	        rotacion.add(1, ultimo);
	    }

	    if (vuelta == 2) {
	        for (int round = 0; round < totalRounds; round++) {
	            List<String> ida = jornadas.get(round);
	            List<String> vueltaJuegos = new ArrayList<String>();

	            for (String juego : ida) {
	                String[] partes = juego.split("-");
	                vueltaJuegos.add(partes[1] + "-" + partes[0]);
	            }

	            jornadas.put(round + totalRounds, vueltaJuegos);
	        }
	    }

	    return jornadas;
	}
	
	public List<Jornadas> getJornadasIdaYVuelta(List<Equipo> equiposL, int vuelta, List<Grupos> grupos){
		
		List<Equipo> equipos = new ArrayList<Equipo>(equiposL);
		
		
		
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
		// HashMap<Integer,List<String>> jornadas = generarJornadasCirculares(numero,vuelta);
		HashMap<Integer,List<String>> jornadas = generarRoundRobinIdaYVuelta(numero, vuelta);
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
	 * Método para agregar nuevos equipos a un calendario en progreso
	 * Preserva jornadas ya jugadas y distribuye los nuevos partidos respetando balance
	 */
	public List<Jornadas> agregarEquiposACalendarioEnProgreso(
			List<Jornadas> jornadasExistentes, 
			List<Equipo> equiposOriginales,
			List<Equipo> nuevosEquipos, 
			int jornadaActual,
			int vuelta) {
		
		// Crear lista completa de equipos
		List<Equipo> todosLosEquipos = new ArrayList<Equipo>(equiposOriginales);
		todosLosEquipos.addAll(nuevosEquipos);
		
		// Manejar número impar de equipos
		boolean equipoFantasmaAgregado = false;
		if (todosLosEquipos.size() % 2 != 0) {
			Equipo equipoFantasma = new Equipo();
			equipoFantasma.setId(-1);
			equipoFantasma.setNombre("Descanso");
			todosLosEquipos.add(equipoFantasma);
			equipoFantasmaAgregado = true;
		}
		
		// Copiar jornadas ya jugadas (preservar intactas)
		List<Jornadas> nuevasJornadas = new ArrayList<Jornadas>();
		for (int i = 0; i < jornadaActual - 1 && i < jornadasExistentes.size(); i++) {
			nuevasJornadas.add(jornadasExistentes.get(i));
		}
		
		// Generar partidos faltantes para nuevos equipos
		List<String> partidosFaltantes = generarPartidosFaltantes(equiposOriginales, nuevosEquipos, jornadasExistentes, jornadaActual - 1);
		
		// Calcular balance actual de equipos existentes
		HashMap<Long, Integer> balanceLocal = calcularBalanceLocal(jornadasExistentes, jornadaActual - 1);
		HashMap<Long, Integer> balanceVisitante = calcularBalanceVisitante(jornadasExistentes, jornadaActual - 1);
		
		// Distribuir partidos faltantes en jornadas futuras
		distribuirPartidosEnJornadas(nuevasJornadas, partidosFaltantes, todosLosEquipos, 
									jornadaActual, balanceLocal, balanceVisitante, equipoFantasmaAgregado);
		
		return nuevasJornadas;
	}
	
	/**
	 * Genera la lista de partidos que faltan por jugar entre equipos nuevos y existentes
	 */
	private List<String> generarPartidosFaltantes(List<Equipo> equiposOriginales, 
												  List<Equipo> nuevosEquipos, 
												  List<Jornadas> jornadasExistentes,
												  int jornadasJugadas) {
		List<String> partidosFaltantes = new ArrayList<String>();
		
		// Crear mapa de partidos ya jugados
		HashMap<String, Boolean> partidosJugados = new HashMap<String, Boolean>();
		for (int i = 0; i < jornadasJugadas && i < jornadasExistentes.size(); i++) {
			for (Jornada juego : jornadasExistentes.get(i).getJornada()) {
				String partido1 = juego.getIdEquipoLocal() + "-" + juego.getIdEquipoVisita();
				String partido2 = juego.getIdEquipoVisita() + "-" + juego.getIdEquipoLocal();
				partidosJugados.put(partido1, true);
				partidosJugados.put(partido2, true);
			}
		}
		
		// Agregar partidos entre nuevos equipos y equipos existentes
		for (Equipo nuevoEquipo : nuevosEquipos) {
			for (Equipo equipoExistente : equiposOriginales) {
				String partido1 = nuevoEquipo.getId() + "-" + equipoExistente.getId();
				String partido2 = equipoExistente.getId() + "-" + nuevoEquipo.getId();
				
				if (!partidosJugados.containsKey(partido1)) {
					partidosFaltantes.add(partido1);
				}
			}
		}
		
		// Agregar partidos entre nuevos equipos
		for (int i = 0; i < nuevosEquipos.size(); i++) {
			for (int j = i + 1; j < nuevosEquipos.size(); j++) {
				String partido = nuevosEquipos.get(i).getId() + "-" + nuevosEquipos.get(j).getId();
				partidosFaltantes.add(partido);
			}
		}
		
		return partidosFaltantes;
	}
	
	/**
	 * Calcula cuántas veces cada equipo ha jugado como local
	 */
	private HashMap<Long, Integer> calcularBalanceLocal(List<Jornadas> jornadas, int jornadasJugadas) {
		HashMap<Long, Integer> balance = new HashMap<Long, Integer>();
		
		for (int i = 0; i < jornadasJugadas && i < jornadas.size(); i++) {
			for (Jornada juego : jornadas.get(i).getJornada()) {
				long equipoLocal = juego.getIdEquipoLocal();
				balance.put(equipoLocal, balance.getOrDefault(equipoLocal, 0) + 1);
			}
		}
		
		return balance;
	}
	
	/**
	 * Calcula cuántas veces cada equipo ha jugado como visitante
	 */
	private HashMap<Long, Integer> calcularBalanceVisitante(List<Jornadas> jornadas, int jornadasJugadas) {
		HashMap<Long, Integer> balance = new HashMap<Long, Integer>();
		
		for (int i = 0; i < jornadasJugadas && i < jornadas.size(); i++) {
			for (Jornada juego : jornadas.get(i).getJornada()) {
				long equipoVisitante = juego.getIdEquipoVisita();
				balance.put(equipoVisitante, balance.getOrDefault(equipoVisitante, 0) + 1);
			}
		}
		
		return balance;
	}
	
	/**
	 * Distribuye los partidos faltantes en las jornadas futuras respetando restricciones
	 */
	private void distribuirPartidosEnJornadas(List<Jornadas> jornadas, 
											  List<String> partidosFaltantes,
											  List<Equipo> todosLosEquipos,
											  int jornadaInicial,
											  HashMap<Long, Integer> balanceLocal,
											  HashMap<Long, Integer> balanceVisitante,
											  boolean equipoFantasmaAgregado) {
		
		int jornadaActual = jornadaInicial;
		List<String> partidosRestantes = new ArrayList<String>(partidosFaltantes);
		
		while (!partidosRestantes.isEmpty()) {
			List<Jornada> juegosJornada = new ArrayList<Jornada>();
			List<Long> equiposOcupados = new ArrayList<Long>();
			List<String> partidosAsignados = new ArrayList<String>();
			
			// Asignar partidos para esta jornada
			for (String partido : partidosRestantes) {
				String[] equipos = partido.split("-");
				long equipoLocal = Long.parseLong(equipos[0]);
				long equipoVisitante = Long.parseLong(equipos[1]);
				
				// Verificar que ningún equipo esté ocupado en esta jornada
				if (!equiposOcupados.contains(equipoLocal) && !equiposOcupados.contains(equipoVisitante)) {
					
					// Decidir local/visitante basado en balance
					boolean intercambiar = debeIntercambiarLocalVisitante(equipoLocal, equipoVisitante, balanceLocal, balanceVisitante);
					if (intercambiar) {
						long temp = equipoLocal;
						equipoLocal = equipoVisitante;
						equipoVisitante = temp;
					}
					
					// Filtrar equipo fantasma
					if (equipoFantasmaAgregado && (equipoLocal == -1 || equipoVisitante == -1)) {
						partidosAsignados.add(partido);
						continue;
					}
					
					// Crear el juego
					Equipo eLocal = buscarEquipoPorId(todosLosEquipos, equipoLocal);
					Equipo eVisitante = buscarEquipoPorId(todosLosEquipos, equipoVisitante);
					
					if (eLocal != null && eVisitante != null) {
						Jornada juego = new Jornada();
						juego.setIdJornada(jornadaActual);
						juego.setNumeroJornada(jornadaActual);
						juego.setId(juegosJornada.size() + 1);
						juego.setIdEquipoLocal((int) equipoLocal);
						juego.setNombreEquipoLocal(eLocal.getNombre());
						juego.setIdEquipoVisita((int) equipoVisitante);
						juego.setNombreEquipoVisita(eVisitante.getNombre());
						juego.setImgLocal(eLocal.getImg());
						juego.setImgVisita(eVisitante.getImg());
						
						juegosJornada.add(juego);
						equiposOcupados.add(equipoLocal);
						equiposOcupados.add(equipoVisitante);
						partidosAsignados.add(partido);
						
						// Actualizar balances
						balanceLocal.put(equipoLocal, balanceLocal.getOrDefault(equipoLocal, 0) + 1);
						balanceVisitante.put(equipoVisitante, balanceVisitante.getOrDefault(equipoVisitante, 0) + 1);
					}
				}
			}
			
			// Remover partidos asignados
			partidosRestantes.removeAll(partidosAsignados);
			
			// Crear jornada si tiene juegos
			if (!juegosJornada.isEmpty()) {
				Jornadas nuevaJornada = new Jornadas();
				nuevaJornada.setIdJornda(jornadaActual);
				nuevaJornada.setNumeroJornada(jornadaActual);
				nuevaJornada.setJornada(juegosJornada);
				jornadas.add(nuevaJornada);
			}
			
			jornadaActual++;
		}
	}
	
	/**
	 * Decide si se debe intercambiar local y visitante para balancear
	 */
	private boolean debeIntercambiarLocalVisitante(long equipo1, long equipo2, 
												   HashMap<Long, Integer> balanceLocal,
												   HashMap<Long, Integer> balanceVisitante) {
		int local1 = balanceLocal.getOrDefault(equipo1, 0);
		int visitante1 = balanceVisitante.getOrDefault(equipo1, 0);
		int local2 = balanceLocal.getOrDefault(equipo2, 0);
		int visitante2 = balanceVisitante.getOrDefault(equipo2, 0);
		
		int balance1 = local1 - visitante1;
		int balance2 = local2 - visitante2;
		
		// Si equipo2 tiene mayor desbalance hacia visitante, hacer que sea local
		return balance2 < balance1;
	}
	
	/**
	 * Busca un equipo por ID en la lista
	 */
	private Equipo buscarEquipoPorId(List<Equipo> equipos, long id) {
		for (Equipo equipo : equipos) {
			if (equipo.getId() == id) {
				return equipo;
			}
		}
		return null;
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
