'use strict';
 
angular.module('myApp')
.controller('CatalogoController', ['$scope','$routeParams','CONFIG', 'CatalogoService', 
	function($scope, $routeParams,CONFIG, CatalogoService) {
	var self = this;
		
	self.catalogo = [];
	self.catalogoFinanzas = [{ codigo : 'ingreso'},{ codigo : 'egreso'}];
	
	self.catalogoSubmit;
	
	self.findAllCatalogs         = findAllCatalogs;
	self.updateConceptos         = updateConceptos;
	
	findAllCatalogs();
	
	function findAllCatalogs(){
		CatalogoService.findAllCatalogs()
            .then(
            function(d) {
            	console.log("[CatalogoController]  usuarios]:",d)
                self.catalogo = d;
            },
            function(errResponse){
                console.error('[CatalogoController]  Error while fetching findAllCatalogs()');
            }
        );
    }
	
	function updateConceptos(nombre, descripcion,tipo) {
		console.log("------------------->addTorneoGrupo]:",tipo)
		if(tipo.codigo == 'egreso'){
			tipo = 2;
		}else{
			tipo = 1;
		}
		CatalogoService
				.updateConceptos(nombre, descripcion,tipo)
				.then(
						function(d) {

							console.log("ConceptosController-updateConceptos]:",
											d)

						   findAllCatalogs();
							return d;
						},
						function(errResponse) {
							console
									.error('[ConceptosController] Error while fetching updateConceptos()');
						});
		return null;
	}
	
}]);