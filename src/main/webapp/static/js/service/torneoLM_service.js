'use strict';
 


angular.module('myApp').factory('TorneoLMService', ['$http', '$q','CONFIG',function($http, $q,CONFIG){

 
	var IP = CONFIG.PROD == false ? CONFIG.IP_DES : CONFIG.IP_PROD
    var REST_SERVICE_URI_E = IP+'/rest/temporada/lm/';
 
    var factory = {
    		getTablaGeneral   : getTablaGeneral,
    		getJornadas       : getJornadas,
    		getGolesJornadas  : getGolesJornadas,
    		addGoles          : addGoles,
    		getJornada        : getJornada,
    		addImagen         : addImagen,
    		getGenerarJornadas: getGenerarJornadas,
    		addJornadas       : addJornadas
    };
 
    return factory;
 
 
    
    
    function getTablaGeneral(idDivision) {
        var deferred = $q.defer();
        var idTorneo = 1;
        $http.get(REST_SERVICE_URI_E+'getTablaGeneral'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision)
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
    
    function getJornadas(idDivision,activa) {
        var deferred = $q.defer();
        var idTorneo = 1;
        var url = REST_SERVICE_URI_E+'getJornadas'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision+"/"+activa
        console.log("utl]:"+ url)
        $http.get(url)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getJornadas');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function getJornada(idJornada,id,idEquipoLocal,idEquipoVisita) {
        var deferred = $q.defer();
        var idTorneo = 1;
        var url = REST_SERVICE_URI_E+'getJornada/'+idJornada+'/'+id+'/'+idEquipoLocal+'/'+idEquipoVisita
        console.log(url);
        $http.get(url)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getGolesJornadas');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function getGolesJornadas(idJornada,idEquipoLocal,idEquipoVisita) {
        var deferred = $q.defer();
        var idTorneo = 1;
        $http.get(REST_SERVICE_URI_E+'getJornadas/goles/'+idJornada+'/1/'+idEquipoLocal+'/'+idEquipoVisita)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getGolesJornadas');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    
  
    function addGoles(idJugador,idEquipo,id,idJornada) {
        var deferred = $q.defer();
        var idTorneo = 1;
        $http.post(REST_SERVICE_URI_E+'addGoles/'+idJugador+'/'+idEquipo+'/'+id+'/'+idJornada)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while addGoles');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function addImagen(idEquipo,id,idJornada,img) {
        var deferred = $q.defer();
        var idTorneo = 1;
        $http.post(REST_SERVICE_URI_E+'addImg/'+idEquipo+'/'+id+'/'+idJornada,img)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while addGoles');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    
    function getGenerarJornadas(idDivision) {
        var deferred = $q.defer();
        var idTorneo = 1;
        var url = REST_SERVICE_URI_E+'getArmarJornadasInicial'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision
        console.log(url);
        $http.get(url)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getJornadas');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function addJornadas(idDivision,jornadas) {
        var deferred = $q.defer();
        var idTorneo = 1;
        $http.post(REST_SERVICE_URI_E+'addJornadas'+"/"+CONFIG.VARTEMPORADA.id+'/'+idDivision,jornadas)
            .then(
            function (response) {
            	console.log(response.data)
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while getJornadas');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
}]);