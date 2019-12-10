package com.app.service;

import java.util.List;

import org.omg.CORBA.IDLTypeOperations;
import org.springframework.web.bind.annotation.PathVariable;

import com.app.modelo.JugadorDraft;
import com.app.modelo.ResponseData;
import com.app.modelo.User;

public interface DraftService {

	List<User> buscarTodos(int idTemporada);

	void crearPrestamo(User jugador, long id,int idTemporada);

	void deletePresById(long id, long idEquipo);

	List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada);

	List<JugadorDraft> findJugadoresDraft(int idTemporada);

	ResponseData initialDraft(long id, int monto, String manager, String observaciones,int idEquipo,int idTemporada);

	ResponseData updateDraft(long id, int monto, String manager, String observaciones, int montoInicial,int idEquipo, int idTemporada);

	List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTemporada);

	ResponseData confirmPlayer(long id, int idEquipo, int idTemporada);

}
