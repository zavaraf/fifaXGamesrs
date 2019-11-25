<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <script src="<c:url value='/static/js/service/user_service.js' />"></script>
  <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
  <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
  <script src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
  
 
  <div  ng-controller="UserController as ctrl">
   <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Añadir Jugador</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Dados Jugador</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <form name="myForm" class="form-horizontal">
                      <input type="hidden" ng-model="ctrl.user.id" />
<!--                       <div class="row"> -->
<!--                           <div class="form-group col-md-12"> -->
<!--                               <label class="col-md-2 control-lable" for="uname">Nombre</label> -->
<!--                               <div class="col-md-7"> -->
<!--                                   <input type="text" ng-model="ctrl.user.nombre" id="uname" class="username form-control input-sm" placeholder="Escribe tu Nombre" required ng-minlength="3"/> -->
<!--                                   <div class="has-error" ng-show="myForm.$dirty"> -->
<!--                                       <span ng-show="myForm.uname.$error.required">Es requerido</span> -->
<!--                                       <span ng-show="myForm.uname.$error.minlength">La longitud minima es 3</span> -->
<!--                                       <span ng-show="myForm.uname.$invalid">Este campo es Invalido</span> -->
<!--                                   </div> -->
<!--                               </div> -->
<!--                           </div> -->
<!--                       </div> -->
<!--                       <div class="row"> -->
<!--                           <div class="form-group col-md-12"> -->
<!--                               <label class="col-md-2 control-lable" for="apater">Apellido Paterno</label> -->
<!--                               <div class="col-md-7"> -->
<!--                                   <input type="text" ng-model="ctrl.user.apellidoPaterno" id="apater" class="lastname form-control input-sm" placeholder="Apellido Paterno" required ng-minlength="3"/> -->
<!--                                   <div class="has-error" ng-show="myForm.$dirty"> -->
<!--                                       <span ng-show="myForm.apater.$error.required">Es requerido</span> -->
<!--                                       <span ng-show="myForm.apater.$error.minlength">La longitud minima es 3</span> -->
<!--                                       <span ng-show="myForm.apater.$invalid">Este campo es Invalido</span> -->
<!--                                   </div> -->
<!--                               </div> -->
<!--                           </div> -->
<!--                       </div> -->
<!--                       <div class="row"> -->
<!--                           <div class="form-group col-md-12"> -->
<!--                               <label class="col-md-2 control-lable" for="amate">Apellido Materno</label> -->
<!--                               <div class="col-md-7"> -->
<!--                                   <input type="text" ng-model="ctrl.user.apellidoMaterno" id="amate" class="lastname form-control input-sm" placeholder="Apellido Paterno" required ng-minlength="3"/> -->
<!--                                   <div class="has-error" ng-show="myForm.$dirty"> -->
<!--                                       <span ng-show="myForm.amate.$error.required">Es requerido</span> -->
<!--                                       <span ng-show="myForm.amate.$error.minlength">La longitud minima es 3</span> -->
<!--                                       <span ng-show="myForm.amate.$invalid">Este campo es Invalido</span> -->
<!--                                   </div> -->
<!--                               </div> -->
<!--                           </div> -->
<!--                       </div> -->
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="nomcom">Nombre Completo</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.NombreCompleto" id="nomcom" class="lastname form-control input-sm" placeholder="Apellido Paterno" required ng-minlength="3"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.nomcom.$error.required">Es requerido</span>
                                      <span ng-show="myForm.nomcom.$error.minlength">La longitud minima es 3</span>
                                      <span ng-show="myForm.nomcom.$invalid">Este campo es Invalido</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="sobreNom">Nombre Corto</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.sobrenombre" id="sobreNom" class="lastname form-control input-sm" placeholder="Apellido Paterno" required ng-minlength="3"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.sobreNom.$error.required">Es requerido</span>
                                      <span ng-show="myForm.sobreNom.$error.minlength">La longitud minima es 3</span>
                                      <span ng-show="myForm.sobreNom.$invalid">Este campo es Invalido</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="raiti">Raiting</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.Raiting" id="raiti" class="lastname form-control input-sm" placeholder="Apellido Paterno" required ng-minlength="2"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.sobreNom.$error.required">Es requerido</span>
                                  </div>
                              </div>
                          </div>
                      </div>                        
                      <div ng-controller="EquipoController as ctrlEquipo"> 
	                      <div class="row">
	                          <div class="form-group col-md-12" >
	                              <label class="col-md-2 control-lable" for="address">Equipo</label>
	                              <div class="col-md-7">
	                                  <select ng-model="selectedTeam" class="lastname form-control input-sm" >
	<!-- 									<option ng-repeat="x in ctrlEquipo.equipos">{{x.nombre}}</option> -->
										<option ng-repeat="x in ctrlEquipo.equipos" value="{{x.id}}">{{x.nombre}}</option>
									</select>
									
	                              </div>
	                              
	                          </div>
	                          
	                      </div>
	                      <div class="row">
	                          <div class="form-actions floatRight">
	                          
	                              <input ng-click="ctrl.submit(selectedTeam)"  type="submit"  value="{{!ctrl.user.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
	                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
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
  
</div>
 
  	<div>
  		<div class="panel-heading"><span class="lead">FIFA XGAMERS </span></div>
  		<div class="formcontainer">
  			
            <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Users </span></div>
              <div class="table-responsive-sm">
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Address</th>
                              <th>Email</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="u in ctrl.users">
                              <td><span ng-bind="u.id"></span></td>
                              <td><span ng-bind="u.username"></span></td>
                              <td><span ng-bind="u.address"></span></td>
                              <td><span ng-bind="u.email"></span></td>
                              <td>
                              <button type="button" ng-click="ctrl.edit(u.id)" class="btn btn-success custom-width">Edit</button>  <button type="button" ng-click="ctrl.remove(u.id)" class="btn btn-danger custom-width">Remove</button>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
  		</div>
  	</div>    
  </div>
  
<!--   <div ng-include="'Equipos.htm'"></div> -->

  </body>
</html>