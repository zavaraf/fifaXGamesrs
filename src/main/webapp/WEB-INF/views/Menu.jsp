<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>FIFA XGAMERS</title>

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
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>



</head>
<body ng-app="myApp" class="ng-cloak">
	<script	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
	<script	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular-route.js"></script>
	
	
        <script src="<c:url value='/static/js/libs/angular.js/angular-pagination.js' />"></script>
	<script src="<c:url value='/static/js/app/app.js' />"></script>
	
	<script	src="<c:url value='/static/js/controller/menu_controller.js' />"></script>
	<script	src="<c:url value='/static/js/controller/equipo_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
	<script	src="<c:url value='/static/js/controller/user_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/user_service.js' />"></script>
	<script	src="<c:url value='/static/js/controller/team_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/team_service.js' />"></script>
	<script	src="<c:url value='/static/js/controller/draft_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/draft_service.js' />"></script>
	<script	src="<c:url value='/static/js/controller/draftPC_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/draftPC_service.js' />"></script>
	<script	src="<c:url value='/static/js/controller/temporada_controller.js' />"></script>
	<script src="<c:url value='/static/js/service/temporada_service.js' />"></script>
	
    

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	    <a class="navbar-brand" href="#!temporada">Temporada</a>
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
				<li class="nav-item"><a class="nav-link" href="#!zonaDraftPC">Draft
						PC</a></li>
				<!-- 	      <li class="nav-item"> -->
				<!-- 	        <a class="nav-link disabled" href="#">Disabled</a> -->
				<!-- 	      </li> -->
			</ul>
			<!-- LOGOUT -->
			<p>
				Bienvenido
				<%=request.getUserPrincipal().getName()%>
				
				<a href="<c:url value='/logout'/>">desconectar</a>
				
				<sec:authentication var="user" property="principal" />
				
					${user.idEquipo}
					${user.nombreEquipo}
					
<%-- 					${user.roles} --%>
<%-- 					${user.roles}.indexOf('ROLE_Admin') --%>
			    
			</p>
			
			
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<hr/>
				<%= request.getUserPrincipal() %>
				<sec:authentication var="user" property="principal" />
				
				<p>
				
				${user.roles} 
				<p>
				${user.authorities}
				<p>
				${user.authorities}.includes('Manager')
				
				<div ng-include="'http://fifa-xgamers.com'"></div>
				
<!-- 	<div ng-view></div> -->
</body>
</html>