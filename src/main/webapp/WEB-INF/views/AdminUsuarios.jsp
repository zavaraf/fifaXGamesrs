<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
  <script src="<c:url value='/static/js/controller/adminUser_controller.js' />"></script>
  <script src="<c:url value='/static/js/controller/adminUser_controller.js' />"></script>
  <script src="<c:url value='/static/js/service/adminUser_service.js' />"></script>
  <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
 

  <div class="container tab-pane active" ng-controller="AdminUserController as ctrl">
  	<div >
  	<!-- Modal Finanzas-->
		<div class="modal fade" id="myModalDraf" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="alert alert-danger alert-dismissable" ng-show="ctrl.isError">
	<!-- 				<button type="button" class="close" data-dismiss="alert">&times;</button> -->
					  <strong>¡Error!</strong> {{ctrl.Error}}
					</div>
					<div class="modal-header">
						<h4 class="modal-title">Usuario : {{ctrl.selectedUser.username}}</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<sec:authentication var="user" property="principal" />
				
					${user.idEquipo}
					${user.nombreEquipo}
<%-- 					<span class="input-group-text" ng-model="ctrl.userAct" ng-init="ctrl.userAct = '<%=request.getUserPrincipal().getName()%>'" >{{ctrl.userAct}}</span> --%>
					<span class="input-group-text" ng-model="ctrl.userAct" ng-init="ctrl.userAct = '<%=request.getUserPrincipal().getName()%>'" >{{ctrl.userAct}}</span>
					
					
					<div class="form-actions floatRight">
                			<input type="button" value="Agregar rol" class="btn btn-primary btn-sm"  ng-click="ctrl.prueba(ctrl.userAct)"  >
             		</div>		
					<form ng-submit="ctrl.updateAdminUser(ctrl.selectedUser,<%=request.getUserPrincipal().getName()%>)" name="myFormCon" class="form-horizontal">

                      <div class="row">
                          <div class="form-group col-md-12">
                        	 <div class="input-group mb-3 input-group-sm">
							     <div class="input-group-prepend">
							       <span class="input-group-text">Equipo</span>					       
							    </div>
							    <select ng-model="ctrl.selectedEquipo"
							    	
							    		ng-options="equipo as equipo.nombre for equipo in ctrl.equipos track by equipo.id" class="lastname form-control input-sm">
								        <option value="">--Elige opcion--</option>
								</select>

							 </div>
                          </div>
                      </div>  
                      <div class="row">
                          <div class="form-group col-md-12">
                        	 <div class="input-group mb-3 input-group-sm">
							     <div class="input-group-prepend">
							       <span class="input-group-text">Roles</span>					       
							    </div>
							   <select ng-model="ctrl.selectedRole"
							    		ng-options="role as role.rol for role in ctrl.roles track by role.id"  class="lastname form-control input-sm">
								        <option value="">--Elige Rol--</option>
								</select>
								<div class="form-actions floatRight">
                           			<input type="button" value="Agregar rol" class="btn btn-primary btn-sm"  ng-click="ctrl.addRole(ctrl.selectedRole)" ng-disabled="ctrl.selectedRole == null" >
                        		</div>
                        	</div>
                          </div>
                      </div> 
                      <div class="row">
                          <div class="form-group col-md-12">	 
						     <div class="input-group-prepend">
						       <span class="input-group-text">Roles</span>					       
						    </div>
						    <div class="table-responsive-sm">
              	
              
			                  <table class="table table-sm table-hover table-dark table-responsive">
			                      <thead>
			                          <tr>
			                              <th>Sel</th>
			                              <th>Rol</th>
			                          </tr>
			                      </thead>
			                      <tbody>
			                          <tr ng-repeat="e in ctrl.selectedUser.roles | orderBy : 'rol'">
			                              <td><button type="button" ng-click="ctrl.removeRole(e.id)" class="btn btn-danger btn-sm">eliminar</button></td>
			                              <td><span ng-bind="e.descripcion"></span></td>
			                          </tr>
			                      </tbody>
			                  </table>
			              </div>	   
                          </div>
                      </div>
 
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Guardar" class="btn btn-primary btn-sm"  >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>
	
  		<div class="panel-heading"><span class="lead">Administración de Usuarios </span></div>
  		<button type="button" class="btn btn-info btn-sm" data-toggle="modal" ng-click="ctrl.buscarEquipos()"
			data-target="#myModalDraf">Administración de Usuarios</button>
  		<div class="formcontainer">
  			
                  <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">Administración de usuarios</span></div>
              <div class="table-responsive-sm">
              		<div class="row">
                          <div class="form-group col-md-12">
                              <div class="col-md-7">
                                  <p><input class="form-control input-sm"  type="text" ng-model="test" placeholder="Filtrar"></p>
                              </div>
                          </div>
              		</div>
              
                  <table class="table table-sm table-hover table-dark table-responsive">
                      <thead>
                          <tr>
                              <th>username</th>
                              <th>Equipo</th>
                              <th>Roles</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="e in ctrl.usuarios | orderBy : 'username' | filter : test">
                              <td><span ng-bind="e.username"></span></td>
                              <td><span ng-bind="e.nombreEquipo"></span></td>
                              <td><span ng-bind="e.rolesDes"></span></td>
                              <td><button type="button" data-toggle="modal" ng-click="ctrl.updateUser(e)"  class="tn btn-info btn-sm" data-target="#myModalDraf">Editar</button></td>
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