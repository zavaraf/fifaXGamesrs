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
      <div class="container  container-fluid" ng-controller="AdminTorneoLMController as ctrl">
			
		<div id="jugadores">
			<!--  Div verde <div class="formcontainer"> -->
			
			<ul class="nav nav-tabs" role="tablist">
			    <li class="nav-item" ng-repeat="div in ctrl.divisiones">
			      <a class="nav-link"  ng-click= "ctrl.divisionSelect=div ; ctrl.getJornadas()" data-toggle="tab" >{{div.nombre}}</a>
			    </li>   
			 </ul>
	        <div class="formcontainer"	>
	        
            	<div class="panel panel-default">
                    <div class="panel-heading">
                       <span class="lead">Generar Jornadas</span>
                    </div>
                </div>
                <button type="button" class="btn btn-primary" ng-show="ctrl.jornadas==null || ctrl.jornadas == '' " ng-click="ctrl.getGenerarJornadas()">Generar Jornadas</button>
                <button type="button" class="btn btn-primary" ng-show="ctrl.jornadas!=null && ctrl.jornadas != '' " ng-click="ctrl.addJornadas()">Guardar</button>
                <div class="row" >
                	
		    		<div class="col" >
					
		    			<div class="row"   >
		    			
							<div class="col-lg-4" ng-repeat="e in ctrl.jornadas | orderBy : 'numeroJornada'">
							<div class="row"   >
								<div class="col" >
									<blockquote class="blockquote text-center">
										  <p class="mb-0">Jornada {{e.numeroJornada}}</p>
										  
									</blockquote>
								</div>
								<div class="col" >
								
									<div class="form-check">
								        <input ng-click="ctrl.addJornadasEdit(e)" ng-model="e.activa" ng-true-value="1" ng-false-value="0" class="form-check-input" type="checkbox" id="gridCheck1">
								        <label class="form-check-label" for="gridCheck1">
								          Avtivar
								        </label>
							      </div>
							      <div class="form-check">
								        <input ng-click="ctrl.addJornadasEdit(e)" ng-model="e.activa" ng-true-value="2" ng-false-value="0" class="form-check-input" type="checkbox" id="gridCheck1">
								        <label class="form-check-label" for="gridCheck1">
								          Cerrar
								        </label>
							      </div>
							    
								</div>
							</div>
							
							<div class="list-group" >
							  <span ng-repeat="jor in e.jornada"  class="list-group-item list-group-item-action">
							  	<div class="container" 
							  	ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
							  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
								  <div class="row text-center">
								    <div class="col ">
								      {{jor.nombreEquipoLocal}}
								    </div>
								    <div class="col-sm-2">
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