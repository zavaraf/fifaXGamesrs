'use strict';
 
angular.module('myApp').factory('DraftPCService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/draft/pc/';
    
 
    var factory = {
    	buscarJugadoresdraft     : buscarJugadoresdraft,
    	buscarJugadoresdraftByID : buscarJugadoresdraftByID,
    	createInitialDraft       : createInitialDraft,
    	updateDraft              : updateDraft,
    	confirmPlayer            : confirmPlayer,
    	getHistoricoDraft        : getHistoricoDraft,
    	updateDraftAdmin         : updateDraftAdmin
    };
 
    return factory;
	
    function getHistoricoDraft(idDraft,idJugador) {
    	console.log("SErvice getHIstorico:"+idDraft+" - idJugador:"+idJugador)
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'getHistorico/'+idDraft+'/'+idJugador+'/'+CONFIG.VARTEMPORADA.id)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getHistorico Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function buscarJugadoresdraft(idTemporada) {
    	console.log("buscarJugadoresdraft: INICIO");
               
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllPC/'+idTemporada)
		.then(
				function (response) {
					console.log("buscarJugadoresdraft: ",response.data);
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Users');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
    }
    
    function buscarJugadoresdraftByID(idEquipo, idTemporada) {
    	var deferred = $q.defer();
    	$http.get(REST_SERVICE_URI+'findAll/'+idEquipo+'/'+idTemporada)
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
    function createInitialDraft(id,monto,manager,observaciones,idEquipo,idTemporada) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'initialDraft/'+id+"/"+monto+"/"+manager
    								+"/"+observaciones+"/"+idEquipo+"/"+CONFIG.VARTEMPORADA.id;
    	
    	
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
    function updateDraft(id,monto,manager,observaciones,ofertaInicial,idEquipo,idTemporada) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'updateDraft/'+id+"/"+monto+"/"+manager
    							+"/"+observaciones+"/"+ofertaInicial+"/"+idEquipo+"/"+CONFIG.VARTEMPORADA.id;
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
    function updateDraftAdmin(id,monto,manager,observaciones,ofertaInicial,idEquipo,idTemporada) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'updateDraftAdmin/'+id+"/"+monto+"/"+manager
    							+"/"+observaciones+"/"+ofertaInicial+"/"+idEquipo+"/"+CONFIG.VARTEMPORADA.id;
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
    function confirmPlayer(id,idEquipo,idTemporada) {
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+'confirmPlayer/'+id+"/"+idEquipo+"/"+CONFIG.VARTEMPORADA.id;
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