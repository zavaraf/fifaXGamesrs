'use strict';
 
angular.module('myApp').factory('CastigosService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/catalogs/';
		 
    var factory = {
    		findAllCastigos: findAllCastigos,
    		updateCastigos: updateCastigos
    	
    };
		
    return factory;
    

    function findAllCastigos() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllCastigos/'+CONFIG.VARTEMPORADA.id)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('[CatalogoService] Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function updateCastigos(castigo) {
        var deferred = $q.defer();
        
        var request = REST_SERVICE_URI+'updateCastigo/'+CONFIG.VARTEMPORADA.id;
      
        console.log(request)
        $http.post(request,castigo)
            .then(
            function (response) {
               console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while updateConceptos',errResponse);
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
	
	
}]);