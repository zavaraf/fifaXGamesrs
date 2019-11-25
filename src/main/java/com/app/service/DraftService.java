package com.app.service;

import java.util.List;

import org.omg.CORBA.IDLTypeOperations;
import org.springframework.web.bind.annotation.PathVariable;

import com.app.modelo.JugadorDraft;
import com.app.modelo.ResponseData;
import com.app.modelo.User;

public interface DraftService {

	List<User> buscarTodos(int idTorneo);

	void crearPrestamo(User jugador, long id,int idTorneo);

	void deletePresById(long id, long idEquipo);

	List<User> buscarTodosByidEquipo(long idEquipo,int idTorneo);

	List<JugadorDraft> findJugadoresDraft(int idTorneo);

	ResponseData initialDraft(long id, int monto, String manager, String observaciones,int idEquipo,int idTorneo);

	ResponseData updateDraft(long id, int monto, String manager, String observaciones, int montoInicial,int idEquipo, int idTorneo);

	List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTorneo);

	ResponseData confirmPlayer(long id, int idEquipo, int idTorneo);

}
