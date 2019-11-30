'use strict';

//http://fifaapp-env-1.kvdjpbscsv.us-east-2.elasticbeanstalk.com/
//'IP_PROD': 'http://env-2654648.jl.serv.net.mx/fifaApp',
angular.module('myApp')
.constant('CONFIG', {
    'VARTORNEO' : '',
    'PROD': false,
    'IP_PROD': 'http://env-2654648.jl.serv.net.mx/fifaApp',
    'IP_DES':'http://localhost:8081/fifaApp'
})
.controller('TorneoController',['$scope','$routeParams','CONFIG','TorneoService',function($scope, $routeParams,CONFIG,TorneoService) {
					
					var self = this;
					
					 
					self.torneos = [];
					self.selectedTor;
					
					self.cambiarTorneo = cambiarTorneo;
				
					buscarTorneos();
				
					function buscarTorneos() {
						TorneoService.buscarTorneos().then(function(d) {
							self.torneos = d;
							console.error('Torneos --- >',d);
							self.selectedTor = self.torneos.length >0 ? self.torneos[self.torneos.length-1] : null;
							//$scope.idTorneo = ($scope.idTorneo == null || $scope.idTorneo === undefined) ? self.selectedTor : $scope.idTorneo; 
						    
							CONFIG.VARTORNEO = self.selectedTor 
									
						    console.log('Torneos Seleccionado--- >',CONFIG.VARTORNEO );
							console.log('Torneos Seleccionado2--- >',self.selectedTor);
						}, function(errResponse) {
							console.error('Error while fetching Torneos');
						});
					}
					function cambiarTorneo() {
					
						CONFIG.VARTORNEO = self.selectedTor
									
					    console.log('Cambiando Torneo ] ------->  Torneos Seleccionado--- >',CONFIG );
						 
						
					}
				

				} ]);