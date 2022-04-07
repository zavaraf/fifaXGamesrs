'use strict';
 
angular.module('myApp')
.controller('DraftController', ['$scope', '$routeParams','CONFIG','DraftService','EquipoService', function($scope,$routeParams,CONFIG ,DraftService,EquipoService) {
    
	
	var self = this;
    
    self.jugadoresPres =[]
    self.equipos =[]
    self.players = []
    self.allDraft = []
    
    $scope.showDraftV
    $scope.selectedEquipoPres
    $scope.showDraft = true
    
    self.showDraft         = showDraft;
    self.crearPrestamo     = crearPrestamo;
    self.buscarTodos       = buscarTodos;
    self.buscarEquipos     = buscarEquipos;
    self.findPlayers       = findPlayers;
    self.deletePrestamo    = deletePrestamo;
    self.getAllDraft       = getAllDraft;
    
    buscarTodos();
    
   
    
    
    function showDraft(op){
    	$scope.showDraftV = op
    }
    function buscarTodos() {
    	DraftService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
			self.jugadoresPres = d;
			console.log("JugadoresPrestados]:",d);
		}, function(errResponse) {
			console.error('Error while fetching Users');
		});
	}
    
    function crearPrestamo(user,idEquipo) {
    	DraftService.crearPrestamo(user,idEquipo,CONFIG.VARTEMPORADA.id).then(buscarTodos,
				function(errResponse) {
					console.error('Error while creating User');
				});
	}
    function deletePrestamo(idUser) {
    	DraftService.deletePrestamo(idUser).then(buscarTodos,
    			function(errResponse) {
    		console.error('Error while creating User');
    	});
    }
    function buscarEquipos() {
    	console.log("[draft_controller]  idTemporada]:",CONFIG.VARTEMPORADA.id);
		EquipoService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Equipos]:",d);
			self.equipos = d;
			self.equiposP = d;
		}, function(errResponse) {
			console.error('[draft_controller] Error while fetching buscarEquipos()');
		});
	}
    
    function findPlayers(idEquipo){
    	DraftService.findPlayersByIdEquipo(idEquipo).then(function(d) {
			console.log("Players]:",d);
			self.players = d;
		}, function(errResponse) {
			self.players = [];
			console.error('Error while fetching Users');
		});
    }
    
    
    function getAllDraft(){
    	DraftService.getAllDraft().then(function(d) {
			console.log("allDraft]:",d);
			self.allDraft = d;
		}, function(errResponse) {
			self.players = [];
			console.error('Error while fetching getAllDraft');
		});
    }

 
}]);


