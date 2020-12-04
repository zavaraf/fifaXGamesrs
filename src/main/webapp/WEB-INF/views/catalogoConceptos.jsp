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
	<script src="<c:url value='/static/js/service/conceptos_service.js' />"></script>
  	<script src="<c:url value='/static/js/controller/conceptos_controller.js' />"></script>
  
  	
	<div ng-controller="CatalogoController as ctrl">
	<sec:authentication var="user" property="principal" />
	  
	
	<!-- Modal Finanzas-->
			<div class="modal fade" id="myModalCatalogoFinanzas" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Datos Financieros</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
					<form ng-submit="ctrl.updateConceptos(ctrl.catalogoSubmit.codigo,ctrl.catalogoSubmit.descripcion,ctrl.catalogoSubmit.tipoconcepto)" name="myFormCon" class="form-horizontal">
<%-- 					<form name="myForm" class="form-horizontal""> --%>
                      <input type="hidden" ng-model="ctrl.equipo.id" />
                     
                      <div class="row">
							<div class="form-group col-md-12">
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Codigo</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.catalogoSubmit.codigo" id="catCodigo" class="form-control input-sm" placeholder="Codigo" required ng-minlength="3"/>
								 </div>
							</div>
							<div class="form-group col-md-12">
								
								<div class="input-group mb-3 input-group-sm">
								     <div class="input-group-prepend">
								       <span class="input-group-text">Nombre</span>					       
								    </div>
								    <input type="text" ng-model="ctrl.catalogoSubmit.descripcion" id="catNombre" class="form-control input-sm" placeholder="Nombre" required ng-minlength="3"/>
								 </div>
							</div>
						</div> 
						 <div class="row">
	                          <div class="form-group col-md-12">
	                        	 <div class="input-group mb-3 input-group-sm">
									     <div class="input-group-prepend">
									       <span class="input-group-text">Tipo Concepto</span>					       
									    </div>
									    <select  ng-model="ctrl.catalogoSubmit.tipoconcepto" ng-options="catFinanzas as catFinanzas.codigo for catFinanzas in ctrl.catalogoFinanzas track by catFinanzas.codigo" class="lastname form-control input-sm">
										    <option value="" >--Elige Opcion--</option>
										 </select>
										
									 </div>
	                          </div>
	                      </div>     
					<div class="modal-footer">
						<div class="form-actions floatRight">
                           <input type="submit" value="Guardar" class="btn btn-primary btn-sm"
                            ng-disabled="(ctrl.catalogoSubmit.descripcion==null || ctrl.catalogoSubmit.codigo==null || ctrl.catalogoSubmit.tipoconcepto==null) " >
                        </div>
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
                  </form>
					
					
					</div>
					
				</div>
			</div>
		</div>		
		
  
<div class="container">

      <div class="formcontainer" >
      <button type="button"  class="btn btn-info btn-sm" data-toggle="modal"
					data-target="#myModalCatalogoFinanzas"
					ng-disabled=false 
					ng-show=true>Agregar Conceptos</button>
					
				<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">
						<span class="lead">Lista de Conceptos</span>
					</div>
				</div>
				<div class="table-responsive-sm">
					<div class="row">
                          <div class="col align-self-center">
                             <p><input class="form-control"  type="text" ng-model="text" placeholder="Buscar"></p>
						   </div>                            
              		</div>
					<table class="table table-sm table-hover table-dark table-responsive">
						<thead>
							<tr>
								<th>codigo</th>
								<th>Descripcion</th>
								<th>Tipo</th>
							</tr>
						</thead>
						<tbody>
							<tr  class = "{{u.tipoconcepto.codigo == 'ingreso' ? 'table-success' : 'table-danger'}}" ng-repeat="u in ctrl.catalogo |orderBy : 'tipoconcepto.codigo'| filter : text" ">
								<td><span ng-bind="u.codigo"></span></td>
								<td><span ng-bind="u.descripcion"></span></td>
								<td><span ng-bind="u.tipoconcepto.codigo"></span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div> 
   
  

</div> 

</div>
</body>
</html>
