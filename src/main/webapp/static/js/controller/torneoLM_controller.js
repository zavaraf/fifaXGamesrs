'use strict';
var app = angular.module('myApp'); 




app.controller('TorneoLMController', ['$scope','$routeParams','CONFIG','TorneoLMService','UserService','EquipoService',
			function($scope,$routeParams,CONFIG,TorneoLMService,UserService,EquipoService) {
	var self = this;
	
	self.tablaGeneral;
	self.jornadas;
	self.jornadaEdit;
	self.players;
	self.golesJornada;
	self.divisiones;
	self.divisionSelect;
	self.jornadaSelect = [];
	self.jorPendientes = [];
	
	self.showPen = false;
	self.showJor = true;
	
	$scope.example9model = [];
	$scope.example9modelV = [];
//	$scope.example9data = [{"id":874,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Paul Bernardoni","sobrenombre":"Paul Bernardoni","fehaNacimiento":null,"raiting":77,"potencial":0,"link":"https://sofifa.com/player/223898/paul-bernardoni/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":875,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Anthony Lopes","sobrenombre":"Anthony Lopes","fehaNacimiento":null,"raiting":84,"potencial":0,"link":"https://sofifa.com/player/199482/anthony-lopes/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":876,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Davide Zappacosta","sobrenombre":"Davide Zappacosta","fehaNacimiento":null,"raiting":79,"potencial":0,"link":"https://sofifa.com/player/216150/davide-zappacosta/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":877,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Álvaro Odriozola Arzalluz","sobrenombre":"Álvaro Odriozola","fehaNacimiento":null,"raiting":80,"potencial":0,"link":"https://sofifa.com/player/234035/alvaro-odriozola-arzalluz/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":878,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Germán Alejandro Pezzella","sobrenombre":"Germán Pezzella","fehaNacimiento":null,"raiting":79,"potencial":0,"link":"https://sofifa.com/player/193601/german-pezzella/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":879,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Panagiotis Retsos","sobrenombre":"Panagiotis Retsos","fehaNacimiento":null,"raiting":75,"potencial":0,"link":"https://sofifa.com/player/234986/panagiotis-retsos/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":880,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Mario Hermoso Canseco","sobrenombre":"Mario Hermoso","fehaNacimiento":null,"raiting":81,"potencial":0,"link":"https://sofifa.com/player/229668/mario-hermoso-canseco/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":881,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Daley Blind","sobrenombre":"Daley Blind","fehaNacimiento":null,"raiting":83,"potencial":0,"link":"https://sofifa.com/player/190815/daley-blind/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":882,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Marcos Alonso","sobrenombre":"Marcos Alonso","fehaNacimiento":null,"raiting":81,"potencial":0,"link":"https://sofifa.com/player/192638/marcos-alonso-mendoza/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":883,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Oleksandr Zinchenko","sobrenombre":"Oleksandr Zinchenko","fehaNacimiento":null,"raiting":78,"potencial":0,"link":"https://sofifa.com/player/227813/oleksandr-zinchenko/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":884,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Gabriel Appelt Pires","sobrenombre":"Gabriel","fehaNacimiento":null,"raiting":80,"potencial":0,"link":"https://sofifa.com/player/208141/gabriel-appelt-pires/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":885,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Tomáš Soucek","sobrenombre":"Tomáš Soucek","fehaNacimiento":null,"raiting":80,"potencial":0,"link":"https://sofifa.com/player/236792/tomas-soucek/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":886,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Carles Aleñá Castillo","sobrenombre":"Aleñá","fehaNacimiento":null,"raiting":76,"potencial":0,"link":"https://sofifa.com/player/233113/carles-alena-castillo/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":887,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Pablo Fornals Malla","sobrenombre":"Pablo Fornals","fehaNacimiento":null,"raiting":80,"potencial":0,"link":"https://sofifa.com/player/226456/pablo-fornals-malla/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":888,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"James Ward-Prowse","sobrenombre":"James Ward-Prowse","fehaNacimiento":null,"raiting":79,"potencial":0,"link":"https://sofifa.com/player/205569/james-ward-prowse/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":889,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Georginio Wijnaldum","sobrenombre":"Georginio Wijnaldum","fehaNacimiento":null,"raiting":84,"potencial":0,"link":"https://sofifa.com/player/181291/georginio-wijnaldum/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":890,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Ricardo Quaresma","sobrenombre":"Quaresma","fehaNacimiento":null,"raiting":81,"potencial":0,"link":"https://sofifa.com/player/20775/ricardo-andrade-quaresma-bernardo/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":891,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Ryad Boudebouz","sobrenombre":"Ryad Boudebouz","fehaNacimiento":null,"raiting":77,"potencial":0,"link":"https://sofifa.com/player/188388/ryad-boudebouz/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":892,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Bruno Alexandre Vieira Almeida","sobrenombre":"Bruno Xadas","fehaNacimiento":null,"raiting":73,"potencial":0,"link":"https://sofifa.com/player/237670/bruno-alexandre-vieira-almeida/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":893,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Jann-Fiete Arp","sobrenombre":"Jann-Fiete Arp","fehaNacimiento":null,"raiting":67,"potencial":0,"link":"https://sofifa.com/player/239981/jann-fiete-arp/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":894,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Andrej Kramaric","sobrenombre":"Andrej Kramaric","fehaNacimiento":null,"raiting":83,"potencial":0,"link":"https://sofifa.com/player/216354/andrej-kramaric/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":895,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Mauro Emanuel Icardi Rivero","sobrenombre":"Mauro Icardi","fehaNacimiento":null,"raiting":86,"potencial":0,"link":"https://sofifa.com/player/201399/mauro-icardi/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":896,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Matheus Santos Carneiro Da Cunha","sobrenombre":"Matheus Cunha","fehaNacimiento":null,"raiting":74,"potencial":0,"link":"https://sofifa.com/player/240243/matheus-santos-carneiro-da-cunha/200016/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1272,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Diego Godín","sobrenombre":"Diego Godín","fehaNacimiento":null,"raiting":88,"potencial":0,"link":"https://sofifa.com/player/182493/diego-godin/200014/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1295,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Moussa Diaby","sobrenombre":"Moussa Diaby","fehaNacimiento":null,"raiting":74,"potencial":0,"link":"https://sofifa.com/player/241852/moussa-diaby/200014/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":11,"nombre":"RB LEIPZIG","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1048,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Odisseas Vlachodimos","sobrenombre":"Odisseas Vlachodimos","fehaNacimiento":null,"raiting":81,"potencial":0,"link":"https://sofifa.com/player/211990/odisseas-vlachodimos/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1049,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Jan Oblak","sobrenombre":"Jan Oblak","fehaNacimiento":null,"raiting":91,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1050,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Daniel Carvajal Ramos","sobrenombre":"Daniel Carvajal Ramos","fehaNacimiento":null,"raiting":85,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1051,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Clément Lenglet","sobrenombre":"Clément Lenglet","fehaNacimiento":null,"raiting":86,"potencial":0,"link":"https://sofifa.com/player/220440/clement-lenglet/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1052,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Jordi Alba Ramos","sobrenombre":"Jordi Alba Ramos","fehaNacimiento":null,"raiting":86,"potencial":0,"link":"https://sofifa.com/player/189332/jordi-alba-ramos/?hl=es-ES","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1053,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Reece James","sobrenombre":"Reece James","fehaNacimiento":null,"raiting":73,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1054,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Héctor Junior Firpo Adamés","sobrenombre":"Héctor Junior Firpo Adamés","fehaNacimiento":null,"raiting":79,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1055,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Yeray Álvarez López","sobrenombre":"Yeray Álvarez López","fehaNacimiento":null,"raiting":80,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1056,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Declan Rice","sobrenombre":"Declan Rice","fehaNacimiento":null,"raiting":78,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1057,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Frenkie de Jong","sobrenombre":"Frenkie de Jong","fehaNacimiento":null,"raiting":86,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1058,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Arthur Henrique Ramos Oliveira Melo","sobrenombre":"Arthur Henrique Ramos Oliveira Melo","fehaNacimiento":null,"raiting":85,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1059,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Jesús Joaquín Fernández Sáez","sobrenombre":"Suso","fehaNacimiento":null,"raiting":82,"potencial":0,"link":"https://sofifa.com/player/202651/jesus-joaquin-fernandez-saez/200014/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1060,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Leon Goretzka","sobrenombre":"Leon Goretzka","fehaNacimiento":null,"raiting":84,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1061,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Thiago Almada","sobrenombre":"Thiago Almada","fehaNacimiento":null,"raiting":72,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1064,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Adam Hložek","sobrenombre":"Adam Hložek","fehaNacimiento":null,"raiting":72,"potencial":0,"link":"https://sofifa.com/player/246618/adam-hlozek/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1065,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Eduardo Camavinga","sobrenombre":"Eduardo Camavinga","fehaNacimiento":null,"raiting":70,"potencial":0,"link":"https://sofifa.com/player/248243/eduardo-camavinga/200014/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1066,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Cristian David Pavón","sobrenombre":"Cristian David Pavón","fehaNacimiento":null,"raiting":79,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1069,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Leroy Sané","sobrenombre":"Leroy Sané","fehaNacimiento":null,"raiting":86,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1071,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Kylian Mbappé","sobrenombre":"Kylian Mbappé","fehaNacimiento":null,"raiting":89,"potencial":0,"link":null,"activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1072,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Raphaël Varane","sobrenombre":"Raphaël Varane","fehaNacimiento":null,"raiting":86,"potencial":0,"link":"https://sofifa.com/player/201535/raphael-varane/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1096,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Ousmane Dembele","sobrenombre":"Ousmane Dembele","fehaNacimiento":null,"raiting":84,"potencial":0,"link":"https://sofifa.com/player/231443/ousmane-dembele/200014/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1313,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Pedro González López","sobrenombre":"Pedri","fehaNacimiento":null,"raiting":72,"potencial":0,"link":"https://sofifa.com/player/251854/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1322,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Jérémy Doku","sobrenombre":"Jérémy Doku","fehaNacimiento":null,"raiting":68,"potencial":0,"link":"https://sofifa.com/player/246420/jeremy-doku/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1333,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Erling Braut Håland","sobrenombre":"Erling Håland","fehaNacimiento":null,"raiting":78,"potencial":0,"link":"https://sofifa.com/player/239085/erling-braut-haland/200015/","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0},{"id":1366,"nombre":null,"apellidoPaterno":null,"apellidoMaterno":null,"nombreCompleto":"Carlos Vinícius Alves Morais","sobrenombre":"Vinícius","fehaNacimiento":null,"raiting":75,"potencial":0,"link":"https://sofifa.com/player/244621/carlos-vinicius-alves-morais/?hl=es-ES","activo":0,"userManager":null,"prestamo":0,"equipo":{"id":15,"nombre":"FC BARCELONA","manager":null,"descripcion":null,"totalJugadores":0,"totalRaiting":0,"salarios":0,"division":null,"jugadores":null,"datosFinancieros":null,"temporada":null,"finanzas":null,"presupuestoInicial":0,"presupuestoFinal":0,"img":null},"equipoPres":null,"equipos_idEquipo":0}];
//
//	$scope.example9settings = {enableSearch: true, displayProp : "sobrenombre",checkBoxes: true,scrollable: true,selectedToTop: true};
//	$scope.example5customTexts = {buttonDefaultText: 'Seleccionaar Jugador'};
	
	$scope.example9settings = {enableSearch: true,displayProp : "sobrenombre",scrollable: true,selectedToTop: true,selectionLimit: 1,
			   groupByTextProvider: function(groupValue) {     
			        if (groupValue == ''+self.jornadaEdit.idEquipoLocal) {
//			        	console.log("valor:"+groupValue+"   nmbre]:"+self.jornadaEdit.nombreEquipoLocal+"   nmbrevisita]:"+self.jornadaEdit.nombreEquipoVisita);
			          return self.jornadaEdit.nombreEquipoLocal; 
			        } else { 
//			        	console.log("valor Visita:"+groupValue+"   nmbrevisita]:"+self.jornadaEdit.nombreEquipoVisita+"   nmbre]:"+self.jornadaEdit.nombreEquipoLocal);
			          return self.jornadaEdit.nombreEquipoVisita; 
			        }       
			    }, 
			  groupBy: 'equipos_idEquipo',
			  smartButtonMaxItems: 1,
			   smartButtonTextConverter: 
				   function(itemText, originalItem) { 
				     return itemText;  }  
			  };
    $scope.example5customTexts = {buttonDefaultText: 'Seleccionaar'};
			  
	

	
	self.findPlayersJornada = findPlayersJornada;
	self.getGolesJornadas = getGolesJornadas;
	self.getPlayers = getPlayers;
	self.addGoles  = addGoles;
	self.getJornada = getJornada;
	self.addImagen =  addImagen;
	self.getInitTorneo = getInitTorneo;
	self.getJornadaActual = getJornadaActual;
	self.setJornadaActual = setJornadaActual;
	self.showEditJornada = showEditJornada;
	self.getTorneos = getTorneos;
	self.getGruposTorneo = getGruposTorneo;
	self.getTablaGrupo = getTablaGrupo;
	self.guardarJornada = guardarJornada;
	self.deletedGol   = deletedGol;
	self.getPendientes = getPendientes;
	
	buscarDivisiones()
	
	function getTorneos(){
		
		return CONFIG.VARTEMPORADA.torneos;
	}
	
	function getJornadaActual (){
		
		if(self.jornadaSelect == null || self.jornadaSelect.length == 0){
			self.jornadaSelect = [];
			if(self.jornadas!= null && self.jornadas!= ''){
				for (var i = 0 ; i<=self.jornadas.length ; i ++){
					if(self.jornadas[i].numeroJornada == 1){
						self.jornadaSelect.push( self.jornadas[i]); 
						console.log("get Jornada Select]:",self.jornadaSelect);
						break;
					}
					
				}
			}
		}else{
			if(self.jornadas!= null && self.jornadas!= ''){
				for (var i = 0 ; i<=self.jornadas.length ; i ++){
					if(self.jornadas[i].numeroJornada == self.jornadaSelect[0].numeroJornada){
						self.jornadaSelect = [];
					    self.jornadaSelect.push( self.jornadas[i]); 
						console.log("get Jornada Select]:",self.jornadaSelect);
						break;
					}
					
				}
			}
			
		}
		
				
	}
	
	function setJornadaActual (jornada){
		self.jornadaSelect = []
		self.jornadaSelect.push( jornada);
		
		console.log("setJornadaActual]:",self.jornadaSelect);
		
	}
	
	function getInitTorneo(div){
		self.jornadaSelect == null;
		self.divisionSelect = div;
		getTablaGeneral()
		getJornadas()
		
	}
	
    function getTablaGeneral(){
    	console.log("-----getTablaGeneral()----->",self.divisionSelect)
    	
		TorneoLMService.getTablaGeneral(self.divisionSelect.id)
                .then(
                function(d) {
                    self.tablaGeneral = d;
                    
                    console.log("TorneoLMService getTablaGeneral]:",self.tablaGeneral)
                    getJornadas();
                    if(self.divisionSelect.tipoTorneo == 2){
                		getGruposTorneo(self.divisionSelect)
                	}
                    return d;
                },
                function(errResponse){
                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
                }
            );
            return null;
        }
	
	 function getJornadas(){
//			TorneoLMService.getJornadas(self.divisionSelect.id,1)
//	                .then(
//	                function(d) {
//	                    self.jornadas = d;
		 try{
		 				self.jornadas = self.tablaGeneral.jornadas;
	                    
	                    console.log("TorneoLMService-getTablaJornadas]:",self.jornadas)
	                    console.log("TorneoLMService-getTablaJornadas]: -----------FIN-----------")
	                    getJornadaActual()
		 }catch(error){}
//	                    return d;
//	                },
//	                function(errResponse){
//	                    console.error('[TorneoLMService] Error while fetching TorneoLMService()');
//	                }
//	            );
	            return null;
	        }
	 
	 function findPlayersJornada(idEquipo,idEquipoVisita){
		 UserService.findPlayersByIdEquipoJornada(idEquipo,idEquipoVisita).then(function(d) {
//				console.log("[TorneoLMService] - Players]:",JSON.stringify(d));
			 console.log("[TorneoLMService] - Players]:",d);
				self.players = d;
				$scope.example9data = d;
			}, function(errResponse) {
				self.players = [];
				console.error('[TorneoLMService] Error while fetching Users');
			});
	    }
	 
	 function getJornada(idJornada,id,idEquipoLocal,idEquipoVisita){
			TorneoLMService.getJornada(idJornada,id,idEquipoLocal,idEquipoVisita)
	                .then(
	                function(d) {
	                    self.jornadaEdit = d;
	                    $scope.example9model = [];
	                	$scope.example9modelV = [];
	                    
	                    console.log("TorneoLMService-getJornada]:",self.jornadaEdit)
	                    
	                    
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[getJornada] Error while fetching getJornada()');
	                }
	            );
	            return null;
	        }
	 
	 function getGolesJornadas(idJornada,idEquipoLocal,idEquipoVisita){
			TorneoLMService.getGolesJornadas(idJornada,idEquipoLocal,idEquipoVisita)
	                .then(
	                function(d) {
	                    self.golesJornada = d;
	                    
	                    console.log("TorneoLMService-getGolesJornadas]:",self.golesJornada)
	                    
	                    
	                    return d;
	                },
	                function(errResponse){
	                    console.error('[getGolesJornadas] Error while fetching TorneoLMService()');
	                }
	            );
	            return null;
	        }
	 
	 function getPlayers(idEquipo,golesJornada){
		 
		 
		 var playersGoles = [];
		 
		 if(golesJornada!=null){
		 for(var i=0;i<golesJornada.length;i++){
				
				if(golesJornada[i].idEquipo == idEquipo && golesJornada[i].deleted == 0){
					playersGoles.push(golesJornada[i]);
				}			
			}
		 }
		 
		 return playersGoles;
		 
	 }
	 
//	 function addGoles(idJugador,idEquipo,jornadaVar) {
//		 
//		 TorneoLMService.addGoles(idJugador,idEquipo,jornadaVar.id,jornadaVar.idJornada)
//         .then(
//         function(d) {
//             self.golesJornada = d;
//             
//             console.log("TorneoLMService-addGoles]:",self.golesJornada)
//             
//             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
//             
//             getTablaGeneral()
//             getJornadas()
//             
//             
//             return d;
//         },
//         function(errResponse){
//             console.error('[addGoles] Error while addGoles()');
//         }
//     );
//     return null;
//		 
//	 }
function addGoles(jugador,idEquipo,jornadaVar) {
		 
//		 TorneoLMService.addGoles(jugador.id,idEquipo,jornadaVar.id,jornadaVar.idJornada)
//         .then(
//         function(d) {
//             self.golesJornada = d;
//             
//             console.log("TorneoLMService-addGoles]:",self.golesJornada)
             
             
             
             //getTablaGeneral()


            
             
             console.log("Jugador Agregar gol]-------",jugador)
        	 var jugadorVal = new Object();
        	 jugadorVal.idEquipo          = idEquipo;
        	 jugadorVal.idPersona         = jugador.id;
        	 jugadorVal.sobrenombre       = jugador.sobrenombre;
        	 jugadorVal.nombreCompleto    = jugador.nombreCompleto;
        	 jugadorVal.isAutogol         = (jugador.equipo.id == idEquipo) ? 0 : 1;
        	 jugadorVal.deleted           = 0;
        	 jugadorVal.id                = 0;
        	 
        	 
        	 
             if(self.jornadaEdit.golesJornada != null){
            	 self.jornadaEdit.golesJornada.push(jugadorVal);
             }else{
            	 var golesJornadaVal = [];
            	 golesJornadaVal.push(jugadorVal);
            	 self.jornadaEdit.golesJornada = golesJornadaVal;
            	 
             }
             
             
             if(self.jornadaEdit.idEquipoLocal == idEquipo){
            	 if(self.jornadaEdit.golesLocal == null){
            		 self.jornadaEdit.golesLocal = 1
            		 self.jornadaEdit.golesVisita = 0
            	 }else{
            		 var golesVal = 0;
            		 self.jornadaEdit.golesJornada.forEach(function (elemento, indice, array) {
            			    if(elemento.idEquipo == self.jornadaEdit.idEquipoLocal && elemento.deleted == 0 ){
            			    	golesVal ++;
            			    }
            			});
            		 self.jornadaEdit.golesLocal = golesVal
            	 }
             }
             if(self.jornadaEdit.idEquipoVisita == idEquipo){
            	 if(self.jornadaEdit.golesVisita == null){
            		 self.jornadaEdit.golesVisita = 1
            		 self.jornadaEdit.golesLocal = 0
            	 }else{
            		 var golesVal = 0;
            		 self.jornadaEdit.golesJornada.forEach(function (elemento, indice, array) {
            			    if(elemento.idEquipo == self.jornadaEdit.idEquipoVisita && elemento.deleted == 0 ){
            			    	golesVal ++;
            			    }
            			});
            		 self.jornadaEdit.golesVisita = golesVal
            	 }
             }
             
//    		 if(jornadaVar!=null){
//    			 console.log("------------------>Entrando",jornadaVar)
//    		 for(var i=0;i<self.jornadas.length;i++){
//    			 console.log("------------------>Entrando Jornadas",self.jornadas[i])
//    				if(self.jornadas[i].idJornda == jornadaVar.idJornada){
//    					console.log("Jornada encontrada",self.jornadas[i])
//    					    					
//    					for(var j=0;j<self.jornadas[i].jornada.length;j++){
//    						console.log("------>Entrando  +++++ Juegos",self.jornadas[i].jornada[j])
//    						if(self.jornadas[i].jornada[j].id == jornadaVar.id){
//    							console.log("Igualando jornada ",self.jornadaEdit)
//    							self.jornadas[i].jornada[j] = self.jornadaEdit;
//    							break;
//    						}
//    						
//    					}
//    					break;
//    				}			
//    			}
//    		 }
             
             
//        va queurn null;
		 
	 }
	function deletedGol(jugador,idEquipo) {
		
		var indexJ =  self.jornadaEdit.golesJornada.indexOf(jugador);
		
		console.log(indexJ)
		self.jornadaEdit.golesJornada[indexJ].deleted = 1;
		
		if(self.jornadaEdit.idEquipoLocal == idEquipo){
			self.jornadaEdit.golesLocal = self.jornadaEdit.golesLocal -1;
		}
		if(self.jornadaEdit.idEquipoVisita == idEquipo){
			self.jornadaEdit.golesVisita = self.jornadaEdit.golesVisita -1;
		}
		
		
	}
	 
//	 function addImagen(idEquipo,jornadaVar,img) {
//		 
//		 TorneoLMService.addImagen(idEquipo,jornadaVar.id,jornadaVar.idJornada,img)
//         .then(
//         function(d) {
//            
//             
//             console.log("TorneoLMService-addImagen]:",d)
//             
//             getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
//             
//             
//             return d;
//         },
//         function(errResponse){
//             console.error('[addGoles] Error while addGoles()');
//         }
//     );
//     return null;
//		 
//	 }
    
	function addImagen(idEquipo,jornadaVar,img) {	           
            
            console.log("TorneoLMService-addImagen]:")
            
            //getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
            
            if(self.jornadaEdit.imagenes == null ){
            	var imagenes = [];
            	
            	self.jornadaEdit.imagenes = imagenes; 
            }
            var imgO = new Object();
            imgO.img = img;
            self.jornadaEdit.imagenes.push(imgO);
            
            console.log("TorneoLMService-addImagen]:",self.jornadaEdit)
		 
	 }
	
	
	function guardarJornada(jornadaVar) {	           
        
		console.log("Jornada a editar]:",self.divisionSelect)
			 TorneoLMService.guardarJornada(jornadaVar,self.divisionSelect.id)
		      .then(
		      function(d) {
		         
		          
		          console.log("TorneoLMService-guardarJornada]:",d)
		          if(d.status == 0){
			          self.tablaGeneral = d.data
			          getJornadas();
			          getPendientes();
		          }
		          
		         // getJornada(jornadaVar.idJornada,jornadaVar.id,jornadaVar.idEquipoLocal,jornadaVar.idEquipoVisita)
		          
		          
		          return d;
		      },
		      function(errResponse){
		          console.error('[guardarJornada] Error while addGoles()');
		      }
		  );
		 return null;
	 
	}
	
	 function buscarDivisiones() {
			EquipoService.buscarDivisiones().then(function(d) {
				console.log("Entre Buscar TorneoLMConroller-buscarDivisiones-->",d)
				self.divisiones = d;
				if(self.divisiones!= null && self.divisiones.length >0){
					self.divisionSelect = (CONFIG.VARTEMPORADA.torneos != null && CONFIG.VARTEMPORADA.torneos.length>0) ? CONFIG.VARTEMPORADA.torneos[0] : null
				 }
				
				getTablaGeneral()
				getJornadas()	
				
			}, function(errResponse) {
				console.error('Error while fetching TorneoLMConroller-buscarDivisiones');
			});
			
		}
	 
	 function showEditJornada(roles,idEquipo,idEquipoLocal,idEquipoVisita) {
		 
			if(self.jornadaEdit!= null && ((roles.includes('Manager') && (idEquipoLocal == idEquipo || idEquipoVisita == idEquipo )) 
					|| roles.includes('Admin')) && self.jornadaEdit.cerrada == 0){	
				return true;
			}						
			return false;
		}
	 
	 function getGruposTorneo(torneoSelect){
			console.log("-----------getGruposTorneo-------->Torneo]:",torneoSelect) 
			if(torneoSelect.tipoTorneo){
			TorneoLMService.getGruposTorneo(torneoSelect.id)
		            .then(
		            function(d) {
		            	
		            	self.gruposTorneo = d;
		            	
		                console.log("TorneoLMService-getGruposTorneo]:",d)
		                
		                
		                return d;
		            },
		            function(errResponse){
		                console.error('[getGruposTorneo] Error while fetching TorneoLMService()');
		            }
		        );
			}else{
				self.gruposTorneo = [];
			}
		        return null;
		    }
	 
	 function getTablaGrupo(grupo){
		 //console.log("Gurpo----",grupo)
		 
		 var tablaGeneralGrupo = [];
		 
		 if (self.tablaGeneral.tablaGeneral!= null){
		 for (var i = 0 ; i<=self.tablaGeneral.tablaGeneral.length ; i ++){
			 try{
				if(self.tablaGeneral.tablaGeneral[i].nombreGrupo == grupo.numero){
					//console.log("Registro..ADD....",self.tablaGeneral[i])
					tablaGeneralGrupo.push( self.tablaGeneral.tablaGeneral[i]); 
					
				}
		     }catch(error){}
				
			}
		 }
		 return tablaGeneralGrupo;
		 
		 
		 
	 }
	 
	 function getPendientes(){
		 
		// var jorPendientes = [];
		 self.jorPendientes = null;
		 self.jorPendientes = [];
		 
		 if(self.jornadas != null){
			 for (var i = 0 ; i<self.jornadas.length ; i ++){
				 var juegos = self.jornadas[i].jornada;
			
				 for (var j = 0 ; j<juegos.length ; j ++){ 
					
					 if(juegos[j].golesLocal == null){
						 self.jorPendientes.push(juegos[j])
					 }
				 }
			 }
			 
		 }
		 
		 console.log("Jornadas pendientes:  ", self.jorPendientes);
	 }
	 
	
	
	

    }]);