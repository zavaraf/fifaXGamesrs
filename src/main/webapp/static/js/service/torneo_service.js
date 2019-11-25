'use strict';
 
angular.module('myApp').factory('TorneoService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI_E = IP+'/rest/torneos/';
 
    var factory = {
    	buscarTorneos   : buscarTorneos
    };
 
    return factory;
 
 
    function buscarTorneos() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI_E+'buscarTorneos')
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