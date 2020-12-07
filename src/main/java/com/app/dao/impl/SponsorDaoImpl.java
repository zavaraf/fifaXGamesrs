package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.app.dao.SponsorDao;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.Equipo;
import com.app.modelo.ObjetivosSponsor;
import com.app.modelo.Sponsor;
import com.app.modelo.TipoConcepto;
@Component
public class SponsorDaoImpl implements SponsorDao{
	@Autowired
    JdbcTemplate jdbcTemplate;

	public List<Sponsor> buscarTodos() {
		
		List<Sponsor> sponsorList = new ArrayList<Sponsor>();
		
		String query = " SELECT "
				+" sponsor.idSponsor,"
				+" sponsor.nombreSponsor,"
				+" sponsor.descripcionSponsor,"
				+" sponsor.clase,"
				+" sponsor.contratoFijo"
				+" FROM sponsor"
				+ " order by sponsor.clase";
		
		Collection sponsors = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Sponsor sponsor = new Sponsor();
                        sponsor.setId(rs.getInt("idSponsor"));
                        sponsor.setNombreSponsor(rs.getString("nombreSponsor"));
                        sponsor.setDescripcion(rs.getString("descripcionSponsor"));
                        sponsor.setContratoFijo(rs.getInt("contratoFijo"));
                        sponsor.setClase(rs.getString("clase"));
                        
                        List<ObjetivosSponsor> listObjetivos = findObjetivosSponsor(sponsor.getId());
                        sponsor.setObjetivos(listObjetivos);
                        
                        return sponsor;
                    }
                });
		 for (Object sponsor : sponsors) {
//	            System.out.println(equipo.toString());
	            sponsorList.add( (Sponsor)sponsor);
	        }
	        

		
		return sponsorList;
	}
	
public List<Sponsor> buscarAllByDivision(long idDivision) {
		
		List<Sponsor> sponsorList = new ArrayList<Sponsor>();
		
		String query = " SELECT "
				+" sponsor.idSponsor,"
				+" sponsor.nombreSponsor,"
				+" sponsor.descripcionSponsor,"
				+" sponsor.clase,"
				+" sponsor.contratoFijo"
				+" FROM sponsor"
				+" JOIN division ON division.idDivision = sponsor.Division_idDivision"
				+" where division.idDivision = "+ idDivision
				+" order by sponsor.clase";
		
		Collection sponsors = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Sponsor sponsor = new Sponsor();
                        sponsor.setId(rs.getInt("idSponsor"));
                        sponsor.setNombreSponsor(rs.getString("nombreSponsor"));
                        sponsor.setDescripcion(rs.getString("descripcionSponsor"));
                        sponsor.setContratoFijo(rs.getInt("contratoFijo"));
                        sponsor.setClase(rs.getString("clase"));
                        
                        List<ObjetivosSponsor> listObjetivos = findObjetivosSponsor(sponsor.getId());
                        sponsor.setObjetivos(listObjetivos);
                        
                        return sponsor;
                    }
                });
		 for (Object sponsor : sponsors) {
	            sponsorList.add( (Sponsor)sponsor);
	        }
	        

		
		return sponsorList;
	}

	public List<ObjetivosSponsor> findObjetivosSponsor(int idSponsor){
		
		List<ObjetivosSponsor> listObjetivos = new ArrayList<ObjetivosSponsor>();
		String query = " SELECT "
				+" sponsor.idSponsor,"
				+" cons.idConcepto,"
				+" cons.nombreConcepto,"
				+" cons.descripcionConcepto,"
				+" cons.monto,"
				+" cons.opcional,"
				+" cons.penalidad"
				+" FROM sponsor"
				+" JOIN division ON division.idDivision = sponsor.Division_idDivision"
				+" join sponsor_has_concepto spcon on spcon.Sponsor_idSponsor = sponsor.idSponsor"
				+" join conceptosponsor cons on cons.idConcepto = spcon.Concepto_idConcepto"
				+" where sponsor.idSponsor = "+idSponsor;
		
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
                        
                        
                        return objetivo;
                    }
                });
		
		for (Object objetivo : objetivos) {
            listObjetivos.add( (ObjetivosSponsor)objetivo);
        }
		
		return listObjetivos;
	}

	public Sponsor buscarSponsorByID(long id) {
List<Sponsor> sponsorList = new ArrayList<Sponsor>();
		
		String query = " SELECT "
				+" sponsor.idSponsor,"
				+" sponsor.nombreSponsor,"
				+" sponsor.descripcionSponsor,"
				+" sponsor.clase,"
				+" sponsor.contratoFijo"
				+" FROM sponsor"
				+" where sponsor.idSponsor = "+ id;
		
		Collection sponsors = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        Sponsor sponsor = new Sponsor();
                        sponsor.setId(rs.getInt("idSponsor"));
                        sponsor.setNombreSponsor(rs.getString("nombreSponsor"));
                        sponsor.setDescripcion(rs.getString("descripcionSponsor"));
                        sponsor.setContratoFijo(rs.getInt("contratoFijo"));
                        sponsor.setClase(rs.getString("clase"));
                        
                        List<ObjetivosSponsor> listObjetivos = findObjetivosSponsor(sponsor.getId());
                        sponsor.setObjetivos(listObjetivos);
                        return sponsor;
                    }
                });
		 for (Object sponsor : sponsors) {
	           return (Sponsor)sponsor;
	        }
		
		return null;
	}

	public void crearDatosFinancieros(long idEquipo,long idSponsor, boolean opcional) {
		// TODO call createOrUpdateDatosSponsor(2,8,0);
		
		String query = "call  createOrUpdateDatosSponsor(?,?,?)";
				
		
		jdbcTemplate.update(query,
			    idEquipo,
			    idSponsor,
			    opcional			    
			  );
		
	}

	public List<CatalogoFinanciero> getCatalogoFinanzas() {
		List<CatalogoFinanciero> listCatalogo = new ArrayList<CatalogoFinanciero>();
		String query = "select cat.idCatalogoConceptos, "
				+"cat.nombre, "
				+"cat.descripcion, "
				+"tipo.idTipoConcepto, "
				+"tipo.codigoConcepto, "
				+"tipo.descripcionConcepto "
				+"from catalogoconceptos cat  "
				+"join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto ";
		
		Collection catalogos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        CatalogoFinanciero catalogo = new CatalogoFinanciero();
                        catalogo.setCodigo(rs.getString("nombre"));
                        catalogo.setDescripcion(rs.getString("descripcion"));
                        catalogo.setId(rs.getInt("idCatalogoConceptos"));
                        TipoConcepto tipo = new TipoConcepto();
                        tipo.setId(rs.getInt("idTipoConcepto"));
                        tipo.setCodigo(rs.getString("codigoConcepto"));
                        tipo.setDescripcion(rs.getString("descripcionConcepto"));
                        catalogo.setTipoconcepto(tipo);
                        
                        return catalogo;
                    }
                });
		 for (Object catalogo : catalogos) {
			 listCatalogo.add((CatalogoFinanciero)catalogo);
	        }
		
		return listCatalogo;
	}
	
	public List<CatalogoFinanciero> getCatalogoFinanzasByID(Equipo equipo) {
		List<CatalogoFinanciero> listCatalogo = new ArrayList<CatalogoFinanciero>();
		String query = " select con.idConceptosFinancieros, "
						+" con.monto, "
						+" cat.idCatalogoConceptos, "
						+" cat.nombre, "
						+" cat.descripcion, "
						+" tipo.idTipoConcepto, "
						+" tipo.codigoConcepto, "
						+" tipo.descripcionConcepto "
						+" from conceptosfinancieros con "
						+" join catalogoconceptos cat on cat.idCatalogoConceptos = con.CatalogoConceptos_idCatalogoConceptos "
						+" join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto "
						+" where con.DatosFinancieros_Equipos_idEquipo = " + equipo.getId()
						+" and con.DatosFinancieros_idDatosFinancieros =  " + equipo.getDatosFinancieros().getId()
						+" and con.datosfinancieros_tempodada_idTemporada =  " + equipo.getTemporada().getId();
								
		Collection catalogos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        CatalogoFinanciero catalogo = new CatalogoFinanciero();
                        catalogo.setCodigo(rs.getString("nombre"));
                        catalogo.setMonto(rs.getInt("monto"));
                        catalogo.setDescripcion(rs.getString("descripcion"));
                        catalogo.setId(rs.getInt("idCatalogoConceptos"));
                        TipoConcepto tipo = new TipoConcepto();
                        tipo.setId(rs.getInt("idTipoConcepto"));
                        tipo.setCodigo(rs.getString("codigoConcepto"));
                        tipo.setDescripcion(rs.getString("descripcionConcepto"));
                        catalogo.setTipoconcepto(tipo);
                        
                        return catalogo;
                    }
                });
		 for (Object catalogo : catalogos) {
			 listCatalogo.add((CatalogoFinanciero)catalogo);
	        }
		
		return listCatalogo;
	}
	
	

	public void crearFinanzas(Equipo equipo, long idCatalogo, long monto,  int idTemporada) {
		
				String query = "call  createOrUpdateDatosFinancieros(?,?,?,?)";
						
				System.out.println(query+"-"+idCatalogo+"-"+monto+"-"+equipo.getId());
				jdbcTemplate.update(query,
					    idCatalogo,
					    monto,
					    equipo.getId(),
					    idTemporada
					  );
	}

	public void createPresupuesto(Equipo equipo, long monto,long montoFinal,long montoFinalSponsor, int idTemporada) {
		
		
		// idEquipo,idSponsor,montoInicial,montoFinal,
		String query = "call  createOrUpdatePresupuesto(?,?,?,?,?)";
		
		System.out.println("createOrUpdatePresupuesto("+equipo.getId()+",0"
				+","+monto +","+montoFinal+ ")");
		
		jdbcTemplate.update(query,
			    equipo.getId(),
			    monto,
			    montoFinal,
			    montoFinalSponsor,
			    idTemporada
			  );
		
	}

	public void updateObjetivosByIdEquipo(Equipo equipo, String objetivos) {
		// createOrUpdateObjetivos(IN `json` JSON,IN idEquipo INT, IN idSponsor INT,IN idTemporada INT)
				String query = "call  createOrUpdateObjetivos(?,?,?,?)";
				
				System.out.println("createOrUpdatePresupuesto("+objetivos+","+equipo.getId()+""
						+","+equipo.getDatosFinancieros().getSponsor().getId() +","+equipo.getTemporada().getId()+ ")");
				
				jdbcTemplate.update(query,
					    objetivos,
					    equipo.getId(),
					    equipo.getDatosFinancieros().getSponsor().getId(),
					    equipo.getTemporada().getId()
					  );
		
	}
		
	
}
