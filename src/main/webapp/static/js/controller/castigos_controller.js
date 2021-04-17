'use strict';
 
angular.module('myApp')
.controller('CastigosController', ['$scope','$routeParams','CONFIG', 'CastigosService', 'TorneoLMService',
	function($scope, $routeParams,CONFIG,CastigosService,TorneoLMService) {
	var self = this;
		
	self.catalogo = [];
	self.catalogoCastigo = [{ codigo : 'puntos'},{ codigo : 'goles'}];
	
	self.castigoSubmit;
	
	self.torneos = CONFIG.VARTEMPORADA.torneos
	
	self.findAllCastigos         = findAllCastigos;
	self.updateCastigos         = updateCastigos;
	
	findAllCastigos();
	findTorneos();
	
	function findTorneos(){
		//TorneoLMService
	}
	
	function findAllCastigos(){
		CastigosService.findAllCastigos()
            .then(
            function(d) {
            	console.log("-----[CastigosController]  findAllCastigos]:",d)
                self.catalogo = d;
            },
            function(errResponse){
                console.error('----[CastigosController]  Error while fetching findAllCastigos()');
            }
        );
    }
	
	function updateCastigos(castigo) {
		console.log("------------------->castigo]:",castigo)
		
		var castigoMOd = {};
		
		castigoMOd.castigo = castigo.tipoconcepto.codigo
		castigoMOd.numero = castigo.numero
		castigoMOd.observaciones = castigo.observaciones
		castigoMOd.idEquipo = castigo.equipo.id
		castigoMOd.idTorneo = castigo.torneo.id
		
		console.log("------------------->castigo]:",castigoMOd)
		
		
		
		CastigosService
				.updateCastigos(castigoMOd)
				.then(
						function(d) {

							console.log("CastigosController-updateCastigos]:",
											d)

						   findAllCastigos();
							return d;
						},
						function(errResponse) {
							console
									.error('[CastigosController] Error while updateCastigos()');
						});
		return null;
	}
	
}]);