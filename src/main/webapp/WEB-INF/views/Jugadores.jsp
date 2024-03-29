<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html ng-app="myApp">
   <head>
      <title>FIFA XGAMERS</title>
        <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		  <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
		<style>
         .username.ng-valid {
         background-color: lightgreen;
         }
         .username.ng-dirty.ng-invalid-required {
         background-color: red;
         }
         .username.ng-dirty.ng-invalid-minlength {
         background-color: yellow;
         }
         .email.ng-valid {
         background-color: lightgreen;
         }
         .email.ng-dirty.ng-invalid-required {
         background-color: red;
         }
         .email.ng-dirty.ng-invalid-email {
         background-color: yellow;
         }
      </style>
<!--       <link rel="stylesheet" -->
<!--          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" -->
<!--          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" -->
<!--          crossorigin="anonymous"> -->
<!--       <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" -->
<!--          integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" -->
<!--          crossorigin="anonymous"></script> -->
<!--       <script -->
<!--          src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" -->
<!--          integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" -->
<!--          crossorigin="anonymous"></script> -->
<!--       <script -->
<!--          src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" -->
<!--          integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" -->
<!--          crossorigin="anonymous"></script> -->
<!--        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script> -->
<!--       <script -->
<!--          src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script> -->
<%--       <script src="<c:url value='/static/js/libs/angular.js/angular-pagination.js' />"></script> --%>
<%--               <script src="<c:url value='/static/js/libs/angular-ui-bootstrap/ui-bootstrap-tpls-2.1.2.min.js' />"></script> --%>
<%--       <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"> --%>
<!--       </link> -->
      
      <%--      <script src="<c:url value='/static/js/service/draft_service.js' />"></script> --%>
      <%--      <script src="<c:url value='/static/js/controller/draft_controller.js' />"></script> --%>
   </head>
   <body class="ng-cloak">
<%--    	  <script src="<c:url value='/static/js/app/app.js' />"></script> --%>
      <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/user_service.js' />"></script>
      <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
      <script src="<c:url value='/static/js/app/customSelect.js' />"></script>
      <div class="container  container-fluid" ng-controller="UserController as ctrl">
      	<div >
      		<div id="jugadores"  >
<!--       		<div id="jugadores" class="container tab-pane active" > -->
               <br>
               <!-- Modal -->
                  <div class="modal fade" id="myModal" role="dialog">
                     <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content bg-dark text-white">
                           <div class="modal-header">                           
                              <h4 class="modal-title">Datos Jugador</h4>	                        
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                           </div>
                           <div class="modal-body">
                              <form  name="myForm" >
                              
                                 <input type="hidden" ng-model="ctrl.player.id" />
                                  <div class="text-center ">	                                  
	                                  <img class="rounded float-center"ng-show="ctrl.player.img != null" ng-src="{{ctrl.player.img}}"   alt="...">
	                              </div>
	                              
                                  <div class="row">
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="idsofifa">idSofifa</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrl.player.idsofifa" id="link"
                                             class="lastname form-control input-sm"
                                             placeholder="ID Sofifa" required ng-minlength="2" />
                                          
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class=" col-md">
                                       <label class="col-md control-lable" for="sobreNom">Nombre Corto</label>
                                       <div class="col-md ">
                                          <input type="text" ng-model="ctrl.player.sobrenombre"
                                             id="sobreNom" class="lastname form-control input-sm "
                                             placeholder="Nombre corto" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myForm.$dirty">
                                             <span ng-show="myForm.sobreNom.$error.required">Es requerido</span> 
                                             <span ng-show="myForm.sobreNom.$error.minlength">La longitud minima es 3</span> 
                                             <span ng-show="myForm.sobreNom.$invalid">Este campo es Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                   <div class="row">
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="nomcom">Nombre Completo</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrl.player.nombreCompleto"
                                             id="nomcom" class="lastname form-control input-sm"
                                             placeholder="Nombre completo" required ng-minlength="3" />
                                          <div class="has-error" ng-show="myForm.$dirty">
                                             <span ng-show="myForm.nomcom.$error.required">Es requerido</span> 
                                             <span ng-show="myForm.nomcom.$error.minlength">La longitud minima es 3</span> 
                                             <span ng-show="myForm.nomcom.$invalid">Este campo es Invalido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="imgcom">Imagen</label>                                   
				                              
		                              
				                        
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrl.player.img"
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
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="raiti">Rating</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrl.player.raiting" id="raiti"
                                             class="lastname form-control input-sm"
                                             placeholder="Raiting" required ng-minlength="2" />
                                          <div class="has-error" ng-show="myForm.$dirty">
                                             <span ng-show="myForm.sobreNom.$error.required">Es requerido</span>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col-md">
                                       <label class="col-md control-lable" for="raiti">Link Sofifa</label>
                                       <div class="col-md">
                                          <input type="text" ng-model="ctrl.player.link" id="link"
                                             class="lastname form-control input-sm"
                                             placeholder="Link Sofifa" required ng-minlength="2" />
                                          
                                       </div>
                                    </div>
                                 </div>
                                 
                                 <div ng-controller="EquipoController as ctrlEquipo">
                                    <div class="row">
                                       <div class="col-md">
                                          <label class="col-md control-lable" for="address">Equipo  {{ctrl.player.equipo.nombre}}</label>
                                          <div class="col-md">
<!--                                           <div  ng-dropdown-multiselect="" options="ctrlEquipo.buscarTodos();ctrlEquipo.equipos"  -->
<!--                                            selected-model="equipoModel" extra-settings="example9settings" translation-texts="example5customTexts"></div> -->
<!--                                              <select ng-model="selectedTeam" -->
<!--                                                 ng-options="equipo as equipo.nombre for equipo in ctrlEquipo.equipos track by equipo.id" -->
<!--                                                 class="lastname form-control input-sm"> -->
<!--                                                 <option value="">--Elige opcion--</option> -->
<!--                                              </select> -->
								
									            <div custom-select="t as t.nombre for t in ctrlEquipo.equipos | filter: { nombre: $searchTerm }" ng-model="ctrl.player.equipo">
									                <div class="pull-left" >
									                    <img ng-src="{{ t.img }}" style="width: 30px" />
									                    <strong>{{ t.nombre }}</strong>
									                </div>
									               
									            </div>
		
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
												  <strong>¡Error!</strong> {{ctrl.Error}}
												</div>
													
													<div class="modal-body">
													
														<div custom-select="t as t.nombre for t in ctrlEquipo.equipos | filter: { nombre: $searchTerm }" ng-model="ctrl.player.equipoPago">
										                <div class="pull-left" >
										                    <img ng-src="{{ t.img }}" style="width: 30px" />
										                    <strong>{{ t.nombre }}</strong>
										                </div>
										               
										                </div>
													
													</div>
													
													<div class="input-group mb-3 input-group-sm">
													     
													    <input type="text" ng-model="ctrl.player.costo" id="montoOfer" class="form-control input-sm" placeholder="Monto" />
													    <label id="montoSeparado" class="form-control input-sm">{{ctrl.player.costo | currency}}</label>
													 </div>
													
												</div>
											</div>
													</div>
								    </div>
								    </div>
                                    </div>
                                    <div class="row">
                                       <div class="form-actions floatRight">
                                          <input  ng-click="ctrl.submitPlayer(ctrl.player.equipo)" 
                                          class="btn btn-default text-white" data-dismiss="modal"
                                             type="submit" value="{{!ctrl.player.id ? 'Add' : 'Update'}}"
                                             class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                                          <button type="button" ng-click="ctrl.reset()"
                                             class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset
                                          Form</button>
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
                  <!-- TABLA JUGADORES-->
                  <div>
                     <div class="panel-heading">
                        <span class="lead">FIFA XGAMERS </span>
                     </div>
                     <!-- Trigger the modal with a button -->
                     <sec:authorize access="hasAnyRole('ROLE_Admin')">
                        <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                           data-target="#myModal">A�adir Jugador</button>
                     </sec:authorize>
                     <div class="formcontainer">
                        <div >
<!--                            <div class="panel panel-default"> -->
<!--                                  <div class="form-check"> -->
<!-- 									  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" ng-click="ctrl.checkBuscar=0" checked> -->
<!-- 									  <label class="form-check-label" for="flexRadioDefault1"> -->
<!-- 									    Mayor a 80 -->
<!-- 									  </label> -->
<!-- 									</div> -->
<!-- 									<div class="form-check"> -->
<!-- 									  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" ng-click="ctrl.checkBuscar=1" > -->
<!-- 									  <label class="form-check-label" for="flexRadioDefault2"> -->
<!-- 									    Menor 70 y menor que 80 -->
<!-- 									  </label> -->
<!-- 									</div> -->
<!-- 									<div class="form-check"> -->
<!-- 									  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" ng-click="ctrl.checkBuscar=2" > -->
<!-- 									  <label class="form-check-label" for="flexRadioDefault2"> -->
<!-- 									    Menor 70  -->
<!-- 									  </label> -->
<!-- 									</div> -->
                                                                  
<!--                               <button type="button" class="btn btn-info btn-sm"  ng-click="ctrl.fetchAllPlayers(ctrl.checkBuscar)">Buscar</button> -->

                              
<!--                            </div> -->
                           <div >
                              <div class="table-responsive-sm">
                                 <div class="row">
                                    <div class="form-group col-md-12">
                                       <div class="col-md-7">
<!--                                           <p><input class="form-control input-sm" ng-model="test" type="text" placeholder="Buscar"></p> -->
                                          <p><input class="form-control input-sm"  type="text" ng-pagination-search="ctrl.players" placeholder="Buscar"></p>
                                       </div>
                                    </div>
                                 </div>
                                 <!--          <table  ng-init='configPages()'  class="table table-striped table-hover"> -->
                                 <table class="table table-lg table-hover table-dark table-center ">
                                    <thead>
                                       <tr>
                                          <th>ID.</th>
                                          <th>N.Corto</th>
                                          <th>Equipo</th>
                                          <th>Rating</th>
                                       </tr>
                                    </thead>
                                    <tbody>
                                       <!--              <tr ng-repeat="u in ctrl.players | orderBy : '-raiting' | filter : test | startFromGrid: currentPage * pageSize | limitTo: pageSize"> -->
                                       <!--              <tr ng-repeat="u in ctrl.players | orderBy : '-raiting' | filter : test "  > -->
                                       <tr ng-pagination="u in ctrl.players | orderBy : '-raiting'" ng-pagination-size="60"  >
                                          <td ng-show="u.img == null">{{u.id}}</td>
                                          <td ng-show="u.img != null">                                          	                                  
			                                  <img height="40" class="rounded float-left" ng-show="u.img != null" ng-src="{{u.img}}"   alt="{{u.id}} ">			                              
			                              </td>
                                          <td ng-show="u.link!=null"><a href="{{u.link}}" target="_blank" >{{u.sobrenombre}}</td>
                                          <td ng-show="u.link==null">{{u.sobrenombre}}</td>
                                          
                                          <td><a href="#!team/{{u.equipo.id}}" >{{u.equipo.nombre}}</a></td>
                                          <td>{{u.raiting}}</td>
                                          
                                             <td>
                                             <sec:authentication var="user" property="principal" />
	                                           <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
<%-- 	                                           <button  ng-disabled=" '${user.idEquipo} == {{u.equipo.id}}' or '${user.roles}'.include('Admin')"   --%>
	                                                <button  ng-disabled=" !ctrl.showEditPlayer(u,'${user.idEquipo}','${user.roles}') " 
	                                                type="button" data-toggle="modal" data-target="#myModal"  ng-click="ctrl.edit(u)"
	                                                   class="btn btn-success btn-sm">Edit</button>
	                                           </sec:authorize>
                                                <sec:authorize access="hasAnyRole('ROLE_Admin')">   
	                                                <button type="button" ng-click="ctrl.remove(u.id)"
	                                                   class="btn btn-danger btn-sm">Remove</button>
	                                            </sec:authorize>       
                                              </td>
                                         	 
                                       </tr>
                                    </tbody>
                                 </table>
                                 <ng-pagination-control pagination-id="ctrl.players"></ng-pagination-control>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
            </div>
      	</div>
      </div>
   </body>
</html>