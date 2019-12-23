'use strict';
var app = angular.module('myApp'); 




app.controller('TorneoLMController', ['$scope','$routeParams','CONFIG','TorneoLMService','UserService','EquipoService',
			function($scope,$routeParams,CONFIG,TorneoLMService,UserService,EquipoService) {
	var self = this;
	
	self.tablaGeneral;
	self.jornadas;
	self.jornadaEdit;
	self.players;
	self.golesJornada;
	self.divisiones;
	self.divisionSelect;
	self.jornadaSelect = [];
	

	
	self.findPlayersJornada = findPlayersJornada;
	self.getGolesJornadas = getGolesJornadas;
	self.getPlayers = getPlayers;
	self.addGoles  = addGoles;
	self.getJornada = getJornada;
	self.addImagen =  addImagen;
	self.getInitTorneo = getInitTorneo;
	self.getJornadaActual = getJornadaActual;
	self.setJornadaActual = setJornadaActual;
	self.showEditJornada = showEditJornada;
	self.getTorneos = getTorneos;
	
	
	buscarDivisiones()
	
	function getTorneos(){
		return CONFIG.VARTEMPORADA.torneos;
	}
	
	function getJornadaActual (){
		self.jornadaSelect = [];
			if(self.jornadas!= null && self.jornadas!= ''){
				for (var i = 0 ; i<=self.jornadas.length ; i ++){
					if(self.jornadas[i].numeroJornada == 1){
						self.jornadaSelect.push( self.jornadas[i]); 
						console.log("get Jornada Select]:",self.jornadaSelect);
						break;
					}
					
				}
			}
		
				
	}
	
	function setJornadaActual (jornada){
		self.jornadaSelect = []
		self.jornadaSelect.push( jornada);
		console.log("setJornadaActual]:",self.jornadaSelect);
		
	}
	
	function getInitTorneo(div){
		self.jornadaSelect == null;
		self.divisionSelect = div;
		getTablaGeneral()
		getJornadas()
		
	}
	
    function getTablaGeneral(){
    	console.log("---------->",self.divisionSelect)
		TorneoLMService.getTablaGeneral(self.divisionSelect.id)
                .then(
                function(d) {
                    self.tablaGeneral = d;
                    
                    console.log("TorneoLMService]:",self.tablaGeneral)
                    
                    return d;
                },
                function(errResponse){
                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
                }
            );
            return null;
        }
	
	 function getJornadas(){
			TorneoLMService.getJornadas(self.divisionSelect.id,1)
	                .then(
	                function(d) {
	                    self.jornadas = d;
	                    
	                    console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
	                    console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
	                    getJornadaActual()
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
	                }
	            );
	            return null;
	        }
	 
	 function findPlayersJornada(idEquipo,idEquipoVisita){
		 UserService.findPlayersByIdEquipoJornada(idEquipo,idEquipoVisita).then(function(d) {
				console.log("[TorneoLMService] - Players]:",d);
				self.players = d;
			}, function(errResponse) {
				self.players = [];
				console.error('[TorneoLMService] Error while fetching Users');
			});
	    }
	 
	 function getJornada(idJornada,id,idEquipoLocal,idEquipoVisita){
			TorneoLMService.getJornada(idJornada,id,idEquipoLocal,idEquipoVisita)
	                .then(
	                function(d) {
	                    self.jornadaEdit = d;
	                    
	                    console.log("TorneoLMService-getJornada]:",self.jornadaEdit)
	                    
	                    
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[getJornada] Error while fetching getJornada()');
	                }
	            );
	            return null;
	        }
	 
	 function getGolesJornadas(idJornada,idEquipoLocal,idEquipoVisita){
			TorneoLMService.getGolesJornadas(idJornada,idEquipoLocal,idEquipoVisita)
	                .then(
	                function(d) {
	                    self.golesJornada = d;
	                    
	                    console.log("TorneoLMService-getGolesJornadas]:",self.golesJornada)
	                    
	                    
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[getGolesJornadas] Error while fetching TorneoLMService()');
	                }
	            );
	            return null;
	        }
	 
	 function getPlayers(idEquipo,golesJornada){
		 
		 
		 var playersGoles = [];
		 
		 if(golesJornada!=null){
		 for(var i=0;i<golesJornada.length;i++){
				
				if(golesJornada[i].idEquipo == idEquipo){
					playersGoles.push(golesJornada[i]);
				}			
			}
		 }
		 
		 return playersGoles;
		 
	 }
	 
	 function addGoles(idJugador,idEquipo,jornadaVar) {
		 
		 TorneoLMService.addGoles(idJugador,idEquipo,jornadaVar.id,jornadaVar.idJornada)
         .then(
         function(d) {
             self.golesJornada = d;
             
             console.log("TorneoLMService-addGoles]:",self.golesJornada)
             
             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
             
             
             return d;
         },
         function(errResponse){
             console.error('[addGoles] Error while addGoles()');
         }
     );
     return null;
		 
	 }
	 
	 function addImagen(idEquipo,jornadaVar,img) {
		 
		 TorneoLMService.addImagen(idEquipo,jornadaVar.id,jornadaVar.idJornada,img)
         .then(
         function(d) {
            
             
             console.log("TorneoLMService-addImagen]:",d)
             
             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
             
             
             return d;
         },
         function(errResponse){
             console.error('[addGoles] Error while addGoles()');
         }
     );
     return null;
		 
	 }
	 function buscarDivisiones() {
			EquipoService.buscarDivisiones().then(function(d) {
				console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",d)
				self.divisiones = d;
				if(self.divisiones!= null && self.divisiones.length >0){
					self.divisionSelect = (CONFIG.VARTEMPORADA.torneos != null && CONFIG.VARTEMPORADA.torneos.length>0) ? CONFIG.VARTEMPORADA.torneos[0] : null
				 }
				
				getTablaGeneral()
				getJornadas()	
				
			}, function(errResponse) {
				console.error('Error while fetching TorneoLMConroller-buscarDivisiones');
			});
			
		}
	 
	 function showEditJornada(roles,idEquipo,idEquipoLocal,idEquipoVisita) {
		 
			if(self.jornadaEdit!= null && ((roles.includes('Manager') && (idEquipoLocal == idEquipo || idEquipoVisita == idEquipo )) 
					|| roles.includes('Admin')) && self.jornadaEdit.cerrada == 0){	
				return true;
			}						
			return false;
		}
	 
	
	

    }]);