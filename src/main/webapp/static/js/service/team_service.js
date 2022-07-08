'use strict';
 
angular.module('myApp').factory('TeamService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI  = IP+'/rest/equipo/team/';
	var REST_SERVICE_URIS = IP+'/rest/sponsor/';
	var REST_SERVICE_URIDRAFT = IP+'/rest/draft/';
	
	var factory = {
	        findAll           : findAll,
	        findEquipoAll     : findEquipoAll,
	        findSponsorByDiv  : findSponsorByDiv,
	        submitSponsor     : submitSponsor,
	        buscarCatFinanzas :buscarCatFinanzas,
	        submitFinanzas    :submitFinanzas,
	        submitDatos       :submitDatos,
	        guardarObj        : guardarObj,
	        findPresByIdEquipo         : findPresByIdEquipo ,
	        deletePrestamo    : deletePrestamo
	    };
	return factory;
	
	function findAll(teamID,idTemporada) {
		
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+teamID+"/"+idTemporada)
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
	function findEquipoAll(teamID, idTemporada) {
		
		var deferred = $q.defer();
		$http.get(REST_SERVICE_URI+"all/"+teamID+"/"+idTemporada, { timeout: 999999 })
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
	function findSponsorByDiv(divID) {
		
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URIS+"division/"+divID)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Sponsors');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
	function buscarCatFinanzas() {
		
		var deferred = $q.defer();
		$http.get(REST_SERVICE_URIS+"catalogoFinanzas")
		.then(
				function (response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Sponsors');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	function submitSponsor(idEquipo,opcionales,idSponsor) {
		
		var deferred = $q.defer();
		var serviceRequest = REST_SERVICE_URIS+idEquipo+"/"+opcionales+"/"+idSponsor
		console.log("Request]:",serviceRequest)
		$http.post(serviceRequest)
		.then(
				function (response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Sponsors');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	function submitFinanzas(catFinanzas,monto,equipo,idTemporada) {
		
		var deferred = $q.defer();
		$http.post(REST_SERVICE_URIS+"finanzas/"+catFinanzas.id+"/"+monto+"/"+idTemporada,equipo)
		.then(
				function (response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Sponsors');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	function submitDatos(monto,equipo,idTemporada) {
		
		var deferred = $q.defer();
		$http.post(REST_SERVICE_URIS+"finanzas/presupuesto/"+monto+"/"+idTemporada,equipo)
		.then(
				function (response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Sponsors');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	function guardarObj(objetivos,idEquipo,idTemporada) {
		
		var deferred = $q.defer();
		var myJSON = JSON.stringify(objetivos)
		$http.post(REST_SERVICE_URIS+"finanzas/presupuesto/objetivos/"+idEquipo+"/"+idTemporada,myJSON)
		.then(
				function (response) {
					console.log(response.data)
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error while fetching Sponsors');
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	
	function findPresByIdEquipo(idEquipo,idTemporada){
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URIDRAFT+"buscarTodos/"+idEquipo+"/"+idTemporada;
    	$http.get(request)
    	.then(
    			function (response) {
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while find players');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    	
    }
	
	function deletePrestamo(id) {
        var deferred = $q.defer();
        $http.delete(REST_SERVICE_URIDRAFT+"player/"+id)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while deleting User');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
	
}]);