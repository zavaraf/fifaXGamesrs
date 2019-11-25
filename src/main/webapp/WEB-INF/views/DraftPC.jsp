<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
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
  <script src="<c:url value='/static/js/service/team_service.js' />"></script>
  <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
  <script src="<c:url value='/static/js/controller/draftPC_controller.js' />"></script>
  <script src="<c:url value='/static/js/service/draftPC_service.js' />"></script>
 

  <div class="container tab-pane active" ng-controller="DraftPCController as ctrl">
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
						<h4 class="modal-title">{{ctrl.jugador.sobrenombre + ' - Raiting: ' + ctrl.jugador.raiting}}</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.submitDraftPC(ctrl.jugador,ctrl.montoOferta,ctrl.manager,ctrl.selectedEquipo)" name="myFormCon" class="form-horizontal">
                      <div class="row">
							<div class="form-group col-md-12">
<!-- 								<div class="input-group mb-3 input-group-sm"> -->
								
<!-- 								     <div class="input-group-prepend"> -->
<!-- 								       <span class="input-group-text">Equipo Oferta</span>					        -->
<!-- 								    </div> -->
								   
<!-- 								    <select ng-model="selectedEquipo1" -->
<!-- 								    		ng-options="equipo as equipo.nombre for equipo in ctrl.equipos track by equipo.id" class="lastname form-control input-sm"> -->
<!-- 									        <option value="">--Elige opcion--</option> -->
<!-- 									</select> -->
<!-- 								 </div> -->
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Monto</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.montoOferta" id="montoOfer" class="form-control input-sm" placeholder="Monto" required ng-minlength="3"/>
								 </div>
								<fieldset disabled> 
								<div class="input-group mb-3 input-group-sm">
								
								<security:authorize access="isAuthenticated()">
									<div class="input-group-prepend">
							          <div class="input-group-text">Equipo: </div>
							        </div>
							        <input type="hidden"  ng-model="ctrl.selectedEquipo.id" 
							        ng-init="ctrl.selectedEquipo.id = '<security:authentication property="principal.idEquipo" />'" />
							        <input ng-model="ctrl.selectedEquipo.nombre" 
							        ng-init="ctrl.selectedEquipo.nombre = '<security:authentication property="principal.nombreEquipo" />'"  
							        type="text"  id="equipoOf" class="form-control input-sm" value={{ctrl.selectedEquipo.nombre}}/>
						      	</security:authorize>
								 </div>
								 </fieldset>
								 <fieldset disabled> 
								 <div class="input-group mb-3 input-group-sm">
								<security:authorize access="isAuthenticated()">
									<div class="input-group-prepend">
							          <div class="input-group-text">Usuario:</div>
							        </div>
							        <input type="text" ng-control="ctrl.manager" ng-init="ctrl.manager = '<%=request.getUserPrincipal().getName()%>'"  
							        id="userOf" class="form-control input-sm" value="{{ctrl.manager}}" />
						      	</security:authorize>
								
								 </div>
								 </fieldset>
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
	
  		<div class="panel-heading"><span class="lead">FIFA XGAMERS Draf PC</span></div>
<!--   		<button type="button" class="btn btn-info btn-sm" data-toggle="modal"  -->
<!-- 			data-target="#myModalDraf">Prestamo</button> -->
		
  		<div class="formcontainer">
<!--   		<div >	 -->
                  <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">Draft PC Mundial </span></div>
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
                              <th>Nombre</th>
                              <th>Equipo</th>
                              <th>Raiging</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr  ng-repeat="e in ctrl.equipo.jugadores | orderBy : 'sobrenombre' | filter : test">
                              <td><span ng-bind="e.id"></span></td>
<!--                               <td><span ng-bind="e.sobrenombre"></span></td> -->
                              <td ng-show="e.link!=null"><a href="{{e.link}}" target="_blank" >{{e.sobrenombre}}</td>
                                <td ng-show="e.link==null">{{e.sobrenombre}}</td>
                              <td><span ng-bind="e.equipo.nombre"></span></td>
                              <td><span ng-bind="e.raiting"></span></td>
                              <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                              <td><button type="button"   data-toggle="modal" 
									data-target="#myModalDraf" ng-click="ctrl.selectJugador(e)"  class="btn btn-info btn-sm">Ofertar</button></td>
							  </sec:authorize>		
                          </tr>
                      </tbody>
                  </table>
              
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
                          <tr class="{{ctrl.selectColor(e)}}"  ng-repeat="e in ctrl.jugadoresDraft | orderBy : 'sobrenombre' | filter : test">
                              <td><span ng-bind="e.id"></span></td>
                              <td><span ng-bind="e.sobrenombre"></span></td>
                              <td><a href="#!team/{{e.idEquipoOferta}}"><span ng-bind="e.comentarios"></span></a></td>
                              <td><span ng-bind="e.manager"></span></td>
                              <td><span ng-bind="e.montoOferta"></span></td>
                              <td><span ng-bind="e.ofertaFinal"></span></td>
                              <td><span ng-bind="e.fecha"></span></td>
                              <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
                              <td><button type="button"  data-toggle="modal" 
									data-target="#myModalDraf" ng-click="ctrl.updateDraft(e)" class="btn btn-info btn-sm" ng-show="e.idEquipoOferta != e.equipo.id">Contraofertar</button></td>
							  </sec:authorize>
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