'use strict';
 
angular.module('myApp')
.controller('SalonFamaController', ['$scope','$routeParams','CONFIG', 'SalonFamaService', 
	function($scope, $routeParams,CONFIG, SalonFamaService) {
	var self = this;
		
	self.salonFama ;
	self.showresumen = true ;
	self.showdetalle = false ;
	
	
	
	self.getSalon         =    getSalon;
	
	
	getSalon();
	
	function getSalon(){
		SalonFamaService.getSalon()
            .then(
            function(d) {
            	console.log("[SalonFamaController]  getSalon]:",d)
                self.salonFama = d;
            },
            function(errResponse){
                console.error('[SalonFamaController]  Error while fetching getSalon()');
            }
        );
    }
	
	
	
}]);