'use strict';

//http://fifaapp-env-1.kvdjpbscsv.us-east-2.elasticbeanstalk.com/
//'IP_PROD': 'http://env-2654648.jl.serv.net.mx/fifaApp',
angular.module('myApp')
.constant('CONFIG', {
    'VARTEMPORADA' : '',
    'PROD': false,
    'IP_PROD': 'http://fifaapp-env-1.kvdjpbscsv.us-east-2.elasticbeanstalk.com',
    'IP_DES':'http://localhost:8080/fifaApp'
})
.controller('TemporadaController',['$scope','$routeParams','CONFIG','TemporadaService',function($scope, $routeParams,CONFIG,TemporadaService) {
					
					var self = this;
					
					 
					self.temporada = [];
					self.selectedTor;
					
					self.cambiarTemporada = cambiarTemporada;
				
					buscarTemporada();
				
					function buscarTemporada() {
						TemporadaService.buscarTemporada().then(function(d) {
							self.temporada = d;
							console.error('temporada --- >',d);
							self.selectedTor = self.temporada.length >0 ? self.temporada[self.temporada.length-1] : null;
							//$scope.idTemporada = ($scope.idTemporada == null || $scope.idTemporada === undefined) ? self.selectedTor : $scope.idTemporada; 
						    
							CONFIG.VARTEMPORADA = self.selectedTor 
									
						    console.log('temporada Seleccionado--- >',CONFIG.VARTEMPORADA );
							console.log('temporada Seleccionado2--- >',self.selectedTor);
						}, function(errResponse) {
							console.error('Error while fetching temporada');
						});
					}
					function cambiarTemporada() {
					
						CONFIG.VARTEMPORADA = self.selectedTor
									
					    console.log('Cambiando Temporada ] ------->  temporada Seleccionado--- >',CONFIG );
						 
						
					}
				

				} ]);