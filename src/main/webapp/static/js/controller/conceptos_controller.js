'use strict';
 
angular.module('myApp')
.controller('CatalogoController', ['$scope','$routeParams','CONFIG', 'CatalogoService', 
	function($scope, $routeParams,CONFIG, CatalogoService) {
	var self = this;
		
	self.catalogo = [];
	self.catalogoFinanzas = [{ codigo : 'ingreso'},{ codigo : 'egreso'}];
	
	self.catalogoSubmit;
	
	self.findAllCatalogs         = findAllCatalogs;
	
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
	
}]);