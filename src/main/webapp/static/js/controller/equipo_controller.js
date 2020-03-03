'use strict';

angular.module('myApp').controller('EquipoController',['$scope','$routeParams','CONFIG','EquipoService',function($scope, $routeParams,CONFIG,EquipoService) {
					
					var self = this;
					self.equipo = {
						id : null,
						nombre : '',
						descripcion : '',
						division : null
					};
					self.equipos = [];
					
					
					self.division = {
							id : null,
							nombre : '',
							descripcion : ''
						};
					self.divisiones = [];
					
					self.showEditEquipo = false;
					
					self.temporada = [];
					

					self.submit = submit;
					self.edit = edit;
					self.remove = remove;
					self.reset = reset;
					self.showEdit = showEdit;

					buscarTodos();
					buscarDivisiones();
//					buscarTemporada();
					$scope.selectedDiv = self.divisiones[0]

					function buscarTodos() {
						var idTemporada = CONFIG.VARTEMPORADA.id
						console.log("[equipo_controller]  idTemporada]:",CONFIG.VARTEMPORADA.id);
						if(CONFIG.CAT_EQUIPOS == null ){
							EquipoService.buscarTodos(idTemporada).then(function(d) {
								self.equipos = d;
								CONFIG.CAT_EQUIPOS = d;
							}, function(errResponse) {
								console.error('[equipo_controller] Error while fetching buscarTodos()');
							});
						}else{
							self.equipos = CONFIG.CAT_EQUIPOS ;
						}
					}
					
					function buscarTemporada() {
						EquipoService.buscarTemporada().then(function(d) {
							self.temporada = d;
							console.error('temporada --- >',d);
						}, function(errResponse) {
							console.error('Error while fetching temporada');
						});
					}
					function buscarDivisiones() {
						if( CONFIG.CAT_DIV == null ){
							EquipoService.buscarDivisiones().then(function(d) {
								console.log("Entre Buscar Divisiones-->",d)
								self.divisiones = d;
								CONFIG.CAT_DIV = d;
							}, function(errResponse) {
								console.error('Error while fetching Divisiones');
							});
						}else{
							self.divisiones = CONFIG.CAT_DIV;
						}
					}

					function crearEquipo(user) {
						EquipoService.crearEquipo(user).then(buscarTodos,
								function(errResponse) {
									console.error('Error while creating User');
								});
					}

					function modificarEquipo(equipo, id) {
						EquipoService.modificarEquipo(equipo, id).then(
								buscarTodos, function(errResponse) {
									console.error('Error while updating User');
								});
					}

					function deleteEquipo(id) {
						EquipoService.deleteEquipo(id).then(buscarTodos,
								function(errResponse) {
									console.error('Error while deleting User');
								});
					}

					function submit(division) {
						console.log("division:"+division)
						self.equipo.division = division
						if (self.equipo.id === null) {
							console.log('Saving New User', self.equipo);
							crearEquipo(self.equipo);
						} else {
							console.log(self.equipo)
							modificarEquipo(self.equipo, self.equipo.id);
							console.log('User updated with id ', self.equipo);
						}
						reset();
					}

					function edit(id) {
						console.log('id to be edited', id);
						for (var i = 0; i < self.equipos.length; i++) {
							if (self.equipos[i].id === id) {
								self.equipo = angular.copy(self.equipos[i]);
								obtenerDivision(self.equipo.division.id)
								console.log("IDEquipo:"+self.equipo.id)
								break;
							}
						}
					}
					function obtenerDivision(valor){
						var div = null  
						for(var i = 0; i < self.divisiones.length; i++){
							console.log("-->division]:"+valor + " = "+ self.divisiones[i].id) 
						    if(self.divisiones[i].id == valor){
						    	console.log("-->Encontre division]:"+self.divisiones[i].nombre)
						      $scope.selectedDiv =  self.divisiones[i];
						      //self.equipo.division = angular.copy($scope.selectedDiv)
							console.log("-->Encontre division1]:"+$scope.selectedDiv.nombre)
							break;
						    }
						  }
			
						}

					function remove(id) {
						console.log('id to be deleted', id);
						if (self.equipo.id === id) {// clean form if the user to
													// be deleted is shown
													// there.
							reset();
						}
						deleteEquipo(id);
					}

					function reset() {
						self.equipo = {
							id : null,
							nombre : '',
							descripcion : '',
							totalJugadores : 0
						};
						$scope.myForm.$setPristine(); // reset Form
					}
					function showEdit(roles,equi,idEquipo) {						
						if((roles.includes('Manager') && equi == idEquipo) || roles.includes('Admin')){	
							return true;
						}						
						return false
					}

				} ]);