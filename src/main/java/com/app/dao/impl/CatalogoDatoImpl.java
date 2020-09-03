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
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.TipoConcepto;
import com.app.utils.MyStoredProcedure;

@Component
public class CatalogoDatoImpl implements CatalogoDao{
	
	@Autowired
    JdbcTemplate jdbcTemplate;

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

}
