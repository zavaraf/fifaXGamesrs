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
       <link data-require="font-awesome@*" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
    <link rel="stylesheet" href="https://rawgit.com/rajush/angular-dropdown-multiselect/master/dist/angular-dropdownMultiselect.min.css" />	
      <script src="<c:url value='/static/js/app/app.js' />"></script>
      <script src="<c:url value='/static/js/controller/salonFama_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/salonFama_service.js' />"></script>
      
      <script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script>

   </head>
   <body class="ng-cloak">
      <div class="container  container-fluid" ng-controller="SalonFamaController as ctrl">

      
      <div class="formcontainer"	>
	        
	        <div class="panel panel-default text-center">
                    <div class="panel-heading">
                       <span class="h2  ">Salon de la fama</span>
                    </div>
                </div>
            	<div class="panel panel-default text-center">
                    
                    <div class="row ">
	                    <div class=" col text-center">
	                        <img ng-src="<c:url value='https://i.postimg.cc/xCrzjtmT/Champions.png'/>" class="rounded " height="80" alt="Cinque Terre">
						    <figcaption class=" figure-caption text-center text-white">Champions</figcaption>
						</div>
						<div class="col">
	                        <img ng-src="<c:url value='https://i.postimg.cc/fyc4ryzw/Europa-Leage.png'/>" class="rounded  "  height="80" alt="Cinque Terre">
	                        <figcaption class=" figure-caption text-center text-white">Europa</figcaption>
						</div>
						<div class="col">
	                        <img ng-src="<c:url value='https://i.postimg.cc/NFc5P2gj/Primera.png'/>" class="rounded "  height="80" alt="Cinque Terre">
	                        <figcaption class=" figure-caption text-center text-white">Primera</figcaption>
						</div>
						<div class="col">
	                        <img ng-src="<c:url value='https://i.postimg.cc/rw0RskYc/Super-Liga1.png'/>" class="rounded  mx-auto"  height="80" alt="Cinque Terre">
	                        <figcaption class=" figure-caption text-center text-white">Superliga</figcaption>
						</div>
						<div class="col">
	                        <img ng-src="<c:url value='https://i.postimg.cc/VNv8kzRR/Superliga.png'/>" class="rounded mx-auto " height="80" alt="Cinque Terre">
	                        <figcaption class=" figure-caption text-center text-white">Juveniles</figcaption>
						</div>

                   
                </div>
               
              
       </div>
      
      
<!--       <div ng-show="ctrl.showresumen" class="row"> -->
		<!-- Nav tabs -->
		
			  <ul class="nav nav-tabs justify-content-center" role="tablist">
			    <li class="nav-item">
			      <a class="nav-link active" data-toggle="tab" ng-click="ctrl.showdetalle = false; ctrl.showresumen = true;">Resumen</a>
			      
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" ng-click="ctrl.showdetalle = true; ctrl.showresumen = false; " >Detalle</a>
			    </li>
			    
			 
			  </ul>
		<div class="col-xs col-md  " >
		<div ng-show="ctrl.showresumen" class="row justify-content-md-center">
							
						
							<div class="col-md"   >
								
							  <div class="form-group col-md">
	                              <div class="col-md">
	                                  <p><input class="form-control input-sm"  type="text" ng-model="test1" placeholder="Filtrar"></p>
	                              </div>
	                          </div>
	                          <div class= "table-responsive">
								<table class="table table-sm table-hover table-dark ">
			                	  <thead class="thead-dark">
			                          <tr>
			                          	  <th>Usuario</th>
			                              <th></th>	
			                              <th>Equipo</th>
			                              <th>Titulos</th>
			                              <th></th>	
			                              <th>Total</th>
			                              	                              
			                          </tr>
			                      </thead>
			                      <tbody>
			                          <tr ng-repeat="jor in ctrl.salonFama.data.resumen  | orderBy : '-totalxTemporada' | filter : test1 "">
								  		  <td><span ng-bind="jor.usuario"></span></td>
			                              <td><img ng-src="{{jor.img}}" height="25"  class="rounded float-left" alt="..."></td>
			                              <td><span ng-bind="jor.nombreEquipo"></span></td>
			                              <td>{{jor.nombreTorneo}}</td>
			                              <td><img ng-src="{{jor.imgTorneo}}" height="40"  class="rounded float-rigth" data-toggle="tooltip" data-placement="right" title="{{jor.nombreTorneo}}" alt="..."></td>
			                              <td>{{jor.totalxTemporada}}</td>
			                              
			                             
			                          </tr>
			                      </tbody>
			    				</table>
			    				</div>
							</div>
						
						</div> 
						
						
       		<div ng-show="ctrl.showdetalle" class="row justify-content-md-center">
							
						
							<div class="col-md"   >
								
							  <div class="form-group col-md">
	                              <div class="col-md justify-content-center">
	                                  <p><input class="form-control input-sm justify-content-center"  type="text" ng-model="test1" placeholder="Filtrar"></p>
	                              </div>
	                          </div>
	                          <div class= "table-responsive">
								<table class="table table-sm table-hover table-dark ">
			                	  <thead class="thead-dark">
			                          <tr>
			                          	  <th>Usuario</th>
			                              <th></th>	
			                              <th>Equipo</th>
			                              <th>Titulos</th>
			                              <th></th>	
			                              <th>Temporada</th>
			                              	                              
			                          </tr>
			                      </thead>
			                      <tbody>
			                          <tr ng-repeat="jor in ctrl.salonFama.data.detalle  | orderBy : '-nombreTemporada' | filter : test1 "">
								  		  <td><span ng-bind="jor.usuario"></span></td>
			                              <td><img ng-src="{{jor.img}}" height="25"  class="rounded float-left" alt="..."></td>
			                              <td><span ng-bind="jor.nombreEquipo"></span></td>
			                              <td>{{jor.nombreTorneo}}</td>
			                              <td><img ng-src="{{jor.imgTorneo}}" height="40"  class="rounded float-rigth" data-toggle="tooltip" data-placement="right" title="{{jor.nombreTorneo}}" alt="..."></td>
			                              <td>{{jor.nombreTemporada}}</td>
			                              
			                             
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