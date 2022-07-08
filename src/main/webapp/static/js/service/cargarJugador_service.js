'use strict';
 
angular.module('myApp').factory('CargarJugadorService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/catalogs/';
		 
    var factory = {
    		confirmarJugadores: confirmarJugadores,
    		updateCastigos: updateCastigos
    	
    };
		
    return factory;
    

    function confirmarJugadores(judadores) {
        var deferred = $q.defer();
        
        console.log(judadores)
        $http.post(REST_SERVICE_URI+'confirmarJugadores/'+CONFIG.VARTEMPORADA.id,judadores)
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