package com.app.utils;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.app.enums.TipoIngreso;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ObjetivosSponsor;
@Component
public class EquipoUtil {
	public int getPresupuestoFinal(Equipo equipo, int montoInicial){
		int totalFinal = 0;
		
		int ingresos = getIngresos(equipo);
		int egresos  = getEgresos(equipo);
		System.out.println("----------->INICIAL]:"+montoInicial);
		System.out.println("----------->INGRESOS]+:"+ingresos);
		System.out.println("----------->EGRESOS]-:"+egresos);
		System.out.println("----------->Salarios]-:"+equipo.getSalarios());
		
//		totalFinal = (montoInicial + ingresos) - (egresos + equipo.getSalarios());
		totalFinal = (montoInicial + ingresos) - (egresos );

		
		return totalFinal;
	}
	public int getPresupuestoFinalSponsor(Equipo equipo, int montoInicial){
		int totalFinal = 0;
		
		int ingresos = getIngresos(equipo);
		int egresos  = getEgresos(equipo);
		System.out.println("----------->INICIAL]:"+montoInicial);
		System.out.println("----------->INGRESOS]+:"+ingresos);
		System.out.println("----------->EGRESOS]-:"+egresos);
		System.out.println("----------->Salarios]-:"+equipo.getSalarios());
		
//		totalFinal = (montoInicial + ingresos) - (egresos + equipo.getSalarios());
		totalFinal = (montoInicial + ingresos) - (egresos );
		
		System.out.println("----------->TOTAL SIN SPONSOR]:"+totalFinal);
		System.out.println("----------->Sponsor]:"+getTotalSponsor(equipo));
		
		totalFinal = totalFinal + getTotalSponsor(equipo);
		System.out.println("----------->TOTAL CON SPONSOR]:"+totalFinal);
		
		return totalFinal;
	}
	
	public int getIngresos(Equipo equipo){
		int ingresos=0;
		if(equipo.getFinanzas()!= null){
			for(CatalogoFinanciero cat : equipo.getFinanzas()){
				if(cat.getTipoconcepto().getCodigo().equals(TipoIngreso.INGRESO.getCodigo())){
					ingresos= ingresos + cat.getMonto();						
				}
			}
		}
		return ingresos;
	}
	public int getEgresos(Equipo equipo){
		int ingresos=0;
		if(equipo.getFinanzas()!= null){
			for(CatalogoFinanciero cat : equipo.getFinanzas()){
				if(cat.getTipoconcepto().getCodigo().equals(TipoIngreso.EGRESO.getCodigo())){
					ingresos= ingresos + cat.getMonto();						
				}
			}
		}
		return ingresos;
	}
	
	public int getTotalSponsor(Equipo equipo){
		int total = 0;
		if(equipo.getDatosFinancieros()!= null){
			if(equipo.getDatosFinancieros().getSponsor()!= null){
				total = total + equipo.getDatosFinancieros().getSponsor().getContratoFijo();
				System.out.println("----------->TOTAL Contrato SPONSOR]:"+total);
			}
			if (equipo.getDatosFinancieros()!= null && equipo.getDatosFinancieros().getSponsor()!= null){
				boolean opcionales = equipo.getDatosFinancieros().isOpcional();
				for(ObjetivosSponsor objetivo : equipo.getDatosFinancieros().getSponsor().getObjetivos()){
					if(objetivo.isCumplido()){
						total = total + objetivo.getMonto();
					}else{
						total = total - objetivo.getPenalizacion();
					}
					
				}
			}
		
		}
		return total;
	}
	
	public List<Jornada> getJornada(int totalJuegos, List<Jornadas> jornadas,List<Equipo> equipos,int idJornada){
		
		
		List<Jornada> jornada = new ArrayList<Jornada>();
		for(int i = 1 ; i <=totalJuegos; i++){
			int equipoLocal = 0;
			int equipoVisita = 0;
			boolean isEquipoInJornad = false;
			boolean isJornadaRe = false;
			boolean next = true;
			boolean nextNum = false;
			while(next == true){
				equipoLocal = (int) Math.floor(Math.random()*(0-equipos.size()+1)+equipos.size());
				equipoVisita = (int) Math.floor(Math.random()*(0-equipos.size()+1)+equipos.size());
				
				
				if(equipoLocal == equipoVisita){
					equipoVisita = (int) Math.floor(Math.random()*(0-equipos.size()+1)+equipos.size());
					System.out.println("Numeros Iguales: "+nextNum);
					if(equipoLocal != equipoVisita){
						nextNum = false;
						System.out.println("Ya soy diferente : "+nextNum);
						
					}
				}
				
				isEquipoInJornad = isEquipoInJornada(equipos.get(equipoLocal).getId(), equipos.get(equipoVisita).getId(), jornada);
				isJornadaRe = isJornadaRepetida(equipos.get(equipoLocal).getId(), equipos.get(equipoVisita).getId(), jornadas);
		
				
			if(isEquipoInJornad == false && isJornadaRe == false ){
				next = false;
				 	
			}
						
			}
			
			System.out.println(idJornada+"--->"+ equipos.get(equipoLocal).getId()+" ->"+ equipos.get(equipoVisita).getId()
					+ "  isEquipoRepetido]:"+ isEquipoInJornad+ " isJornadaRepe]:"+isJornadaRe + " next]:"+next);
			
			Jornada jor = new Jornada();
			
			jor.setId(i);
			jor.setIdJornada(idJornada);
			jor.setIdEquipoLocal((int) equipos.get(equipoLocal).getId());
			jor.setIdEquipoVisita((int) equipos.get(equipoVisita).getId());
			jor.setNombreEquipoLocal( equipos.get(equipoLocal).getNombre());
			jor.setNombreEquipoVisita( equipos.get(equipoVisita).getNombre());
			
			jornada.add(jor);
		}
		
		
		return jornada;
	}
	
	public boolean isEquipoInJornada(long idEquipo,long idEquipoVisita, List<Jornada> jornada ){
		
		for(Jornada jor : jornada){			
			if(idEquipo == jor.getIdEquipoLocal() || idEquipo == jor.getIdEquipoVisita() ||
			  idEquipoVisita == jor.getIdEquipoLocal() || idEquipoVisita == jor.getIdEquipoVisita()){
				
				return true;
			}
		}
		
		return false;
	}
	public boolean isJornadaRepetida(long idEquipo,long idEquipoVisita, List<Jornadas> jornada ){
			
			for(Jornadas jo : jornada){
				for(Jornada jor : jo.getJornada()){
					if((idEquipo == jor.getIdEquipoLocal() && idEquipoVisita == jor.getIdEquipoVisita()) ||
					   (idEquipoVisita == jor.getIdEquipoLocal() && idEquipo == jor.getIdEquipoVisita())){
						return true;
					}
				}
			}
			
			return false;
		}
	

}
