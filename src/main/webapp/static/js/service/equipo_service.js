'use strict';
 
angular.module('myApp').factory('EquipoService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI = IP+'/rest/equipo/';
    var REST_SERVICE_URI_E = IP+'/rest/torneos/';
 
    var factory = {
    	buscarTodos     : buscarTodos,
    	buscarDivisiones: buscarDivisiones,
    	crearEquipo     : crearEquipo,
    	modificarEquipo : modificarEquipo,
    	deleteEquipo    : deleteEquipo,
    	buscarTorneos   : buscarTorneos
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
    function buscarDivisiones() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'buscarDivisiones')
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
        $http.put(REST_SERVICE_URI+id, equipo)
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