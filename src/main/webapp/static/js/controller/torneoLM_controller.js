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
	self.getGruposTorneo = getGruposTorneo;
	self.getTablaGrupo = getTablaGrupo;
	self.guardarJornada = guardarJornada;
	self.deletedGol   = deletedGol;
	
	buscarDivisiones()
	
	function getTorneos(){
		return CONFIG.VARTEMPORADA.torneos;
	}
	
	function getJornadaActual (){
		
		if(self.jornadaSelect == null || self.jornadaSelect.length == 0){
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
		}else{
			if(self.jornadas!= null && self.jornadas!= ''){
				for (var i = 0 ; i<=self.jornadas.length ; i ++){
					if(self.jornadas[i].numeroJornada == self.jornadaSelect[0].numeroJornada){
						self.jornadaSelect = [];
					    self.jornadaSelect.push( self.jornadas[i]); 
						console.log("get Jornada Select]:",self.jornadaSelect);
						break;
					}
					
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
                    
                    console.log("TorneoLMService getTablaGeneral]:",self.tablaGeneral)
                    
                    getJornadas();
                    return d;
                },
                function(errResponse){
                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
                }
            );
            return null;
        }
	
	 function getJornadas(){
//			TorneoLMService.getJornadas(self.divisionSelect.id,1)
//	                .then(
//	                function(d) {
//	                    self.jornadas = d;
		 
		 				self.jornadas = self.tablaGeneral.jornadas;
	                    
	                    console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
	                    console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
	                    getJornadaActual()
//	                    return d;
//	                },
//	                function(errResponse){
//	                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
//	                }
//	            );
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
				
				if(golesJornada[i].idEquipo == idEquipo && golesJornada[i].deleted == 0){
					playersGoles.push(golesJornada[i]);
				}			
			}
		 }
		 
		 return playersGoles;
		 
	 }
	 
//	 function addGoles(idJugador,idEquipo,jornadaVar) {
//		 
//		 TorneoLMService.addGoles(idJugador,idEquipo,jornadaVar.id,jornadaVar.idJornada)
//         .then(
//         function(d) {
//             self.golesJornada = d;
//             
//             console.log("TorneoLMService-addGoles]:",self.golesJornada)
//             
//             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
//             
//             getTablaGeneral()
//             getJornadas()
//             
//             
//             return d;
//         },
//         function(errResponse){
//             console.error('[addGoles] Error while addGoles()');
//         }
//     );
//     return null;
//		 
//	 }
function addGoles(jugador,idEquipo,jornadaVar) {
		 
//		 TorneoLMService.addGoles(jugador.id,idEquipo,jornadaVar.id,jornadaVar.idJornada)
//         .then(
//         function(d) {
//             self.golesJornada = d;
//             
//             console.log("TorneoLMService-addGoles]:",self.golesJornada)
             
             
             
             //getTablaGeneral()


            
             
             console.log("Jugador Agregar gol]-------",jugador)
        	 var jugadorVal = new Object();
        	 jugadorVal.idEquipo          = idEquipo;
        	 jugadorVal.idPersona         = jugador.id;
        	 jugadorVal.sobrenombre       = jugador.sobrenombre;
        	 jugadorVal.nombreCompleto    = jugador.nombreCompleto;
        	 jugadorVal.isAutogol         = (jugador.equipo.id == idEquipo) ? 0 : 1;
        	 jugadorVal.deleted           = 0;
        	 jugadorVal.id                = 0;
        	 
        	 
        	 
             if(self.jornadaEdit.golesJornada != null){
            	 self.jornadaEdit.golesJornada.push(jugadorVal);
             }else{
            	 var golesJornadaVal = [];
            	 golesJornadaVal.push(jugadorVal);
            	 self.jornadaEdit.golesJornada = golesJornadaVal;
            	 
             }
             
             
             if(self.jornadaEdit.idEquipoLocal == idEquipo){
            	 if(self.jornadaEdit.golesLocal == null){
            		 self.jornadaEdit.golesLocal = 1
            		 self.jornadaEdit.golesVisita = 0
            	 }else{
            		 var golesVal = 0;
            		 self.jornadaEdit.golesJornada.forEach(function (elemento, indice, array) {
            			    if(elemento.idEquipo == self.jornadaEdit.idEquipoLocal && elemento.deleted == 0 ){
            			    	golesVal ++;
            			    }
            			});
            		 self.jornadaEdit.golesLocal = golesVal
            	 }
             }
             if(self.jornadaEdit.idEquipoVisita == idEquipo){
            	 if(self.jornadaEdit.golesVisita == null){
            		 self.jornadaEdit.golesVisita = 1
            		 self.jornadaEdit.golesLocal = 0
            	 }else{
            		 var golesVal = 0;
            		 self.jornadaEdit.golesJornada.forEach(function (elemento, indice, array) {
            			    if(elemento.idEquipo == self.jornadaEdit.idEquipoVisita && elemento.deleted == 0 ){
            			    	golesVal ++;
            			    }
            			});
            		 self.jornadaEdit.golesVisita = golesVal
            	 }
             }
             
//    		 if(jornadaVar!=null){
//    			 console.log("------------------>Entrando",jornadaVar)
//    		 for(var i=0;i<self.jornadas.length;i++){
//    			 console.log("------------------>Entrando Jornadas",self.jornadas[i])
//    				if(self.jornadas[i].idJornda == jornadaVar.idJornada){
//    					console.log("Jornada encontrada",self.jornadas[i])
//    					    					
//    					for(var j=0;j<self.jornadas[i].jornada.length;j++){
//    						console.log("------>Entrando  +++++ Juegos",self.jornadas[i].jornada[j])
//    						if(self.jornadas[i].jornada[j].id == jornadaVar.id){
//    							console.log("Igualando jornada ",self.jornadaEdit)
//    							self.jornadas[i].jornada[j] = self.jornadaEdit;
//    							break;
//    						}
//    						
//    					}
//    					break;
//    				}			
//    			}
//    		 }
             
             
//        va queurn null;
		 
	 }
	function deletedGol(jugador,idEquipo) {
		
		var indexJ =  self.jornadaEdit.golesJornada.indexOf(jugador);
		
		console.log(indexJ)
		self.jornadaEdit.golesJornada[indexJ].deleted = 1;
		
		if(self.jornadaEdit.idEquipoLocal == idEquipo){
			self.jornadaEdit.golesLocal = self.jornadaEdit.golesLocal -1;
		}
		if(self.jornadaEdit.idEquipoVisita == idEquipo){
			self.jornadaEdit.golesVisita = self.jornadaEdit.golesVisita -1;
		}
		
		
	}
	 
//	 function addImagen(idEquipo,jornadaVar,img) {
//		 
//		 TorneoLMService.addImagen(idEquipo,jornadaVar.id,jornadaVar.idJornada,img)
//         .then(
//         function(d) {
//            
//             
//             console.log("TorneoLMService-addImagen]:",d)
//             
//             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
//             
//             
//             return d;
//         },
//         function(errResponse){
//             console.error('[addGoles] Error while addGoles()');
//         }
//     );
//     return null;
//		 
//	 }
    
	function addImagen(idEquipo,jornadaVar,img) {	           
            
            console.log("TorneoLMService-addImagen]:")
            
            //getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
            
            if(self.jornadaEdit.imagenes == null ){
            	var imagenes = [];
            	
            	self.jornadaEdit.imagenes = imagenes; 
            }
            var imgO = new Object();
            imgO.img = img;
            self.jornadaEdit.imagenes.push(imgO);
            
            console.log("TorneoLMService-addImagen]:",self.jornadaEdit)
		 
	 }
	
	
	function guardarJornada(jornadaVar) {	           
        
		console.log("Jornada a editar]:",self.divisionSelect)
			 TorneoLMService.guardarJornada(jornadaVar,self.divisionSelect.id)
		      .then(
		      function(d) {
		         
		          
		          console.log("TorneoLMService-guardarJornada]:",d)
		          if(d.status == 0){
			          self.tablaGeneral = d.data
			          getJornadas();
		          }
		          
		         // getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
		          
		          
		          return d;
		      },
		      function(errResponse){
		          console.error('[guardarJornada] Error while addGoles()');
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
	 
	 function getGruposTorneo(torneoSelect){
			console.log("-----------getGruposTorneo-------->Torneo]:",torneoSelect) 
			if(torneoSelect.tipoTorneo){
			TorneoLMService.getGruposTorneo(torneoSelect.id)
		            .then(
		            function(d) {
		            	
		            	self.gruposTorneo = d;
		            	
		                console.log("TorneoLMService-getGruposTorneo]:",d)
		                
		                
		                return d;
		            },
		            function(errResponse){
		                console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
		            }
		        );
			}else{
				self.gruposTorneo = [];
			}
		        return null;
		    }
	 
	 function getTablaGrupo(grupo){
		 console.log("Gurpo----",grupo)
		 
		 var tablaGeneralGrupo = [];
		 
		 if (self.tablaGeneral.tablaGeneral!= null){
		 for (var i = 0 ; i<=self.tablaGeneral.tablaGeneral.length ; i ++){
			 try{
				if(self.tablaGeneral.tablaGeneral[i].nombreGrupo == grupo.numero){
					//console.log("Registro..ADD....",self.tablaGeneral[i])
					tablaGeneralGrupo.push( self.tablaGeneral.tablaGeneral[i]); 
					
				}
		     }catch(error){}
				
			}
		 }
		 return tablaGeneralGrupo;
		 
		 
		 
	 }
	 
	
	
	

    }]);