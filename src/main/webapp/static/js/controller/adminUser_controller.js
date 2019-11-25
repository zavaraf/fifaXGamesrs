'use strict';
 
angular.module('myApp')
.controller('AdminUserController', ['$scope','$routeParams','CONFIG', 'AdminUserService','EquipoService', 
	function($scope, $routeParams,CONFIG, AdminUserService,EquipoService) {
	var self = this;
	
	self.usuarios = [];
	self.roles    = [];
	self.selectedUser;
	self.selectedEquipo = null;
	self.selectedRole = null;
	self.isError = false;
	self.Error = null;	
	self.userAct = null;	
	
	self.updateUser         = updateUser;
	self.addRole            = addRole;
	self.removeRole            = removeRole;
	self.concatRoles        = concatRoles;
	self.updateAdminUser        = updateAdminUser;
	self.prueba        = prueba;
	
	
	fetchAllUsers();
	function prueba(userSe) {
		console.log("[AdminUserController] ====>User]:"+userSe)
		
		
	}
	function fetchAllUsers(){
		AdminUserService.fetchAllUsers()
            .then(
            function(d) {
            	console.log("[AdminUserController]  usuarios]:",d)
                self.usuarios = d;
            },
            function(errResponse){
                console.error('[AdminUserController]  Error while fetching fetchAllUseres()');
            }
        );
    }
	
	function updateUser(user){
		self.selectedUser = user;	
		console.log("[AdminUserController]  User]:",user)
		buscarEquipos()
		buscarRoles()
	}
	function buscarEquipos() {
		var idTorneo = CONFIG.VARTORNEO.id
		console.log("[AdminUserController]  idTorneo]:",idTorneo);
		EquipoService.buscarTodos(idTorneo).then(function(d) {
			console.log("[AdminUserController]  Equipos]:",d);
			self.equipos = d;
		}, function(errResponse) {
			console.error('[AdminUserController]  Error while fetching buscarEquipos()');
		});
	}
	function buscarRoles() {
		AdminUserService.buscarRoles().then(function(d) {
			console.log("[AdminUserController]  Roles]:",d);
			self.roles = d;
		}, function(errResponse) {
			console.error('[AdminUserController] Error while fetching buscarRoles()');
		});
	}
	function addRole(varRol) {
		console.log("User roles]:",self.selectedUser.roles)
		console.log("AddRole]:",varRol)
		if(self.selectedUser.roles != null){
		 console.log("Check]"+checkRole(self.selectedUser.roles,varRol.id))
			if(checkRole(self.selectedUser.roles,varRol.id) == false){
				self.selectedUser.roles.push(varRol)
			}else{ 
				console.error("Role ya existe en el arreglo")
			}
		}else{
			var rolesAdd = [];
			rolesAdd.push(varRol);
			self.selectedUser.roles = rolesAdd; 
		}
		
		console.log("User ]:",self.selectedUser	)
	}
	function removeRole(varRol) {
		
		console.log("RemoveRole]:",varRol)
		if(self.selectedUser.roles != null){
		 
			var i = 0;
			var result = false;
			for(i=0;i<self.selectedUser.roles.length;i++){
				console.log()
				if(self.selectedUser.roles[i].id == varRol){
					self.selectedUser.roles.splice(i, 1);
				}			
			}
		}
		
		console.log("User ]:",self.selectedUser	)
	}
	function checkRole(roles, valor) {
		var i = 0;
		var result = false;
		for(i=0;i<roles.length;i++){
			console.log()
			if(roles[i].id == valor){
				result = true;
			}			
		}
		
		return result;
	}
	
	function concatRoles(roles){
		var rolesDes = [];
		var i=0;
		if(self.selectedUser == null){
			return null
		}
		for(i=0;i<self.selectedUser.roles.length;i++){
			rolesDes.push(self.selectedUser.roles[i].rol)
		}
		
		console.log("Descricpicon:",rolesDes)
		return  rolesDes.join(" - ")
		
	}
	
	function updateAdminUser(user,userAct) {
		console.log("idUserAct]]"+userAct+" [user]",user)
		if(self.selectedEquipo == null){
			user.idEquipo = 0
		}else{
			user.idEquipo = self.selectedEquipo.id
		}
		AdminUserService.updateAdminUser(user,userAct)
        .then(
        function(d) {
        	console.log("usuarios]:",d)
        	if(d.status == 1){
				self.isError = true;
				self.Error = d.mensaje;					
			}else{
				fetchAllUsers();
			}
        },
        function(errResponse){
            console.error('Error while fetching Users');
        }
    );
	}
 
}]);