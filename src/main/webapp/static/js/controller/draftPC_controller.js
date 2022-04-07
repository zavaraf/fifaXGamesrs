'use strict';
 
angular.module('myApp')
.controller('DraftPCController', ['$scope','$routeParams','CONFIG', 'DraftPCService','TeamService','EquipoService', 
	function($scope,$routeParams,CONFIG, DraftPCService,TeamService,EquipoService) {
	
	var self = this;
	var separador = document.getElementById('montoOfer');
    
    self.jugadoresDraft =[]
    self.isError = false
    self.Error = ''
    self.manage = ''
    self.visibleJugadores = true;
    self.visibleOfertas == false;
    self.historicoDraft ;
    
    self.buscarJugadoresdraft  =  buscarJugadoresdraft;
    self.findTeam              =  findTeam;
    self.selectJugador          =  selectJugador;
    self.submitDraftPC          =  submitDraftPC;
    self.updateDraft            =  updateDraft;
    self.buscarEquipos          =  buscarEquipos;
    self.selectColor            = selectColor;
    self.updateDraftAdmin       = updateDraftAdmin;
    
    self.getHistoricoDraft      = getHistoricoDraft;
    
    
    actualizar();
    
    separador.addEventListener('keyup', (e) => {
        var entrada = e.target.value.split(',').join('');
        entrada = entrada.split('').reverse();
        
        var salida = [];
        var aux = '';
        
        var paginador = Math.ceil(entrada.length / 3);
        
        for(let i = 0; i < paginador; i++) {
            for(let j = 0; j < 3; j++) {
                if(entrada[j + (i*3)] != undefined) {
                    aux += entrada[j + (i*3)];
                }
            }
            salida.push(aux);
            aux = '';
            document.querySelector('#montoSeparado').innerText = salida.join(',').split("").reverse().join('');
        }
    }, false);
    
    function getHistoricoDraft(idDraft,idJugador){
    	  		console.log("getHIstorico:"+idDraft+" - idJugador:"+idJugador)
    		DraftPCService.getHistoricoDraft(idDraft,idJugador).then(function(d) {
    			console.log("historico Draft]:",d);
    			self.historicoDraft = d;
    		}, function(errResponse) {
    			console.error('Error while historico draft Users');
    		});
    }
    
    function buscarJugadoresdraft() {
    	DraftPCService.buscarJugadoresdraft(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Jugadores Draft]:",d);
			self.jugadoresDraft = d;
			console.log("Jugadores Draft............]:",d);
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
					self.jugadoresDraft = d.data;
					//actualizar();
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
					self.jugadoresDraft = d.data;
					//actualizar();
				}
				
			}, function(errResponse) {
				self.isError = true;
				self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
			});
    	}
    	  	
    	
	}
    
    function updateDraftAdmin(jug, monto,manager,equipo){
    	
    	DraftPCService.updateDraftAdmin(jug.id,monto,manager,equipo.nombre,jug.ofertaFinal,equipo.id, CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("update updateDraftAdmin]:",d);
			//self.jugadoresDraft = d;
			
			if(d.status == 1){
				self.isError = true;
				self.Error = d.mensaje;					
			}else{
				self.jugadoresDraft = d.data;
				//actualizar();
			}
			
		}, function(errResponse) {
			self.isError = true;
			self.Error = 'Error while create initial Draft'
			console.error('Error while create initial Draft');
		});
    }
    function buscarEquipos() {
    	console.log("[draftPC]  idTemporada]:",CONFIG.VARTEMPORADA.id);
    	if(self.equipos == null ){
		EquipoService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Equipos]:",d);
			self.equipos = d;
		}, function(errResponse) {
			console.error('[draftPC] Error while fetching buscarEquipos()');
		});
    	}
	}
    
    function actualizar(){
    	findTeam();
        buscarJugadoresdraft();
    }
    
    function selectColor(jug){
    	// console.log("--------------Entrando a seleccionar color tabla Drat---------")
    	if(jug.idEquipoOferta == jug.equipo.id){
    		return ''
    	}else{
    		return 'border-success'
    	}
    }
	
}]);
