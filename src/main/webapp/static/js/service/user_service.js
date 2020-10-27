'use strict';
 
angular.module('myApp').factory('UserService', ['$http', '$q','CONFIG',function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI = IP+'/rest/user/';
 
    var factory = {
        fetchAllUsers: fetchAllUsers,
        fetchAllPlayers: fetchAllPlayers,
        createUser: createUser,
        createPlayer : createPlayer,
        updateUser:updateUser,
        updatePlayer:updatePlayer,
        deleteUser:deleteUser,
        findPlayersByIdEquipo : findPlayersByIdEquipo,
        findPlayersByIdEquipoJornada : findPlayersByIdEquipoJornada
    };
 
    return factory;
    
    function fetchAllUsers() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllUsers')
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
    function fetchAllPlayers() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllPlayers/'+CONFIG.VARTEMPORADA.id)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
    function createUser(user) {
        var deferred = $q.defer();
        $http.post(REST_SERVICE_URI, user)
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while creating User');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
 
    function createPlayer(player) {
    	var deferred = $q.defer();
    	$http.post(REST_SERVICE_URI+"player"+"/"+CONFIG.VARTEMPORADA.id, player)
    	.then(
    			function (response) {
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while creating User');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    }
    
 
    function updateUser(user, id) {
        var deferred = $q.defer();
        console.log("------> Player Update]",user)
        $http.put(REST_SERVICE_URI+id, user)
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
    function updatePlayer(player, id) {
        var deferred = $q.defer();
        console.log("------> Player Update]",player)
        $http.post(REST_SERVICE_URI+"playerUpdate/"+id+"/"+CONFIG.VARTEMPORADA.id, player)
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
 
    function deleteUser(id) {
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
    
    function findPlayersByIdEquipo(idEquipo){
    	var deferred = $q.defer();
    	console.log("findPlayersByIdEquipo]:",CONFIG)
    	var request = REST_SERVICE_URI+"player/"+idEquipo+"/"+CONFIG.VARTEMPORADA.id;
    	$http.get(request)
    	.then(
    			function (response) {
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while creating User');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    	
    }
    
    function findPlayersByIdEquipoJornada(idEquipo,idEquipoVisita){
    	var deferred = $q.defer();
    	var request = REST_SERVICE_URI+"player/"+idEquipo+"/"+idEquipoVisita+"/"+CONFIG.VARTEMPORADA.id;
    	$http.get(request)
    	.then(
    			function (response) {
    				deferred.resolve(response.data);
    			},
    			function(errResponse){
    				console.error('Error while creating User');
    				deferred.reject(errResponse);
    			}
    	);
    	return deferred.promise;
    	
    }
 
}]);