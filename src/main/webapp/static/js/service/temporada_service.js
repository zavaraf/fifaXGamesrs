'use strict';
 
angular.module('myApp').factory('TemporadaService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI_E = IP+'/rest/temporada/';
 
    var factory = {
    	buscarTemporada   : buscarTemporada
    };
 
    return factory;
 
 
    function buscarTemporada() {
    	
    	
        var deferred = $q.defer();
        const headerDict = {
        		  'Content-Type': 'application/json',
        		  'Accept': 'application/json',
        		  'Access-Control-Allow-Origin': '*',
        	      'Access-Control-Allow-Headers': 'Content-Type',
        	      'Access-Control-Allow-Methods': 'GET,POST,OPTIONS,DELETE,PUT',
        	      'Authorization': 'Bearer key',
        		}

        		const requestOptions = {                                                                                                                                                                                 
        		  headers: new Headers(headerDict), 
        		};
        
        $http.get(REST_SERVICE_URI_E+'buscarTemporada',requestOptions)
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