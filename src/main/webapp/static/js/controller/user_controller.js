'use strict';

var app = angular.module('myApp'); 
//var app = angular.module('myApp',["ngPagination"]); 



app.controller('UserController', ['$scope','$routeParams','CONFIG','UserService','EquipoService',
			function($scope,$routeParams,CONFIG,UserService, EquipoService) {
	
    var self = this;
    self.user={id:null,nombre : '',apellidoPaterno : '',apellidoMaterno : '',nombreCompleto : '',sobrenombre : '',fehaNacimiento : null,raiting : 0 ,potencial : 0  ,activo : 0 ,userManager : '',prestamo : 0};
    self.users=[];
    self.player={id:null,nombre : '',apellidoPaterno : '',apellidoMaterno : '',nombreCompleto : '',sobrenombre : '',fehaNacimiento : null,raiting : 0 ,potencial : 0 ,activo : 0 ,userManager : '',prestamo : 0};
    self.players=[];
    
 
    self.submit = submit;
    self.submitPlayer = submitPlayer;
    self.edit = edit;
    self.remove = remove;
    self.reset = reset;
    self.showDraft = showDraft;
    self.showEditPlayer = showEditPlayer; 
    
    $scope.selectedTeam
    $scope.showDraftV = false
    
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.pages = [];
    $scope.configPages = null;
 
 
//    fetchAllUsers();
    fetchAllPlayers();
    
    function showDraft(op){
        $scope.showDraftV = op
    }

 
    function fetchAllUsers(){
        UserService.fetchAllUsers()
            .then(
            function(d) {
                self.users = d;
            },
            function(errResponse){
                console.error('[user_controller] Error while fetching fetchAllUsers');
            }
        );
    }
    function fetchAllPlayers(){
        UserService.fetchAllPlayers()
            .then(
            function(d) {
                self.players = d;
                console.log("[user_controller] AllPlayers]:",self.players)
               // $scope.tableParams = new NgTableParams({}, { dataset: self.players});  
//                $scope.configPages = configPages()
            },
            function(errResponse){
                console.error('[user_controller] Error while fetching fetchAllPlayers');
            }
        );
    }
 
    function createUser(user){
        UserService.createUser(user)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('[user_controller] Error while creating User');
            }
        );
    }
    function createPlayer(player){
        UserService.createPlayer(player)
            .then(
            fetchAllPlayers,
            function(errResponse){
                console.error('[user_controller] Error while creating User');
            }
        );
    }
 
    function updateUser(user, id){
        UserService.updateUser(user, id)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('[user_controller] Error while updating User');
            }
        );
    }
    function updatePlayer(player, id){
        UserService.updatePlayer(player, id)
            .then(
            fetchAllPlayers,
            function(errResponse){
                console.error('[user_controller] Error while updating User');
            }
        );
    }
 
    function deleteUser(id){
        UserService.deleteUser(id)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('[user_controller] Error while deleting User');
            }
        );
    }
 
    function submit(equipo) {
        console.log("[user_controller] Equipo:"+equipo+ " Jugador]:"+self.user)
        self.user.Equipos_idEquipo = equipo
        if(self.user.id===null){
            console.log('[user_controller] Saving New User', self.user);
            createUser(self.user, equipo);
        }else{
            updateUser(self.user, self.user.id);
            console.log('[user_controller] User updated with id ', self.user.id);
        }
        reset();
    }
    function submitPlayer(equipo) {
        console.log("[user_controller] --->Entre submitPlayer");
        self.player.equipo = equipo
        console.log("[user_controller] Equipo:",equipo+ " Jugador]:",self.player)
        if(self.player.id===null){
            console.log('[user_controller] Saving New User', self.player);
            createPlayer(self.player);
        }
        else{
            updatePlayer(self.player, self.player.id);
            console.log('[user_controller] User updated with id ', self.user.id);
        }
        reset();
    }
    
 
    function edit(id){
        console.log('[user_controller] id to be edited', id);
        for(var i = 0; i < self.players.length; i++){
            if(self.players[i].id === id) {
                self.player = angular.copy(self.players[i]);
                obtenerEquipo(self.player.equipo.id)
                self.player.equipo = $scope.selectedTeam
                console.log('[user_controller] jugador',self.pyaler)
                break;
            }
        }
    }
    function obtenerEquipo(equipo) {
        var allTeams = null  
        console.log("[user_controller] Entrando a buscar Equipos----  >",CONFIG.VARTORNEO.id)
        EquipoService.buscarTodos(CONFIG.VARTORNEO.id).then(function(d) {
            allTeams = d;
            for(var i = 0; i < allTeams.length; i++){
                console.log("[user_controller] -->equipo]:"+equipo + " = ", allTeams[i]) 
                if(allTeams[i].id == equipo){
                    console.log("[user_controller] -->Encontre equipos]:"+allTeams[i].nombre)
                  $scope.selectedTeam =  allTeams[i];
                console.log("[user_controller] -->Encontre division1]:"+$scope.selectedTeam.nombre)
                break;
                }
              }
        }, function(errResponse) {
            console.error(' [user_controller] Error while fetching Equipos');
        });
        
        
    }
 
    function remove(id){
        console.log('[user_controller] id to be deleted', id);
        if(self.user.id === id) {//clean form if the user to be deleted is shown there.
            reset();
        }
        deleteUser(id);
    }
 
 
    function reset(){
        console.log("[user_controller] ------>Entre reset")
        self.player={id:null,NombreCompleto:'',sobrenombre:'',Raiting:'',equipo:null};
        $scope.myForm.$setPristine(); //reset Form
    }
    
    function showEditPlayer(player,userEquipoId,roles){
    	var ban = false;
    	
    	if(player.equipo.id == userEquipoId || roles.includes('Admin') || player.equipo.id ==1){
    		ban = true;
    	}
    	
    	return ban;
    	
    }
    
 
}])
;




