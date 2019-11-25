<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<html>
  <head>  
    <title>FIFA XGAMERS</title>  
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
      
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
     
    
  </head>
  <body ng-app="myApp" class="ng-cloak">
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
  <script src="<c:url value='/static/js/app/app.js' />"></script>
  <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
  <script src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
 
<!--   <div class="generic-container" ng-controller="EquipoController as ctrl"> -->
  <div class="container tab-pane active"  ng-controller="EquipoController as ctrl">
<!--   	<div class="panel panel-default"> -->
  	<div >
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Datos Jugador</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submit(selectedDiv)" name="myForm" class="form-horizontal">
                      <input type="hidden" ng-model="ctrl.equipo.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" >Nombre</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.equipo.nombre" id="nombre" class="username form-control input-sm" placeholder="Escribe tu Nombre" required ng-minlength="3"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.nombre.$error.required">Es requerido</span>
                                      <span ng-show="myForm.nombre.$error.minlength">La longitud minima es 3</span>
                                      <span ng-show="myForm.nombre.$invalid">Este campo es Invalido</span>
                                  </div>
                              </div>
                          </div>
                      </div>                       
                       
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" >Descripción</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.equipo.descripcion" id="descripcion" class="form-control input-sm" placeholder="Descripción"/>
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" >Divsión</label>
                               <div class="col-md-7">
<!-- 	                                  <select ng-model="selectedDiv" class="lastname form-control input-sm" > -->
<!-- 										<option   ng-repeat="x in ctrl.divisiones" value="{{x.id}}">{{x.nombre}}</option> -->
									<select  ng-model="selectedDiv" ng-options="division as division.nombre for division in ctrl.divisiones track by division.id" class="lastname form-control input-sm">
									        <option value="">--Elige opcion--</option>
									      </select>
									</select>
									
	                              </div>
                          </div>
                      </div>
  
                      <div class="row">
                          <div class="form-actions floatRight">
                              <input type="submit"  value="{{!ctrl.equipo.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
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
  		<div  class="panel-heading">
  			<span class="lead">FIFA XGAMERS </span>
  		</div>
  		<sec:authorize access="hasAnyRole('ROLE_Admin')">
  		<button type="button" class="btn btn-info btn-sm" data-toggle="modal"
			data-target="#myModal">Añadir Equipo</button>
		</sec:authorize>
  		<div class="formcontainer">
  			
                  <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">Equipos Mundial </span></div>
              <div class="table-responsive-sm">
              		<div class="row">
                          <div class="form-group col-md-12">
                              <div class="col-md-7">
                                  <p><input class="form-control input-sm"  type="text" ng-model="test" placeholder="Filtrar"></p>
                              </div>
                          </div>
              		</div>
              
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
<!--                               <th>Manager</th> -->
                              <th>Nombre</th>
<!--                               <th>Descripción</th> -->
                              <th>Jugadores</th>
                              <th>Rating</th>
                              <th>Salarios</th>
                              <th>P. Inicial</th>
                              <th>P. Final</th>
                              <th>División</th>
<!--                               <th width="20%"></th> -->
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="e in ctrl.equipos | orderBy : 'e.division' | filter : test">
                              <td><span ng-bind="e.id"></span></td>
<!--                               <td><span ng-bind="e.manager"></span></td> -->
                              <td><a href="#!team/{{e.id}}">{{e.nombre}}</a></td>
<!--                               <td><span ng-bind="e.descripcion"></span></td> -->
                              <td><span ng-bind="e.totalJugadores"></span></td>
                              <td><span ng-bind="e.totalRaiting"></span></td>
                              <td><span ng-bind="e.salarios | currency"></span></td>
                              <td><span ng-bind="e.presupuestoInicial | currency"></span></td>
                              <td><span ng-bind="e.presupuestoFinal | currency"></span></td>
                              <td><span ng-bind="e.division.nombre"></span></td>
                              <td>
                              <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                              <sec:authentication var="user" property="principal" />
                             
		     				  <span style="display:none;" class="input-group-text" ng-model="ctrl.userAct" ng-init="ctrl.userAct = '<%=request.getUserPrincipal().getName()%>'" >{{ctrl.userAct}}</span>
                              <button type="button" data-toggle="modal" data-target="#myModal" ng-click="ctrl.edit(e.id)" ng-disabled="ctrl.showEdit( '${user.authorities}',e.id,'${user.idEquipo}') == false" class="btn btn-success btn-sm">Edit</button>
                              </sec:authorize>  
<!--                               <button type="button" ng-click="ctrl.remove(e.id)" class="btn btn-danger custom-width">Remove</button> -->
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
  		</div>
  	</div>    
  </div>

  </body>
</html>