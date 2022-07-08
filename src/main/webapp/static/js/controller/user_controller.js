'use strict';

var app = angular.module('myApp'); 
//var app = angular.module('myApp',["ngPagination"]); 



app.controller('UserController', ['$scope','$routeParams','CONFIG','$timeout','UserService','EquipoService',
			function($scope,$routeParams,CONFIG,$timeout,UserService, EquipoService) {
	
    var self = this;
    self.user={id:null,nombre : '',apellidoPaterno : '',apellidoMaterno : '',nombreCompleto : '',sobrenombre : '',fehaNacimiento : null,raiting : 0 ,potencial : 0  ,activo : 0 ,userManager : '',prestamo : 0};
    self.users=[];
    self.player={id:null,nombre : '',apellidoPaterno : '',apellidoMaterno : '',nombreCompleto : '',sobrenombre : '',fehaNacimiento : null,raiting : 0 ,potencial : 0 ,activo : 0 ,userManager : '',prestamo : 0};
    self.players=[];
    
    self.checkBuscar=0
    
 
    self.submit          = submit;
    self.submitPlayer    = submitPlayer;
    self.edit            = edit;
    self.remove          = remove;
    self.reset           = reset;
    self.showDraft       = showDraft;
    self.showEditPlayer  = showEditPlayer;
    self.fetchAllPlayers = fetchAllPlayers; 
    
    $scope.selectedTeam
    $scope.showDraftV = false
    
    $scope.currentPage = 0;
    $scope.pageSize = 10;
    $scope.pages = [];
    $scope.configPages = null;
    
    $scope.people = [
        { name: 'John Doe', phone: '555-123-456', picture: 'http://www.saintsfc.co.uk/images/common/bg_player_profile_default_big.png' },
        { name: 'Axel Zarate', phone: '888-777-6666', picture: 'https://avatars0.githubusercontent.com/u/4431445?s=60' },
        { name: 'Walter White', phone: '303-111-2222', picture: 'http://upstreamideas.org/wp-content/uploads/2013/10/ww.jpg' }
    ];
    
    
    $scope.equiposData = [];
	$scope.equipoModel = [];
	$scope.example9settings = {enableSearch: true,displayProp : "nombre",scrollable: true,selectedToTop: true,selectionLimit: 1,
			
			smartButtonMaxItems: 1,
			   smartButtonTextConverter: 
				   function(itemText, originalItem) { 
				     return itemText;  }  
			  };
	$scope.example5customTexts = {buttonDefaultText: 'Seleccione Equipo'};
 
//    fetchAllUsers();
    fetchAllPlayers(0);
    
    $scope.searchAsync = function (term) {
        // No search term: return initial items
	    if (!term) {
	        return  ['Item 1', 'Item 2', 'Item 3'];
	    }
	    var deferred = $q.defer();
	    $timeout(function () {
	        var result = [];
	        for (var i = 1; i <= 3; i++)
	        {
	            result.push(term + ' ' + i);
	        }
	        deferred.resolve(result);
	    }, 30000);
	    return deferred.promise;
	};
    
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
    function fetchAllPlayers(option){
//    	if (CONFIG.JUGADORES == null){
	        UserService.fetchAllPlayers(option)
	            .then(
	            function(d) {
	                self.players = d;
//	                CONFIG.JUGADORES = d;
	                console.log("[user_controller] AllPlayers]:",self.players)
	               // $scope.tableParams = new NgTableParams({}, { dataset: self.players});  
	//                $scope.configPages = configPages()
	            },
	            function(errResponse){
	                console.error('[user_controller] Error while fetching fetchAllPlayers');
	            }
	        );
	     
//    	}else{
//    		self.players = CONFIG.JUGADORES;
//    	}
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
            		 function(d) { 
       		          
       		          console.log("UserControler-createPlayer]:",d)
       		          if(d.status == 0){
       			          self.players = d.data;
//       			          CONFIG.JUGADORES = d;
       			          
       		          }
       		          
       		          
       		          return d;
       		      },
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
             function(d) { 
        		          
        		          console.log("UserControler-updaePlayer]:",d)
        		          if(d.status == 0){
        			          self.players  = d.data;
//        			          CONFIG.JUGADORES = d;
        			          
        		          }
        		          
        		          
        		          return d;
        		      },
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
            console.log('[user_controller] Saving New Player', self.player);
            createPlayer(self.player);
        }
        else{
            updatePlayer(self.player, self.player.id);
            console.log('[user_controller] User updated with id ', self.user.id);
        }
        reset();
    }
    
 
    function edit(user){
        console.log('[user_controller] id to be edited', user.id);
//        for(var i = 0; i < self.players.length; i++){
//            if(self.players[i].id === id) {
//                self.player = angular.copy(self.players[i]);
                self.player = user;
                $scope.selectedTeam = user.equipo;
                
//                obtenerEquipo(self.player.equipo.id)
//                self.player.equipo = $scope.selectedTeam
//                self.player.equipo = ($scope.equipoModel != null && $scope.equipoModel.length>0) ? $scope.equipoModel[0] : null;
                
                console.log('[user_controller] jugador',self.player)
//                console.log('[user_controller] user',user)
//                break;
//            }
//        }
    }
    function obtenerEquipo(equipo) {
        var allTeams = null  
        console.log("[user_controller] Entrando a buscar Equipos----  >",CONFIG.VARTEMPORADA.id)
        EquipoService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
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
        $scope.equipoModel = [];
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




