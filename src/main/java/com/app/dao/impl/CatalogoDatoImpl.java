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

import com.app.dao.CatalogoDao;
import com.app.modelo.CatalogoFinanciero;
import com.app.modelo.TipoConcepto;

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

}
