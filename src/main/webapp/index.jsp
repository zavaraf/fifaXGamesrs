<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<title>FIFA XGAMERS</title>

<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" -->
<!-- 	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" -->
<!-- 	crossorigin="anonymous"> -->
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" -->
<!-- 	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" -->
<!-- 	crossorigin="anonymous"></script> -->
<!-- <script -->
<!-- 	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" -->
<!-- 	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" -->
<!-- 	crossorigin="anonymous"></script> -->
<!-- <script -->
<!-- 	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" -->
<!-- 	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" -->
<!-- 	crossorigin="anonymous"></script> -->
	
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>  
  
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>




</head>
<body ng-app="myApp"   class="ng-cloak">
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular-route.js"></script>
	<script src="<c:url value='/static/js/libs/angular.js/angular-pagination.js' />"></script>
	
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script> -->
  
	<script src="<c:url value='/static/js/app/app.js' />"></script>
	
<%-- 	<script src="<c:url value='/static/angular-bootstrap-multiselect/dist/angular-bootstrap-multiselect.min.js' />"></script> --%>
	
	<script
		src="<c:url value='/static/js/controller/menu_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/user_service.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/user_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/team_service.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/team_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/draft_service.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/draft_controller.js' />"></script>
	<script
		src="<c:url value='/static/js/controller/draftPC_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/draftPC_service.js' />"></script>
	
	<script src="<c:url value='/static/js/controller/adminUser_controller.js' />"></script>
    <script src="<c:url value='/static/js/service/adminUser_service.js' />"></script>
    
    <script src="<c:url value='/static/js/controller/temporada_controller.js' />"></script>
    <script src="<c:url value='/static/js/service/temporada_service.js' />"></script>
    
    <script src="<c:url value='/static/js/service/conceptos_service.js' />"></script>
  	<script src="<c:url value='/static/js/controller/conceptos_controller.js' />"></script>
  	
  	<script src="<c:url value='/static/js/controller/torneoLM_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/torneoLM_service.js' />"></script>
      
      <script src="<c:url value='/static/js/controller/adminTorneoLM_controller.js' />"></script>

	<script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script>

    
    <div ng-controller="TemporadaController as ctrl">
    <!-- Modal DraftPC  Cambiar Temporada-->
		<div class="modal fade" id="myModalTemporada" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
				
					<div class="modal-header">
					    <h4 class="modal-title">Confirmar</h4>
						
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
<%-- 					<form  name="myFormCon" class="form-horizontal"> --%>
                      <select  ng-model="ctrl.selectedTor" ng-options="temporada as temporada.nombre for temporada in ctrl.temporada track by temporada.id"  		
						 class="form-control mr-sm-2" name="temporada" form="carform">
						</select>
						<div class="form-actions floatRight">
                           <input ng-click="ctrl.cambiarTemporada()" type="submit" value="Confirmar" data-dismiss="modal" class="btn btn-primary btn-sm" >
                        </div>
<%--                   </form> --%>
					
					
					</div>
					
				</div>
			</div>
		</div>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#!torneo">Torneo</a>
		<a class="navbar-brand" href="#!jugadores">Jugadores</a> 
		<a class="navbar-brand" href="#!equipos">Equipos</a>
		
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo02"
			aria-controls="navbarTogglerDemo02" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-item active"><a class="nav-link"
					href="#!zonaDraft">Draft DT<span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#!zonaDraftPC">Draft	PC</a></li>
				<sec:authorize access="hasAnyRole('ROLE_Admin')">
				<li class="nav-item"><a class="nav-link" href="#!adminDT">Admin DTS</a></li>
				<li class="nav-item"><a class="nav-link" href="#!adminTorneo">Admin Torneo</a></li>
				<li class="nav-item dropdown">
				    <a class="nav-link dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" aria-expanded="false">Catalogos</a>
				    <div class="dropdown-menu">
				      <a class="dropdown-item" href="#!conceptos">Conceptos Financieros</a>
				    </div>
				  </li>
				</sec:authorize>
				<!-- 	      <li class="nav-item"> -->
				<!-- 	        <a class="nav-link disabled" href="#">Disabled</a> -->
				<!-- 	      </li> -->
			</ul>
			<!-- LOGOUT -->
			<p>
				Bienvenido
				<%=request.getUserPrincipal().getName()%>
				
				<a href="<c:url value='/logout'/>">desconectar</a>
				
			
			</p>
			
			<form  class="form-inline my-2 my-lg-0">
						
	
				<button data-toggle="modal"
				data-target="#myModalTemporada" class="btn btn-outline-success my-2 my-sm-0" type="submit">{{ctrl.selectedTor.descripcion}}</button>
			
			</form>
		</div>
	</nav>
	</div>
	<div class="container">


</div>

	<div ng-view></div>
</body>
</html>