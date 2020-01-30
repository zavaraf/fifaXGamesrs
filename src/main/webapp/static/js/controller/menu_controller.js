'use strict';
 
//var app = angular.module("myApp", ["ngRoute","ngPagination",'btorfs.multiselect','dropdown-multiselect']);
var app = angular.module("myApp", ["ngRoute","ngPagination",'angularjs-dropdown-multiselect']);
    app.config(function($routeProvider) {
        $routeProvider
        .when("/", {
           // templateUrl : "Jugadores.htm"
        	templateUrl : "Torneo"
        })
        .when("/jugadores", {
            templateUrl : "Jugadores.htm"
        })
        .when("/equipos/", {
        	templateUrl : "Equipos.htm"
        })
        .when("/team/:teamID", {
            templateUrl : "Team.htm"
//            controller: "TeamController"
        })
        .when("/zonaDraft", {
        	templateUrl : "Draft.htm"

        })
        .when("/zonaDraftPC", {
        	templateUrl : "DraftPC.htm"
        	
        })
        .when("/adminDT", {
        	templateUrl : "AdminUsuarios.htm"
        	
        })
        .when("/conceptos", {
        	templateUrl : "Conceptos"
        	
        })
        .when("/torneo", {
        	templateUrl : "Torneo"
        	
        })
        .when("/adminTorneo", {
        	templateUrl : "adminTorneo"
        	
        })
        ;
 
});