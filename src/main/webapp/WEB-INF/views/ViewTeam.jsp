<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>FIFA XGAMERS</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<!--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
<!--      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script> -->
<!-- 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
  </style>
</head>
<body ng-app="myApp" >
	<script src="<c:url value='/static/js/service/team_service.js' />"></script>
  	<script src="<c:url value='/static/js/controller/team_controller.js' />"></script>
  	<script src="<c:url value='/static/js/service/draftPC_service.js' />"></script>
  	  <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/user_service.js' />"></script>
      <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
<div ng-controller="TeamController as ctrl">
<div ng-controller="UserController as ctrlJuga">

<sec:authentication var="user" property="principal" />
<!-- <div class="jumbotron jumbotron-fluid" > -->
  
  <div class="container text-center container-fluid">
  
    <img src="{{ctrl.equipo.img}}" style="width: 15%;"class="card-img-center" alt="..."> 
    <h4>{{ctrl.equipo.nombre}}</h4>      
<!--     <p>{{ctrl.equipo.descripcion}}</p> -->
<!--       <div class="row  justify-content-center"> -->
      <div class="row-fluid">
<!-- 	    <div class="col-sm-3"> -->
<!-- 	      <h4><span class="badge badge badge-primary">Total Rating: {{ctrl.equipo.totalRaiting}}</span></h4> -->
<!-- 	    </div> -->
<!-- 	    <div class="col-sm-3"> -->
<!-- 	      <h4><span class="badge badge-primary">Total Jugadores: {{ctrl.equipo.totalJugadores}}</span></h4> -->
<!-- 	    </div> -->
<!-- 	    <div class="col-sm-3"> -->
<!-- 	      <h4><span class="badge badge-success">Salarios : {{ctrl.equipo.salarios | currency}}</span></h4> -->
<!-- 	    </div> -->
		  <div class=" badge badge-success"><h5><span>Total Rating: {{ctrl.equipo.totalRaiting}}</span></h5></div>
          <div class=" badge  badge-primary"><h5><span>Total Jugadores: {{ctrl.equipo.totalJugadores}}</span></h5></div>
          <div class="badge badge-success"><h5><span>Salarios : {{ctrl.equipo.salarios | currency}}</span></h5></div>
	  </div>
  </div>
<!-- </div> -->

<!-- ModalJugadores -->
                  <div class="modal fade" id="myModal" role="dialog">
                     <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                           <div class="modal-header">
                              <h4 class="modal-title">Datos Jugador</h4>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                           </div>
                           <div class="modal-body">
                              <form  name="myFormJuga" class="form-horizontal">
                                 <input type="hidden" ng-model="ctrlJuga.player.id" />
                                 <div class="row">
                                    <div class="form-group col-md-12">
                                       <label class="col-md-2 control-lable" for="nomcom">Nombre
                                       Completo</label>
                                       <div class="col-md-7">
                                          <input type="text" ng-model="ctrlJuga.player.nombreCompleto"
                                             id="nomcom" class="lastname form-control input-sm"
                                             placeholder="Nombre completo" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myFormJuga.$dirty">
                                             <span ng-show="myFormJuga.nomcom.$error.required">Es
                                             requerido</span> <span ng-show="myFormJuga.nomcom.$error.minlength">La
                                             longitud minima es 3</span> <span ng-show="myFormJuga.nomcom.$invalid">Este
                                             campo es Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="form-group col-md-12">
                                       <label class="col-md-2 control-lable" for="sobreNom">Nombre
                                       Corto</label>
                                       <div class="col-md-7">
                                          <input type="text" ng-model="ctrlJuga.player.sobrenombre"
                                             id="sobreNom" class="lastname form-control input-sm"
                                             placeholder="Nombre corto" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myFormJuga.$dirty">
                                             <span ng-show="myFormJuga.sobreNom.$error.required">Es
                                             requerido</span> <span ng-show="myFormJuga.sobreNom.$error.minlength">La
                                             longitud minima es 3</span> <span
                                                ng-show="myFormJuga.sobreNom.$invalid">Este campo es
                                             Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="form-group col-md-12">
                                       <label class="col-md-2 control-lable" for="raiti">Rating</label>
                                       <div class="col-md-7">
                                          <input type="text" ng-model="ctrlJuga.player.raiting" id="raiti"
                                             class="lastname form-control input-sm"
                                             placeholder="Raiting" required ng-minlength="2" />
                                          <div class="has-error" ng-show="myFormJuga.$dirty">
                                             <span ng-show="myFormJuga.sobreNom.$error.required">Es
                                             requerido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="form-group col-md-12">
                                       <label class="col-md-2 control-lable" for="raiti">Link Sofifa</label>
                                       <div class="col-md-7">
                                          <input type="text" ng-model="ctrlJuga.player.link" id="link"
                                             class="lastname form-control input-sm"
                                             placeholder="Link Sofifa" required ng-minlength="2" />
                                          
                                       </div>
                                    </div>
                                 </div>
                                 <div ng-controller="EquipoController as ctrlEquipo">
                                    <div class="row">
                                       <div class="form-group col-md-12">
                                          <label class="col-md-2 control-lable" for="address">Equipo</label>
                                          <div class="col-md-7">
                                             <select ng-model="selectedTeam"
                                                ng-options="equipo as equipo.nombre for equipo in ctrlEquipo.equipos track by equipo.id"
                                                class="lastname form-control input-sm">
                                                <option value="">--Elige opcion--</option>
                                             </select>
                                          </div>
                                       </div>
                                    </div>
                                    <div class="row">
                                       <div class="form-actions floatRight">
                                          <input  ng-click="ctrl.submitPlayer(selectedTeam,ctrlJuga.player)" 
                                             type="submit" value="{{!ctrlJuga.player.id ? 'Add' : 'Update'}}"
                                             class="btn btn-primary btn-sm" ng-disabled="myFormJuga.$invalid" data-dismiss="modal">
                                       </div>
                                    </div>
                                 </div>
                              </form>
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                           </div>
                        </div>
                     </div>
                  </div>
  
  <!-- Modal Sponsor-->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Sponsor</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submitSponsor(sponsorSelected,opcionalSelected)" name="myForm" class="form-horizontal">
<%-- 					<form name="myForm" class="form-horizontal""> --%>
                      <input type="hidden" ng-model="ctrl.equipo.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                        	 <div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Sponsor</span>					       
								    </div>
								    <select  ng-model="sponsorSelected" ng-options="sponsor as ('Clase:' + sponsor.clase +' ' +sponsor.nombreSponsor ) for sponsor in ctrl.sponsors track by sponsor.id" class="lastname form-control input-sm">
										<option value="" >--Elige Sponsor--</option>
									</select>
									
								 </div>
                          </div>
                      </div>  
                      <div class="row">
							<div class="form-group col-md-12">
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Contrato Fijo</span>					       
								    </div>
								    <input type="text" class="form-control" readonly value="{{sponsorSelected.contratoFijo | currency}}">
								    <div class="input-group-prepend">
								       <span class="input-group-text">Objetivos</span>					       
								    </div>
								    <input type="text" class="form-control" readonly value="{{ctrl.sumaObjetivos(sponsorSelected,false,false) | currency}}">
								 </div>
							</div>
						</div>    
						<div class="row">
							<div class="form-group col-md-12">
								
								<div class="input-group mb-3 input-group-sm">
								<div class="form-check">
								  <label class="form-check-inline">
								    <input type="checkbox" class="form-check-input" name="optradio" ng-model="opcionalSelected">Opcionales
								  </label>
								</div>
								    <div class="input-group-prepend" ng-show="opcionalSelected">
								       <span class="input-group-text">Opcionales</span>					       
								    </div>
								    <input type="text" class="form-control" ng-show="opcionalSelected" readonly value="{{ctrl.sumaObjetivos(sponsorSelected,opcionalSelected,false) | currency}}">
								    <div class="input-group-prepend">
								       <span class="input-group-text">Total</span>					       
								    </div>
								    <input type="text" class="form-control" readonly value="{{ctrl.getTotal(sponsorSelected,opcionalSelected,false) | currency}}">
								 </div>
							</div>
						</div>                    
                       
                      <div class="row">
                          <div class="form-group col-md-12">
                              <div class="col">
                                  <div class="table-responsive-sm">
							       <table class="table table-hover">
									    <thead>
									      <tr>
									        <th>Objetivo</th>
									        <th>Pago</th>
									        <th>Opcional</th>
									      </tr>
									    </thead>
									    <tbody>
									      <tr ng-repeat="u in sponsorSelected.objetivos">
									        <td>{{u.nombre}}</td>
									        <td>{{u.monto}}</td>
									        <td>{{u.penalizacion}}</td>
									      </tr>
									    </tbody>
									  </table>
									  </div>
                              </div>
                          </div>
                      </div>
                     
  
<!--                       <div class="row"> -->
<!--                           <div class="form-actions floatRight"> -->
<!--                               <input type="submit"  value="Guardar" class="btn btn-primary btn-sm" ng-disabled="sponsorSelected==null"> -->
<!--                           </div> -->
<!--                       </div> -->
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Guardar" class="btn btn-primary btn-sm" ng-disabled="sponsorSelected==null" >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>
		
		<!-- Modal Finanzas-->
		<div class="modal fade" id="myModalFinanzas" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Datos Financieros</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submitFinanzas(catSelected,ctrl.montoCatalogo)" name="myFormCon" class="form-horizontal">
<%-- 					<form name="myForm" class="form-horizontal""> --%>
                      <input type="hidden" ng-model="ctrl.equipo.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                        	 <div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Concepto</span>					       
								    </div>
								    <select  ng-model="catSelected" ng-options="catFinanzas as catFinanzas.descripcion for catFinanzas in ctrl.catalogoFinanzas track by catFinanzas.id" class="lastname form-control input-sm">
									        <option value="" >--Elige Opcion--</option>
									      </select>
									</select>
								 </div>
                          </div>
                      </div>  
                      <div class="row">
							<div class="form-group col-md-12">
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Monto</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.montoCatalogo" id="montoCon" class="form-control input-sm" placeholder="Monto" required ng-minlength="3"/>
								 </div>
							</div>
						</div>    
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Guardar" class="btn btn-primary btn-sm" ng-disabled="ctrl.montoCatalogo==null" >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>
		<!-- Modal DraftPC-->
		<div class="modal fade" id="myModalDraf" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
				<div class="alert alert-danger alert-dismissable" ng-show="ctrl.isError">
<!-- 				<button type="button" class="close" data-dismiss="alert">&times;</button> -->
				  <strong>¡Error!</strong> {{ctrl.Error}}
				</div>
					<div class="modal-header">
						<h4 class="modal-title">{{ctrl.jugador.sobrenombre + ' - Raiting: ' + ctrl.jugador.raiting}}</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submitDraftPC(ctrl.jugador,ctrl.montoOferta,ctrl.manager,selectedEquipo)" name="myFormCon" class="form-horizontal">
                      <div class="row">
							<div class="form-group col-md-12">
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Equipo Oferta</span>					       
								    </div>
								    <select ng-model="selectedEquipo"
								    		ng-options="equipo as equipo.nombre for equipo in ctrl.equipos track by equipo.id" class="lastname form-control input-sm">
									        <option value="">--Elige opcion--</option>
									</select>
								 </div>
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Monto</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.montoOferta" id="montoOfer" class="form-control input-sm" placeholder="Monto" required ng-minlength="3"/>
								 </div>
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Manager</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.manager" id="manager" class="form-control input-sm" placeholder="Manager" required ng-minlength="3"/>
								 </div>
							</div>
						</div>    
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Guardar" class="btn btn-primary btn-sm" ng-disabled="ctrl.montoOferta==null && ctrl.selectedEquipo ==null" >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>
		<!-- Modal DraftPC  Confirmar-->
		<div class="modal fade" id="myModalConfirm" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
				<div class="alert alert-danger alert-dismissable" ng-show="ctrl.isError">
<!-- 				<button type="button" class="close" data-dismiss="alert">&times;</button> -->
				  <strong>¡Error!</strong> {{ctrl.Error}}
				</div>
					<div class="modal-header">
					    <h4 class="modal-title">Confirmar</h4>
						
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submitDraftPCConfirm(ctrl.jugador,selectedEquipo)" name="myFormCon" class="form-horizontal">
                      <h3 class="modal-title">{{ctrl.jugador.sobrenombre + ' - Raiting: ' + ctrl.jugador.raiting}}</h3>   
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Confirmar" class="btn btn-primary btn-sm" >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>
  
<div class="container">
  <br>
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" data-toggle="tab" ng-click="ctrl.ocultaDatos()">Jugadores</a>
      
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.ocultaJuga()" >Datos Financieros</a>
    </li>
    
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showPrestamos(true)" >Prestamos</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showDraftPC(true)" >Draft PC</a>
    </li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div id="home" class="container tab-pane active" >
      <div class="container-fluid bg-3 text-center"> 

      <div class="formcontainer" ng-show="ctrl.vistaJuga">
				<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">
						<span class="lead">Lista de Jugadores</span>
					</div>
				</div>
				<div class="table-responsive-sm">
					<div class="row">
                          <div class="col align-self-center">
                             <p><input class="form-control"  type="text" ng-model="test" placeholder="Buscar"></p>
						   </div>                            
              		</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID.</th>
								<th>N. Largo</th>
								<th>N. Corto</th>
								<th>Equipo</th>
								<th>Rating</th>
<!-- 								<th width="20%"></th> -->
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="u in ctrl.equipo.jugadores | orderBy : '-raiting' | filter : test" ">
								<td><span ng-bind="u.id"></span></td>
<!-- 								<td><span ng-bind="u.nombreCompleto"></span></td> -->
								<td ng-show="u.link!=null"><a href="{{u.link}}" target="_blank" >{{u.nombreCompleto}}</td>
                                <td ng-show="u.link==null">{{u.nombreCompleto}}</td>
								<td><span ng-bind="u.sobrenombre"></span></td>
								<td><span ng-bind="u.equipo.nombre"></span></td>
								<td><span ng-bind="u.raiting"></span></td>
								<td>
                                <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                                     <button  ng-disabled=" !ctrl.showEditPlayer(ctrl.equipo,'${user.idEquipo}','${user.roles}') "                                       
                                     type="button" data-toggle="modal" data-target="#myModal"  ng-click="ctrlJuga.edit(u.id)"
                                        class="btn btn-success btn-sm">Edit</button>
                                </sec:authorize>
                                </td>
							</tr>
						</tbody>
					</table>
				</div>
			</div> 
			
		
    </div>
    </div>
    <div id="menu1" class="container tab-pane active" ng-show="ctrl.vistaDat"><br>
    
      <div class="formcontainer">
<!--       <div class="container-fluid bg-3 text-center"> -->
		<div class="panel panel-default">
<!-- 		<div > -->
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead">Datos financieros</span>
			</div>
			<div class="container">
			  <div class="row">
			    <div class="col-sm">
			    <form ng-submit="ctrl.submitDatos(ctrl.preInicial)" name="myFormDat" class="form-horizontal">
			    <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
			    <button type="button" ng-click="ctrl.showEditDat()" class="btn btn-info btn-sm" 
			    ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false"
			     ng-show="!ctrl.showInicial" >Editar</button>
			     </sec:authorize>
				<button type="submit" ng-click="ctrl.showGuarDat()" class="btn btn-info btn-sm" 
				 ng-show="ctrl.showInicial">Guardar</button>
				   
				      <div class="input-group mb-3 input-group-sm">
					     <div class="input-group-prepend">
					       <span class="input-group-text">Presupuesto Inicial</span>					       
					    </div>
					    <input type="text" class="form-control" ng-show="!ctrl.showInicial" readonly value="{{ctrl.equipo.datosFinancieros.presupuestoInicial | currency}}">
					    <input type="text" ng-model="ctrl.preInicial" ng-show="ctrl.showInicial" id="montoInicial" class="form-control input-sm" placeholder="Presupuesto Inicial" required ng-minlength="3"/>
					    
					  </div>
				      <div class="col-sm">
<!-- 					     <div class="input-group-prepend"> -->
						   <span class="input-group-text">Salarios: {{ctrl.equipo.salarios | currency}}</span>	
					       <span class="input-group-text">Presupuesto Final: {{ctrl.equipo.datosFinancieros.presupuestoFinal | currency}}</span>					       
					       <span class="input-group-text">Presupuesto Final Sponsor: {{ctrl.equipo.datosFinancieros.presupuestoFinalSponsor | currency}}</span>					       
<!-- 					    </div> -->
					    
					  </div>
				  </form>
				  <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
				  <button type="button" ng-click="ctrl.buscarCatFinanzas()" class="btn btn-info btn-sm" data-toggle="modal"
					data-target="#myModalFinanzas"
					ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false" 
					ng-show="ctrl.equipo.datosFinancieros!=null">Agregar Conceptos</button>
				  </sec:authorize>	
				  <div class="table-responsive-sm">
				       <table class="table table-hover">
						    <thead>
						      <tr>
						        <th>Concepto</th>
						        <th>Monto</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr class = "{{f.tipoconcepto.codigo == 'ingreso' ? 'table-success' : 'table-danger'}}" ng-repeat="f in ctrl.equipo.finanzas">
						        <td>{{f.descripcion}}</td>
						        <td>{{f.monto | currency}}</td>
						      </tr>
						    </tbody>
						  </table>
						  </div>
    		</div>
<!--     		----------------------------------PARTE DE SPONSOR ------------------------------------- -->
<!--     		<div class="col-sm"> -->
<%--     			<sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')"> --%>
<!-- 	    		<button type="button" ng-click="ctrl.buscarSponsors()" class="btn btn-info btn-sm" data-toggle="modal" -->
<!-- 				data-target="#myModal" -->
<%-- 				ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false"  --%>
<!-- 				ng-show="ctrl.equipo.datosFinancieros.sponsor==null">Agregar Sponsor</button> -->
<%-- 				</sec:authorize> --%>
<%-- 				<sec:authorize access="hasAnyRole('ROLE_Admin')"> --%>
<!--     			<button type="button" ng-click="ctrl.showEditObj(true)" class="btn btn-info btn-sm"  -->
<!-- 			     ng-show="!ctrl.showObj">Calificar Objetivos</button> -->
<%-- 			     </sec:authorize> --%>
<%-- 			     <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')"> --%>
<!-- 			    <button type="button" ng-click="ctrl.guardarObj(ctrl.equipo.datosFinancieros.sponsor.objetivos)" class="btn btn-info btn-sm"  -->
<!-- 			     ng-show="ctrl.showObj">Guardarr</button>  -->
<%-- 			     </sec:authorize> --%>
<!-- 			    <button type="button" ng-click="ctrl.showEditObj(false)" class="btn btn-info btn-sm"  -->
<!-- 			     ng-show="ctrl.showObj">Canelar</button>   -->
<!--      			  <span class="input-group-text">Sponsior: {{ctrl.equipo.datosFinancieros.sponsor.nombreSponsor}}</span> -->
<!-- 			      <span class="input-group-text">Contrato Fijo: {{ctrl.equipo.datosFinancieros.sponsor.contratoFijo | currency}}</span> -->
<!-- 			      <span class="input-group-text">Total: {{ctrl.getTotal(ctrl.equipo.datosFinancieros.sponsor,ctrl.equipo.datosFinancieros.opcional,true) | currency}}</span> -->
<!-- 			      <div class="table-responsive-sm"> -->
<!-- 			      <table class="table table-hover"> -->
<!-- 				    <thead> -->
<!-- 				      <tr> -->
<!-- 				        <th>Objetivo</th> -->
<!-- 				        <th>Pago</th> -->
<!-- 				        <th>Opcional</th> -->
<!-- 				        <th ng-disabled="!ctrl.showObj">OK</th> -->
<!-- 				      </tr> -->
<!-- 				    </thead> -->
<!-- 				    <tbody> -->
<!-- 				      <tr ng-repeat="o in ctrl.equipo.datosFinancieros.sponsor.objetivos"> -->
<!-- 				        <td>{{o.nombre}}</td> -->
<!-- 				        <td>{{o.monto | currency}}</td> -->
<!-- 				        <td>{{o.penalizacion | currency}}</td> -->
<!-- 				        <td> -->
<!-- 				        	<div class="form-check"> -->
<!-- 							  <label class="form-check-inline"> -->
<!-- 							    <input type="checkbox" class="form-check-input" name="optobj"  -->
<!-- 							       ng-model="o.cumplido" ng-disabled="!ctrl.showObj"> -->
<!-- 							  </label> -->
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 				      </tr> -->
<!-- 				    </tbody> -->
<!-- 				  </table> -->
<!-- 				  </div> -->
<!--     	</div> -->
   
  </div>
</div> 
		</div>
	 </div> 
    
    </div>
    
    
    <div class="formcontainer" ng-show="ctrl.vistaDraftPC" >
				<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">
						<span class="lead">Draft PC - Jugadores ofertados</span>
					</div>
				</div>
				<div class="table-responsive-sm">
					<table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Nombre</th>
                              <th>Equipo Oferta</th>
                              <th>Manager</th>
                              <th>Oferta</th>
                              <th>Oferta Final</th>
                              <th>Fecha</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="e in ctrl.jugadoresDraft | orderBy : 'sobrenombre' | filter : test">
                              <td><span ng-bind="e.id"></span></td>
                              <td><span ng-bind="e.sobrenombre"></span></td>
                              <td><span ng-bind="e.comentarios"></span></td>
                              <td><span ng-bind="e.manager"></span></td>
                              <td><span ng-bind="e.montoOferta"></span></td>
                              <td><span ng-bind="e.ofertaFinal"></span></td>
                              <td><span ng-bind="e.fecha"></span></td>
                              <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                              <td><button type="button"  data-toggle="modal" 
                              		ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false"
									data-target="#myModalDraf" ng-click="ctrl.updateDraft(e)" class="btn btn-info btn-sm" ng-show="(e.idEquipoOferta != e.equipo.id)" >Contraofertar</button>
								   <button type="button"  data-toggle="modal" 
								   ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false"
									data-target="#myModalConfirm" ng-click="ctrl.updateDraft(e)" class="btn btn-info btn-sm" ng-show="(e.idEquipoOferta == ${user.idEquipo} && e.idEquipoOferta != e.equipo.id)" >Confirmar</button>							  
							  </td>
							  </sec:authorize>
                          </tr>
                      </tbody>
                  </table>
				</div>
			</div> 
			<div class="formcontainer" ng-show="ctrl.vistaPrestamos" >
				<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">
						<span class="lead">Lista de Prestamos</span>
					</div>
				</div>
				<div class="table-responsive-sm">
					<div class="row">
                          <div class="col align-self-center">
                             <p><input class="form-control"  type="text" ng-model="test" placeholder="Buscar"></p>
						   </div>                            
              		</div>
					<table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Nombre</th>
                              <th>Equipo</th>
                              <th>Equipo a Prestao</th>
                              <th></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="e in ctrl.prestamos | orderBy : 'sobrenombre' | filter : test">
                              <td><span ng-bind="e.id"></span></td>
                              <td><span ng-bind="e.sobrenombre"></span></td>
                              <td><span ng-bind="e.equipo.nombre"></span></td>
                              <td><span ng-bind="e.equipoPres.nombre"></span></td>
                              <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                              <td><button type="button" ng-click="ctrl.deletePrestamo(e.id)"
                              ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false" 
                              class="btn btn-danger custom-width">Terminar</button></td>
                              </sec:authorize>
                          </tr>
                      </tbody>
                  </table>
				</div>
			</div> 
   
  </div>
</div> 




<footer class="container-fluid text-center">
  <p>Footer Text</p>
</footer>
</div>
</div>
</body>
</html>
