package com.app.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.app.modelo.JugadorDraft;
import com.app.modelo.User;

public interface DraftDao {


	List<User> buscarTodos(int idTemporada);

	void crearPrestamo(User jugador, long id,int idTemporada);

	void deletePresById(long id,long idEquipo);

	List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada);

	List<JugadorDraft> findJugadoresDraft( int idTemporada);

	HashMap<String, String> initialDraft(long id, int monto, String manager, String observaciones,int idEquipo, int idTemporada);

	HashMap<String, String> updateDraft(long id, int monto, String manager, String observaciones, int montoFinal,int idEquipo, int idTemporada);

	List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTemporada);

	HashMap<String, String> confirmPlayer(long id, int idEquipo, int idTemporada);

}
