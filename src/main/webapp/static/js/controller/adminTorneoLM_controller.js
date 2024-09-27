'use strict';
var app = angular.module('myApp');

app.controller('AdminTorneoLMController',
['$scope','$routeParams','CONFIG','TorneoLMService','EquipoService','TemporadaService',
function($scope, $routeParams, CONFIG, TorneoLMService, EquipoService, TemporadaService) {
	
	var self = this;

	self.tablaGeneral;
	self.jornadas;
	self.jornadasLiguilla;
	self.jornadaEdit;
	self.juegoEdit;
	self.players;
	self.golesJornada;
	self.divisiones;
	self.divisionSelect;
	self.isEdit = false;
	self.isJornadaInsert = false;
	self.jornadasEdit = [];
	self.equiposTorneo = [];
	self.equiposSelect;
	self.gruposSe = [];
	
	self.catTorneo;
	self.selectedCatTorneo
	
	self.gruposTorneo = [];
	self.confJor = 2;
	self.confTor = 2;
	self.confAle = 2;
	self.confLiguilla = 2;
	self.CatLiguilla = [{id : 1 , nombre:"Final"},{id : 2 , nombre:"Semifinal"},{id : 3 , nombre:"Cuartos"},{id : 4 , nombre:"Octavos"}];
	
	self.getGenerarJornadas = getGenerarJornadas;
	self.getJornadas = getJornadas;
	self.addJornadas = addJornadas;
	
	self.addJornadasEdit = addJornadasEdit;
	self.getTorneos = getTorneos;
	self.buscarTodos = buscarTodos;
	self.addEquipo = addEquipo;
	self.getJornadasGrupos = getJornadasGrupos;
	self.addTorneoGrupo = addTorneoGrupo;
	self.getGruposTorneo = getGruposTorneo;
	self.generarPartidosFinales = generarPartidosFinales;
	self.addJuegosLiguilla = addJuegosLiguilla;
	self.getCatTorneos = getCatTorneos;
	self.equiposEdit = equiposEdit;
	self.cambiarLocalia = cambiarLocalia;
	self.delJuego = delJuego;
	self.editJuego = editJuego;
	self.buscarTemporadasEspejo = buscarTemporadasEspejo;
	self.getJornadasEspejo = getJornadasEspejo;
	self.cambiarLocalias = cambiarLocalias;
	self.cambiarEquipoJornadas = cambiarEquipoJornadas;
	
	
	//self.getEquiposDes = getEquiposDes;
	
	$scope.example9model = [];
	$scope.equiposLiguilla = [];
	// $scope.example9data = [ {id: 1, nombre: "David"},
	// {id: 2, nombre: "Jhon"}, {id: 3, nombre:
	// "Danny"}];
	// $scope.example9data = buscarTodos();
	
	$scope.example9settings = {
		enableSearch : true,
		displayProp : "nombre",
		checkBoxes : true,
		scrollable : true,
		selectedToTop : true
	};
	
	$scope.getFormatDate = function (val) { // assuming val is date like "/Date(946673340000)/"
	 if (val != undefined) {
	   let date = new Date(String(val).match(/\d+/)[0] * 1); // creating a date object from val
	    return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 
	   date.getHours(), date.getMinutes());
	 }
	}
	
//	$scope.options = {
//    
//    minDate: new Date(),
//    showWeeks: false,
//    currentText: 'Hoy',    
//    closeText: 'OK'
//  };
//
//	
  $scope.minDate = new Date();
//  
//  $scope.test = function() {
//    $scope.minDate = new Date();
//  }
//	
	
	buscarDivisiones();
	getCatTorneos();
	
	
	
	
	
//  function getDayClass(data) {
//    var date = data.date,
//      mode = data.mode;
//    if (mode === 'day') {
//      var dayToCheck = new Date(date).setHours(0,0,0,0);
//
//      for (var i = 0; i < $scope.events.length; i++) {
//        var currentDay = new Date($scope.events[i].date).setHours(0,0,0,0);
//
//        if (dayToCheck === currentDay) {
//          return $scope.events[i].status;
//        }
//      }
//    }
//
//    return new Date(date);
//  }
//	
//	

							
function getCatTorneos(){
	console.log("------------------->getCatTorneos()")
	TorneoLMService.getCatTorneos()
	.then(
		function(d) {

			self.catTorneo = d;
			

			console.log("TorneoLMService-ggetCatTorneos]:",self.catTorneo)
			console.log("TorneoLMService-getCatTorneos]: -----------FIN-----------")

			return d;
		},
		function(errResponse) {
			console
			.error('[getCatTorneos] Error while fetching TorneoLMService()');
		});
	return null;
	
}

function getTorneos(e) {
	return CONFIG.VARTEMPORADA.torneos;
}
function addEquipo(equi) {
	console.log("EquipoADD]:", equi)
	self.equiposTorneo.push(equi);
}
function buscarTodos() {
	var idTemporada = CONFIG.VARTEMPORADA.id
	console.log("[adminTorneo_controller]  entre idTemporada]:",CONFIG.VARTEMPORADA.id);
	EquipoService
	.buscarTodos(idTemporada)
	.then(
		function(d) {
			self.equipos = d;
			$scope.options = self.equipos;
			$scope.example9data = self.equipos;
			
			if(self.juegoEdit != null){
				equiposEdit();
			}

			return $scope.options;

		},
		function(errResponse) {
			console.error('[adminTorneo_controller] Error while fetching buscarTodos()');
		});
}
function addJornadasEdit(jor) {
	var isJornada = false;
	if (self.isEdit == true) {
		if (self.jornadasEdit != null
			&& self.jornadasEdit.length > 0) {
			for (var i = 0; i < self.jornadasEdit.length; i++) {
				if (self.jornadasEdit[i].numeroJornada == jor.numeroJornada) {
					self.jornadasEdit[i] = jor;
					isJornada = true;
					console.log("Edit Jornada:",jor);
					break;
				}
			}
		}
		if (isJornada == false) {
			self.jornadasEdit.push(jor);
			console.log("Add Jornada:", jor);
		}
	}
}

function buscarDivisiones() {
	EquipoService
	.buscarDivisiones()
	.then(
		function(d) {
			console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",d)
			self.divisiones = d;
			if (self.divisiones != null&& self.divisiones.length > 0) {
				
				self.divisionSelect = (CONFIG.VARTEMPORADA.torneos != null && CONFIG.VARTEMPORADA.torneos.length > 0) ? CONFIG.VARTEMPORADA.torneos[0]
				: self.divisiones[0]
				console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",self.divisionSelect)
				getJornadas();
			}

		},
		function(errResponse) {
			console.error('Error while fetching TorneoLMConroller-buscarDivisiones');
		});

}

function getGenerarJornadas() {
	console.log("------------------->torneo]:"+ self.divisionSelect)
	TorneoLMService.getGenerarJornadas(self.divisionSelect.id, 0)
	.then(
		function(d) {

			self.jornadas = d;
			

			console.log("TorneoLMService-getGenerarJornadas]:",self.jornadas)
			console.log("TorneoLMService-getGenerarJornadas]: -----------FIN-----------")

			return d;
		},
		function(errResponse) {
			console
			.error('[TorneoLMService] Error while fetching TorneoLMService()');
		});
	return null;
}

function getJornadas() {
	console.log("torneoSeleccionado]:"+ self.divisionSelect.id)
	TorneoLMService.getJornadas(self.divisionSelect.id, 0).then(
		function(d) {
			self.jornadas = d;
			

			if (self.jornadas != null
				&& self.jornadas != '') {
				self.isEdit = true;
			self.isJornadaInsert = true;

		} else {
			self.isEdit = false;

		}
//													console.log("TorneoLMService-getTablaJornadas]:"+ JSON.stringify(self.jornadas))
console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
self.jornadasEdit = [];
return d;
},
function(errResponse) {
	console
	.error('[TorneoLMService] Error while fetching TorneoLMService()');
});
	return null;
}

function addJornadas() {

	var jor;
	jor = self.jornadas;
	if (self.isEdit == true) {
		jor = self.jornadasEdit;
	}
	TorneoLMService
	.addJornadas(self.divisionSelect,jor)
	.then(
		function(d) {

			console
			.log(
				"TorneoLMService-addJornadas]:",
				d)

			self.isEdit = true;
			self.isJornadaInsert = true;
			return d;
		},
		function(errResponse) {
			console
			.error('[TorneoLMService] Error while addJornadas TorneoLMService()');
		});
	return null;
}

function getJornadasGrupos(equiposSeleccionados,numeroGrupos) {
	console.log("------------------->Torneo]:",
		equiposSeleccionados)
	TorneoLMService
	.getJornadasGrupos(
		equiposSeleccionados,
		self.divisionSelect.id,
		numeroGrupos, self.confJor,
		self.confAle)
	.then(
		function(d) {

			self.gruposSe = d;

			console
			.log(
				"TorneoLMService-getJornadasGrupos]:",
				self.gruposSe)

						// console.log("Grupos]:"+
						// JSON.stringify(self.gruposSe))

						return d;
					},
					function(errResponse) {
						console
						.error('[getJornadasGrupos] Error while fetching TorneoLMService()');
					});
	return null;
}

function addTorneoGrupo(grupos, nombreTorneo) {
	console.log("-----------addTorneoGrupo-------->Torneo]:",grupos, self.selectedCatTorneo,self.confTor)
	TorneoLMService
	.addTorneoGrupo(grupos, self.selectedCatTorneo,self.confTor)
	.then(
		function(d) {

			console
			.log(
				"TorneoLMService-addTorneoGrupo]:",
				d)

			buscarTemporada();
			return d;
		},
		function(errResponse) {
			console
			.error('[addTorneoGrupo] Error while fetching TorneoLMService()');
		});
	return null;
}

function getGruposTorneo(torneoSelect) {
	console.log("-----------getGruposTorneo-------->Torneo]:",torneoSelect)
	if (torneoSelect.tipoTorneo) {
		TorneoLMService.getGruposTorneo(torneoSelect.id).then(
			function(d) {

				self.gruposTorneo = d;

				console.log("TorneoLMService-getGruposTorneo]:",d)

				return d;
			},
			function(errResponse) {
				console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
			});
	} else {
		self.gruposTorneo = [];
	}
	return null;
}

function buscarTemporada() {
	TemporadaService
	.buscarTemporada()
	.then(
		function(d) {
			var temporada = d;
			console.error(
				'temporada --- >',
				d);
			var selectedTor = temporada.length > 0 ? temporada[temporada.length - 1]
			: null;
						// $scope.idTemporada =
						// ($scope.idTemporada ==
						// null ||
						// $scope.idTemporada ===
						// undefined) ?
						// self.selectedTor :
						// $scope.idTemporada;

						CONFIG.VARTEMPORADA.torneos = selectedTor.torneos

						console.log('temporada Seleccionado--- >',CONFIG.VARTEMPORADA);
						console.log('temporada Seleccionado2--- >',self.selectedTor);
					},
					function(errResponse) {
						console
						.error('Error while fetching temporada');
					});
}

function buscarTemporadasEspejo() {
	TemporadaService
	.buscarTemporada()
	.then(
		function(d) {
			var temporada = d;
			console.error('temporada --- >',d);
			
			self.temporadasEspejo = d;
		},
		function(errResponse) {
			console.error('Error while fetching temporada');
		});
}



function generarPartidosFinales(equipos, nombreJor,idFase) {

	var jornadasL = [];

	var jornada = {};

	jornada.activa = 1;
	jornada.cerrada = 0;
	jornada.idJornda = 0;
	jornada.nombreJornada = nombreJor;
	jornada.numeroJornada = 0;
	jornada.tipoJornada = idFase;
	var juegos = [];

	for (var i = 0; i < equipos.length; i++) {

		var juego = {};

		juego.idEquipoLocal = equipos[i].id;
		juego.nombreEquipoLocal = equipos[i].nombre;
		juego.imgLocal = equipos[i].img;

		juego.idEquipoVisita = equipos[i + 1].id;
		juego.nombreEquipoVisita = equipos[i + 1].nombre;
		juego.imgVisita = equipos[i + 1].img;

		juegos.push(juego);

		i++;

	}
	jornada.jornada = juegos;

	jornadasL.push(jornada)
	
	if(self.confLiguilla == 2){
		var jornada = {};

		jornada.activa = 1;
		jornada.cerrada = 0;
		jornada.idJornda = 0;
		jornada.nombreJornada = nombreJor +' Vuelta';
		jornada.numeroJornada = 0;
		jornada.tipoJornada = idFase;
		var juegos = [];

		for (var i = 0; i < equipos.length; i++) {

			var juego = {};

			juego.idEquipoLocal = equipos[i+1].id;
			juego.nombreEquipoLocal = equipos[i+1].nombre;
			juego.imgLocal = equipos[i+1].img;

			juego.idEquipoVisita = equipos[i].id;
			juego.nombreEquipoVisita = equipos[i].nombre;
			juego.imgVisita = equipos[i].img;

			juegos.push(juego);

			i++;

		}
		jornada.jornada = juegos;

		jornadasL.push(jornada)
	}
	
	self.jornadasLiguilla = jornadasL;
	console.log("Jornadas generadas ]:",self.jornadasLiguilla);
	console.log("Jornadas generadas ]:",JSON.stringify(self.jornadasLiguilla));
	

}

function addJuegosLiguilla(jornadasLiguillaVar,selectedTorneoModal){
	TorneoLMService.addJuegosLiguilla(jornadasLiguillaVar,selectedTorneoModal.id).then(
		function(d) {

			self.jornadas = d.data;

			console.log("TorneoLMService-getGruposTorneo]:",d)

			return d;
		},
		function(errResponse) {
			console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
		});
}

function equiposEdit(){
	
	console.log(self.juegoEdit)
	
	self.juegoEdit.equipoLocal = self.equipos.find( elt => elt.id === self.juegoEdit.idEquipoLocal);
	self.juegoEdit.equipoVisita = self.equipos.find( elt => elt.id === self.juegoEdit.idEquipoVisita);
	
	console.log(self.juegoEdit)
	
}

function cambiarLocalia(){
	
	if(self.juegoEdit != null){
		self.juegoEdit.equipoVisita = self.equipos.find( elt => elt.id === self.juegoEdit.idEquipoLocal);
		self.juegoEdit.equipoLocal  = self.equipos.find( elt => elt.id === self.juegoEdit.idEquipoVisita);
		
		self.juegoEdit.idEquipoLocal = self.juegoEdit.equipoLocal.id;
		self.juegoEdit.nombreEquipoLocal = self.juegoEdit.equipoLocal.nombre;
		
		self.juegoEdit.idEquipoVisita = self.juegoEdit.equipoVisita.id;
		self.juegoEdit.nombreEquipoVisita = self.juegoEdit.equipoVisita.nombre;
		
		self.juegoEdit.imgLocal             = self.juegoEdit.equipoLocal.img
		self.juegoEdit.imgVisita            = self.juegoEdit.equipoVisita.img			
	}
}


function delJuego(){
	
	if(self.juegoEdit != null){
		TorneoLMService.delJuego(self.juegoEdit.id).then(
		function(d) {
			
			const jornadasAux = self.jornadas.filter(elt => elt.idJornda == self.juegoEdit.idJornada);
	
			const juegosAux = jornadasAux[0].jornada.filter(elt => elt.id != self.juegoEdit.id);
			
			if(jornadasAux.length >0 ){
		
				self.jornadas.filter(elt => elt.idJornda == self.juegoEdit.idJornada)[0].jornada = juegosAux;
			}
		
	console.log(self.jornadas);
			
			
			
			self.juegoEdit = null;

			return d;
		},
		function(errResponse) {
			console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
		});
	}
}

function editJuego(){
	
	if(self.juegoEdit != null){
		
		if (self.juegoEdit.equipoLocal != null ){
			
			self.juegoEdit.idEquipoLocal = self.juegoEdit.equipoLocal.id;
			self.juegoEdit.nombreEquipoLocal = self.juegoEdit.equipoLocal.nombre;
			self.juegoEdit.imgLocal             = self.juegoEdit.equipoLocal.img
						
		}
		if (self.juegoEdit.equipoVisita != null ){
			
			self.juegoEdit.idEquipoVisita = self.juegoEdit.equipoVisita.id;
			self.juegoEdit.nombreEquipoVisita = self.juegoEdit.equipoVisita.nombre;
		    self.juegoEdit.imgVisita            = self.juegoEdit.equipoVisita.img
			
		}
			
			
		
		
	
	
		TorneoLMService.editJuego(self.juegoEdit).then(
		function(d) {
			
			//buscarTodos();
			getGruposTorneo(self.divisionSelect);
			
			self.juegoEdit = null;

			return d;
		},
		function(errResponse) {
			console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
		});
	}
}

function getJornadasEspejo(temporada, torneo) {
	console.log("getJornadasEspejo() torneoSeleccionado]:",temporada,torneo)
		
	
	TorneoLMService.getJornadasEspejo(temporada.id,torneo.id, 0).then(
		function(d) {
			self.jornadasEspejo = d.filter( elt => !isNaN(elt.nombreJornada));
			
			

			if (self.jornadasEspejo != null
				&& self.jornadasEspejo != '') {
				self.isEditEspejo = true;
			self.isJornadaInsertEspejo = true;

		} else {
			self.isEditEspejo = false;

		}
//													console.log("TorneoLMService-getTablaJornadas]:"+ JSON.stringify(self.jornadas))
	console.log("TorneoLMService-getTablaJornadas]:",self.jornadasEspejo)
	
	
	console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------",self.selectedCatTorneo,self.catTorneo)
	
	self.selectedCatTorneo = self.catTorneo.data.catTorneo.find(elt => elt.nombre == torneo.nombre);
	
	if (torneo.tipoTorneo) {
		TorneoLMService.getGruposTorneoTemp(torneo.id,temporada.id).then(
			function(res) {

				self.gruposTorneo = res;

				console.log("TorneoLMService-getGruposTorneo]:",res)

	
				return res;
			},
			function(errResponse) {
				console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
			});
	} else {
		self.gruposTorneo = [];
	}
	
	return d;
	},
	function(errResponse) {
		console
		.error('[TorneoLMService] Error while fetching TorneoLMService()');
	});
		return null;
}

function cambiarLocalias(){
	
	let jornadasCambio = self.jornadasEspejo;
	
	self.jornadasEspejo.reverse();
	
	jornadasCambio.forEach( (jornada,index) => {
    	
    	jornada.numeroJornada = index +1;
    	
    	jornada.jornada.forEach(juego => {  
			
			let idEquipoLocalTemp= juego.idEquipoLocal
			let idEquipoVisitaTemp= juego.idEquipoVisita
			let imgLocalTemp= juego.imgLocal
			let imgVisitaTemp= juego.imgVisita
			let nombreEquipoLocalTemp= juego.nombreEquipoLocal
			let nombreEquipoVisitaTemp  = juego.nombreEquipoVisita	
			
			juego.idEquipoLocal        = idEquipoVisitaTemp
			juego.idEquipoVisita       = idEquipoLocalTemp
			juego.imgLocal             = imgVisitaTemp
			juego.imgVisita            = imgLocalTemp
			juego.nombreEquipoLocal    = nombreEquipoVisitaTemp
			juego.nombreEquipoVisita   = nombreEquipoLocalTemp
			juego.numeroJornada        = index +1;
    	
	    	
		});
	});
	
	
	
	
	if(self.gruposTorneo.length > 0 )
		self.gruposTorneo[0].jornadas = self.jornadasEspejo 
	
	self.gruposSe = self.gruposTorneo;
	
	console.log(self.gruposTorneo)
	
	 
	
}

function cambiarEquipoJornadas(equipo, equipoCambio){
	
	let jornadasCambio = self.jornadasEspejo;
	
	console.log("entro cambiarequipo jornadas",equipo,equipoCambio)
	
	if(self.gruposTorneo.length > 0 ){
		self.gruposTorneo[0].equipos.forEach( (equi, index )=> {
			if(equi.id == equipoCambio.id){
				self.gruposTorneo[0].equipos[index] = equipoCambio
			}
		})	
	}
		 
		 console.log(self.gruposTorneo)
	
	jornadasCambio.forEach(jornada => {
    	
    	
    	jornada.jornada.forEach(juego => {  
			
			
			if(juego.idEquipoLocal == equipo.id){
				juego.idEquipoLocal        = equipoCambio.id
				juego.imgLocal             = equipoCambio.img
				juego.nombreEquipoLocal    = equipoCambio.nombre				
				
			}
			if(juego.idEquipoVisita == equipo.id){
				juego.idEquipoVisita        = equipoCambio.id
				juego.imgVisita             = equipoCambio.img
				juego.nombreEquipoVisita    = equipoCambio.nombre				
				
			}
    	
	    	
		});
	});
	
}			
							

}])

;