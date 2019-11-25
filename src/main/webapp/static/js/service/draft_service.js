'use strict';
 
angular.module('myApp').factory('DraftService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI = IP+'/rest/draft/';
    var REST_SERVICE_URIP = IP+'/rest/user/';
    
 
    var factory = {
      buscarTodos     : buscarTodos,
      crearPrestamo   : crearPrestamo,
      findPlayersByIdEquipo: findPlayersByIdEquipo,
      deletePrestamo  : deletePrestamo
    };
 
    return factory;
 
    function buscarTodos(idTorneo) {
        var deferred = $q.defer();
        
        $http.get(REST_SERVICE_URI+'buscarTodos/'+idTorneo)
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
    
    function crearPrestamo(jugador,idEquipo,idTorneo) {
        var deferred = $q.defer();
        
        var request = REST_SERVICE_URI+idEquipo+"/"+idTorneo;
        $http.post(request,jugador)
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
    
    function findPlayersByIdEquipo(idEquipo){
      var deferred = $q.defer();
      
      var request = REST_SERVICE_URIP+"player/"+idEquipo;
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
        
        $http.delete(REST_SERVICE_URI+"player/"+id)
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