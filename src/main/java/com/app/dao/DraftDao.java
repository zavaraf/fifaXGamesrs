package com.app.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.app.modelo.JugadorDraft;
import com.app.modelo.User;

public interface DraftDao {


	List<User> buscarTodos(int idTorneo);

	void crearPrestamo(User jugador, long id,int idTorneo);

	void deletePresById(long id,long idEquipo);

	List<User> buscarTodosByidEquipo(long idEquipo,int idTorneo);

	List<JugadorDraft> findJugadoresDraft( int idTorneo);

	HashMap<String, String> initialDraft(long id, int monto, String manager, String observaciones,int idEquipo, int idTorneo);

	HashMap<String, String> updateDraft(long id, int monto, String manager, String observaciones, int montoFinal,int idEquipo, int idTorneo);

	List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTorneo);

	HashMap<String, String> confirmPlayer(long id, int idEquipo, int idTorneo);

}
