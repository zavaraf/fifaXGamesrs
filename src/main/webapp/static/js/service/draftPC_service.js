'use strict';
 
angular.module('myApp').factory('DraftPCService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/draft/pc/';
    
 
    var factory = {
    	buscarJugadoresdraft     : buscarJugadoresdraft,
    	buscarJugadoresdraftByID : buscarJugadoresdraftByID,
    	createInitialDraft       : createInitialDraft,
    	updateDraft              : updateDraft,
    	confirmPlayer            : confirmPlayer
    };
 
    return factory;
	
    function buscarJugadoresdraft(idTorneo) {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllPC/'+idTorneo)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    function buscarJugadoresdraftByID(idEquipo, idTorneo) {
    	var deferred = $q.defer();
    	$http.get(REST_SERVICE_URI+'findAll/'+idEquipo+'/'+idTorneo)
    	.then(
    			function (response) {
    				console.log(response.data)
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while fetching Users');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    }
    function createInitialDraft(id,monto,manager,observaciones,idEquipo,idTorneo) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'initialDraft/'+id+"/"+monto+"/"+manager
    								+"/"+observaciones+"/"+idEquipo+"/"+idTorneo;
    	
    	
    	console.log(request);
    	$http.post(request)
    	.then(
    			function (response) {
    				console.log(response.data)
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while fetching Users');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    }
    function updateDraft(id,monto,manager,observaciones,ofertaInicial,idEquipo,idTorneo) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'updateDraft/'+id+"/"+monto+"/"+manager
    							+"/"+observaciones+"/"+ofertaInicial+"/"+idEquipo+"/"+idTorneo;
    	console.log(request);
    	$http.post(request)
    	.then(
    			function (response) {
    				console.log(response.data)
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while fetching Users');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    }
    function confirmPlayer(id,idEquipo,idTorneo) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'confirmPlayer/'+id+"/"+idEquipo+"/"+idTorneo;
    	console.log(request);
    	$http.post(request)
    	.then(
    			function (response) {
    				console.log(response.data)
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while fetching Users');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    }
}]);