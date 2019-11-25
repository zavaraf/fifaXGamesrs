<%@ include file="/WEB-INF/views/include.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html ng-app="myApp">
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="<c:url value='/static/css/bootstrap.min.css' />" rel="stylesheet"></link>
        <script src="<c:url value='/static/js/libs/angular.js/angular.min.js' />"></script>
        <script src="<c:url value='/static/js/libs/angular.js/angular-pagination.js' />"></script>
        <script src="<c:url value='/static/js/libs/angular-ui-bootstrap/ui-bootstrap-tpls-2.1.2.min.js' />"></script>

        <script src="<c:url value='/static/js/app/app.js' />"></script>
  	    <script src="<c:url value='/static/js/controller/tablaUsuarios.js' />"></script>
  	    <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
	    <script src="<c:url value='/static/js/service/user_service.js' />"></script>
	    <script src="<c:url value='/static/js/service/equipo_service.js' />"></script>
	    
	    
	    
    </head>
    <body ng-controller="UserController as ctrl">
    
        <h1>Ejemplo pagineo</h1>
        
       
		<div id="jugadores" class="container tab-pane active" >
        
        <p><input class="form-control input-sm"  type="text" ng-model="test" placeholder="Buscar"></p>
        <input type="text" ng-model="busqueda"> <button ng-click="buscar(busqueda)">Buscar</button>
        <input type="text" ng-pagination-search="ctrl.players">
<!--         <div class="row" ng-repeat="item in filtroItems"> -->
<!--             <div class="col-md-7"> -->
<!--                 <a href="#"> -->
<!--                     <img class="img-responsive" ng-src="http://placehold.it/700x300" alt=""> -->
<!--                 </a> -->
<!--             </div> -->
<!--             <div class="col-md-5"> -->
<!--                 <h3>{{item.nombre}}</h3> -->
<!--                 <h4>{{item.subnombre}}</h4> -->
<!--                 <p>{{item.descripcion}}</p> -->
      
<!--             </div> -->
<!--         </div> -->
		
			<table id="dtBasicExample" class="table table-striped table-bordered table-sm" >

          <thead>
            <tr>
              <th>Id</th>
              <th>Primer Nombre</th>
              <th>Segundo Nombre</th>
              <th>Primer Apellido</th>
            </tr>
          </thead>
          <tbody>
<!--             <tr ng-repeat='usuario in usuarios | startFromGrid: currentPage * pageSize | limitTo: pageSize' , ng-click='seleccionarUsuario(usuario.id)'> -->
<!--             <tr ng-repeat="u in filtroItems | filter : test" > -->
            <tr ng-pagination="u in ctrl.players | filter : test" ng-pagination-size="20"  >
              <td>{{u.id}}</td>
			  <td>{{u.sobrenombre}}</td>
			  <td>{{u.equipo.nombre}}</td>
			  <td>{{u.raiting}}</td>
            </tr>
          </tbody>
        </table>
        <ng-pagination-control pagination-id="ctrl.players"></ng-pagination-control>
		</div>
        <hr />        
        <ul uib-pagination total-items="totalItems"  items-per-page="numPerPage" ng-model="currentPage"></ul>
        
        
    </body>
</html>