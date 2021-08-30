'use strict';
 
angular.module('myApp').factory('SalonFamaService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
	
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
	var REST_SERVICE_URI = IP+'/rest/temporada/lm/';
		 
    var factory = {
    		getSalon  : getSalon
    	
    };
		
    return factory;
    

    function getSalon() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'getSalonFama')
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('[CatalogoService] Error while fetching salonFama');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
   
	
	
}]);