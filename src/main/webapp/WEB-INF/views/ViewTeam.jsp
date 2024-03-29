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
      <script src="<c:url value='/static/js/LIB/ngtweet.min.js' />"></script>  
<%--       <script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script> --%>
<div ng-controller="TeamController as ctrl">
<div ng-controller="UserController as ctrlJuga">

<sec:authentication var="user" property="principal" />
<!-- <div class="jumbotron jumbotron-fluid" > -->
  
  <div class="container text-center container-fluid">
  
    <img src="{{ctrl.equipo.img2}}" style="width: 15%;"class="card-img-center" alt="..."> 
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
<!-- 		  <div class=" badge badge-success"><h5><span>Total Rating: {{ctrl.equipo.totalRaiting}}</span></h5></div> -->
          <div class=" badge  badge-primary"><h5><span>Total Jugadores: {{ctrl.equipo.totalJugadores}}</span></h5></div>
          <div class="badge badge-success"><h5><span>Presupuesto : {{ctrl.equipo.datosFinancieros.presupuestoFinal | currency}}</span></h5></div>
	  </div>
  </div>
<!-- </div> -->

<!-- ModalJugadores -->
                  <div class="modal fade" id="myModal" role="dialog">
                     <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content bg-dark text-white">
                           <div class="modal-header">
                              <h4 class="modal-title">Datos Jugador</h4>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                           </div>
                           <div class="modal-body">
                              <form  name="myFormJuga" >
                                 <input type="hidden" ng-model="ctrlJuga.player.id" />
                                 
                                  <div class="text-center ">	                                  
	                                  <img class="rounded float-center"ng-show="ctrlJuga.player.img != null" ng-src="{{ctrlJuga.player.img}}"   alt="...">
	                              </div>
                                 <div class="row">
                                    <div class="form-group col-md">
                                       <label class="col-md control-lable" for="idsofifa">ID sofifa</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrlJuga.player.idsofifa"
                                             id="idsofifa" class="lastname form-control input-sm"
                                             placeholder="idSofifa" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myFormJuga.$dirty">
                                             <span ng-show="myFormJuga.idsofifa.$error.required">idsofifa requerido</span> <span ng-show="myFormJuga.sobreNom.$error.minlength">La
                                             longitud minima es 3</span> <span
                                                ng-show="myFormJuga.idsofifa.$invalid">Este campo es Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="form-group col-md">
                                       <label class="col-md control-lable" for="sobreNom">Nombre
                                       Corto</label>
                                       <div class="col-md">
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
                                    <div class="form-group col-md">
                                       <label class="col-md control-lable" for="nomcom">Nombre
                                       Completo</label>
                                       <div class="col-md">
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
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="imgcom">Imagen</label>   
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrlJuga.player.img"
                                             id="imgcom" class="lastname form-control input-sm"
                                             placeholder="Imagen" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myForm.$dirty">
                                             <span ng-show="myForm.nomcom.$error.required">Es requerido</span> 
                                             <span ng-show="myForm.nomcom.$error.minlength">La longitud minima es 3</span> 
                                             <span ng-show="myForm.nomcom.$invalid">Este campo es Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="form-group col-md">
                                       <label class="col-md control-lable" for="raiti">Rating</label>
                                       <div class="col-md">
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
                                    <div class="form-group col-md">
                                       <label class="col-md control-lable" for="raiti">Link Sofifa</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrlJuga.player.link" id="link"
                                             class="lastname form-control input-sm"
                                             placeholder="Link Sofifa" required ng-minlength="2" />
                                          
                                       </div>
                                    </div>
                                 </div>
                                 <div ng-controller="EquipoController as ctrlEquipo">
                                    <div class="row">
                                    
                                       <div class="form-group col-md">
                                          <label class="col-md control-lable" for="address">Equipo</label>
                                          <div class="col-md">
<!--                                           <div  ng-dropdown-multiselect="" options="ctrlEquipo.buscarTodos();ctrlEquipo.equipos" selected-model="equipoModel" extra-settings="example9settings" translation-texts="example5customTexts"></div> -->
                                          <div custom-select="t as t.nombre for t in ctrlEquipo.equipos | filter: { nombre: $searchTerm }" ng-model="ctrlJuga.player.equipo">
									                <div class="pull-left" >
									                    <img ng-src="{{ t.img }}" style="width: 30px" />
									                    <strong>{{ t.nombre }}</strong>
									                </div>
									               
									            </div>
<!--                                              <select ng-model="selectedTeam" -->
<!--                                                 ng-options="equipo as equipo.nombre for equipo in ctrlEquipo.equipos track by equipo.id" -->
<!--                                                 class="lastname form-control input-sm"> -->
<!--                                                 <option value="">--Elige opcion--</option> -->
<!--                                              </select> -->

                                          </div>
                                       </div>
                                       
                                    </div>
                                    <div class="row">
                                    <div class="col-md">
                                    <div class="col-md">
                                    	<button  
										  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
										    Venta
										  </button>
										  <div class="collapse" id="collapseExample">
										    <div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
												<div class="alert alert-danger alert-dismissable" ng-show="ctrl.isError">
								<!-- 				<button type="button" class="close" data-dismiss="alert">&times;</button> -->
												  <strong>Â¡Error!</strong> {{ctrl.Error}}
												</div>
													
													<div class="modal-body">
													
														<div custom-select="t as t.nombre for t in ctrlEquipo.equipos | filter: { nombre: $searchTerm }" ng-model="ctrlJuga.player.equipoPago">
										                <div class="pull-left" >
										                    <img ng-src="{{ t.img }}" style="width: 30px" />
										                    <strong>{{ t.nombre }}</strong>
										                </div>
										               
										                </div>
													
													</div>
													
													<div class="input-group mb-3 input-group-sm">
													     
													    <input type="text" ng-model="ctrlJuga.player.costo" id="montoOfer" class="form-control input-sm" placeholder="Monto" />
													    <label id="montoSeparado" class="form-control input-sm">{{ctrlJuga.player.costo | currency}}</label>
													 </div>
													
												</div>
											</div>
													</div>
								    </div>
								    </div>
                                    </div>
                                    <div class="row">
                                       <div class="form-actions floatRight">
                                          <input  ng-click="ctrl.submitPlayer(ctrlJuga.player.equipo,ctrlJuga.player)" 
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
							       <table class="table table-lg table-hover table-center table-dark table-responsive">
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
				<div class="modal-content bg-dark text-white">
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
								    <label id="montoSeparado" class="form-control input-sm">0</label>
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
				<div class="modal-content bg-dark text-white">
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
				<div class="modal-content bg-dark text-white">
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
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showPrestamos(true)" >Movimientos</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showDraftPC(true)" >Draft PC</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showPublicacion()" >Publicacion de Plantilla</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showPantilla()" >Plantilla Sofifa</a>
    </li>
  </ul>

<!-- <!-- Navigation-->
<!--         <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav"> -->
<!--             <a class="navbar-brand js-scroll-trigger" href="#page-top"> -->
<!--                 <span class="d-block d-lg-none">BORUSSIA DORTMUND</span> -->
<!--                 <span class="d-none d-lg-block"><img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="https://i.postimg.cc/g2f8cNrw/BVB22-2x.png" alt="..." /></span> -->
<!--             </a> -->
<!--             <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button> -->
<!--             <div class="collapse navbar-collapse" id="navbarResponsive"> -->
<!--                 <ul class="navbar-nav"> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.ocultaDatos() href="#about">Jugadores</a></li> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.ocultaJuga() href="#experience">Datos Financieros</a></li> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.showPrestamos(true)"  href="#education">Movimientos</a></li> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.showDraftPC(true)" href="#skills">Draft PC</a></li> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.showPublicacion()" href="#interests">Publicacion de Plantilla</a></li> -->
<!--                     <li class="nav-item"><a class="nav-link js-scroll-trigger" ng-click="ctrl.showPantilla()" href="#awards">Plantilla Sofifa</a></li> -->
<!--                 </ul> -->
<!--             </div> -->
<!--         </nav> -->

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
<!-- 				<div class="table-responsive-sm"> -->
				<div class="table-responsive-sm">
					<div class="row">
                          <div class="col align-self-center">
                             <p><input class="form-control"  type="text" ng-model="test" placeholder="Buscar"></p>
						   </div>                            
              		</div>
					<table class="table table-lg table-hover table-center table-dark table-responsive">
						<thead>
							<tr>
								<th></th>
								<th>ID.</th>
								<th>N. Corto</th>
								
								<th>Equipo</th>
								<th>Rating</th>
<!-- 								<th width="20%"></th> -->
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="u in ctrl.equipo.jugadores | orderBy : '-raiting' | filter : test" ">
								<td >                                          	                                  
                                  <img height="40" class="rounded float-left" ng-show="u.img != null" ng-src="{{u.img}}"   alt="{{u.id}} ">			                              
                                </td>
								<td><span ng-bind="u.id"></span></td>
<!-- 								<td><span ng-bind="u.nombreCompleto"></span></td> -->
								<td ng-show="u.link!=null"><a href="{{u.link}}" target="_blank" >{{u.sobrenombre}}</td>
                                <td ng-show="u.link==null">{{u.sobrenombre}}</td>
<!-- 								<td><span ng-bind="u.sobrenombre"></span></td> -->
								<td><span ng-bind="u.equipo.nombre"></span></td>
								<td><span ng-bind="u.raiting"></span></td>
								<td>
                                <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                                     <button  ng-disabled=" !ctrl.showEditPlayer(ctrl.equipo,'${user.idEquipo}','${user.roles}') "                                       
                                     type="button" data-toggle="modal" data-target="#myModal"  ng-click="ctrlJuga.edit(u)"
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
    <div id="sofifaP" class="container tab-pane active" ng-if="ctrl.vistaPantilla" >
      <div class="container-fluid bg-3 text-center"> 
	<button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseLinkSofifa" aria-expanded="false" aria-controls="collapseLinkSofifa">
		Add Sofifa
    </button>
    <div ng-if="ctrl.equipo.linksofifa!=null"><h3><a href="{{ctrl.equipo.linksofifa}}" target="_blank" >{{ctrl.equipo.linksofifa}}</a></h3></div>
    
      <div class="collapse" id="collapseLinkSofifa">
					  <div class="card card-body">
					     <div class="form-group">
		            <label for="recipient-name" class="col-form-label">ALink Sofifa:</label>
		            <input ng-model="ctrl.equipo.linksofifa"type="text" class="form-control" id="recipient-name">
		            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
		            	<button type="button" class="btn btn-primary btn-sm"
		            	 data-toggle="collapse" data-target="#collapseLinkSofifa"
		            	ng-click= "ctrl.modificarEquipo()"  >Agregar</button>
		            </sec:authorize>
			   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseLinkSofifa" aria-expanded="false" aria-controls="collapseExample">Cancelar</button>
		          </div>
					  </div>
					</div>
					
	  <div class="embed-responsive embed-responsive-16by9" ng-if="ctrl.vistaPantilla && urlSofifa!=null" >
	  	
		  <iframe class="embed-responsive-item" ng-src="{{urlSofifa}}" allowfullscreen></iframe>

	


		</div>
		
		
    </div>
    </div>
    <div id="publicacionIS" class="container tab-pane active" >
      <div class="container-fluid bg-3 text-center"> 

      <div class="formcontainer" ng-show="ctrl.vistaPublicacion">
				<div class="table-responsive-sm">
					<table class="">
						
						<tr>
							<td><h6>[align=center][img]{{ctrl.equipo.img}}[/img][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][glow=#ff0000][b][size=300]</h6></td>
						</tr>
						<tr>
							<td><h6>{{ctrl.equipo.nombre}}[/size][/b][/glow][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=300][shadow=#000000]</h6></td>
						</tr>
						<tr>
							<td><h6>===[ LISTA DE JUGADORES ]===[/shadow][/size][/align]</h6></td>
						</tr>
					
						<tr ng-repeat="u in ctrl.equipo.jugadores | orderBy : '-raiting' ">
							<td>[align=center][font=Verdana][size=130][b]<span ng-bind="u.sobrenombre"></span>[/b]</td>
							<td> - <span ng-bind="u.raiting"></span> [/size][/font][/align]</td>
						</tr>
						
						<tr>
							<td><h6>[align=center][b][size=200]Total de Jugadores: {{ctrl.equipo.totalJugadores}}[/size][/b][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=300][shadow=#000000]</h6></td>
						</tr>
						<tr>
							<td><h6>=======[ DRAFT ]======[/shadow][/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=270]</h6></td>
						</tr>
						<tr>
							<td><h6>------[ [shadow=#0000ff]Altas[/shadow] ]-----[/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=150]Indica en "Altas" todos los movimientos referentes a perdidas de dinero y entradas de jugadores.</h6></td>
						</tr>
						<tr ng-repeat="e in ctrl.jugadoresDraft | orderBy : 'sobrenombre' " ng-if="e.equipo.id == ctrl.equipo.id && e.idEquipoOferta == ctrl.equipo.id"> 
                              <td>[b]Compra a la CPU -[/b]  <span ng-bind="e.sobrenombre"></span></td>
                              <td>- <span>{{e.ofertaFinal | currency}}</span></td>
                        </tr>
                        <tr ng-repeat="p in ctrl.equipo.altas | orderBy : '-raiting' "">
                              <td>[b]Altas -[/b] <span ng-bind="p.sobrenombre"> </span></td>
                              <td>- <span>{{p.rating}}</span></td>
                              <td>- <span>{{p.equipo.nombre}}</span></td>
                               <td>- <span>{{p.costo | currency}}</span></td>
                        </tr>
						
						<tr>
							<td><h6>[/size][/align]</h6></td>
						</tr>
						<tr>
								<td><h6>[align=center][size=270]----[ [shadow=#ff0000]Bajas[/shadow] ]----[/size][/align]</h6></td>
						</tr>
						
						<tr>
							<td><h6>[align=center][size=150]Indica en "Bajas" todos los movimientos referentes a ganancias de dinero y salidas de jugadores.</h6></td>
						</tr>
						
						<tr ng-repeat="p in ctrl.equipo.bajas | orderBy : '-raiting' "">
                              <td>[b]Bajas -[/b] <span ng-bind="p.sobrenombre"> </span></td>
                              <td>- <span>{{p.rating}}</span></td>
                              <td>- <span>{{p.equipo.nombre}}</span></td>
                              <td>- <span>{{p.costo | currency}}</span></td>
                        </tr>
						
						<tr ng-repeat="e in ctrl.prestamos | orderBy : 'sobrenombre' | filter : test">
                              <td>[b]Prestamo -[/b] <span ng-bind="e.sobrenombre"></span></td>
                              <td>al <span ng-bind="e.equipoPres.nombre"></span> Temporadas: #</td>
                        </tr>
						<tr>
							<td><h6>[/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=300][shadow=#000000]===[ BALANCE Y SALARIOS ]===[/shadow][/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][b][size=150]</h6></td>
						</tr>
						<tr>
							<td><h6>[highlight=#ffff00][shadow=#000000]PRESUPUESTO INICIAL : {{ctrl.equipo.datosFinancieros.presupuestoInicial | currency}}[/shadow][/highlight][/size][/b][size=150]</h6></td>
						</tr>
						<tr>
							<td><h6>[shadow=#0000ff]Ingresos[/shadow] :
							
							</h6></td>
						</tr>
						<tr ng-if = "f.tipoconcepto.codigo == 'ingreso'" ng-repeat="f in ctrl.equipo.finanzas">
						        <td> {{f.descripcion}} ==> {{f.monto | currency}}</td> 
						</tr>
						<tr>
							<td><h6>[shadow=red]Egresos[/shadow] : </h6></td>
						</tr>
						<tr ng-if = "f.tipoconcepto.codigo != 'ingreso'" ng-repeat="f in ctrl.equipo.finanzas">
						    <td>     {{f.descripcion}} ==> {{f.monto | currency}} </td> 
						<tr>
							
						<tr>
							<td><h6>[b][highlight=#ffff00][shadow=#000000]PRESUPUESTO FINAL : {{ctrl.equipo.datosFinancieros.presupuestoFinal | currency}}</h6></td>
						</tr>
						<tr>
							<td><h6>[/shadow][/highlight][/b][/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][size=150][b]Total Rating:[/b] {{ctrl.equipo.totalRaiting}}</h6></td>
						</tr>
						<tr>
							<td><h6>[b]Salarios:[/b] {{ctrl.equipo.salarios | currency}}[/size][/align]</h6></td>
						</tr>
						<tr>
							<td><h6>[align=center][b][size=150]Link de sofifa: {{ctrl.equipo.linksofifa}}</h6></td>
						</tr>
						<tr>
							<td><h6>[/size][/b][/align]</h6></td>
						</tr>
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
<!-- 			    <button type="button" ng-click="ctrl.showEditDat()" class="btn btn-info btn-sm"  -->
<%-- 			    ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false" --%>
<!-- 			     ng-show="!ctrl.showInicial" >Editar</button> -->
			    <button type="button" ng-click="ctrl.showEditDat()" class="btn btn-info btn-sm" 
			    ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'1') == false"
			     ng-show="!ctrl.showInicial" >Editar</button>
			     </sec:authorize>
				<button type="submit" ng-click="ctrl.showGuarDat()" class="btn btn-info btn-sm" 
				 ng-show="ctrl.showInicial">Guardar</button>
			
			<button type="button" ng-click="ctrl.actualizarSuma()" class="btn btn-info btn-sm" 
			    ng-disabled="ctrl.showEdit( '${user.authorities}',ctrl.equipo.id,'${user.idEquipo}') == false"
			  >ActualizarSuma</button>
				   
				      <div class="input-group mb-3 input-group-sm">
					     <div class="col-sm">
					       <div class="badge badge-dark"><h5><span>Presupuesto Inicial : {{ctrl.equipo.datosFinancieros.presupuestoInicial | currency}}</span></h5></div>					       
					    </div>
<!-- 					    <input type="text" class="form-control" ng-show="!ctrl.showInicial" readonly value="{{ctrl.equipo.datosFinancieros.presupuestoInicial | currency}}"> -->
<!-- 					    <input type="text" ng-model="ctrl.preInicial" ng-show="ctrl.showInicial" id="montoInicial" class="form-control input-sm" placeholder="Presupuesto Inicial" required ng-minlength="3"/> -->
<!-- 					    <label id="montoSeparadoPI" class="form-control input-sm" ng-show="ctrl.showInicial">0</label> -->
					  </div>
					  <div class="form-row" ng-show="ctrl.showInicial" >
					    <div class="form-group col-md-6">
					      <label for="inputEmail4">Presupuesto Inicial {{ctrl.preInicial | currency}}</label>
					      <input type="text" ng-model="ctrl.preInicial" 
					       class="form-control" id="inputEmail4" placeholder="Presupuesto">
					    </div>
					   
					  </div>
				      <div class="col-sm">
<!-- 					     <div class="input-group-prepend"> -->
<!-- 						   <span class="input-group-text">Salarios: {{ctrl.equipo.salarios | currency}}</span>	 -->
<!-- 					       <span class="input-group-text">Presupuesto Final: {{ctrl.equipo.datosFinancieros.presupuestoFinal | currency}}</span>					        -->
<!-- 					       <span class="input-group-text">Presupuesto Final Sponsor: {{ctrl.equipo.datosFinancieros.presupuestoFinalSponsor | currency}}</span> -->
					       <div class="badge badge-dark"><h5><span>Presupuesto Final: {{ctrl.equipo.datosFinancieros.presupuestoFinal | currency}}</span></h5></div>					       
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
				       <table class="table table-lg table-hover table-center table-dark table-responsive">
						    <thead>
						      <tr>
						        <th>Concepto</th>
						        <th>Monto</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr class = "{{f.tipoconcepto.codigo == 'ingreso' ? 'bg-success' : 'bg-danger'}}" ng-repeat="f in ctrl.equipo.finanzas">
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
					<table class="table table-lg table-hover table-center table-dark table-responsive">
                      <thead>
                          <tr>
                              <th></th>
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
	                          <td >                                          	                                  
                                <img height="40" class="rounded float-left" ng-show="e.img != null" ng-src="{{e.img}}"   alt="{{e.id}} ">			                              
                              </td>
                              <td><span ng-bind="e.id"></span></td>
                              <td><span ng-bind="e.sobrenombre"></span></td>
                              <td><span ng-bind="e.comentarios"></span></td>
                              <td><span ng-bind="e.manager"></span></td>
                              <td><span>{{e.montoOferta | currency}}</span></td>
                              <td><span>{{e.ofertaFinal | currency}}</span></td>
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
					<div class="row">
                          <div class="col align-self-center">
                             <p><input class="form-control"  type="text" ng-model="test" placeholder="Buscar"></p>
						   </div>                            
              		</div>
              		
					<div class="panel-heading">
						<span class="lead">Altas</span>
					</div>
					<table class="table table-lg table-hover table-center table-dark table-responsive">
						<thead>
							<tr>
								<th></th>
								<th>ID</th>
								<th>Nombre</th>
								<th>$</th>
								<th>Equipo</th>
								<th>Rating</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="u in ctrl.equipo.altas | orderBy : '-raiting' | filter : test" ">
							   <td >                                          	                                  
                                <img height="40" class="rounded float-left" ng-show="u.img != null" ng-src="{{u.img}}"   alt="{{u.id}} ">			                              
                              </td>
								<td><span ng-bind="u.id"></span></td>
<!-- 								<td><span ng-bind="u.nombreCompleto"></span></td> -->
								<td ng-show="u.link!=null"><a href="{{u.link}}" target="_blank" >{{u.sobrenombre}}</td>
                                <td ng-show="u.link==null">{{u.sobrenombre}}</td>
<!-- 								<td><span ng-bind="u.sobrenombre"></span></td> -->
								<td><span ng-bind="u.costo | currency"></span></td>
								<td><span ng-bind="u.equipo.nombre"></span></td>
								<td><span ng-bind="u.raiting"></span></td>
							</tr>
						</tbody>
					</table>
					
				</div>
				<div class="table-responsive-sm">
					
					<table class="table table-lg table-hover table-center table-dark table-responsive">
                      <thead>
                          <tr>
                          	<th></th>
                              <th>ID.</th>
                              <th>Nombre</th>
                              <th>Equipo</th>
                              <th>Equipo a Prestao</th>
                              <th></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="e in ctrl.prestamos | orderBy : 'sobrenombre' | filter : test">
                          <td >                                          	                                  
                                <img height="40" class="rounded float-left" ng-show="e.img != null" ng-src="{{e.img}}"   alt="{{e.id}} ">			                              
                              </td>
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
				<div>
			<div class="panel-heading">
				<span class="lead">Bajas</span>
			</div>
					<table class="table table-lg table-hover table-center table-dark table-responsive">
						<thead>
							<tr>
								<th></th>
								<th>ID</th>
								<th>Nombre</th>
								<th>$</th>
								<th>Equipo</th>
								<th>Rating</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="u in ctrl.equipo.bajas | orderBy : '-raiting' | filter : test" ">
							<td >                                          	                                  
                                <img height="40" class="rounded float-left" ng-show="u.img != null" ng-src="{{u.img}}"   alt="{{u.id}} ">			                              
                              </td>
								<td><span ng-bind="u.id"></span></td>
<!-- 								<td><span ng-bind="u.nombreCompleto"></span></td> -->
								<td ng-show="u.link!=null"><a href="{{u.link}}" target="_blank" >{{u.sobrenombre}}</td>
                                <td ng-show="u.link==null">{{u.sobrenombre}}</td>
<!-- 								<td><span ng-bind="u.sobrenombre"></span></td> -->
								<td><span ng-bind="u.costo | currency"></span></td>
								<td><span ng-bind="u.equipo.nombre"></span></td>
								<td><span ng-bind="u.raiting"></span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div> 
			
   
  </div>
</div> 

</div>
</div>
</body>
</html>
