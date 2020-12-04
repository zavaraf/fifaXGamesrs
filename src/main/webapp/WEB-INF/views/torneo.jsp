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

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<!-- 		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!-- 		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> -->
<!-- 		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> -->
<%--   <script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script> --%>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>




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
</head>
<body ng-app="myApp" >
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular-route.js"></script>
<script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script>
<!-- <script src="bower_components/angular-bootstrap-multiselect/dist/angular-bootstrap-multiselect.min.js"></script> -->
      <script src="<c:url value='/static/js/controller/torneoLM_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/torneoLM_service.js' />"></script>
      

  
  	
	<div class="container container-fluid bg-dark text-white" ng-controller="TorneoLMController as ctrl">
	
	<!-- Modal -->
		<div class="modal fade " id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		  <div class="modal-dialog  modal-lg " role="document">
		    <div class="modal-content bg-dark text-white">
		      <div class="modal-header ">
		        <span ng-show="ctrl.jornadaEdit.username != null && ctrl.jornadaEdit.username != '' " type="button" class="btn btn-outline-primary" aria-disabled="true">{{ctrl.jornadaEdit.username}}</span>
		        <span ng-show="ctrl.jornadaEdit.date != null && ctrl.jornadaEdit.date != '' && ctrl.jornadaEdit.username != null" type="button" class="btn btn-outline-primary" aria-disabled="true">{{ctrl.jornadaEdit.date}}</span>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>

		      <div class="modal-body ">
		      <sec:authentication var="user" property="principal" />
		        <blockquote class="blockquote text-center">
					  <p class="mb-0">RESUMEN</p>
				</blockquote>
		       <div class="table-responsive-sm  text-center">
<!-- 		        <div class="container text-center" > -->
		        <table class="table text-center ">
				  <tr >
				    <td >
				      
				    <blockquote class="blockquote bg-dark text-white ">
				    <img ng-src="{{ctrl.jornadaEdit.imgLocal}}" style="width: 30%;"class="card-img-center" alt="...">
					  <p class="mb-0">{{ctrl.jornadaEdit.nombreEquipoLocal}} </p>
				    
			       	<p>
			       	<sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
					  <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
					    +Gol
					  </button>
<%-- 					  <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)"  --%>
<!-- 					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample"> -->
<!-- 					    +Img -->
<!-- 					  </button> -->
					 </sec:authorize>
					</p>
					<div class="collapse" id="collapseExample">
					  <div class="card card-body bg-secondary text-white">
					    <div class="form-group">
					   
			            <label for="recipient-name" class="col-form-label">Add Gol:</label>
			           
			           <div  ng-dropdown-multiselect="" options="example9data" selected-model="example9model" extra-settings="example9settings" translation-texts="example5customTexts"></div>
			           
			           
<!-- 			            <select ng-model="selectedPlayer" -->
<!--                             ng-options="pla as pla.nombreCompleto for pla in ctrl.players | orderBy : 'nombreCompleto' track by pla.id" -->
<!--                             class="custom-select input-sm"> -->
<!--                             <option value="">--Elige opcion--</option> -->
<!--                          </select> -->
			            
<!-- 			            <select class="custom-select" id="inputGroupSelect01"> -->
<!-- 						    <option ng-repeat="pla in ctrl.players | orderBy : 'nombreCompleto'" >{{pla.nombreCompleto}}</option>   -->
<!-- 						  </select> -->
						<sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
				            <button type="button" class="btn btn-primary btn-sm" 
				            ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
				            ng-click= "ctrl.addGoles(example9model[0],ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit)">Agregar</button>
					   	</sec:authorize>
					   		<button type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" >Cancelar</button>
				   		
			          </div>
					  </div>
					</div>
<!-- 					<div class="collapse" id="collapseImg"> -->
					
<!-- 					  <div class="card card-body"> -->
<!-- 					    <div class="form-group"> -->
<!-- 			            <label for="recipient-name" class="col-form-label">Add Img:</label> -->
<!-- 			            <input ng-model="selectedImg" type="text" class="form-control" id="recipient-name"> -->
<%-- 			            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')"> --%>
<!-- 			            	<button type="button" class="btn btn-primary btn-sm"  -->
<%-- 			            	ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)"  --%>
<!-- 			            	ng-click= "ctrl.addImagen(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit,selectedImg);selectedImg=''" >Agregar</button> -->
<%-- 			            </sec:authorize> --%>
<!-- 				   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample">Cancelar</button> -->
<!-- 			          </div> -->
<!-- 					  </div> -->
					
<!-- 					</div> -->
				    
				    <footer class="text-right bg-dark text-white ">
					  
					  <p class="mb-0 font-italic {{p.isAutogol == 1 ? 'text-danger' : ''}}" 
					  ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}} 
					  <a href="" class = "text-danger" ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					  ng-click= "ctrl.deletedGol(p,ctrl.jornadaEdit.idEquipoLocal)">(-)</a>
					  </p>
					</footer>
					
<!-- 					  <footer class="blockquote-footer text-right {{ p.isAutogol == 1 ? 'alert alert-danger' : ''}} " ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}</footer> -->
					  
					</blockquote>
				    </td>
				    <td >				      
				      <blockquote class="blockquote  bg-dark text-white">
					  <p class="mb-0">{{ctrl.jornadaEdit.golesLocal}}-{{ctrl.jornadaEdit.golesVisita}}</p>
					  </blockquote>
				    </td>
				   
				    <td >
				      
				      <blockquote class="blockquote bg-dark text-white ">
				      <img ng-src="{{ctrl.jornadaEdit.imgVisita}}" style="width: 30%;"class="card-img-center" alt="...">
					  <p class="mb-0">{{ctrl.jornadaEdit.nombreEquipoVisita}}</p>
				      <p>
				      <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
					  <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample1">
					    +Gol
					  </button>
<%-- 					  <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)"  --%>
<!-- 					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseImg1" aria-expanded="false" aria-controls="collapseExample1"> -->
<!-- 					    +Img -->
<!-- 					  </button> -->
					  </sec:authorize>
					</p>
					<div class="collapse" id="collapseExample1">
					  <div class="card card-body bg-secondary text-white">
					    <div class="form-group">
			            <label for="recipient-name" class="col-form-label">Add Gol:</label>
			            
			            <div ng-dropdown-multiselect="" options="example9data" selected-model="example9modelV" extra-settings="example9settings" translation-texts="example5customTexts"></div>
			            
<!-- 			            <select ng-model="selectedPlayerV" -->
<!--                             ng-options="pla as pla.nombreCompleto for pla in ctrl.players | orderBy : 'nombreCompleto' track by pla.id" -->
<!--                             class="custom-select input-sm"> -->
<!--                             <option value="">--Elige opcion--</option> -->
<!--                          </select> -->
                         
                         <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
			            	<button type="button" class="btn btn-primary btn-sm"
			            	ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
			            	ng-click= "ctrl.addGoles(example9modelV[0],ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit)" >Agregar</button>
			            </sec:authorize>
				   		<button type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample" >Cancelar</button>
			          </div>
					  </div>
					</div>
<!-- 					<div class="collapse" id="collapseImg1"> -->
<!-- 					  <div class="card card-body"> -->
<!-- 					    <div class="form-group"> -->
<!-- 			            <label for="recipient-name" class="col-form-label">Add Img:</label> -->
<!-- 			            <input ng-model="selectedImg1"type="text" class="form-control" id="recipient-name"> -->
<%-- 			            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')"> --%>
<!-- 			            	<button type="button" class="btn btn-primary btn-sm" -->
<%-- 			            	ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)"  --%>
<!-- 			            	ng-click= "ctrl.addImagen(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit,selectedImg1);selectedImg1=''"  >Agregar</button> -->
<%-- 			            </sec:authorize> --%>
<!-- 				   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg1" aria-expanded="false" aria-controls="collapseExample">Cancelar</button> -->
<!-- 			          </div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
					
					<footer class="text-left bg-dark text-white ">
					  
					  <p class="mb-0 font-italic {{p.isAutogol == 1 ? 'text-danger' : ''}}" 
					  ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}
					  <a href="" class = "text-danger" ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					   ng-click= "ctrl.deletedGol(p,ctrl.jornadaEdit.idEquipoVisita)">(-)</a>
					</footer>
<!-- 						<footer class="blockquote-footer text-left {{p.isAutogol == 1 ? 'alert alert-danger' : ''}} " ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}</footer> -->
					
					  
					</blockquote>
				    </td>
				  </tr>
				</table>
				
			     <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample1">
				 	   +Img
				 </button>
				 
				 <button ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
					  class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapsePub" aria-expanded="false" aria-controls="collapseExample1">
				 	   Publicación
				 </button>
				 
				 <div class="collapse" id="collapseImg" style="margin: 0 auto; width:70%;">
				  <div class="card card-body bg-secondary text-white">
				    <div class="form-group">
		            <label for="recipient-name" class="col-form-label">Add Img:</label>
		            <input ng-model="selectedImg1"type="text" class="form-control" id="recipient-name">
		            <sec:authorize access="hasAnyRole('ROLE_Admin','ROLE_Manager')">
		            	<button type="button" class="btn btn-primary btn-sm"
		            	ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
		            	ng-click= "ctrl.addImagen(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit,selectedImg1);selectedImg1=''"  >Agregar</button>
		            </sec:authorize>
			   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample">Cancelar</button>
		          </div>
				  </div>
				</div>
				 
				 <div class="collapse" id="collapsePub" style="margin: 0 auto; width:70%;">
				  <div class="card card-body bg-secondary text-white">
				    <div class="form-group">
				    <div>
				    	{{'[size=150]'+ ctrl.jornadaEdit.nombreEquipoLocal +'  '+ ctrl.jornadaEdit.golesLocal}} - {{ctrl.jornadaEdit.golesVisita +'  '+ ctrl.jornadaEdit.nombreEquipoVisita +'[/size]'}}
				    	
				    	<p >Goles {{ctrl.jornadaEdit.nombreEquipoLocal}} :</p>
				    	<span ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}, </span>
				    	<p>Goles {{ctrl.jornadaEdit.nombreEquipoVisita}} :</p>
				    	<span ng-repeat="p in ctrl.getPlayers(ctrl.jornadaEdit.idEquipoVisita,ctrl.jornadaEdit.golesJornada)">{{p.sobrenombre}}, </span>
				    	<br>
				    	<p span ng-repeat="x in ctrl.jornadaEdit.imagenes">[img] {{x.img}} [/img]</p>
				    	
				    	
		            </div>
		            
			   		<button type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#collapseImg" aria-expanded="false" aria-controls="collapseExample">Cancelar</button>
		          </div>
				  </div>
				</div>
				
				</div>
<!-- 		        <img src="https://i.imgur.com/qHTsbGs.png" class="img-fluid" alt="Responsive image"> -->
<!-- 		        <img src="https://i.imgur.com/Pwac2HN.png" class="img-fluid" alt="Responsive image"> -->
		        <img  ng-repeat="img in ctrl.jornadaEdit.imagenes"   ng-src="{{img.img}}" class="img-fluid" alt="Responsive image">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary"  data-dismiss="modal" 
		        ng-model="status" ng-show= "ctrl.showEditJornada('${user.roles}','${user.idEquipo}',ctrl.jornadaEdit.idEquipoLocal,ctrl.jornadaEdit.idEquipoVisita)" 
		         ng-click="status = ctrl.guardarJornada(ctrl.jornadaEdit)">Guardar</button>
		      </div>
		    </div>
		  </div>
		</div>
			
		<div id="jugadores">
			<!--  Div verde <div class="formcontainer"> -->
		
			<ul class="nav nav-tabs" role="tablist">
			    <li class="nav-item" ng-repeat="div in ctrl.getTorneos()">
			      <a class="nav-link" ng-click= "ctrl.jornadaSelect = [];ctrl.getInitTorneo(div);ctrl.getGruposTorneo(div);" data-toggle="tab" >{{div.nombre}}</a>
			    </li>   
			 </ul>
	        <div class="formcontainer"	>
	        
            	<div class="panel panel-default">
                    <div class="panel-heading">
                        <img ng-src="<c:url value='/imagenes/LigaMundialXGamers.png'/>" class="rounded mx-auto d-block" style="width: 200px; height: 200px;" alt="Cinque Terre">
                        
<!--                         https://i.imgur.com/iOfwGBr.png -->
<!--                        <span class="lead">Tabla General</span> -->
                    </div>
                </div>
                <div  class="row">
                	<div class="col-xs-12 col-md-7">
		                <table  ng-show = "ctrl.divisionSelect.tipoTorneo ==1" class="table table-lg table-hover table-center table-dark ">
<%-- 		               style="background: url(<c:url value='/imagenes/LigaMundialXGamers.png'/>) " > --%>
		                	<thead class="thead-dark">
		                          <tr>
		                          	  <th>*</th>
		                          	  <th>*</th>
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
		                          <tr ng-repeat="e in ctrl.tablaGeneral.tablaGeneral">
		                          	  <td><a>{{$index+1}}</a></td>
		                          	  <td><img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td><a>{{e.nombreEquipo}}</a></td>
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
		    			
		    			<table ng-show = "ctrl.divisionSelect.tipoTorneo ==2" ng-repeat="grupo in ctrl.gruposTorneo" class="table table-sm table-hover table-center table-dark ">
		                	<thead class="thead-dark">
		                          <tr>
		                              <th>*</th>
		                          	  <th>*</th>
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
		                          <tr ng-repeat="e in ctrl.getTablaGrupo(grupo)">
		                          	  <td><a>{{$index+1}}</a></td>
		                          	  <td><img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td><a>{{e.nombreEquipo}}</a></td>
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
		    			
		    	<div  class="row">
                	<div class="col-xs-12 col-md-7">
		    			<table class="table table-sm table-hover table-dark table-responsive">
		    				<thead class="thead-dark">
		                          <tr>
		                          	  <th>*</th>
		                              <th>Goles</th>
		                              <th>Nombre</th>	
		                              	                              
		                          </tr>
		                      </thead>
		                       <tbody>
		                          <tr ng-repeat="e in ctrl.tablaGeneral.golesTorneo">
		                          	  <td><img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td><a>{{e.goles}}</a></td>
		                              <td><a>{{e.sobrenombre}}</a></td>
		                              
		                              
		                          </tr>
		                      </tbody>
		    			
		    			</table>
		    		</div>
		    		<div class="col-xs-6 col-md-5 ">
		    			<table class="table table-sm table-hover table-dark table-responsive">
		    				<thead class="thead-dark">
		                          <tr>
		                          	  <th>*</th>
		                              <th>Goles</th>
		                              <th>Nombre</th>	
		                              	                              
		                          </tr>
		                      </thead>
		                       <tbody>
		                          <tr ng-repeat="e in ctrl.tablaGeneral.golesTorneoEquipo">
		                          	  <td><img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td><a>{{e.goles}}</a></td>
		                              <td><a>{{e.sobrenombre}}</a></td>
		                              
		                              
		                          </tr>
		                      </tbody>
		    			
		    			</table>
		    		</div>
		    		</div>
		    		</div>
		    		<div class="col-xs-6 col-md-5 " >
			    		
			    		<!-- Nav tabs -->
						  <ul class="nav nav-tabs" role="tablist">
						    <li class="nav-item">
						      <a class="nav-link active" data-toggle="tab" ng-click="ctrl.showPen = false; ctrl.showJor = true">Jornadas</a>
						      
						    </li>
						    <li class="nav-item">
						      <a class="nav-link" data-toggle="tab" ng-click="ctrl.getPendientes(); ctrl.showPen = true; ctrl.showJor = false" >Pendientes</a>
						    </li>
						 
						  </ul>
						  
						 <div ng-show="ctrl.showPen" class="row">
							
						
							<div class="col"   >
								
							  <div class="form-group col-md-12">
	                              <div class="col-md-7">
	                                  <p><input class="form-control input-sm"  type="text" ng-model="test1" placeholder="Filtrar"></p>
	                              </div>
	                          </div>
								<table class="table table-sm table-hover table-dark table-responsive ">
			                	  <thead class="thead-dark">
			                          <tr>
			                          	  <th>#</th>
			                              <th>Local</th>
			                              <th></th>	
			                              <th></th>
			                              <th></th>
			                              <th></th>
			                              <th></th>
			                              <th>Visita</th>
			                              	                              
			                          </tr>
			                      </thead>
			                      <tbody>
			                          <tr ng-repeat="jor in ctrl.jorPendientes  | orderBy : 'numeroJornada' | filter : test1 " ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
								  	ctrl.getJornada(jor.idJornada,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
								  	data-toggle="modal" data-target="#exampleModalScrollable">
								  		  <td><span ng-bind="jor.numeroJornada"></span></td>
			                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
			                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
			                              <td>{{jor.golesLocal}}</td>
			                              <td>-</td>
			                              <td>{{jor.golesVisita}}</td>
			                              <td ><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
			                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
			                             
			                          </tr>
			                      </tbody>
			    				</table>
							</div>
						
						</div> 
					
		    			<div ng-show="ctrl.showJor" class="row">
		    			<div class="scrollmenu">
						  <a href="" ng-click="ctrl.setJornadaActual(e)" ng-repeat="e in ctrl.jornadas | orderBy : 'numeroJornada'" >
						  {{e.tipoJornada == 0 ? ("Jornada "+ e.numeroJornada) : e.nombreJornada }} </a>
						</div>
							<div class="col"  ng-repeat="e in ctrl.jornadaSelect | orderBy : 'numeroJornada'" >
								<blockquote class="blockquote text-center">
									  <p class="mb-0">{{e.tipoJornada == 0 ? ("Jornada "+ e.numeroJornada) : e.nombreJornada }} <a ng-show="e.cerrada==1">Cerrada</a></p>
									  
								</blockquote>
								<table class="table table-sm table-hover table-dark table-responsive ">
			                	
			                      <tbody>
			                          <tr ng-repeat="jor in e.jornada" ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
								  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
								  	data-toggle="modal" data-target="#exampleModalScrollable">
			                              <td><span class="text-right">{{e.nombreEquipo}}</span></td>
			                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
			                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
			                              <td>{{jor.golesLocal}}</td>
			                              <td>-</td>
			                              <td>{{jor.golesVisita}}</td>
			                              <td ><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
			                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
			                             
			                          </tr>
			                      </tbody>
			    				</table>
							</div>
						</div>
					
						
		    		</div> 
	    		</div>           
        	</div>   
        	
        	             
		</div> 
	
	</div>
</body>
</html>
