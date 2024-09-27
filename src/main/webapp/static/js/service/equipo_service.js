'use strict';
 
angular.module('myApp').factory('EquipoService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI = IP+'/rest/equipo/';
    var REST_SERVICE_URI_E = IP+'/rest/temporada/';
    
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
  
 
    var factory = {
    	buscarTodos     : buscarTodos,
    	buscarDivisiones: buscarDivisiones,
    	crearEquipo     : crearEquipo,
    	modificarEquipo : modificarEquipo,
    	deleteEquipo    : deleteEquipo,
    	buscarTemporada   : buscarTemporada
    };
 
    return factory;
 
    function buscarTodos(idTemporada) {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'buscarTodos/'+idTemporada)
            .then(
            function (response) {
            	console.log("EquipoService - buscarTodos]",response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    function buscarTemporada() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI_E+'buscarTemporada')
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
    function buscarDivisiones() {
    	
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'buscarDivisiones',requestOptions)
            .then(
            function (response) {
            	console.log("buscarDivisiones()",response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
    function crearEquipo(equipo) {
        var deferred = $q.defer();
        console.log('SErvice .- Saving New Equipo', equipo);
        $http.post(REST_SERVICE_URI, equipo)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while creating Equipo');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
 
    function modificarEquipo(equipo, id) {
        var deferred = $q.defer();
        console.log("Equipo_Service Mod:"+equipo.division.id)
        console.log("Equipo_Service Mod:"+equipo.division.nombre)
        $http.put(REST_SERVICE_URI+id+"/"+CONFIG.VARTEMPORADA.id, equipo)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while updating User');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
    function deleteEquipo(id) {
        var deferred = $q.defer();
        $http.delete(REST_SERVICE_URI+id)
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