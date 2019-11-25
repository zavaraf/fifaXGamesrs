<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html ng-app="myApp">
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
         .anyClass {
		  height:550px;
		  overflow-y: scroll;
		}
		div.scrollmenu {
		  background-color: #333;
		  overflow: auto;
		  white-space: nowrap;
		}
		
		div.scrollmenu a {
		  display: inline-block;
		  color: white;
		  text-align: center;
		  padding: 14px;
		  text-decoration: none;
		}
		
		div.scrollmenu a:hover {
		  background-color: #777;
		}
      </style>
      <link rel="stylesheet"
         href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
         integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
         crossorigin="anonymous">
      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
         integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
         crossorigin="anonymous"></script>
      <script
         src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
         integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
         crossorigin="anonymous"></script>
      <script
         src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
         integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
         crossorigin="anonymous"></script>
      <!--  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script> -->
      <script
         src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
      <script src="<c:url value='/static/js/libs/angular.js/angular-pagination.js' />"></script>
      <%--         <script src="<c:url value='/static/js/libs/angular-ui-bootstrap/ui-bootstrap-tpls-2.1.2.min.js' />"></script> --%>
      <link href="<c:url value='/static/css/app.css' />" rel="stylesheet">
      </link>
      <script src="<c:url value='/static/js/app/app.js' />"></script>
      <script src="<c:url value='/static/js/controller/torneoLM_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/torneoLM_service.js' />"></script>
      <%--      <script src="<c:url value='/static/js/service/draft_service.js' />"></script> --%>
      <%--      <script src="<c:url value='/static/js/controller/draft_controller.js' />"></script> --%>
   </head>
   <body class="ng-cloak">
      <div class="container  container-fluid" ng-controller="TorneoLMController as ctrl">
      
      <!-- Modal -->
		<div class="modal fade " id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <blockquote class="blockquote text-center">
					  <p class="mb-0">RESUMEN</p>
				</blockquote>
		        <div class="container text-center" >
				  <div class="row">
				    <div class="col">
				      
				    <blockquote class="blockquote ">
					  <p class="mb-0">{{ctrl.jornadaEdit.nombreEquipoLocal}} </p>
				    
			       	<p>
			       	<sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
					  <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
					    +Gol
					  </button>
					  <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample">
					    +Img
					  </button>
					 </sec:authorize>
					</p>
					<div class="collapse" id="collapseExample">
					  <div class="card card-body">
					    <div class="form-group">
					   
			            <label for="recipient-name" class="col-form-label">Add Gol:</label>
			           
			            
			            <select ng-model="selectedPlayer"
                            ng-options="pla as pla.nombreCompleto for pla in ctrl.players | orderBy : 'nombreCompleto' track by pla.id"
                            class="custom-select input-sm">
                            <option value="">--Elige opcion--</option>
                         </select>
			            
<!-- 			            <select class="custom-select" id="inputGroupSelect01"> -->
<!-- 						    <option ng-repeat="pla in ctrl.players | orderBy : 'nombreCompleto'" >{{pla.nombreCompleto}}</option>   -->
<!-- 						  </select> -->
						<sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
				            <button type="button" class="btn btn-primary btn-sm" ng-click= "ctrl.addGoles(selectedPlayer.id,ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit)">Agregar</button>
					   	</sec:authorize>
					   		<button type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" >Cancelar</button>
				   		
			          </div>
					  </div>
					</div>
					<div class="collapse" id="collapseImg">
					  <div class="card card-body">
					    <div class="form-group">
			            <label for="recipient-name" class="col-form-label">Add Img:</label>
			            <input ng-model="selectedImg" type="text" class="form-control" id="recipient-name">
			            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
			            	<button type="button" class="btn btn-primary btn-sm" ng-click= "ctrl.addImagen(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit,selectedImg)" >Agregar</button>
			            </sec:authorize>
				   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample">Cancelar</button>
			          </div>
					  </div>
					</div>
				    
					  <footer class="blockquote-footer text-right" ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}</footer>
					  
					</blockquote>
				    </div>
				    <div class="col-2">				      
				      <blockquote class="blockquote ">
					  <p class="mb-0">{{ctrl.jornadaEdit.golesLocal}}-{{ctrl.jornadaEdit.golesVisita}}</p>
					  </blockquote>
				    </div>
				   
				    <div class="col">
				      
				      <blockquote class="blockquote ">
					  <p class="mb-0">{{ctrl.jornadaEdit.nombreEquipoVisita}}</p>
				      <p>
				      <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
					  <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample1">
					    +Gol
					  </button>
					  <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseImg1" aria-expanded="false" aria-controls="collapseExample1">
					    +Img
					  </button>
					  </sec:authorize>
					</p>
					<div class="collapse" id="collapseExample1">
					  <div class="card card-body">
					    <div class="form-group">
			            <label for="recipient-name" class="col-form-label">Add Gol:</label>
			            <select ng-model="selectedPlayerV"
                            ng-options="pla as pla.nombreCompleto for pla in ctrl.players | orderBy : 'nombreCompleto' track by pla.id"
                            class="custom-select input-sm">
                            <option value="">--Elige opcion--</option>
                         </select>
                         <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
			            	<button type="button" class="btn btn-primary btn-sm" ng-click= "ctrl.addGoles(selectedPlayerV.id,ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit)" >Agregar</button>
			            </sec:authorize>
				   		<button type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample" >Cancelar</button>
			          </div>
					  </div>
					</div>
					<div class="collapse" id="collapseImg1">
					  <div class="card card-body">
					    <div class="form-group">
			            <label for="recipient-name" class="col-form-label">Add Img:</label>
			            <input ng-model="selectedImg1"type="text" class="form-control" id="recipient-name">
			            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
			            	<button type="button" class="btn btn-primary btn-sm" ng-click= "ctrl.addImagen(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit,selectedImg1)"  >Agregar</button>
			            </sec:authorize>
				   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg1" aria-expanded="false" aria-controls="collapseExample">Cancelar</button>
			          </div>
					  </div>
					</div>
					
					<footer class="blockquote-footer text-left" ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}</footer>
					
					  
					</blockquote>
				    </div>
				  </div>
				</div>
<!-- 		        <img src="https://i.imgur.com/qHTsbGs.png" class="img-fluid" alt="Responsive image"> -->
<!-- 		        <img src="https://i.imgur.com/Pwac2HN.png" class="img-fluid" alt="Responsive image"> -->
		        <img ng-repeat="img in ctrl.jornadaEdit.imagenes" src="{{img.img}}" class="img-fluid" alt="Responsive image">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
			
		<div id="jugadores">
			<!--  Div verde <div class="formcontainer"> -->
			
			<ul class="nav nav-tabs" role="tablist">
			    <li class="nav-item" ng-repeat="div in ctrl.divisiones">
			      <a class="nav-link" ng-click= "ctrl.getInitTorneo(div)" data-toggle="tab" >{{div.nombre}}</a>
			    </li>   
			 </ul>
	        <div class="formcontainer"	>
	        
            	<div class="panel panel-default">
                    <div class="panel-heading">
                       <span class="lead">Tabla General</span>
                    </div>
                </div>
                <div class="row">
                	<div class="col-xs-12 col-md-8">
		                <table class="table table-sm table-hover table-striped">
		                	<thead class="thead-dark">
		                          <tr>
		                              <th>Equipo</th>
		                              <th>PJ</th>
		                              <th>PG</th>
		                              <th>PE</th>
		                              <th>PP</th>
		                              <th>GF</th>
		                              <th>GE</th>
		                              <th>DIF</th>
		                              <th>PTS</th>
		                          </tr>
		                      </thead>
		                      <tbody>
		                          <tr ng-repeat="e in ctrl.tablaGeneral">
		                              <td><span>{{e.nombreEquipo}}</a></td>
		                              <td><span ng-bind="e.pj"></span></td>
		                              <td><span ng-bind="e.pg"></span></td>
		                              <td><span ng-bind="e.pe"></span></td>
		                              <td><span ng-bind="e.pp"></span></td>
		                              <td><span ng-bind="e.gf"></span></td>
		                              <td><span ng-bind="e.ge"></span></td>
		                              <td><span ng-bind="e.dif"></span></td>
		                              <td><span ng-bind="e.pts"></span></td>
		                          </tr>
		                      </tbody>
		    			</table>
		    		</div>
		    		<div class="col-xs-6 col-md-4  " >
		    		
					
		    			<div class="row">
		    			<div class="scrollmenu">
						  <a href="" ng-click="ctrl.setJornadaActual(e)" ng-repeat="e in ctrl.jornadas | orderBy : 'numeroJornada'" >Jornada {{e.numeroJornada}}</a>
						 
						</div>
							<div class="col"  ng-repeat="e in ctrl.jornadaSelect | orderBy : 'numeroJornada'" >
							<blockquote class="blockquote text-center">
								  <p class="mb-0">Jornada {{e.numeroJornada}}</p>
							</blockquote>
							
							<div  class="list-group">
							  <span  ng-repeat="jor in e.jornada" class="list-group-item list-group-item-action">
							  	<div class="container" 
							  	ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
							  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
								  <div class="row text-center">
								    <div class="col " >
								      {{jor.nombreEquipoLocal}} 
								    </div>
								    <div class="col-sm">
								      {{jor.golesLocal}}-{{jor.golesVisita}}
								    </div>
								    <div class="col">
								      {{jor.nombreEquipoVisita}}
								    </div>
								  </div>
								</div>
							  </span>
							 
						
							
							
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