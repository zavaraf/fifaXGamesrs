package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Component;

import com.app.dao.CatalogoDao;
import com.app.dao.EquipoDao;
import com.app.modelo.Castigo;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.TipoConcepto;
import com.app.modelo.Torneo;
import com.app.utils.MyStoredProcedure;

@Component
public class CatalogoDatoImpl implements CatalogoDao{
	
	@Autowired
    JdbcTemplate jdbcTemplate;
	
	@Autowired
	EquipoDao equipoDao;

	@Override
	public List<CatalogoFinanciero> listAllCatalogs() {
		
			List<CatalogoFinanciero> listCatalogo = new ArrayList<CatalogoFinanciero>();
			
			String query = " select  "
					+" cat.idCatalogoConceptos, "
					+" cat.nombre, "
					+" cat.descripcion, "
					+" tipo.idTipoConcepto, "
					+" tipo.codigoConcepto, "
					+" tipo.descripcionConcepto "
					+" from catalogoconceptos cat  "
					+" join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto  ";
							
									
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
	
	@Override
	public HashMap<String, String> updateCatalogos(String nombre, String desctipcion, int tipo) {
		
		System.out.println("----->createOrUpdateConceptos]:" + nombre);
		String query = "createOrUpdateConceptos";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter nombreVal         = new SqlParameter("codigo", Types.VARCHAR);
		SqlParameter desctipcionVal    = new SqlParameter("descripcion", Types.VARCHAR);
		SqlParameter tipoVal         = new SqlParameter("tipo", Types.INTEGER);
		
		SqlOutParameter isError        = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message        = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { nombreVal, desctipcionVal,tipoVal,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(nombre, desctipcion,tipo);

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}
	
	
	@Override
	public List<Castigo> listAllCastigos(int idTemporada) {
		
			List<Castigo> list = new ArrayList<Castigo>();
			
			String query = " SELECT idcastigos, "
					+"     idEquipo, "
					+"     idTemporada, "
					+"     observaciones, "
					+"     valor, "
					+"     tipo, "
					+ "    nombreTorneo, "
					+ "    torneo_idtorneo "
					+" FROM castigos "
					+ " JOIN torneo  on torneo.idtorneo = castigos.torneo_idtorneo " 					   
					+" where castigos.idTemporada =  " + idTemporada;
							
									
			Collection castigos = jdbcTemplate.query(
	                query
	                , new RowMapper() {

	                    public Object mapRow(ResultSet rs, int arg1)
	                            throws SQLException {
	                       Castigo castigo = new Castigo();
	                       
	                       castigo.setCastigoId(rs.getInt("idcastigos"));
	                       castigo.setIdEquipo(rs.getInt("idEquipo"));
	                       castigo.setIdTemporada(rs.getInt("idTemporada"));
	                       castigo.setCastigo(rs.getString("tipo"));
	                       castigo.setNumero(rs.getInt("valor"));
	                       castigo.setObservaciones(rs.getString("observaciones")) ;
	                       
//	                       castigo.setEquipo(equipoDao.findByIdAll(castigo.getIdEquipo(),idTemporada))  ;
	                       
	                       Torneo torneo = new Torneo();
	                       
	                       torneo.setId(rs.getInt("torneo_idtorneo"));
	                       torneo.setNombre(rs.getString("nombreTorneo"));
	                       
	                       castigo.setTorneo(torneo);
	                        
	                        return castigo;
	                    }
	                });
			 for (Object castigo : castigos) {
				 Castigo cas = (Castigo)castigo;
				 cas.setEquipo(equipoDao.findByIdAll(cas.getIdEquipo(),idTemporada))  ;
				 list.add((Castigo)cas);
		        }
			
			return list;
	
	}
	
	@Override
	public HashMap<String, String> updateCastigos(int id  , 
			                        int idEquipo, 
			                        int idTemporada,
			                        int valor,
			                        String observaciones,
			                        String tipo,
			                        int idTorneo) {
		
		System.out.println("----->call createOrUpdateCastigo("+id+","
				
				+idEquipo+","
				+idTemporada+","
				+valor+",'"
				+observaciones+"', '"
				+tipo+"',"
				+idTorneo+" )");
		String query = "createOrUpdateCastigo" ;

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idVal             = new SqlParameter("id", Types.INTEGER);
		SqlParameter idEquipoVal    = new SqlParameter("idEquipo", Types.INTEGER);
		SqlParameter idTemporadaVal         = new SqlParameter("idTemporada", Types.INTEGER);
		SqlParameter valorVal         = new SqlParameter("valor", Types.INTEGER);
		SqlParameter obserVal         = new SqlParameter("observaciones", Types.VARCHAR);
		SqlParameter tipoVal         = new SqlParameter("tipo", Types.VARCHAR);
		SqlParameter idTorneoVal         = new SqlParameter("idTorneo", Types.INTEGER);
		
		SqlOutParameter isError        = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message        = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idVal, idEquipoVal,idTemporadaVal,valorVal, obserVal,tipoVal,idTorneoVal,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id, idEquipo,idTemporada,valor,observaciones,tipo,idTorneo);

		System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		System.out.println(mapa);

		return mapa;
	}

}
