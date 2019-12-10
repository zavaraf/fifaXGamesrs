'use strict';
 
angular.module('myApp')
.controller('DraftPCController', ['$scope','$routeParams','CONFIG', 'DraftPCService','TeamService','EquipoService', 
	function($scope,$routeParams,CONFIG, DraftPCService,TeamService,EquipoService) {
	
	var self = this;
    
    self.jugadoresDraft =[]
    self.isError = false
    self.Error = ''
    self.manage = ''
    
    
    self.buscarJugadoresdraft  =  buscarJugadoresdraft;
    self.findTeam              =  findTeam;
    self.selectJugador          =  selectJugador;
    self.submitDraftPC          =  submitDraftPC;
    self.updateDraft            =  updateDraft;
    self.buscarEquipos          =  buscarEquipos;
    self.selectColor            = selectColor;
    
    
    actualizar();
    
    function buscarJugadoresdraft() {
    	DraftPCService.buscarJugadoresdraft(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Jugadores Draft]:",d);
			self.jugadoresDraft = d;
		}, function(errResponse) {
			console.error('Error while fetching Users');
		});
	}
    function findTeam(){
		var team = 1;
		console.log('Equipo a Buscar]:'+team);
		TeamService.findEquipoAll(team, CONFIG.VARTEMPORADA.id)
            .then(
            function(d) {
                self.equipo = d;
            	console.log('--------->',d)
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }
    function selectJugador(jugadorSel){
    	self.isError = false;
		self.Error = ''
    	self.jugador = jugadorSel
    	self.isUpdate = false;  
    	buscarEquipos()
    }
    function updateDraft(jugadorSel){
    	self.isError = false;
    	self.Error = ''
		self.jugador = jugadorSel
		self.isUpdate = true
		buscarEquipos()
    }
    
    function submitDraftPC (jug, monto,manager,equipo) {
    	console.log('monto:'+monto+' manager]:'+manager+' obser]:'+equipo.nombre+ ' Jugador:',jug);
//    	self.isError= !self.isError  
    	if(self.isUpdate == false){
	    	DraftPCService.createInitialDraft(jug.id,monto,manager,equipo.nombre,equipo.id, CONFIG.VARTEMPORADA.id).then(function(d) {
				console.log("initial Draft]:",d);
				//self.jugadoresDraft = d;
				
				if(d.status == 1){
					self.isError = true;
					self.Error = d.mensaje;					
				}else{
					actualizar();
				}
				
			}, function(errResponse) {
				self.isError = true;
				self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
			});
    	}else{
    		DraftPCService.updateDraft(jug.id,monto,manager,equipo.nombre,jug.ofertaFinal,equipo.id, CONFIG.VARTEMPORADA.id).then(function(d) {
				console.log("update Draft]:",d);
				//self.jugadoresDraft = d;
				
				if(d.status == 1){
					self.isError = true;
					self.Error = d.mensaje;					
				}else{
					actualizar();
				}
				
			}, function(errResponse) {
				self.isError = true;
				self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
			});
    	}
    	  	
    	
	}
    function buscarEquipos() {
    	console.log("[draftPC]  idTemporada]:",CONFIG.VARTEMPORADA.id);
		EquipoService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Equipos]:",d);
			self.equipos = d;
		}, function(errResponse) {
			console.error('[draftPC] Error while fetching buscarEquipos()');
		});
	}
    
    function actualizar(){
    	findTeam();
        buscarJugadoresdraft()
    }
    
    function selectColor(jug){
    	console.log("--------------Entrando a seleccionar color tabla Drat---------")
    	if(jug.idEquipoOferta == jug.equipo.id){
    		return 'table-success'
    	}else{
    		return 'table-warning'
    	}
    }
	
}]);
