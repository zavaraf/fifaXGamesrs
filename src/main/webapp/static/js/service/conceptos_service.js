'use strict';
 
angular.module('myApp').factory('CatalogoService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/catalogs/';
		 
    var factory = {
    		findAllCatalogs: findAllCatalogs
    	
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
	
	
}]);