'use strict';

//'IP_PROD' : 'http://fifaapp-env-1.kvdjpbscsv.us-east-2.elasticbeanstalk.com',
//'IP_DES' : 'http://localhost:8081/fifaApp',
angular
		.module('myApp')
		.constant(
				'CONFIG',
				{
					'VARTEMPORADA' : '',
					'PROD' : true,
					'IP_PROD' : 'http://fifaxgamers.jvmhost.net/fifaApp',
					'IP_DES' : 'http://localhost:8081/fifaApp',
					'JUGADORES' : null,
					'EQUIPOS' : null,
					'CAT_EQUIPOS' : null,
					'CAT_DIV' : null,
					'ID_EQUIPO' : 0,
					'USERID' : null

				})
		.controller(
				'TemporadaController',
				[
						'$scope',
						'$routeParams',
						'CONFIG',
						'TemporadaService',
						function($scope, $routeParams, CONFIG, TemporadaService) {

							var self = this;

							self.temporada = [];
							self.selectedTor;

							self.cambiarTemporada = cambiarTemporada;
							self.mostrar = mostrar;

							buscarTemporada();
							
							function mostrar(idEquipo,user){
								CONFIG.ID_EQUIPO = idEquipo
								CONFIG.USERID = user
								return true;
							}

							function buscarTemporada() {
								TemporadaService
										.buscarTemporada()
										.then(
												function(d) {
													self.temporada = d;
													console.error(
															'temporada --- >',
															d);
													self.selectedTor = self.temporada.length > 0 ? self.temporada[self.temporada.length - 1]
															: null;
													// $scope.idTemporada =
													// ($scope.idTemporada ==
													// null ||
													// $scope.idTemporada ===
													// undefined) ?
													// self.selectedTor :
													// $scope.idTemporada;

													CONFIG.VARTEMPORADA = self.selectedTor

													console
															.log(
																	'temporada Seleccionado--- >',
																	CONFIG.VARTEMPORADA);
													console
															.log(
																	'temporada Seleccionado2--- >',
																	self.selectedTor);
												},
												function(errResponse) {
													console
															.error('Error while fetching temporada');
												});
							}
							function cambiarTemporada() {

								CONFIG.VARTEMPORADA = self.selectedTor

								console
										.log(
												'Cambiando Temporada ] ------->  temporada Seleccionado--- >',
												CONFIG);

							}

						} ]);