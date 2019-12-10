'use strict';
 
angular.module('myApp').controller('TeamController', ['$scope','$routeParams','CONFIG','TeamService','EquipoService','DraftPCService','UserService',
	function($scope,$routeParams, CONFIG,TeamService,EquipoService,DraftPCService,UserService) {
	var self = this;
	

	self.vistaJuga = true
	self.vistaDat = false
	self.vistaPrestamos = false
	self.vistaDraftPC = false
	
	
	self.preInicial
	self.showInicial = false
	self.showObj     = false
	
	
	self.equipo = []
	self.prestamos = []
	
	self.divisiones = []
	
	self.sponsors = []
	self.catalogoFinanzas = []
	
	self.montoCatalogo
	
	$scope.selectedDiv
	$scope.opcionalSelected = false
	
	self.ocultaJuga        = ocultaJuga;
	self.ocultaDatos       = ocultaDatos;
	self.showEditDat       = showEditDat;
	self.showGuarDat       = showGuarDat;
	self.showEditObj       = showEditObj;
	self.showPrestamos     = showPrestamos;
	self.showDraftPC       = showDraftPC;
	self.showEdit          = showEdit;
	self.showEditPlayer    = showEditPlayer;
	
	

	self.buscarDivisiones  = buscarDivisiones;
	self.buscarSponsors    = buscarSponsors;
	self.buscarPrestamos   = buscarPrestamos;
	self.actualizar        = actualizar;
	
	self.sumaObjetivos     = sumaObjetivos;
	self.getTotal          = getTotal;
	self.buscarCatFinanzas = buscarCatFinanzas;
	self.buscarJugadoresdraft = buscarJugadoresdraft;
	self.updateDraft       = updateDraft;

	self.submitSponsor     = submitSponsor;
	self.submitFinanzas    = submitFinanzas;
	self.submitDatos       = submitDatos;
	self.guardarObj        = guardarObj;
	self.submitDraftPC     = submitDraftPC;
	self.submitDraftPCConfirm     = submitDraftPCConfirm;
	self.submitPlayer      = submitPlayer;
	
	self.deletePrestamo         = deletePrestamo;
	
	
	findTeam()
//	buscarDivisiones()
	function showEditPlayer(equipo,userEquipoId,roles){
    	var ban = false;
    	
    	if(equipo.id == userEquipoId || roles.includes('Admin') || equipo.id ==1){
    		ban = true;
    	}
    	
    	return ban;
    	
    }
	function showEdit(roles,equi,idEquipo) {
		console.log("Entre]:"+roles+" equi]:"+equi+" = "+ idEquipo)
						if((roles.includes('Manager') && equi == idEquipo) || roles.includes('Admin')){	
							return true;
						}						
						return false
					}
	
	function showPrestamos(val){
		self.vistaPrestamos = val;	
		if(val == true){
			self.vistaJuga = false
			self.vistaDat = false
			self.vistaDraftPC = false
			buscarPrestamos()
		}
	}
	function showDraftPC(val){
		self.vistaDraftPC = val;	
		if(val == true){
			self.vistaJuga = false
			self.vistaDat = false
			self.vistaPrestamos = false
			buscarJugadoresdraft()
		}
	}
	function showEditObj(val){
		self.showObj = val;		
	}
	function showEditDat(){
		self.showInicial = true;		
	}
	function showGuarDat(){
		self.showInicial = false;		
	}
	function ocultaJuga(){
		self.vistaJuga = false;
		self.vistaDat = true;
		showPrestamos(false)
		showDraftPC(false)
			
	}
	function ocultaDatos(){
		self.vistaJuga = true;
		self.vistaDat = false;
		showPrestamos(false)
		showDraftPC(false)
				
	}
	function findTeam(){
		var team = $routeParams.teamID
		console.log('Equipo a Buscar]:'+team);
		TeamService.findAll(team,CONFIG.VARTEMPORADA.id)
            .then(
            function(d) {
                self.equipo = d;
            	console.log('--------->',d)
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }
	function buscarDivisiones() {
		EquipoService.buscarDivisiones().then(function(d) {
			console.log("Entre Buscar Divisiones-->"+d.toString())
			self.divisiones = d;
		}, function(errResponse) {
			console.error('Error while fetching Divisiones');
		});
	}
	
	function buscarSponsors(){
		console.log("ID Division]:",self.equipo.division.id)	
		TeamService.findSponsorByDiv(self.equipo.division.id)
        .then(
        function(d) {
            self.sponsors = d;
        	console.log('--------->',d)
        },
        function(errResponse){
            console.error('Error while fetching Users');
        }
    );
	}
	function buscarCatFinanzas(){
		console.log("Finanzas]:",self.equipo.division.id)	
		TeamService.buscarCatFinanzas()
		.then(
				function(d) {
					self.catalogoFinanzas = d;
					console.log('--------->',d)
				},
				function(errResponse){
					console.error('Error while fetching Users');
				}
		);
	}
	
	
	function submitPlayer(equipoS,player) {
        console.log("[Team_controller] --->Entre submitPlayer",equipoS);
        player.equipo = equipoS
        console.log("[Team_controller] Equipo:",equipoS+ " Jugador]:",player)
        if(player.id===null){
            console.log('[Team_controller] Saving New User', player);
//            createPlayer(self.player);
        }
        else{
            updatePlayer(player, player.id);
            console.log('[Team_controller] User updated with id ', player.id);
        }
//        findTeam();
        
    }
	function updatePlayer(player, id){
        UserService.updatePlayer(player, id)
            .then(
            findTeam,
            function(errResponse){
                console.error('[Team_controller] Error while updating User');
            }
        );
    }
	
	function submitSponsor(sponsor,opcionales){
		console.log("Crear Sponsor]:",self.equipo.id," Opcionales]:",opcionales)	
		TeamService.submitSponsor(self.equipo.id,opcionales,sponsor.id)
		.then(findTeam,
				function(d) {
					self.sponsors = d;
					console.log('--------->',d)
				},
				function(errResponse){
					console.error('Error while fetching Users');
				}
		);
	}
	
	function submitFinanzas(catalogo,monto){
		console.log("Crear Finanzas]:",catalogo," Monto]:",monto,CONFIG.VARTEMPORADA.id)	
			
		TeamService.submitFinanzas(catalogo,monto,self.equipo,CONFIG.VARTEMPORADA.id)
		.then(findTeam,
				function(d) {			
			console.log('submitFinanzas--------->',d)
		},
		function(errResponse){
			console.error('Error while fetching Users');
		}
		);
	}
	function submitDatos(monto){
		console.log("Crear Finanzas]:"," Monto]:",monto)
		console.log("-------->idTemporada]:"+CONFIG.VARTEMPORADA.id)
		
		TeamService.submitDatos(monto,self.equipo,CONFIG.VARTEMPORADA.id)
		.then(findTeam,
				function(d) {			
			console.log('submitDatos--------->',d)
		},
		function(errResponse){
			console.error('Error while fetching Users');
		}
		);
	}
	function guardarObj(objetivos){
		console.log("guardarObj]:"," Objetivos]:",objetivos)	
		
		TeamService.guardarObj(objetivos,self.equipo.id,CONFIG.VARTEMPORADA.id)
		.then(findTeam,showEditObj(false),
			function(d) {			
				console.log('submitDatos--------->',d);
			},
			function(errResponse){
				console.error('Error while fetching Users');
			}
		);
	}
	
	function sumaObjetivos(sponsor, op,cumplido){
		var total = 0;
		if(sponsor!=null && sponsor.objetivos!=null){
			var objetivos = sponsor.objetivos
			for(var ob in objetivos){
				
				if(objetivos[ob].opcional == op){
					if(cumplido == false){
						total = total + objetivos[ob].monto;
					}else{
						if(objetivos[ob].opcional == op && objetivos[ob].cumplido == true){
							total = total + objetivos[ob].monto;
						}else{
							total = total - objetivos[ob].penalizacion;
						}
					}
				}
				
			}
		}
		return total
	}
	function getTotal(sponsor,op,cumplido){
		var total = 0;
		var contrato = sponsor!= null ? sponsor.contratoFijo : null;
		if(contrato !=null){
			total = contrato;
			total = total + sumaObjetivos(sponsor,false,cumplido);
			if(op == true){
				total =  total + sumaObjetivos(sponsor,op,cumplido);
			}
		}
		return total
	}
	
	function buscarPrestamos(){
		var team = $routeParams.teamID
    	TeamService.findPresByIdEquipo(team,CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Prestamos Players]:",d);
			self.prestamos = d;
		}, function(errResponse) {
			self.players = [];
			console.error('Error while fetching Users');
		});
    }
	
	function deletePrestamo(idUser) {
		console.log("Delete Prestamo]:"+idUser)
		TeamService.deletePrestamo(idUser).then(actualizar,
    			function(errResponse) {
    		console.error('Error while creating User');
    	});
    }
	function actualizar(){
		findTeam()
		buscarPrestamos()
	}
	
	//Draft PC
	
	function buscarJugadoresdraft() {
		var team = $routeParams.teamID
		console.log("[teamController: buscarJugadoresdraft] idTemporada]:",CONFIG.VARTEMPORADA.id);
    	DraftPCService.buscarJugadoresdraftByID(team,CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Jugadores Draft]:",d);
			self.jugadoresDraft = d;
		}, function(errResponse) {
			console.error('Error while fetching Users');
		});
	}
	function updateDraft(jugadorSel){
    	self.isError = false;
    	self.Error = ''
		self.jugador = jugadorSel
		self.isUpdate = true
		buscarEquipos()
    }
	function buscarEquipos() {
		console.log("[teamController]  idTemporada]:",CONFIG.VARTEMPORADA.id);
		EquipoService.buscarTodos(CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("Equipos]:",d);
			self.equipos = d;
		}, function(errResponse) {
			console.error('[teamController] Error while fetching Users');
		});
	}
	function submitDraftPC (jug, monto,manager,equipo) {
    	console.log('monto:'+monto+' manager]:'+manager+' obser]:'+equipo.nombre+ ' Jugador:',jug);
//    	self.isError= !self.isError  
    	if(self.isUpdate == false){
	    	DraftPCService.createInitialDraft(jug.id,monto,manager,equipo.nombre,equipo.id).then(function(d) {
				console.log("initial Draft]:",d);
				//self.jugadoresDraft = d;
				
				if(d.status == 1){
					self.isError = true;
					self.Error = d.mensaje;					
				}else{
					actualizar();
				}
				
			}, function(errResponse) {
				self.isError = true;
				self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
			});
    	}else{
    		DraftPCService.updateDraft(jug.id,monto,manager,equipo.nombre,jug.ofertaFinal,equipo.id).then(function(d) {
				console.log("update Draft]:",d);
				//self.jugadoresDraft = d;
				
				if(d.status == 1){
					self.isError = true;
					self.Error = d.mensaje;					
				}else{
					actualizar();
				}
				
			}, function(errResponse) {
				self.isError = true;
				self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
			});
    	}
	}
	function submitDraftPCConfirm (jug) {
		console.log( ' Jugador:',jug);

		DraftPCService.confirmPlayer(jug.id,jug.idEquipoOferta, CONFIG.VARTEMPORADA.id).then(function(d) {
			console.log("initial Draft]:",d);			
			if(d.status == 1){
				self.isError = true;
				self.Error = d.mensaje;					
			}else{
				actualizar();
			}
			
		}, function(errResponse) {
			self.isError = true;
			self.Error = 'Error while create initial Draft'
				console.error('Error while create initial Draft');
		});
		
	}
	 function actualizar(){
		 	buscarJugadoresdraft()
		 	findTeam()
	    }
	
}]);