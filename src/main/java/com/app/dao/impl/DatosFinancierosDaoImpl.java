package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.app.dao.DatosFinancierosDao;
import com.app.dao.SponsorDao;
import com.app.modelo.DatosFinancieros;
import com.app.modelo.Equipo;
import com.app.modelo.ObjetivosSponsor;
import com.app.modelo.Sponsor;
import com.app.modelo.Torneo;


@Service
public class DatosFinancierosDaoImpl implements DatosFinancierosDao {
	@Autowired
    JdbcTemplate jdbcTemplate;
	@Autowired
    SponsorDao sponsorDao;

	public DatosFinancieros getDatosFinancieros(Equipo equipo) {
		
		String query = " select distinct "
				+" dat.idDatosFinancieros, "
				+" dat.Equipos_idEquipo, "
				+" dat.presupuestoFinal, "
				+" dat.presupuestoFinalSponsor, "
				+" dat.presupuestoInicial, "
				+" dat.sponsorOpcional, "
				+" dat.Torneos_idTorneo, "
				+" datS.Sponsor_idSponsor "
				+" from datosfinancieros dat "
				+" left join dadosfinancierossponsor datS on datS.DatosFinancieros_idDatosFinancieros = dat.idDatosFinancieros "
				+"        and datS.DatosFinancieros_Equipos_idEquipo = dat.Equipos_idEquipo "
				+"        and datS.DatosFinancieros_Torneos_idTorneo = dat.Torneos_idTorneo "
				+" where dat.idDatosFinancieros = 1 "
				+" and dat.Equipos_idEquipo = " +  equipo.getId() 
				+" and dat.Torneos_idTorneo = " +  equipo.getTorneo().getId(); 
		
		
		Collection datosF = jdbcTemplate.query(
                query
                , new RowMapper() {                	
                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        DatosFinancieros datos = new DatosFinancieros();
                        datos.setId(rs.getInt("idDatosFinancieros"));
                        datos.setIdEquipo(rs.getInt("Equipos_idEquipo"));
                        
                        
                        datos.setPresupuestoFinal(rs.getInt("presupuestoFinal"));
                        datos.setPresupuestoFinalSponsor(rs.getInt("presupuestoFinalSponsor"));
                        datos.setPresupuestoInicial(rs.getInt("presupuestoInicial"));
                        
                        Sponsor sponsor = new Sponsor();
                        sponsor = sponsorDao.buscarSponsorByID(rs.getLong("Sponsor_idSponsor"));                        

                        datos.setSponsor(sponsor);
                                                
                        return datos;
                    }

					

                });
		
		for(Object datosFin :  datosF){
			List<ObjetivosSponsor> objetivos = new ArrayList<ObjetivosSponsor>();
			DatosFinancieros d = (DatosFinancieros) datosFin;
			if(d.getSponsor() != null){
				objetivos = findObjetivosSponsor(equipo, d.getSponsor());
				d.getSponsor().setObjetivos(objetivos);
			}
			return d;			
			
		}
		
//		DatosFinancieros datos = null;
//		List<Map<String, Object>> rows = jdbcTemplate.queryForList(query);
//		
//		Map<String, Object> pa = new HashMap<String,Object>();
//		pa.put("id", false);
//		pa.put("Nam", "hola");
//		System.out.println("----------->"+pa);
//		for (Map row : rows) {
//			System.out.println(row);
//			System.out.println("Opcional]:"+Boolean.parseBoolean(row.get("sponsorOpcional").toString()));
//			System.out.println("Opcional]:"+row.get("sponsorOpcional").getClass().getName());
//			boolean b = Boolean.valueOf(row.get("sponsorOpcional").toString());
//			System.out.println("B-->:"+b);
//			System.out.println("Opcional]:"+Integer.parseInt(row.get("sponsorOpcional").toString()));
//			datos = new DatosFinancieros();
//            datos.setId(Integer.parseInt(row.get("idDatosFinancieros").toString()));
//            datos.setIdEquipo(Integer.parseInt( row.get("Equipos_idEquipo").toString()));
//            datos.setIdSponsor(Integer.parseInt(row.get("Sponsor_idSponsor").toString()));
//            datos.setOpcional(Boolean.parseBoolean(row.get("sponsorOpcional").toString()));
//            datos.setPresupuestoFinal((int)Float.parseFloat( row.get("presupuestoFinal").toString()));
//            datos.setPresupuestoInicial((int)Float.parseFloat(row.get("presupuestoInicial").toString()));
//            Sponsor sponsor = new Sponsor();
//            sponsor = sponsorDao.buscarSponsorByID(Integer.parseInt( row.get("Sponsor_idSponsor").toString()));                        
//            List<ObjetivosSponsor> objetivosSelected = new ArrayList<ObjetivosSponsor>();
//            objetivosSelected = findObjetivosSponsor(equipo, sponsor);
//            sponsor.setObjetivos(objetivosSelected);
//            datos.setSponsor(sponsor);
//		}
		System.out.println("hola sali");
		

		return null;
	}
	
public List<ObjetivosSponsor> findObjetivosSponsor(Equipo equipo, Sponsor sponsor){
		
		List<ObjetivosSponsor> listObjetivos = new ArrayList<ObjetivosSponsor>();
		String query = " select cons.idConcepto,"
				+" cons.nombreConcepto,"
				+" cons.descripcionConcepto,"
				+" cons.monto,"
				+" cons.opcional,"
				+" cons.penalidad,"
				+" dathas.cumplio"
//				+" from datosfinancieros datos"
				+" from DadosFinancierosSponsor dathas "
				+" join conceptosponsor cons on cons.idConcepto = dathas.ConceptoSponsor_idConcepto"
				+" where dathas.DatosFinancieros_Equipos_idEquipo = " + equipo.getId()
				+" and dathas.Sponsor_idSponsor = " + sponsor.getId()
				+" and dathas.DatosFinancieros_Torneos_idTorneo = " + equipo.getTorneo().getId();;
		
		Collection objetivos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        ObjetivosSponsor objetivo = new ObjetivosSponsor();
                        
                        objetivo.setId(rs.getInt("idConcepto"));
                        objetivo.setNombre(rs.getString("nombreConcepto"));
                        objetivo.setDescripcion(rs.getString("descripcionConcepto"));
                        objetivo.setMonto(rs.getInt("monto"));
                        objetivo.setOpcional(rs.getBoolean("opcional"));
                        objetivo.setPenalizacion(rs.getInt("penalidad"));
                        objetivo.setCumplido(rs.getBoolean("cumplio"));
                        
                        
                        return objetivo;
                    }
                });
		
			
		
		
		for (Object objetivo : objetivos) {
            listObjetivos.add( (ObjetivosSponsor)objetivo);
        }
		
		return listObjetivos;
	}
	
public void test() {
		
	String insert = "call spTest()";
	
	
	jdbcTemplate.query(insert,new RowMapper(){
		  public Object mapRow(ResultSet rs, int arg1)
                  throws SQLException {
			  
			  System.out.println(rs);
			  
			  return null;
		  }
		
	}
		  );
	List<Map<String, Object>> rows = jdbcTemplate.queryForList(insert);
	
	
	
	for (Map row : rows) {
		System.out.println(row);
	}
	System.out.println("hola sali");
	
	Equipo equipo = new Equipo();
	equipo.setId(2);
	Torneo torneo = new Torneo();
	torneo.setId(1);
	equipo.setTorneo(torneo);
	getDatosFinancieros(equipo);
		
	}


}
