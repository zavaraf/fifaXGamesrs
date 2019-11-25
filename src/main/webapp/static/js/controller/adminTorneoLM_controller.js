'use strict';
var app = angular.module('myApp'); 




app.controller('AdminTorneoLMController', ['$scope','$routeParams','CONFIG','TorneoLMService','UserService','EquipoService',
			function($scope,$routeParams,CONFIG,TorneoLMService,UserService,EquipoService) {
	var self = this;
	
	self.tablaGeneral;
	self.jornadas;
	self.jornadaEdit;
	self.players;
	self.golesJornada;
	self.divisiones;
	self.divisionSelect;
	self.isEdit = false;
	self.jornadasEdit = [];
	
	
	self.getGenerarJornadas = getGenerarJornadas;
	self.getJornadas = getJornadas;
	self.addJornadas = addJornadas;
	self.print = print;
	self.addJornadasEdit = addJornadasEdit;
	
	
	buscarDivisiones();
	
	function print(e){
		console.log("--------->",e)
		console.log("--------->",self.jornadas)
	}
	
	function addJornadasEdit(jor){
		var isJornada = false;
		if(self.isEdit== true){
			if(self.jornadasEdit != null && self.jornadasEdit.length >0 ){
				for(var i = 0; i<self.jornadasEdit.length; i++){
					if(self.jornadasEdit[i].numeroJornada == jor.numeroJornada){
						self.jornadasEdit[i] = jor;
						isJornada = true;
						console.log("Edit Jornada:",jor);
						break;
					}
				}
			}
			if(isJornada == false){
				self.jornadasEdit.push(jor);
				console.log("Add Jornada:",jor);
			}
		}
	}
	
	 function buscarDivisiones() {
			EquipoService.buscarDivisiones().then(function(d) {
				console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",d)
				self.divisiones = d;
				if(self.divisiones!= null && self.divisiones.length >0){
					 self.divisionSelect = self.divisiones[0];
					 console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",self.divisionSelect)
					 getJornadas();	
				 }
				
				
				
			}, function(errResponse) {
				console.error('Error while fetching TorneoLMConroller-buscarDivisiones');
			});
			
		}
	
	
	 function getGenerarJornadas(){
		TorneoLMService.getGenerarJornadas(self.divisionSelect.id,0)
	            .then(
	            function(d) {
	            	
	            	self.jornadas = d;
	                
	                console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
	                console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
	                
	                return d;
	            },
	            function(errResponse){
	                console.error('[TorneoLMService] Error while fetching TorneoLMService()');
	            }
	        );
	        return null;
	    }
	 
	 function getJornadas(){
			TorneoLMService.getJornadas(self.divisionSelect.id,0)
	                .then(
	                function(d) {
	                    self.jornadas = d;
	                    
	                    if(self.jornadas!= null && self.jornadas!=''){
	                    	self.isEdit=true;
	                    }else{
	                    	self.isEdit=false;
	                    	self.jornadasEdit = [];
	                    }
	                    console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
	                    console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
	                    
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
	                }
	            );
	            return null;
	        }
	 
	 function addJornadas(){
		
		 var jor;
		 jor = self.jornadas;
		 if(self.isEdit==true){
			 jor = self.jornadasEdit;
		 }
		TorneoLMService.addJornadas(self.divisionSelect.id,jor)
                .then(
                function(d) {
                    
                    
                    console.log("TorneoLMService-addJornadas]:",d)
                    
                    self.isEdit = true;
                    return d;
                },
                function(errResponse){
                    console.error('[TorneoLMService] Error while addJornadas TorneoLMService()');
                }
            );
            return null;
        }
	 
	
	

    }]);