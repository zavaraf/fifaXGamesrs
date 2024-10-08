package com.app.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Component;

import com.app.dao.TemporadaDao;
import com.app.modelo.DatosJornadas;
import com.app.modelo.Equipo;
import com.app.modelo.EventoPartido;
import com.app.modelo.GolesJornadas;
import com.app.modelo.Grupos;
import com.app.modelo.Jornada;
import com.app.modelo.Jornadas;
import com.app.modelo.ResponseData;
import com.app.modelo.SalonFama;
import com.app.modelo.TablaGeneral;
import com.app.modelo.Temporada;
import com.app.modelo.Torneo;
import com.app.utils.MyStoredProcedure;

@Component
public class TemporadaDaoImpl implements TemporadaDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public List<Temporada> buscarTodos() {
		List<Temporada> temporadaList = new ArrayList<Temporada>();
		String query = "  SELECT idTemporada, " +
					   " NombreTemporada, " +
					   " Descripcion " +
					" FROM  temporada";
		Collection temporada = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Temporada temporada = new Temporada();
                    	temporada.setId(rs.getInt("idTemporada"));
                    	temporada.setNombre(rs.getString("NombreTemporada"));
                    	temporada.setDescripcion(rs.getString("Descripcion"));
                    	return temporada;
                    }
                });
		 for (Object tempo : temporada) {
	            //System.out.println(tempo.toString());
	            Temporada tem = (Temporada)tempo;
	            tem.setTorneos(buscarTodosTorneos(tem.getId()));
	            temporadaList.add( tem);
	        }
	        
		return temporadaList;
	}
	
	public List<Torneo> buscarTodosTorneos(int idTemporada) {
		List<Torneo> torneodaList = new ArrayList<Torneo>();
		String query = "  select idtorneo,nombreTorneo, tipoTorneo_idtipoTorneo " +
					   " from torneo where tempodada_idTemporada = " + idTemporada ;
		Collection temporada = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Torneo torneo = new Torneo();
                    	torneo.setId(rs.getInt("idtorneo"));
                    	torneo.setNombre(rs.getString("nombreTorneo"));
                    	torneo.setTipoTorneo(rs.getInt("tipoTorneo_idtipoTorneo"));
                    	return torneo;
                    }
                });
		 for (Object tempo : temporada) {
	            
	            torneodaList.add( (Torneo)tempo);
	        }
	        
		return torneodaList;
	}
	
	public Torneo getTorneoGeneral(int idTemporada, int idTorneo, int idEquipo) {
		
		actualizaJornadas();
		Torneo torneo = new Torneo();
		
		torneo.setTablaGeneral(getTablaGeneral(idTemporada, idTorneo));
		torneo.setGolesTorneo(getGolesTorneo(idTorneo, 0,idTemporada));
		torneo.setGolesTorneoEquipo(getGolesTorneo(idTorneo, idEquipo,idTemporada));
		torneo.setJornadas(getJornadas(idTemporada, idTorneo, 1));
		torneo.setEventos(getEventosTemporada(idTemporada));
		
		return torneo;
		
	}
	
	public List<TablaGeneral> getTablaGeneral(int idTemporada, int idTorneo) {
		List<TablaGeneral> tablaGeneralList = new ArrayList<TablaGeneral>();
		
		
		String query = "   SELECT   "
				+"   grupos_torneo.nombreGrupo,  "
				+"   tablaGeneral.id,   "
				+"   tablaGeneral.division_idDivision,   "
				+"   tablaGeneral.tempodada_idTemporada,   "
				+"   tablaGeneral.idTorneo,  "
				+"   tablaGeneral.idEquipo,    "
				+"   (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = tablaGeneral.idEquipo and equipos_has_imagen.idTemporada = "+ idTemporada +" )img,  "
				+"   tablaGeneral.nombreEquipo,   "
				+"   tablaGeneral.pj,   "
				+"   tablaGeneral.pg,    "
				+"   tablaGeneral.pe,   "
				+"   tablaGeneral.pp,   "
				+"   tablaGeneral.gf,   "
				+"   tablaGeneral.ge,   "
				+"   tablaGeneral.dif  as dif ,   "
				+"   tablaGeneral.pts as pts "
				+"    "
				+"   from (   "
				+"    "
				+"   SELECT   "
				+"   tablaGeneral.id,   "
				+"   tablaGeneral.division_idDivision,   "
				+"   tablaGeneral.tempodada_idTemporada,   "
				+"   tablaGeneral.idTorneo,  "
				+"   tablaGeneral.idEquipo,    "
				+"   (CASE WHEN equipos_has_temporada.nombreEquipo is null then tablaGeneral.nombreEquipo "
				+"   ELSE equipos_has_temporada.nombreEquipo "
				+"   END) AS NombreEquipo , "
				+"   (sum(tablaGeneral.pg)+sum(tablaGeneral.pe)+sum(tablaGeneral.pp)) as pj,   "
				+"   sum(tablaGeneral.pg) as pg,    "
				+"   sum(tablaGeneral.pe) as pe,   "
				+"   sum(tablaGeneral.pp) as pp,   "
				+"   sum(tablaGeneral.gf) as gf,   "
				+"   sum(tablaGeneral.ge) as ge,   "
				+"   (sum(tablaGeneral.gf) - sum(tablaGeneral.ge) + COALESCE((select sum(valor) ptsMenos from castigos  "
				+"   where castigos.idEquipo = tablaGeneral.idEquipo  "
				+"   and castigos.idTemporada = tablaGeneral.tempodada_idTemporada  "
				+"   and castigos.torneo_idtorneo = tablaGeneral.idTorneo "
				+"   and castigos.tipo = 'goles'),0)) as dif,   "
				+"   ((sum(tablaGeneral.pg) * 3) + sum(tablaGeneral.pe) +COALESCE((select sum(valor) ptsMenos from castigos  "
				+"   where castigos.idEquipo = tablaGeneral.idEquipo  "
				+"   and castigos.idTemporada = tablaGeneral.tempodada_idTemporada  "
				+"   and castigos.torneo_idtorneo = tablaGeneral.idTorneo "
				+"   and castigos.tipo = 'puntos'),0) ) as pts,  "
				+"   (select sum(valor) ptsMenos from castigos  "
				+"   where castigos.idEquipo = tablaGeneral.idEquipo  "
				+"   and castigos.idTemporada = tablaGeneral.tempodada_idTemporada  "
				+"   and castigos.torneo_idtorneo = tablaGeneral.idTorneo "
				+"   and castigos.tipo = 'puntos') as ptsMenos, "
				+"   (select sum(valor) ptsMenos from castigos  "
				+"   where castigos.idEquipo = tablaGeneral.idEquipo  "
				+"   and castigos.idTemporada = tablaGeneral.tempodada_idTemporada  "
				+"   and castigos.torneo_idtorneo = tablaGeneral.idTorneo "
				+"   and castigos.tipo = 'goles') as golesMenos "
				+"    "
				+"   from (   "
				+"    "
				+"   /* PARTIDOS JUGADOS */    "
				+"   (   "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,   "
				+"   torneo.idTorneo,  "
				+"   equipos.idEquipo as idEquipo,    "
				+"   equipos.nombreEquipo,    "
				+"   count(equipos.idEquipo) as pj,   "
				+"   0 as pg,   "
				+"   0 as pp,   "
				+"   0 as pe,   "
				+"   0 as gf,   "
				+"   0 as ge   "
				+"   from jornadas_has_equipos jhe   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada  "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo,   "
				+"   equipos    "
				+"   where (jhe.equipos_idEquipoLocal = equipos.idEquipo   "
				+"   or jhe.equipos_idEquipoVisita = equipos.idEquipo)   "
				+"   and jornadas.activa = 1   "
				+"   and jornadas.tipoJornada = 0   "
				+"    "
				+"   group by torneo.idtorneo,equipos.idEquipo   "
				+"   order by equipos.idEquipo   "
				+"    "
				+"   )   "
				+"    "
				+"   UNION   "
				+"    "
				+"   /* PARTIDOS GANADOS LOCAL*/    "
				+"   (  "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,   "
				+"   torneo.idTorneo,  "
				+"   jhe.equipos_idEquipoVisita as idEquipo,    "
				+"   equipos.nombreEquipo,  "
				+"   0 as pj,   "
				+"   count(jhe.equipos_idEquipoVisita) as pg,   "
				+"   0 as pp,   "
				+"   0 as pe,   "
				+"   sum(jhe.golesVisita) as gf,    "
				+"   sum(jhe.golesLocal) as ge   "
				+"   from jornadas_has_equipos jhe   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada   "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo   "
				+"   join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita   "
				+"   where   "
				+"   jhe.golesVisita> jhe.golesLocal   "
				+"   and jornadas.tipoJornada = 0  "
				+"    "
				+"    "
				+"   group by jhe.equipos_idEquipoVisita, torneo.idtorneo    "
				+"   order by equipos.idEquipo   "
				+"    "
				+"   )  "
				+"   union  "
				+"    "
				+"   /* PARTIDOS GANADOS VISITA */    "
				+"   (  "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,   "
				+"   torneo.idTorneo,  "
				+"   jhe.equipos_idEquipoLocal as idEquipo,    "
				+"   equipos.nombreEquipo,   "
				+"   0 as pj,   "
				+"   count(jhe.equipos_idEquipoLocal) as pg,    "
				+"   0 as pp,   "
				+"   0 as pe,   "
				+"   sum(jhe.golesLocal) as gf,   "
				+"   sum(jhe.golesVisita) as ge   "
				+"    "
				+"   from jornadas_has_equipos jhe   "
				+"   join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada  "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo   "
				+"   where jhe.golesLocal > jhe.golesVisita   "
				+"   and jornadas.tipoJornada = 0   "
				+"    "
				+"   group by jhe.equipos_idEquipoLocal , torneo.idtorneo    "
				+"   order by equipos.idEquipo  "
				+"   )  "
				+"   UNION   "
				+"   /* PARTIDOS EMPATADOS */   "
				+"   (   "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,  "
				+"   torneo.idTorneo,  "
				+"   equipos.idEquipo as idEquipo,   "
				+"   equipos.nombreEquipo,   "
				+"   0 as pj,   "
				+"   0 as pg,   "
				+"   0 as pp,   "
				+"   count(equipos.idEquipo) as pe,   "
				+"   sum(jhe.golesLocal) as gf,    "
				+"   sum(jhe.golesVisita) as ge   "
				+"   from jornadas_has_equipos jhe   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada  "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo ,   "
				+"   equipos   "
				+"    "
				+"   where (equipos.idEquipo = jhe.equipos_idEquipoVisita    "
				+"   or equipos.idEquipo = jhe.equipos_idEquipoLocal)   "
				+"   and   "
				+"   jhe.golesVisita = jhe.golesLocal and jhe.golesLocal is not null   "
				+"   and jornadas.tipoJornada = 0  "
				+"    "
				+"   group by equipos.idEquipo , torneo.idtorneo   "
				+"   order by equipos.idEquipo  "
				+"   )   "
				+"    "
				+"   UNION   "
				+"    "
				+"   (   "
				+"   /* PARTIDOS PERDIDOS LOCAL  */   "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,   "
				+"   torneo.idTorneo,  "
				+"   jhe.equipos_idEquipoLocal as idEquipo,    "
				+"   equipos.nombreEquipo,   "
				+"   0 as pj,   "
				+"   0 as pg,   "
				+"   count(jhe.equipos_idEquipoLocal) as pp,    "
				+"   0 as pe,   "
				+"   sum(jhe.golesLocal) as gf,   "
				+"   sum(jhe.golesVisita) as ge   "
				+"    "
				+"   from jornadas_has_equipos jhe   "
				+"   join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada   "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo  "
				+"   where jhe.golesLocal < jhe.golesVisita   "
				+"   and jornadas.tipoJornada = 0  "
				+"   group by jhe.equipos_idEquipoLocal, torneo.idtorneo    "
				+"   order by equipos.idEquipo   "
				+"   )   "
				+"    "
				+"   UNION   "
				+"   (   "
				+"   /* PARTIDOS PERDIDOS VISITA */   "
				+"    "
				+"   select jhe.id,   "
				+"   jornadas.division_idDivision,   "
				+"   torneo.tempodada_idTemporada,   "
				+"   torneo.idTorneo,  "
				+"   jhe.equipos_idEquipoVisita as idEquipo,    "
				+"   equipos.nombreEquipo,   "
				+"   0 as pj,   "
				+"   0 as pg,   "
				+"   count(jhe.equipos_idEquipoVisita) as pp,   "
				+"   0 as pe,   "
				+"   sum(jhe.golesVisita) as gf  ,    "
				+"   sum(jhe.golesLocal) as ge   "
				+"   from jornadas_has_equipos jhe   "
				+"   join jornadas on jornadas.idJornada = jhe.jornadas_idJornada   "
				+"   join torneo on torneo.idtorneo = jornadas.torneo_idtorneo  "
				+"   join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita   "
				+"   where   "
				+"   jhe.golesVisita < jhe.golesLocal   "
				+"   and jornadas.tipoJornada = 0  "
				+"    "
				+"   group by jhe.equipos_idEquipoVisita, torneo.idtorneo    "
				+"   order by equipos.idEquipo   "
				+"    "
				+"    "
				+"   )   "
				+"   )  "
				+"   as tablaGeneral  "
				+"   join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = tablaGeneral.idEquipo "
				+"   and tablaGeneral.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada "
				+"    "
				+"   where tablaGeneral.idTorneo =   " + idTorneo
				+"   and   tablaGeneral.tempodada_idTemporada =  " + idTemporada
				+"   group by tablaGeneral.idEquipo  "
				+"    "
				+"   ) tablaGeneral   "
				+"   join grupos_torneo on (grupos_torneo.equipos_idEquipo = tablaGeneral.idEquipo  "
				+"   and grupos_torneo.torneo_idtorneo = tablaGeneral.idTorneo)  "
				+"    "
				+"    "
				+"    "
				+"   group by grupos_torneo.nombreGrupo, tablaGeneral.idEquipo  "
				+"   order by grupos_torneo.nombreGrupo, tablaGeneral.pts desc,        "
				+"    "
				+"   tablaGeneral.dif desc ";
		
		
		Collection tablaGeneral = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	TablaGeneral tablaG = new TablaGeneral();
                    	
                    	tablaG.setIdEquipo(rs.getInt("idEquipo"));
                    	tablaG.setNombreEquipo(rs.getString("nombreEquipo"));
                    	tablaG.setPj(rs.getInt("pj"));
                    	tablaG.setPg(rs.getInt("pg"));
                    	tablaG.setPe(rs.getInt("pe"));
                    	tablaG.setPp(rs.getInt("pp"));
                    	tablaG.setGf(rs.getInt("gf"));
                    	tablaG.setGe(rs.getInt("ge"));
                    	tablaG.setDif(rs.getInt("dif"));
                    	tablaG.setPts(rs.getInt("pts"));
                    	tablaG.setImg(rs.getString("img"));
                    	tablaG.setNombreGrupo(rs.getString("nombreGrupo"));
                    	
                    	
                    	
                    	return tablaG;
                    }
                });
		 for (Object tablaG : tablaGeneral) {
	           
	            tablaGeneralList.add( (TablaGeneral)tablaG);
	        }
	        
		return tablaGeneralList;
	}
	
	public List<EventoPartido> getEventosTemporada(int idTemporada) {
		List<EventoPartido> eventosList = new ArrayList<EventoPartido>();
		
		String query =" select datosjornadas.id, "
				+" datosjornadas.equipos_idequipo, "
				+" equipos_has_temporada.nombreEquipo , "
				+" equipos_has_imagen.imagen, "
				+" datosjornadas.activa, "
				+" datosjornadas.updatedate, "
				+" datosjornadas.tipodatojornada_id, "
				+" datosjornadas.persona_idpersona, "
				+" persona.sobrenombre, "
				+" jornadas.numeroJornada, "
				+" torneo.nombreTorneo "
				+" from datosjornadas "
				+" join jornadas on jornadas.idJornada = datosjornadas.jornadas_has_equipos_jornadas_idjornada "
				+" join torneo on torneo.idtorneo = jornadas.torneo_idtorneo "
				+" join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = datosjornadas.equipos_idequipo and torneo.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada "
				+" join persona on persona.idPersona = datosjornadas.persona_idpersona "
				+" join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = datosjornadas.equipos_idequipo and equipos_has_imagen.idTemporada = torneo.tempodada_idTemporada "
				+" where  "
				+" equipos_has_imagen.tipoImagen_idTipoImagen = 1 and "
				+" torneo.tempodada_idTemporada =  " + idTemporada;
		
		
		Collection eventos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	EventoPartido evento = new EventoPartido();
                    	Equipo equipo = new Equipo();
                    	
                    	equipo.setId(rs.getInt("equipos_idequipo"));
                    	equipo.setNombre(rs.getString("nombreEquipo"));
                    	equipo.setImg(rs.getString("imagen"));
                    	
                    	evento.setEquipo(equipo);
                    	
                    	evento.setIdEvento(rs.getInt("id"));
                    	evento.setFecha(rs.getString("updatedate"));
                    	evento.setTipo(rs.getInt("tipodatojornada_id"));
                    	evento.setActiva(rs.getInt("activa"));
                    	evento.setJornada(rs.getInt("numeroJornada"));
                    	evento.setNombreTorneo(rs.getString("nombreTorneo"));
                    	evento.setSobrenombre(rs.getString("sobrenombre"));
                    	
                    	
                    	return evento;
                    }
                });
		 for (Object evento : eventos) {
	           
			 eventosList.add( (EventoPartido)evento);
	        }
	        
		return eventosList;
	}
	
	public List<GolesJornadas> getGolesTorneo(int idTorneo, int idEquipo,int idTemporada) {
		List<GolesJornadas> golesList = new ArrayList<GolesJornadas>();
		String aux = " and persona_has_temporada.Equipos_idEquipo = " + idEquipo;
		String query =" select count(persona.idPersona) goles, "
				+" persona.idPersona,"
				+" persona.NombreCompleto, "
				+" persona.sobrenombre, "
				+" equipos.idEquipo,"
				+" equipos.nombreEquipo,"
				+" jornadas.torneo_idtorneo,"
				+" ehi.imagen"
				+" from golesjornadas"
				+" join jornadas on jornadas.idJornada = golesjornadas.jornadas_has_equipos_jornadas_idJornada"
				+" join persona_has_temporada on persona_has_temporada.persona_idPersona = golesjornadas.persona_idPersona "
				+" join persona on persona.idPersona = persona_has_temporada.persona_idPersona "
				+" join equipos on equipos.idEquipo = persona_has_temporada.Equipos_idEquipo "
				+" left join equipos_has_imagen ehi on equipos.idEquipo = ehi.equipos_idEquipo "
				+ "      and persona_has_temporada.temporada_idTemporada = ehi.idTemporada"
				+" where jornadas.torneo_idtorneo = " + idTorneo
				+" and golesjornadas.isautogol = 0 " + ( idEquipo != 0 ? aux : "")
				+" and ehi.tipoImagen_idTipoImagen = 1"
				+" and persona_has_temporada.temporada_idTemporada =  "+ idTemporada
				+" group by persona.idPersona,jornadas.torneo_idtorneo"
				+" order by jornadas.torneo_idtorneo, goles  desc"
				+" limit 10";
		Collection goles = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	GolesJornadas goles = new GolesJornadas();
                    	goles.setIdEquipo(rs.getInt("idEquipo"));
                    	goles.setIdPersona(rs.getInt("idPersona"));
                    	goles.setNombreCompleto(rs.getString("NombreCompleto"));
                    	goles.setNombreEquipo(rs.getString("nombreEquipo"));
                    	goles.setSobrenombre(rs.getString("sobrenombre"));
                    	goles.setGoles(rs.getInt("goles"));
                    	goles.setImg(rs.getString("imagen"));
                    	return goles;
                    }
                });
		 for (Object gol : goles) {
	           
	            golesList.add( (GolesJornadas)gol);
	        }
	        
		return golesList;
	}
	
	public List<Jornadas> getJornadas(int idTemporada, int idTorneo,int activa) {
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		String queryAddActiva = "";
		if (activa == 1){
			queryAddActiva = "  and jornadas.activa = 1 ";
		}
		String query =" select tabla.idJornada, tabla.id, tabla.numeroJornada, "
					+" tabla.equipos_idEquipoLocal, "
					+" tabla.activa, "
					+" tabla.cerrada, "
					+" tabla.nombreJornada,"
					+" tabla.tipoJornada,"
					+" (select case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end "
					+"  from equipos  "
					+"  join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = equipos.idEquipo "
					+"  where equipos.idEquipo =  tabla.equipos_idEquipoLocal " 
					+"  and equipos_has_temporada.tempodada_idTemporada = "+ idTemporada+" ) equipoLocal, "
					+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 "
					+ " and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoLocal "
					+ " and equipos_has_imagen.idTemporada = "+ idTemporada +" "
					+ " ) imgLocal, "
					+" tabla.golesLocal, "
					+" tabla.golesVisita, "
					+" tabla.fechaInicio,"
					+" tabla.fechaFin,"
					+" (select case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end "
					+"  from equipos  "
					+"  join equipos_has_temporada on equipos_has_temporada.Equipos_idEquipo = equipos.idEquipo "
					+"  where equipos.idEquipo =  tabla.equipos_idEquipoVisita " 
					+"  and equipos_has_temporada.tempodada_idTemporada =  "+ idTemporada +") equipoVisita, "
					+" (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoVisita and equipos_has_imagen.idTemporada = "+ idTemporada +"  ) imgVisita, "
					+" tabla.equipos_idEquipoVisita "
					+" "
					+" from ( "
					+" "
					+" select jornadas.idJornada, "
					+" je.id, jornadas.numeroJornada,"
					+" jornadas.nombreJornada,"
					+" jornadas.tipoJornada,"
					+" jornadas.activa,"
					+" jornadas.cerrada,"
					+" je.equipos_idEquipoLocal, "
					+" je.golesLocal, "
					+" je.golesVisita, "
					+" je.equipos_idEquipoVisita,"
					+" jornadas.fechaInicio,"
					+" jornadas.fechaFin"
					+" from jornadas "
					+" join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada "
					+" join torneo on torneo.idtorneo = jornadas.torneo_idtorneo "
					+" where tempodada_idTemporada = " + idTemporada
					+" and  jornadas.torneo_idtorneo = " + idTorneo
					+" " + queryAddActiva
					+" ) tabla order by tabla.idJornada asc "

;
		Collection jornadas = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Jornada jornada = new Jornada();
                    	jornada.setId(rs.getInt("id"));
                    	jornada.setIdJornada(rs.getInt("idJornada"));
                    	jornada.setIdEquipoLocal(rs.getInt("equipos_idEquipoLocal"));
                    	jornada.setNombreEquipoLocal(rs.getString("equipoLocal"));
                    	jornada.setIdEquipoVisita(rs.getInt("equipos_idEquipoVisita"));
                    	jornada.setNombreEquipoVisita(rs.getString("equipoVisita"));
                    	jornada.setNumeroJornada(rs.getInt("numeroJornada"));
                    	jornada.setActiva(rs.getInt("activa"));
                    	jornada.setCerrada(rs.getInt("cerrada"));
                    	jornada.setImgLocal(rs.getString("imgLocal"));
                    	jornada.setImgVisita(rs.getString("imgVisita"));
                    	jornada.setTipoJornada(rs.getInt("tipoJornada"));
                    	jornada.setNombreJornada(rs.getString("nombreJornada"));
                    	try{
                    	
                    	jornada.setGolesLocal(Integer.parseInt(rs.getString("golesLocal")));
                    	jornada.setGolesVisita(Integer.parseInt(rs.getString("golesVisita")));
                    	}catch(Exception e){
                    		                    		
                    	}
                    	jornada.setFechaInicio(rs.getTimestamp("fechaInicio"));
                    	jornada.setFechaFin(rs.getTimestamp("fechaFin"));
                    	
                    	return jornada;
                    }
                });
		List<Jornada> ListJornada = new ArrayList<Jornada>();
		 for (Object jornada : jornadas) {
			 ListJornada.add( (Jornada)jornada);		 
	        }
		 
		HashMap<Integer,Integer> mapJornadas = getMapaJornadas(ListJornada);
	
		
		for (Map.Entry<Integer, Integer> entry : mapJornadas.entrySet()) {
			Jornadas jorn = new Jornadas();
		    List<Jornada> juegos = getJuegos(ListJornada, entry.getKey());
		    //System.out.println("idJornada=" + entry.getKey() + ", NumeroJornada=" + entry.getValue() + " Fechas: "+juegos.get(0).getFechaInicio()+ " - "+juegos.get(0).getFechaFin());
		    DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    if(juegos.size()>0){
		    	
		    	jorn.setActiva(juegos.get(0).getActiva());
		    	jorn.setCerrada(juegos.get(0).getCerrada());
		    	jorn.setIdJornda(juegos.get(0).getIdJornada());
		    	jorn.setNumeroJornada(juegos.get(0).getNumeroJornada());
		    	jorn.setTipoJornada(juegos.get(0).getTipoJornada());
		    	jorn.setNombreJornada(juegos.get(0).getNombreJornada());
		    	try {
					jorn.setFechaInicio(juegos.get(0).getFechaInicio() != null ? juegos.get(0).getFechaInicio() : null);
					jorn.setFechaFin(juegos.get(0).getFechaFin()!= null ? juegos.get(0).getFechaFin(): null);
					jorn.setFechaInicioString(juegos.get(0).getFechaInicio() != null ? sdf.format(juegos.get(0).getFechaInicio()) : null);
					jorn.setFechaFinString(juegos.get(0).getFechaFin()!= null ? sdf.format(juegos.get(0).getFechaFin()): null);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		    	jorn.setJornada(juegos);
		    	
		    	
		    	jornadasList.add(jorn);
		    }
		    
		    
		}
		 
	        
		return jornadasList;
	}
	
	public List<Jornada> getJuegos(List<Jornada> juegos,int idJornada){
		List<Jornada> juegosJornada = new ArrayList<Jornada>();
		
		for(Jornada ju : juegos){
			if(ju.getIdJornada() == idJornada){
				juegosJornada.add(ju);
			}
		}
		
		
		return juegosJornada;
	}
	public HashMap<Integer,Integer> getMapaJornadas(List<Jornada> juegos){
		HashMap<Integer,Integer> jornadas = new HashMap<Integer,Integer>();
		
		try{
			for(Jornada jor : juegos){
				jornadas.put(jor.getIdJornada(), jor.getNumeroJornada());
			}
		}catch(Exception e){}
		
		return jornadas;
	}
	
	public List<Jornadas> getArmarJornadasInicial(int idTemporada, int idDivision) {
		List<Jornadas> jornadasList = new ArrayList<Jornadas>();
		
		return jornadasList;
	}
	
	
	
	
	
	public List<GolesJornadas> getGolesJornadas(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita) {
		List<GolesJornadas> golesList = new ArrayList<GolesJornadas>();
		String query ="  select equipos.idEquipo,golesjornadas.id, " +
				"  equipos.nombreEquipo, " +
				"  persona.idPersona, " +
				"  persona.sobrenombre, " +
				"  persona.NombreCompleto, " +
				"  golesjornadas.isautogol " +
				"  from golesjornadas " +
				"  join persona on persona.idPersona = golesjornadas.persona_idPersona " +
				"  join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo " +
				"  where golesjornadas.jornadas_has_equipos_jornadas_idJornada =  "+ idJornada +
				"  and golesjornadas.jornadas_has_equipos_id = "+ id +
				"  and equipos.idEquipo in ( "+ idEquipoLocal+","+idEquipoVisita+")";
		Collection goles = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	GolesJornadas goles = new GolesJornadas();
                    	goles.setId(rs.getInt("id"));
                    	goles.setIdEquipo(rs.getInt("idEquipo"));
                    	goles.setIdPersona(rs.getInt("idPersona"));
                    	goles.setNombreCompleto(rs.getString("NombreCompleto"));
                    	goles.setNombreEquipo(rs.getString("nombreEquipo"));
                    	goles.setSobrenombre(rs.getString("sobrenombre"));
                    	goles.setIsAutogol(rs.getInt("isautogol"));
                    	return goles;
                    }
                });
		 for (Object gol : goles) {
	           
	            golesList.add( (GolesJornadas)gol);
	        }
	        
		return golesList;
	}
	
	public List<DatosJornadas> getDatosJornadas(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita,
			int tipoDato) {
		
		String datos = " and datosjornadas.tipoDatoJornada_id =  " + tipoDato;
		
		if(tipoDato == 1 || tipoDato == 3) {
			datos = " and datosjornadas.tipoDatoJornada_id in ( 1,3)" ;
		}
		List<DatosJornadas> golesList = new ArrayList<DatosJornadas>();
		String query ="  select equipos.idEquipo,datosjornadas.id, " +
				"  equipos.nombreEquipo, " +
				"  persona.idPersona, " +
				"  persona.sobrenombre, " +
				"  persona.NombreCompleto, " +
				"  datosjornadas.activa, " +
				"  datosjornadas.tipoDatoJornada_id " +
				"  from datosjornadas " +
				"  join persona on persona.idPersona = datosjornadas.persona_idPersona " +
				"  join equipos on equipos.idEquipo = datosjornadas.equipos_idEquipo " +
				"  where datosjornadas.jornadas_has_equipos_jornadas_idJornada =  "+ idJornada +
				"  and datosjornadas.jornadas_has_equipos_id = "+ id +
				"  and equipos.idEquipo in ( "+ idEquipoLocal+","+idEquipoVisita+") "
				+ datos;
		
		
		Collection goles = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	DatosJornadas goles = new DatosJornadas();
                    	goles.setId(rs.getInt("id"));
                    	goles.setIdEquipo(rs.getInt("idEquipo"));
                    	goles.setIdPersona(rs.getInt("idPersona"));
                    	goles.setNombreCompleto(rs.getString("NombreCompleto"));
                    	goles.setNombreEquipo(rs.getString("nombreEquipo"));
                    	goles.setSobrenombre(rs.getString("sobrenombre"));
                    	goles.setActivo(rs.getInt("activa"));
                    	goles.setTipo(rs.getInt("tipoDatoJornada_id"));
                    	return goles;
                    }
                });
		 for (Object gol : goles) {
	           
	            golesList.add( (DatosJornadas)gol);
	        }
	        
		return golesList;
	}
	
	public List<DatosJornadas> getDatosJornadaEquipos(String idJornada,String id,
			String idEquipoLocal,
			String idEquipoVisita,
			int idTemporada
			) {
		List<DatosJornadas> golesList = new ArrayList<DatosJornadas>();
		String query ="  select *   "
				+"  from (  "
				+"  select count(datosjornadas.persona_idPersona) as cuantos,   "
				+"  equipos.Equipos_idEquipo,datosjornadas.id,  "
				+"  equipos.nombreEquipo,  "
				+"  persona.idPersona,  "
				+"  persona.sobrenombre,  "
				+"  persona.NombreCompleto,  "
				+"  datosjornadas.activa,  "
				+"  equipos_has_imagen.imagen,  "
				+"  datosjornadas.tipoDatoJornada_id  "
				+"  from datosjornadas  "
				+"  join persona on persona.idPersona = datosjornadas.persona_idPersona  "
				+"  join equipos_has_temporada equipos on equipos.Equipos_idEquipo = datosjornadas.equipos_idEquipo  "
				+"  join jornadas on jornadas.idJornada = datosjornadas.jornadas_has_equipos_jornadas_idJornada  "
				+"  join torneo on torneo.idtorneo = jornadas.torneo_idtorneo  "
				+"  join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = equipos.Equipos_idEquipo  "
				+"  where  "
				+"  equipos.Equipos_idEquipo in  ( "+ idEquipoLocal+","+idEquipoVisita+")  "
				+"  and datosjornadas.activa = 1  "
				+"  and torneo.tempodada_idTemporada = " +idTemporada
				+"  and equipos.tempodada_idTemporada = " +idTemporada
				+"  and equipos_has_imagen.idTemporada =  " +idTemporada
				+"  and equipos_has_imagen.tipoImagen_idTipoImagen = 2   "
				+"  group by datosjornadas.persona_idPersona , datosjornadas.tipoDatoJornada_id  "
				+"  ) datos  "
				+"  where   "
				+"  datos.tipoDatoJornada_id in(1,2) or (datos.tipoDatoJornada_id = 3 and datos.cuantos >1)  " ;
		
		
//		//System.out.println(query);
		Collection goles = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	DatosJornadas goles = new DatosJornadas();
                    	goles.setId(rs.getInt("id"));
                    	goles.setIdEquipo(rs.getInt("Equipos_idEquipo"));
                    	goles.setIdPersona(rs.getInt("idPersona"));
                    	goles.setNombreCompleto(rs.getString("NombreCompleto"));
                    	goles.setNombreEquipo(rs.getString("nombreEquipo"));
                    	goles.setSobrenombre(rs.getString("sobrenombre"));
                    	goles.setActivo(rs.getInt("activa"));
                    	goles.setImg(rs.getString("imagen"));
                    	goles.setTipo(rs.getInt("tipoDatoJornada_id"));
                    	return goles  ;
                    }
                });
		 for (Object gol : goles) {
	           
	            golesList.add( (DatosJornadas)gol);
	        }
	        
		return golesList;
	}
	
	public Jornada getJornada(String idJornada,String id,	String idEquipoLocal,	String idEquipoVisita, int idTemporada){
		
		//System.out.println("idTemporada]:"+idTemporada);
	Jornada jornada = new Jornada();
	String query ="  select tabla.idJornada, tabla.id, tabla.numeroJornada, tabla.cerrada,"
				+"  tabla.equipos_idEquipoLocal, "
				+"  (select equipos_has_temporada.nombreEquipo from equipos_has_temporada where equipos_has_temporada.Equipos_idEquipo = tabla.equipos_idEquipoLocal and  tempodada_idTemporada = "+ idTemporada +" ) equipoLocal, "
				+"  tabla.golesLocal, "
				+"  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal, " 
				+"  (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=1 and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoLocal and equipos_has_imagen.idTemporada = "+ idTemporada +" ) imgLocal, "
				+"  tabla.golesLocal, "
				+"  tabla.golesVisita, "
				+"   "
				+"  (select equipos_has_temporada.nombreEquipo from equipos_has_temporada where equipos_has_temporada.Equipos_idEquipo = tabla.equipos_idEquipoVisita and  tempodada_idTemporada = "+ idTemporada +" ) equipoVisita, "
				+"  (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=1 and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoVisita and equipos_has_imagen.idTemporada = "+ idTemporada +" ) imgVisita, "
				+"  tabla.equipos_idEquipoVisita, "
				+"  tabla.username, "
				+"  tabla.updateDate "
				+"   "
				+"  from ( "
				+"   "
				+"  select jornadas.idJornada, je.id, jornadas.numeroJornada, jornadas.cerrada,"
				+"  je.equipos_idEquipoLocal, "
				+"  je.golesLocal, "
				+"  je.golesVisita, "
				+"  je.equipos_idEquipoVisita, "
				+"  je.username, "
				+"  je.updateDate "
				+"  from jornadas "
				+"  join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada "
				+"  ) tabla "
				+"  where tabla.idJornada = "+idJornada+" and tabla.id = "+id
				+ " order by tabla.idJornada asc "

;
	
	//System.out.println(query);
	Collection jornadas = jdbcTemplate.query(
            query
            , new RowMapper() {

                public Object mapRow(ResultSet rs, int arg1)
                        throws SQLException {
                    
                	Jornada jornada = new Jornada();
                	jornada.setId(rs.getInt("id"));
                	jornada.setIdJornada(rs.getInt("idJornada"));
                	jornada.setIdEquipoLocal(rs.getInt("equipos_idEquipoLocal"));
                	jornada.setNombreEquipoLocal(rs.getString("equipoLocal"));
                	jornada.setIdEquipoVisita(rs.getInt("equipos_idEquipoVisita"));
                	jornada.setNombreEquipoVisita(rs.getString("equipoVisita"));
                	jornada.setNumeroJornada(rs.getInt("numeroJornada"));
                	jornada.setCerrada(rs.getInt("cerrada"));
                	jornada.setImgLocal(rs.getString("imgLocal"));
                	jornada.setImgVisita(rs.getString("imgVisita"));
                	jornada.setUsername(rs.getString("username"));
                	jornada.setDate(rs.getString("updateDate"));
                	//System.out.println(rs.getString("updateDate"));
                	
                	try{
                	jornada.setGolesLocal(Integer.parseInt(rs.getString("golesLocal")));
                	jornada.setGolesVisita(Integer.parseInt(rs.getString("golesVisita")));
                	}catch(Exception e){
                		                    		
                	}
                	
                	return jornada;
                }
            });
	
	 for (Object jor : jornadas) {
		 jornada =  (Jornada)jor;		 
        }
	 
	        
		return jornada;
	}
	
	public List<String> getImagenes(String idJornada,String id){
		
		List<String> imagenesList = new ArrayList<String>();
		String query = "  	select imgJornada " 
					+" from imagenesjornadas "
					+" where imagenesjornadas.jornadas_has_equipos_id = "+ id
					+" and imagenesjornadas.jornadas_has_equipos_jornadas_idJornada =  "+ idJornada;

	
		Collection imagenes = jdbcTemplate.query(
	            query
	            , new RowMapper() {

	                public Object mapRow(ResultSet rs, int arg1)
	                        throws SQLException {
	                    
	                	String imggen = rs.getString("imgJornada");
	                	
	                	
	                	return imggen;
	                }
	            });
		
		 for (Object img : imagenes) {
			 imagenesList.add(img.toString());		 
	        }
		 
		        
			return imagenesList;
		}
	
	@Override
	public HashMap<String, String> addGol(int idJugador,int idEquipo,int id,int idJornada) {

		//System.out.println("----->addGoles]:" + idJugador+",idEqupo]:"+idEquipo+",id]:"+id+",idJonada]:"+idJornada);
		String query = "addGoles";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJornadaVar = new SqlParameter("idJornada", Types.VARCHAR);
		SqlParameter idJornadaID = new SqlParameter("id", Types.VARCHAR);
		SqlParameter idJugadorVar = new SqlParameter("idJugador", Types.INTEGER);
		SqlParameter idEquipoVar = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJornadaVar, idJornadaID,idJugadorVar,idEquipoVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(idJornada, id, idJugador, idEquipo);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	
	public HashMap<String, String> addResultJornada(int idTorneo,int idTemporada,String jornada, String username) {

//		Tipo 1 - Roja, 2, lesion, 3 amarilla
		//System.out.println("----->registrarJornada]:" + idTorneo+",idEqupo]:"+idTemporada+",id]:"+idTemporada+",user]:"+ username);
		String query = "registrarJornada";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter jsonVar = new SqlParameter("json", Types.VARCHAR);
		SqlParameter nombreTorneoID = new SqlParameter("nombreTorneo", Types.VARCHAR);
		SqlParameter idTemporadaVar = new SqlParameter("idTemporada", Types.INTEGER);
		SqlParameter usernameVar = new SqlParameter("username", Types.VARCHAR);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { jsonVar, nombreTorneoID,idTemporadaVar,usernameVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure  
		Map storedProcResult = myStoredProcedure.execute(jornada, "nombre", idTemporada,username);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	
	@Override
	public HashMap<String, String> addImagen(int idEquipo,int id,int idJornada,String img) {

		//System.out.println("----->addImagen]:" + img+",idEqupo]:"+idEquipo+",id]:"+id+",idJonada]:"+idJornada);
		String query = "addImagen";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter idJornadaVar = new SqlParameter("idJornada", Types.VARCHAR);
		SqlParameter idJornadaID = new SqlParameter("id", Types.VARCHAR);
		SqlParameter idEquipoVar = new SqlParameter("idEquipo", Types.VARCHAR);
		SqlParameter imgVar = new SqlParameter("img", Types.VARCHAR);
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJornadaVar,idJornadaID,idEquipoVar,imgVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(idJornada, id,  idEquipo,img);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}

	@Override
	public HashMap<String, String> addJornada(int idTemporada, int idDivision, Jornada juego,int activa,int cerrada,Date fechaIni,Date fechaFin) {
		//System.out.println("----->equipoLocal]:" + juego.getIdEquipoLocal()+","
//				+ "equipoVisita]:"+juego.getIdEquipoVisita()+
//				",numJornada]:"+juego.getId()+",temporada]:"+idDivision+",division]:"+idDivision+
//				",liga]:1"+",activa]:"+juego.getActiva()+",id]:"+juego.getId()+",fechaIFin]:"+fechaFin);
		String query = "crearJornada";
		

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter equipoLocal    = new SqlParameter("equipoLocal", Types.INTEGER);
		SqlParameter equipoVisita    = new SqlParameter("equipoVisita", Types.INTEGER);
		SqlParameter numJornada      = new SqlParameter("numJornada", Types.INTEGER);
		SqlParameter torneo          = new SqlParameter("torneo", Types.INTEGER);
		SqlParameter division        = new SqlParameter("division", Types.INTEGER);
		SqlParameter liga            = new SqlParameter("liga", Types.INTEGER);
		SqlParameter activaV          = new SqlParameter("activa", Types.INTEGER);
		SqlParameter cerradaV          = new SqlParameter("cerrada", Types.INTEGER);
		SqlParameter id          = new SqlParameter("id", Types.INTEGER);
		SqlParameter fechaIniV          = new SqlParameter("fechaIni", Types.TIMESTAMP);
		SqlParameter fechaFinV          = new SqlParameter("fechaFin", Types.TIMESTAMP);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { equipoLocal,equipoVisita,numJornada,
				torneo,division,liga,activaV,cerradaV,id,fechaIniV,fechaFinV,isError ,message};

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(juego.getIdEquipoLocal(),juego.getIdEquipoVisita(),
				juego.getNumeroJornada(),idDivision,idDivision,1,activa,cerrada,juego.getId(),fechaIni,fechaFin);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	
	
	@Override
	public HashMap<String, String> addJornadasGrupos(int idTemporada, String nombre , String grupos, int idCat) {
		//System.out.println("----->createOrTorneoGrupos]:" + idTemporada+ " nombre]:"+ nombre +" grupos]:"+grupos+" idCat]:"+ idCat);
		String query = "createOrTorneoGrupos";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter json            = new SqlParameter("json", Types.CLOB);
		SqlParameter nombreTorneo    = new SqlParameter("nombreTorneo", Types.VARCHAR);
		SqlParameter idTemporadaV     = new SqlParameter("idTemporada", Types.INTEGER);
		SqlParameter idCatV           = new SqlParameter("idCat", Types.INTEGER);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { json,nombreTorneo,idTemporadaV,idCatV,isError ,message};

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(grupos,nombre,idTemporada,idCat);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	@Override
	public HashMap<String, String> crearTorneo(int idTemporada, String nombre ) {
		//System.out.println("----->crearTorneo]:" + idTemporada+ " nombre]:"+ nombre );
		String query = "crearTorneo";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		
		SqlParameter nombreTorneo    = new SqlParameter("nombreTorneo", Types.VARCHAR);
		SqlParameter idTemporadaV      = new SqlParameter("idTemporada", Types.INTEGER);
		SqlParameter tipoTorneo      = new SqlParameter("tipoTorneo", Types.INTEGER);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { nombreTorneo,idTemporadaV,tipoTorneo,isError ,message};

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(nombre,idTemporada,1);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	
	public List<Grupos> getGruposTorneo(int idTemporada, int idTorneo){
		
		//System.out.println("Consultando Grupos Torneo]"+idTemporada+" idTorneo]:"+idTorneo);
		
		List<Grupos> gruposList = new ArrayList<Grupos>();		
		
		String query =" select distinct nombreGrupo  "
				+" from grupos_torneo "
				+" join torneo on torneo.idtorneo = grupos_torneo.torneo_idtorneo "
				+" where grupos_torneo.torneo_idtorneo = " + idTorneo
				+" and torneo.tempodada_idTemporada =  " + idTemporada 
				+" order by nombreGrupo ";
		
		
	Collection grupos = jdbcTemplate.query(
            query
            , new RowMapper() {

                public Object mapRow(ResultSet rs, int arg1)
                        throws SQLException {
                    
                	Grupos grupo = new Grupos();
                	
                	grupo.setNumero(rs.getInt("nombreGrupo"));
                	
                	return grupo;
                }
            });
	
	 for (Object gru : grupos) {
		 Grupos grup = new Grupos();
		  
		  
		  grup = (Grupos)gru;
		  
		  grup.setEquipos(getEquiposByGrupo(grup.getNumero(),idTorneo,idTemporada));
		  
		  gruposList.add(grup);
		  
        }
		
	 return gruposList;
			 
	}
	
	public List<Equipo> getEquiposByGrupo( int idGrupo, int idTorneo, int idTemporada){
		
		List<Equipo> equiposList = new ArrayList<Equipo>();		
		
		String query =" select idEquipo, "
					+ " equipos_has_temporada.nombreEquipo, "
					+ " equipos_has_temporada.nombreEquipo as descripcionEquipo, "
					+ " equipos_has_imagen.imagen "
					+ " from equipos "
					+ " join grupos_torneo on grupos_torneo.equipos_idEquipo = equipos.idEquipo "
					+ " join equipos_has_imagen on equipos.idEquipo = equipos_has_imagen.equipos_idEquipo  "
					+ " join equipos_has_temporada on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo and equipos_has_imagen.idTemporada = equipos_has_temporada.tempodada_idTemporada "
					+ " where grupos_torneo.nombreGrupo =  "+ idGrupo
					+ " and grupos_torneo.torneo_idtorneo =  "+ idTorneo
					+ " and equipos_has_imagen.idTemporada = "+ idTemporada 
					+ " and equipos_has_imagen.tipoImagen_idTipoImagen = 1 ";
							
		
	Collection equipos = jdbcTemplate.query(
            query
            , new RowMapper() {

                public Object mapRow(ResultSet rs, int arg1)
                        throws SQLException {
                    
                	Equipo equipo = new Equipo();
                	
                	equipo.setId(rs.getInt("idEquipo"));
                	equipo.setNombre(rs.getString("nombreEquipo"));
                	equipo.setImg(rs.getString("imagen"));
                	
                	return equipo;
                }
            });
	
	 for (Object equ : equipos) {
		 Equipo equipo = new Equipo();
		  equipo = (Equipo)equ;
		  equiposList.add(equipo);
		 
        }
	 
	 return equiposList;
		
	}
	
	public HashMap<String, String> addJuegosLiguilla(int idTemporada,int idTorneo,String json) {

		//System.out.println("----->crearJornadasFinales]:" + idTorneo+",idTemporada]:"+idTemporada+",jornadas]:"+json);
		String query = "crearJornadasFinales";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlParameter jsonVar = new SqlParameter("json", Types.VARCHAR);
		SqlParameter idTorneoVar = new SqlParameter("idTorneo", Types.INTEGER);
		SqlParameter idTemporadaVar = new SqlParameter("idTemporada", Types.INTEGER);
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { jsonVar, idTorneoVar,idTemporadaVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(json, idTorneo, idTemporada);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}

	@Override
	public List<SalonFama> getSalonFama(boolean detalle) {
	List<SalonFama> eventosList = new ArrayList<SalonFama>();
		
		String query ="  SELECT cat_salon_fama.id,"
				+"      cat_salon_fama.username,"
				+"      cat_salon_fama.nombreEquipo,"
				+"      cat_salon_fama.img,"
				+"      cat_salon_fama.idtorneo,"
				+"      cat_salon_fama.idtemporada,"
				+"      cat_salon_fama.campeon,"
				+"      cat_salon_fama.idequipo,"
				+"      cat_salon_fama.idcat_torneo,"
				+"      cat_salon_fama.nombretorneo,"
				+"      cat_salon_fama.nombretemporada,"
				+"      cat_salon_fama.img_torneo,"
				+"      count(cat_salon_fama.idcat_torneo) totalxTorneo,    "
				+"      (select count(ca.username) from cat_salon_fama as ca where ca.username = cat_salon_fama.username ) total"
				+"  FROM cat_salon_fama "
				+ " where cat_salon_fama.campeon = 1"
				+"  group by cat_salon_fama.idcat_torneo, cat_salon_fama.username"
				+"  order by  total desc;";
		
		if(detalle == true){
			query ="  SELECT cat_salon_fama.id,"
					+"      cat_salon_fama.username,"
					+"      cat_salon_fama.nombreEquipo,"
					+"      cat_salon_fama.img,"
					+"      cat_salon_fama.idtorneo,"
					+"      cat_salon_fama.idtemporada,"
					+"      cat_salon_fama.campeon,"
					+"      cat_salon_fama.idequipo,"
					+"      cat_salon_fama.idcat_torneo,"
					+"      cat_salon_fama.nombretorneo,"
					+"      cat_salon_fama.nombretemporada,"
					+"      cat_salon_fama.img_torneo,"
					+"      0 totalxTorneo,  "
					+"      (select count(ca.username) from cat_salon_fama as ca where ca.username = cat_salon_fama.username ) total"
					+"  FROM cat_salon_fama"					
					+"  order by  total desc;";
			
		}
		
		
		Collection eventos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	SalonFama salon = new SalonFama();
                    	
                    	salon.setUsuario(rs.getString("username"));
                    	salon.setNombreEquipo(rs.getString("nombreEquipo"));
                    	salon.setImg(rs.getString("img"));
                    	salon.setIdTorneo(rs.getInt("idtorneo"));
                    	salon.setIdTemporada(rs.getInt("idtemporada"));
                    	salon.setIdEquipo(rs.getInt("idEquipo"));
                    	salon.setIdTipoTorneo(rs.getInt("idcat_torneo"));
                    	salon.setNombreTorneo(rs.getString("nombretorneo"));
                    	salon.setNombreTemporada(rs.getInt("nombretemporada"));
                    	salon.setImgTorneo(rs.getString("img_torneo"));
                    	salon.setTotalxTemporada(rs.getInt("totalxTorneo"));
                    	salon.setTotal(rs.getInt("total"));
                    	
                    	
                    	return salon;
                    }
                });
		 for (Object salon : eventos) {
	           
			 eventosList.add( (SalonFama)salon);
	        }
	        
		return eventosList;
	}

	@Override
	public List<Torneo> getCatTorneo() {
		List<Torneo> eventosList = new ArrayList<Torneo>();
		
		String query = " SELECT id, "
						+"     nombre, "
						+"    descripcion, "
						+"    img "
						+" FROM cat_torneo ";
		
		
		
		Collection eventos = jdbcTemplate.query(
                query
                , new RowMapper() {

                    public Object mapRow(ResultSet rs, int arg1)
                            throws SQLException {
                        
                    	Torneo cat = new Torneo();
                    	
                    	cat.setId(rs.getInt("id"));
                    	cat.setNombre(rs.getString("nombre"));
                    	cat.setImg(rs.getString("img"));
                    	
                    	
                    	return cat;
                    }
                });
		 for (Object cat : eventos) {
	           
			 eventosList.add( (Torneo)cat);
	        }
	        
		return eventosList;
	}
	
	public void actualizaJornadas() {

		//System.out.println("----->activarJornadas]:" );
		String query = "activarJornadas";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { 
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure  
		Map storedProcResult = myStoredProcedure.execute();

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		
	}

	@Override
	public HashMap<String, String> delJuegoJornada(int id) {
		
		//System.out.println("----->delJuegoJornada]:"+id );
		String query = "delJuegoJornada";

		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);

		// Sql parameter mapping
		
		SqlParameter idJuegoVar = new SqlParameter("idJuego", Types.INTEGER);
		
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);

		SqlParameter[] paramArray = { idJuegoVar,
				isError, message };

		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();

		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id);

		//System.out.println(storedProcResult);

		HashMap<String, String> mapa = new HashMap<String, String>();

		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);

		return mapa;
	}
	@Override
	public HashMap<String, String> editJuegoJornada(int id, int idEquipoLocal, int idEquipoVisita) {
		
		//System.out.println("----->modJuegoJornada]:"+id + "  "+ idEquipoLocal+ " "+ idEquipoVisita );
		String query = "modJuegoJornada";
		
		MyStoredProcedure myStoredProcedure = new MyStoredProcedure(jdbcTemplate, query);
		
		// Sql parameter mapping
		
		SqlParameter idJuegoVar        = new SqlParameter("idJuego", Types.INTEGER);
		SqlParameter idEquipoLocalVar  = new SqlParameter("idEquipoLocal", Types.INTEGER);
		SqlParameter idEquipoVisitaVar = new SqlParameter("idEquipoVisita", Types.INTEGER);
		
		
		SqlOutParameter isError = new SqlOutParameter("isError", Types.INTEGER);
		SqlOutParameter message = new SqlOutParameter("message", Types.VARCHAR);
		
		SqlParameter[] paramArray = { idJuegoVar,idEquipoLocalVar,idEquipoVisitaVar,
				isError, message };
		
		myStoredProcedure.setParameters(paramArray);
		myStoredProcedure.compile();
		
		// Call stored procedure
		Map storedProcResult = myStoredProcedure.execute(id,idEquipoLocal, idEquipoVisita);
		
		//System.out.println(storedProcResult);
		
		HashMap<String, String> mapa = new HashMap<String, String>();
		
		mapa.put("status", storedProcResult.get("isError").toString());
		mapa.put("mensaje", storedProcResult.get("message").toString());
		//System.out.println(mapa);
		
		return mapa;
	}


}
