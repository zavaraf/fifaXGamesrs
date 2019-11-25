'use strict';
 
angular.module('myApp').factory('AdminUserService', ['$http', '$q','CONFIG', function($http, $q,CONFIG){
 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI = IP+'/rest/adminUser/';
 
    var factory = {
    		fetchAllUsers: fetchAllUsers,
    		buscarRoles  : buscarRoles,
    		updateAdminUser : updateAdminUser
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
    function buscarRoles() {
        var deferred = $q.defer();
        $http.get(REST_SERVICE_URI+'findAllRoles')
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
    
    function updateAdminUser(user,idUserAct) {
    	
    	var Indata = {'idUsuario': user.username, 'idEquipo': user.idEquipo, 'roles' : user.roles,'idUsuarioActualiza': 'zaa' };
    	console.log("------------------------->roles]:", user.roles)
    	var deferred = $q.defer();
        $http.post(REST_SERVICE_URI+'updateUserAdmin?idUsuario='+user.username+'&idEquipo='+user.idEquipo,user.roles)
        .then(
        function (response) {
            deferred.resolve(response.data);
        },
        function(errResponse){
            console.error('Error while update UsersAdmin');
            deferred.reject(errResponse);
        }
    );
    return deferred.promise;
		
	}
 
}]);