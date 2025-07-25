'use strict';



angular.module('myApp').factory('TorneoLMService', ['$http', '$q', 'CONFIG', function($http, $q, CONFIG) {


	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI_E = IP + '/rest/temporada/lm/';

	var factory = {
		getTablaGeneral: getTablaGeneral,
		getJornadas: getJornadas,
		getGolesJornadas: getGolesJornadas,
		addGoles: addGoles,
		getJornada: getJornada,
		addImagen: addImagen,
		getGenerarJornadas: getGenerarJornadas,
		addJornadas: addJornadas,
		getJornadasGrupos: getJornadasGrupos,
		addTorneoGrupo: addTorneoGrupo,
		getGruposTorneo: getGruposTorneo,
		guardarJornada: guardarJornada,
		addJuegosLiguilla: addJuegosLiguilla,
		getCatTorneos: getCatTorneos,
		delJuego: delJuego,
		editJuego: editJuego,
		getJornadasEspejo: getJornadasEspejo,
		getGruposTorneoTemp: getGruposTorneoTemp
	};

	return factory;


	function getCatTorneos() {
		var deferred = $q.defer();

		//         $http.get(REST_SERVICE_URI_E+'getTablaGeneral'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision)
		var idEquipo = CONFIG.ID_EQUIPO == null ? 0 : CONFIG.ID_EQUIPO;

		var url = REST_SERVICE_URI_E + 'getCatTorneo'
		console.log("torneoLM_service" + url, CONFIG)

		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while fetching Users');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;

	}


	function getTablaGeneral(idDivision) {
		var deferred = $q.defer();
		var idTorneo = 1;
		//        $http.get(REST_SERVICE_URI_E+'getTablaGeneral'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision)
		var idEquipo = CONFIG.ID_EQUIPO == null ? 0 : CONFIG.ID_EQUIPO;

		var url = REST_SERVICE_URI_E + 'getTorneoGeneral' + "/" + CONFIG.VARTEMPORADA.id + '/' + idDivision + '/' + idEquipo
		console.log("getTablaGeneral]:"+url, CONFIG)

		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while fetching Users');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function getJornadas(idDivision, activa) {
		var deferred = $q.defer();
		var idTorneo = 1;
		var url = REST_SERVICE_URI_E + 'getJornadas' + "/" + CONFIG.VARTEMPORADA.id + '/' + idDivision + "/" + activa
		console.log("utl]:" + url)
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function getJornada(idJornada, id, idEquipoLocal, idEquipoVisita) {
		var deferred = $q.defer();
		var idTorneo = 1;
		var url = REST_SERVICE_URI_E + 'getJornada/' + idJornada + '/' + id + '/' + idEquipoLocal + '/' + idEquipoVisita + "/" + CONFIG.VARTEMPORADA.id
		console.log(url);
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getGolesJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function getGolesJornadas(idJornada, idEquipoLocal, idEquipoVisita) {
		var deferred = $q.defer();
		var idTorneo = 1;
		$http.get(REST_SERVICE_URI_E + 'getJornadas/goles/' + idJornada + '/1/' + idEquipoLocal + '/' + idEquipoVisita)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getGolesJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}



	function addGoles(idJugador, idEquipo, id, idJornada) {
		var deferred = $q.defer();
		var idTorneo = 1;
		$http.post(REST_SERVICE_URI_E + 'addGoles/' + idJugador + '/' + idEquipo + '/' + id + '/' + idJornada)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addGoles');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function addImagen(idEquipo, id, idJornada, img) {
		var deferred = $q.defer();
		var idTorneo = 1;
		$http.post(REST_SERVICE_URI_E + 'addImg/' + idEquipo + '/' + id + '/' + idJornada, img)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addGoles');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}


	function getGenerarJornadas(idDivision) {
		var deferred = $q.defer();
		var idTorneo = 1;
		var url = REST_SERVICE_URI_E + 'getArmarJornadasInicial' + "/" + CONFIG.VARTEMPORADA.id + '/' + idDivision
		console.log(url);
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function addJornadas(torneo, jornadas) {
		var deferred = $q.defer();
		var idTorneo = 1;
		var url = REST_SERVICE_URI_E + 'addJornadas' + "/" + CONFIG.VARTEMPORADA.id + '/' + torneo.id + '/' + torneo.tipoTorneo
		console.log(url,jornadas)
		$http.post(url, jornadas)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function getJornadasGrupos(equiposSeleccionados, idTorneo, numeroGrupos, confJor, confAle) {
		var deferred = $q.defer();
		var idTorneo = 1;
		var url = REST_SERVICE_URI_E + 'getArmarJornadasGrupos' + "/" + CONFIG.VARTEMPORADA.id + '/' + idTorneo + '/' + numeroGrupos + '/' + confJor + '/' + confAle
		console.log(url, equiposSeleccionados);
		$http.post(url, equiposSeleccionados)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function addTorneoGrupo(grupos, nombre, confTor) {
		var deferred = $q.defer();


		console.log("catTorneo]:", nombre, confTor);
		var url = REST_SERVICE_URI_E + 'addJornadasGrupos' + "/" + CONFIG.VARTEMPORADA.id + '/' + nombre.nombre + '/' + confTor + '/' + nombre.id
		console.log(url, grupos);
		$http.post(url, grupos)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	function getGruposTorneo(idGrupo) {
		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + 'getGruposTorneo' + "/" + CONFIG.VARTEMPORADA.id + '/' + idGrupo
		console.log(url);
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	function getGruposTorneoTemp(idGrupo, idTemp) {
		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + 'getGruposTorneo' + "/" + idTemp + '/' + idGrupo
		console.log(url);
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function guardarJornada(jornada, idTorneo) {
		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + 'addResultJornada/' + idTorneo + '/' + CONFIG.VARTEMPORADA.id + '/' + CONFIG.ID_EQUIPO + '/' + CONFIG.USERID;
		console.log("------Jornada Service];----", url,jornada)
		console.log("Requesta enviada:", JSON.stringify(jornada, null, 2));
		$http.post(url, jornada)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addResultJornada');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function addJuegosLiguilla(jornadasLiguillaVar, idTorneo) {
		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + 'addJuegosLiguilla/' + CONFIG.VARTEMPORADA.id + '/' + idTorneo;
		console.log("------addJuegosLiguilla Service];----", url)
		console.log("------addJuegosLiguilla Service];----", jornadasLiguillaVar)
		$http.post(url, jornadasLiguillaVar)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addJuegosLiguilla');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

	function delJuego(id) {

		const urlCompl = '/juego/del/';

		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + urlCompl + id;

		console.log("------delJuego Service];----", url)

		$http.post(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addJuegosLiguilla');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;


	}
	function editJuego(juego) {

		const urlCompl = '/juego/edit';

		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + urlCompl + "/" + juego.id + "/" + juego.idEquipoLocal + "/" + juego.idEquipoVisita;

		console.log("------edit Service];----", url)

		$http.post(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while addJuegosLiguilla');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;


	}

	function getJornadasEspejo(idTemporada, idTorneo, activa) {
		var deferred = $q.defer();

		var url = REST_SERVICE_URI_E + 'getJornadas' + "/" + idTemporada + '/' + idTorneo + "/" + activa
		console.log("utl]:" + url)
		$http.get(url)
			.then(
				function(response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse) {
					console.error('Error while getJornadas');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}

}]);