package com.app.service;

import java.util.List;

import com.app.modelo.JugadorDraft;
import com.app.modelo.ResponseData;
import com.app.modelo.User;

public interface DraftService {

	List<User> buscarTodos(int idTemporada);

	void crearPrestamo(User jugador, long id,int idTemporada);

	void deletePresById(long id, long idEquipo,int idTemporada);

	List<User> buscarTodosByidEquipo(long idEquipo,int idTemporada);

	List<JugadorDraft> findJugadoresDraft(int idTemporada);

	ResponseData initialDraft(long id, int monto, String manager, String observaciones,int idEquipo,int idTemporada);

	ResponseData updateDraft(long id, int monto, String manager, String observaciones, int montoInicial,int idEquipo, int idTemporada);
	ResponseData updateDraftAdmin(long id, int monto, String manager, String observaciones, int montoInicial,int idEquipo, int idTemporada);

	List<JugadorDraft> findJugadoresDraftByIdEquipo(int idEquipo, int idTemporada);

	ResponseData confirmPlayer(long id, int idEquipo, int idTemporada);
	
	List<JugadorDraft> getHistoricoDraft(int idDraft,int idJugador, int idTemporada);

}
