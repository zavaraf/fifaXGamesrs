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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
  </style>
</head>
<body ng-app="myApp" >
	
  	<script src="<c:url value='/static/js/controller/cargaJugadores_controller.js' />"></script>
  	<script src="<c:url value='/static/js/service/cargarJugador_service.js' />"></script>
  	
      
      <script src="<c:url value='/static/js/app/customSelect.js' />"></script>

	  <script src="<c:url value='/static/js/app/papaparse.js' />"></script>
	<script src="<c:url value='/static/js/app/papaparse.min.js' />"></script>   
  
  	

  
  	
<div ng-controller="CargaJugadoresController as ctrl">
	<sec:authentication var="user" property="principal" />
	  

  
<div class="container">

      <div class="formcontainer" >
      
			<section class="content">
			 
			    <div class="row">
			          <div class="col-md-12">
			             
			            
			                <div class="box-body table-responsive">
			                    <!-- form start -->
			                    
			                    <form role="form" class="form-horizontal" name="bulkDirectForm" method="post" enctype="multipart/form-data" novalidate>
			                    
			                        <div id="messages" class="alert alert-success" data-ng-show="messages" data-ng-bind="messages"></div>
			                        <div id="warning" class="alert alert-warning" data-ng-show="warning" data-ng-bind="warning"></div>
			                        
			                        <div class="form-group">
			                          <div class="col-sm-10">
			                            <input type="file" class="form-control" id="bulkDirectFile" placeholder="CSV file with phone numbers and amount" ng-model="prd.bulk_direct_file" required accept=".csv">
			                          </div>
			                          <div class="col-sm-2">
			                            <button type="submit" class="btn btn-block btn-info" ng-show="!verCheck" data-ng-click="ctrl.add(); verCheck=true">Procesar</button>
			                            <button type="button" class="btn btn-success"  ng-show="verCheck == true" ng-click="ctrl.read(data);">Checar informacion</button>
			                          </div>
			                          <br>
			                          <div class="col-sm-10" >
			                          
			                          <h5 ng-show="ctrl.datos.length>0" > Se encontraron {{ctrl.datos.length}} registros para procesar</h5>
			                          
			                          <h5 ng-show="ctrl.datos.length>0" > {{ctrl.result}}</h5>
			 
<!-- 			 						<a>{{ctrl.datos}}</a> -->
			                          <br>
			                          
			                          <button type="button" class="btn btn-success" ng-show="ctrl.datos.length>0" ng-click="ctrl.confirmar(data)">confirmar</button>
			                          
			                          </div>
			 
			 
			                          
			                        </div>
			                       
			                       
<!--			                        	<table class="table table-lg table-hover table-dark table-center ">
			                                    <thead>
			                                       <tr>
			                                          <th>ID.</th>
			                                          <th>ID.</th>
			                                          <th>N.Corto</th>
			                                          <th>Club</th>
			                                          <th>Overral</th>
			                                          <th>Potencial</th>
			                                          <th>value</th>
			                                       </tr>
			                                    </thead>
			<!--                                        <tr ng-pagination="u in ctrl.players | orderBy : '-raiting'" ng-pagination-size="60"  > -->
			<!--                                        <tr  ng-repeat="u in ctrl.data | orderBy : '-raiting' | filter : test "> 
			                                    <tbody>
			                                       
													<tr ng-pagination="u in ctrl.data | orderBy : '-Overall'" ng-pagination-size="60"  >
			                                          <td ng-show="u.Imagen == null">{{u.ID}}</td>
			                                          <td ng-show="u.Imagen != null">                                          	                                  
						                                  <img height="40" class="rounded float-left" ng-show="u.Imagen != null" ng-src="{{u.Imagen}}"   alt="{{u.id}} ">			                              
						                              </td>
			                                          <td ng-show="u.link!=null"><a href="{{u.Url}}" target="_blank" >{{u.Name}}</td>
			                                          <td ng-show="u.link==null">{{u.Name}}</td>
			                                          
			                                          <td><a >{{u.Club}}</a></td>
			                                          <td>{{u.Overall}}</td>
			                                          <td>{{u.Potential}}</td>
			                                          <td>{{u.Value}}</td>
			                                          
			                                          
			                                         	 
			                                       </tr>
			                                    </tbody>
			                                 </table>
			                                 <ng-pagination-control pagination-id=" ctrl.data"></ng-pagination-control>
			                        -->
			                    </form>
			                     
			              </div>
			          </div>
			     </div>
			 
			 
			</section>
      
      </div>
   
  

</div> 



</div>


 



 
 


</body>
</html>
