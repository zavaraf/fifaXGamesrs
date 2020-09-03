'use strict';
 
angular.module('myApp').factory('CatalogoService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/catalogs/';
		 
    var factory = {
    		findAllCatalogs: findAllCatalogs,
    		updateConceptos: updateConceptos
    	
    };
		
    return factory;
    

    function findAllCatalogs() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllCatalogs')
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
    
    function updateConceptos(nombre,descripcion,tipo) {
        var deferred = $q.defer();
        
        var request = REST_SERVICE_URI+'updateCatalogos/'+nombre+'/'+descripcion+'/'+tipo;
      
        console.log(request)
        $http.post(request)
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