var app = angular.module("myApp", ["ngPagination"]);

app.controller("pagineoCtrl", ['$scope','UserService','EquipoService' ,
	function($scope,UserService,EquipoService) {
	var self = this;
	
	fetchAllPlayers()
	    
        function fetchAllPlayers(){
            UserService.fetchAllPlayers()
                .then(
                function(d) {
                    self.players = d;
                    
                    console.log("tablaUsuarios]:",self.players)
                    
                    return d;
                   // $scope.tableParams = new NgTableParams({}, { dataset: self.players});  
//                    $scope.configPages = configPages()
                },
                function(errResponse){
                    console.error('[tablaUsuarios] Error while fetching fetchAllPlayers()');
                }
            );
            return null;
        }

    }]);