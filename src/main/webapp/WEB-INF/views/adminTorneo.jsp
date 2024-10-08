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
         
         .full button span {
    background-color: limegreen;
    border-radius: 32px;
    color: black;
  }
  .partially button span {
    background-color: orange;
    border-radius: 32px;
    color: black;
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
      
      
      <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
       <link data-require="font-awesome@*" data-semver="4.5.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.css" />
    <link rel="stylesheet" href="https://rawgit.com/rajush/angular-dropdown-multiselect/master/dist/angular-dropdownMultiselect.min.css" />	
      <script src="<c:url value='/static/js/app/app.js' />"></script>
      <script src="<c:url value='/static/js/controller/torneoLM_controller.js' />"></script>
      <script src="<c:url value='/static/js/service/torneoLM_service.js' />"></script>
      <script src="<c:url value='/static/js/app/ui-bootstrap-tpls-0.10.0.js' />"></script>
      

      <%--      <script src="<c:url value='/static/js/service/draft_service.js' />"></script> --%>
      <%--      <script src="<c:url value='/static/js/controller/draft_controller.js' />"></script> --%>
           <script src="<c:url value='/static/dotansimha-angularjs-dropdown-multiselect-e73fca5/dist/angularjs-dropdown-multiselect.min.js' />"></script>
<!--       <script src="/static/js/app/script.js"></script> -->
   </head>
   <body class="ng-cloak">
      <div class="container  container-fluid" ng-controller="AdminTorneoLMController as ctrl">
      
<!--       MODAL EDIT JORNADA -->
      <div class="modal fade" id="myModalJuego" role="dialog">
			<div class="modal-dialog  modal-lg">
				<!-- Modal content-->
				<div class="modal-content bg-dark text-white">
					<div class="modal-header">
						<h4 class="modal-title">Edit Jornada</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<form name="myForm">
						
						<div class="row text-center">
								<div class="col-md-4">
									<label class="col-md control-lable" for="address">Equipo
										{{ctrl.juegoEdit.nombreEquipoLocal}}</label>
									<div class="col-md">

										<div class="col"
											custom-select="t as t.nombre for t in ctrl.equipos | filter: { nombre: $searchTerm }"
											ng-model="ctrl.juegoEdit.equipoLocal" ng-click="ctrl.juegoEdit.equipoLocal">
											<div class="pull-left">
												<img ng-src="{{ t.img }}" style="width: 30px" /> <strong>{{
													t.nombre }}</strong>
											</div>

										</div>

									</div>

								</div>
								<div class="col-md-2 text-center ">
								  <label  >
								    vs
								 </label>
								 
								 <div class = "row ">
									 <div class="col-md-2 text-center">
										 <button type="button" ng-click="ctrl.cambiarLocalia()" class="btn btn-primary" >Cambiar</button>
									 </div>
								 </div>
									
								</div>
								<div class="col-md-4">
									<label class="col-md control-lable" for="address">Equipo
										{{ctrl.juegoEdit.nombreEquipoVisita}}</label>
									<div class="col-md">

										<div class="col"
											custom-select="t as t.nombre for t in ctrl.equipos  | filter: { nombre: $searchTerm }"
											ng-model="ctrl.juegoEdit.equipoVisita">
											<div class="pull-left">
												<img ng-src="{{ t.img }}" style="width: 30px" /> <strong>{{
													t.nombre }}</strong>
											</div>

										</div>

									</div>

								</div>


							</div>
							
						
						</form>
					</div>
					
					<div class="row modal-footer">
					
					
					<div class="col">
					    <button type="button" ng-click="ctrl.delJuego()" class="btn btn-danger " data-dismiss="modal">eliminar</button>
					</div>
					<div class="col ">
					
					
					    
					    <button type="button" class="btn btn-primary float-right" data-dismiss="modal" 
					    
					    ng-click="ctrl.editJuego()">Guardar</button>
					    
						<button type="button" class="btn btn-dark float-right" data-dismiss="modal">Close</button>
					
					    
						
					</div>
					</div>
				</div>
			</div>
		</div>
      
      
      <!--       Modal Liguilla -->
      <div class="modal fade bd-example-modal-sm" id="ModalLiguilla" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content bg-dark text-white">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">Fase Finales</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        Mi modal Para Fases finales
<!-- 		        ng-repeat="tor in ctrl.getTorneos()" -->
		        
		        <select ng-model="selectedTorneoModal" 
                    ng-options="pla as pla.nombre for pla in ctrl.getTorneos()  track by pla.id"
                    class="custom-select input-sm">
                    <option value="">--Torneo--</option>
                 </select>
                 <select ng-model="selectedFaseModal" 
                    ng-options="pla as pla.nombre for pla in ctrl.CatLiguilla  track by pla.id"
                    class="custom-select input-sm">
                    <option value="">--Fase--</option>
                 </select>
                <div class="form-row align-items-center">
                <div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" ng-model="ctrl.confLiguilla" name="inlineRadioOptionsLiguilla" id="inlineRadioLiguilla1" ng-value=1>
				  <label class="form-check-label" for="inlineRadioJ1">Solo Ida</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" ng-model="ctrl.confLiguilla" name="inlineRadioOptionsLiguilla" id="inlineRadioLiguilla2" ng-value=2>
				  <label class="form-check-label" for="inlineRadioJ2">Ida y Vuelta</label>
				</div>
				</div>
				<div class="form-row align-items-center">
				<div class="col-auto my-1">
				<div ng-dropdown-multiselect="" class="bg-white" options="example9data" selected-model="equiposLiguilla" extra-settings="example9settings"></div>
				</div>
				</div>
				<button type="button"  class="btn btn-primary" ng-click="ctrl.generarPartidosFinales(equiposLiguilla,selectedFaseModal.nombre,selectedFaseModal.id)" >Generar Partidos</button>
				<div  class="list-group" >
				  <span   class="list-group-item list-group-item-action">
				  	<div class="container" >
					  <div  class="row text-center">
					    <div ng-repeat="e in equiposLiguilla " class="col-sm-2 ">
					    
					    <img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="...">  
					      {{e.nombre}}
					    </div>
					  </div>
					</div>
				  </span>
			     </div>
			     
			        
			     <div class="row" >
                	
		    		<div class="col" >
					
		    			<div class="row"   >
		    			
							<div class="col-lg-6" ng-repeat="e in ctrl.jornadasLiguilla ">
							<div class="row"   >
								<div class="col" >
									<blockquote class="blockquote text-center">
										  <p class="mb-0">{{e.nombreJornada}}</p>
										  
									</blockquote>
								</div>
							</div>
							
							<table class="table table-sm table-hover table-dark table-responsive">
		                	
		                      <tbody>
		                          <tr  ng-repeat="jor in e.jornada" ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
							  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
		                              <td><span class="text-right">{{e.nombreEquipo}}</span></td>
		                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
		                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td>{{jor.golesLocal}}</td>
		                              <td>-</td>
		                              <td>{{jor.golesVisita}}</td>
		                              <td><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
		                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
		                             
		                          </tr>
		                      </tbody>
		    			</table>
							</div>
						</div>
					
						
		    		</div> 
	    		</div> 
			     
			     
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		        <button type="button"  class="btn btn-primary"ng-click="ctrl.addJuegosLiguilla(ctrl.jornadasLiguilla,selectedTorneoModal)" data-dismiss="modal">Guardar</button>
		      </div>
		    </div>
		  </div>
		  
		</div>
      
<!--       Modal Admin torneo -->
      <div class="modal fade bd-example-modal-lg" id="ModalTorneo" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content bg-dark text-white">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">Crear Torneo</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" ng-model="ctrl.confTor" name="inlineRadioOptions" id="inlineRadio1" ng-value=1>
				  <label class="form-check-label" for="inlineRadio1">Por divisi�n</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" ng-model="ctrl.confTor" name="inlineRadioOptions" id="inlineRadio2" ng-value=2>
				  <label class="form-check-label" for="inlineRadio2">Por Grupos</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" ng-click="ctrl.buscarTemporadasEspejo()" ng-model="ctrl.confTor" name="inlineRadioOptions" id="inlineRadio3" ng-value=3>
				  <label class="form-check-label" for="inlineRadio3">Jornadas Espejo</label>
				</div>
				<div ng-show="ctrl.confTor == 1">
					<h5 class="modal-title" id="exampleModalLongTitle">Preciona Guardar para generar los torneos por divisi�n</h5>
				</div>
				<div ng-show="ctrl.confTor == 3">
				
					<div>
						<select  ng-model="ctrl.selectedCatTemp" 
						    ng-options="temporada as temporada.nombre for temporada in ctrl.temporadasEspejo track by temporada.id"  		
							 class="custom-select input-sm">
							 <option value="">--Temporada--</option>
							</select>
						<select ng-model="ctrl.selectedCatTorneoTemp" 
		                    ng-options="pla as pla.nombre for pla in ctrl.selectedCatTemp.torneos  track by pla.id"
		                    class="custom-select input-sm">
		                    <option value="">--Torneo--</option>
		                 </select>
					
					</div>
					<div>
						<button type="button" ng-click="ctrl.getJornadasEspejo(ctrl.selectedCatTemp,ctrl.selectedCatTorneoTemp)" class="btn btn-primary">Consultar</button>
						<button type="button" ng-click="ctrl.cambiarLocalias()" class="btn btn-primary">Cambiar</button>
					
					</div>
					<div>
						<div class="modal-body">
						<form name="myForm">
						
						<div class="row text-center">
								<div class="col-md-4">
									<label class="col-md control-lable" for="address">Equipo
										{{ctrl.juegoEdit.nombreEquipoLocal}}</label>
									<div class="col-md">

										<div class="col"
											custom-select="t as t.nombre for t in ctrl.equipos | filter: { nombre: $searchTerm }"
											ng-model="ctrl.juegoEdit.equipoLocal">
											<div class="pull-left">
												<img ng-src="{{ t.img }}" style="width: 30px" /> <strong>{{
													t.nombre }}</strong>
											</div>

										</div>

									</div>

								</div>
								<div class="col-md-2 text-center ">
								  <label  >
								    vs
								 </label>
								 
								 <div class = "row ">
									 <div class="col-md-2 text-center">
										 <button type="button" ng-click="ctrl.cambiarEquipoJornadas(ctrl.juegoEdit.equipoLocal,ctrl.juegoEdit.equipoVisita)" class="btn btn-primary" >Cambiar</button>
									 </div>
								 </div>
									
								</div>
								<div class="col-md-4">
									<label class="col-md control-lable" for="address">Equipo
										{{ctrl.juegoEdit.nombreEquipoVisita}}</label>
									<div class="col-md">

										<div class="col"
											custom-select="t as t.nombre for t in ctrl.equipos  | filter: { nombre: $searchTerm }"
											ng-model="ctrl.juegoEdit.equipoVisita">
											<div class="pull-left">
												<img ng-src="{{ t.img }}" style="width: 30px" /> <strong>{{
													t.nombre }}</strong>
											</div>

										</div>

									</div>

								</div>


							</div>
							
						
						</form>
					</div>
					</div>
					
					<div ng-repeat="jor in ctrl.jornadasEspejo">
						jornada : {{jor.numeroJornada}}

						<table class="table table-sm table-hover table-dark">
		                	
		                      <tbody>
		                          <tr  ng-repeat="jor in jor.jornada | filter : test " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
		                              <td><span class="text-right">{{e.nombreEquipo}}</span></td>
		                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
		                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td>{{jor.golesLocal}}</td>
		                              <td>-</td>
		                              <td>{{jor.golesVisita}}</td>
		                              <td><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
		                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
		                             
		                          </tr>
		                      </tbody>
		    			</table>
						
						</div>	
				</div>
				<div ng-show="ctrl.confTor == 2">
					<div class="row">
					<div class="col">
					<select ng-model="ctrl.selectedCatTorneo" 
	                    ng-options="pla as pla.nombre for pla in ctrl.catTorneo.data.catTorneo  track by pla.id"
	                    class="custom-select input-sm">
	                    <option value="">--Torneo--</option>
	                 </select>
					</div>
<!-- 					    <div class="col"> -->
<!-- 					      <input type="text" class="form-control" ng-model="ctrl.selectedCatTorneo.nombre"placeholder="Nombre del torneo"> -->
<!-- 					    </div> -->
					    <div class="col">
					      <input type="text" class="form-control" ng-model="equiposXGrupo" placeholder="Numero de equpos x Grupo">
					    </div>
					</div>
					<div class="row">
					 <div class="col">
					    <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" ng-model="ctrl.confJor" name="inlineRadioOptionsJ" id="inlineRadioJ1" ng-value=1>
						  <label class="form-check-label" for="inlineRadioJ1">Solo Ida</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" ng-model="ctrl.confJor" name="inlineRadioOptionsJ" id="inlineRadioJ2" ng-value=2>
						  <label class="form-check-label" for="inlineRadioJ2">Ida y Vuelta</label>
						</div>
						
					  </div>
					</div>
					<div class="row">
					 <div class="col">
					    <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" ng-model="ctrl.confAle" name="inlineRadioOptionsA" id="inlineRadioA1" ng-value=1>
						  <label class="form-check-label" for="inlineRadioA1">Aleatorio</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" ng-model="ctrl.confAle" name="inlineRadioOptionsA" id="inlineRadioA2" ng-value=2>
						  <label class="form-check-label" for="inlineRadioA2">Posici�n</label>
						</div>
						
						
					  </div>
					</div>
					<div class="form-row align-items-center">
					    <div class="col-auto my-1">
					      
	
					      
<!-- 					      <multiselect ng-model="selection" options="options" id-prop="id" display-prop="nombre" show-search="true"> -->
<!-- 	 					  </multiselect> -->
						 <div ng-dropdown-multiselect="" class="bg-white" options="example9data" selected-model="example9model" extra-settings="example9settings"></div>
	 					
					      <br>
<!-- 					       <pre> Selected Items = {{example9model | json}} </pre> -->
	 					  <button type="button" ng-click="ctrl.getJornadasGrupos(example9model,equiposXGrupo)" class="btn btn-primary">Generar Grupos</button>
						  
					    </div>
					    
					    
					  </div>
					  
					  
					  <div  class="list-group" >
					  <span   class="list-group-item list-group-item-action">
					  	<div class="container" >
						  <div  class="row text-center">
						    <div ng-repeat="e in example9model " class="col-sm-2 ">
						    
						    <img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="...">  
						      {{e.nombre}}
						    </div>
						  </div>
						</div>
					  </span>
				     </div>
				     
				     <div class="col"  ng-repeat="grupo in ctrl.gruposSe | orderBy : 'numero'" >
								<blockquote class="blockquote text-center">
									  <p class="mb-0">Grupo {{grupo.numero}} </p>
									  
								</blockquote>
								
								<div  class="list-group">
								  <span  ng-repeat="e in grupo.equipos" class="list-group-item list-group-item-action">
								  	<div class="container" >
									  <div class="row text-center">
									    <div class="col " >
									      <img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."> 
									       {{e.nombre}}
									    </div>
									  </div>
									</div>
								  </span>
								 
							
								
								
								</div>
						<div class="row">
                          <div class="form-group col-md-12">
                              <div class="col-md-7">
                                  <p><input class="form-control input-sm"  type="text" ng-model="test" placeholder="Filtrar"></p>
                              </div>
                          </div>
              		</div>
						<div ng-repeat="jor in grupo.jornadas">
						jornada : {{jor.numeroJornada}}
<!-- 						 <span  ng-repeat="e in ctrl.getEquiposDes(grupo.equipos,jor.jornada)" class="list-group-item list-group-item-action"> -->
<!-- 								  	<div class="container" > -->
<!-- 									  <div class="row text-center"> -->
<!-- 									    <div class="col " > -->
<!-- 									      <img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="...">  -->
<!-- 									       {{e.nombre}} -->
<!-- 									    </div> -->
<!-- 									  </div> -->
<!-- 									</div> -->
<!-- 								  </span> -->
						<table class="table table-sm table-hover table-dark">
		                	
		                      <tbody>
		                          <tr  ng-repeat="jor in jor.jornada | filter : test " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
		                              <td><span class="text-right">{{e.nombreEquipo}}</span></td>
		                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
		                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td>{{jor.golesLocal}}</td>
		                              <td>-</td>
		                              <td>{{jor.golesVisita}}</td>
		                              <td><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
		                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
		                             
		                          </tr>
		                      </tbody>
		    			</table>
						
						</div>		
						
					</div>
					
					
					     
				</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		        <button type="button"  class="btn btn-primary"ng-click="ctrl.addTorneoGrupo(ctrl.gruposSe,torneoNombre)" data-dismiss="modal">Guardar</button>
		      </div>
		    </div>
		  </div>
		  
		</div>
			
		<div id="jugadores">
			<!--  Div verde <div class="formcontainer"> -->
			
			<ul class="nav nav-tabs" role="tablist">
			    <li class="nav-item" ng-repeat="tor in ctrl.getTorneos()">
			      <a class="nav-link"  ng-click= "ctrl.divisionSelect=tor ;ctrl.isJornadaInsert = false; ctrl.getJornadas();ctrl.getGruposTorneo(tor)" data-toggle="tab" >{{tor.nombre}}</a>
			    </li>
			    
			    
			    <li class="nav-item dropdown">
				    <a class="nav-link dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" aria-expanded="false">Agregar torneo</a>
				    <div class="dropdown-menu">
				      <a class="dropdown-item" ng-click="ctrl.buscarTodos()" data-toggle="modal" data-target="#ModalTorneo" href="">AgregarTorneo</a>
				      <a class="dropdown-item" ng-click="ctrl.buscarTodos()"  data-toggle="modal" data-target="#ModalLiguilla" href="">Liguilla</a>
				    </div>
				    
				    
				  </li> 
				 
				  
		
			 </ul>
			 
			 
	        <div class="formcontainer"	>
	        
            	<div class="panel panel-default">
                    <div class="panel-heading">
                       <span class="lead">Generar Jornadas</span>
                    </div>
                </div>
                <div class="row">
                          <div class="form-group col-md-12">
                              <div class="col-md-7">
                                  <p><input class="form-control input-sm"  type="text" ng-model="test1" placeholder="Filtrar"></p>
                              </div>
                          </div>
              		</div>
                <button type="button" class="btn btn-primary"  ng-show="ctrl.isJornadaInsert==false"  ng-click="ctrl.getGenerarJornadas()">Generar Jornadas</button>
                <button type="button" class="btn btn-primary" ng-show="ctrl.jornadas!=null && ctrl.jornadas != '' " ng-click="ctrl.addJornadas()">Guardar</button>
                
                <div ng-if="ctrl.gruposTorneo.length>1" class="row">
                <div class="col"  ng-repeat="grupo in ctrl.gruposTorneo| orderBy : 'numero'" >
							<blockquote class="blockquote text-center">
								  <p class="mb-0">Grupo {{grupo.numero}} </p>
								  
							</blockquote>
							
							<div  class="list-group">
							  <span  ng-repeat="e in grupo.equipos" class="list-group-item list-group-item-action">
							  	<div class="container" >
								  <div class="row text-center">
								    <div class="col " >
								      <img ng-src="{{e.img}}" height="25"  class="rounded float-left" alt="..."> 
								       {{e.nombre}}
								    </div>
								  </div>
								</div>
							  </span>
							</div>
				</div>
				</div>
							
                <div class="row" >
                	
		    		<div class="col" >
					
		    			<div class="row"   >
		    				
		    			
							<div class="col-lg-6" ng-repeat="e in ctrl.jornadas | orderBy : 'numeroJornada' ">
							<div class="row"   >
								<div class="col" >
									<blockquote class="blockquote text-center">
										  <p class="mb-0">{{e.tipoJornada == 0 ? ("Jornada "+ e.numeroJornada) : e.nombreJornada }} </a></p>
										  
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
								        <input ng-click="ctrl.addJornadasEdit(e)" ng-model="e.cerrada" ng-true-value="1" ng-false-value="0" class="form-check-input" type="checkbox" id="gridCheck1">
								        <label class="form-check-label" for="gridCheck1">
								          Cerrar
								        </label>
							      </div>
							    
								</div>
								
							</div>
							
							<div class="p-3 mb-2 bg-dark text-white">
							<div class="col" >
									Fecha Inicio {{e.fechaInicioString}}
    								<input type="datetime-local" name="input" ng-init='e.fechaInicioSt = getFormatDate(e.fechaInicio)' 
    								ng-model="e.fechaInicioSt" ng-change="ctrl.addJornadasEdit(e);e.fechaInicioString = (e.fechaInicioSt | date:'yyyy-MM-dd HH:mm:ss')"
      								placeholder="yyyy-MM-ddTHH:mm:ss" min="minDate" max="minDate" required />
      						</div>
      						<div class="col" >		
    								Fecha Fin {{e.fechaFinString}}
    								<input type="datetime-local" name="input" ng-init='e.fechaFinSt = getFormatDate(e.fechaFin)' 
    								ng-model="e.fechaFinSt" ng-change="ctrl.addJornadasEdit(e); e.fechaFinString = (e.fechaFinSt | date:'yyyy-MM-dd HH:mm:ss')"
      								placeholder="yyyy-MM-ddTHH:mm:ss" min="minDate" max="minDate" required />
    						</div>		
    								

						    </div>
						    
							
							<table class="table table-sm table-hover table-dark">
		                	
		                      <tbody>
		                          <tr  ng-repeat="jor in e.jornada | filter : test1" ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita);
							  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  " 
							  	data-toggle="modal" data-target="#exampleModalScrollable">
		                              <td><span class="text-right">{{e.nombreEquipo}}</span></td>
		                              <td><span ng-bind="jor.nombreEquipoLocal"></span></td>
		                              <td><img ng-src="{{jor.imgLocal}}" height="25"  class="rounded float-left" alt="..."></td>
		                              <td>{{jor.golesLocal}}</td>
		                              <td>-</td>
		                              <td>{{jor.golesVisita}}</td>
		                              <td><img ng-src="{{jor.imgVisita}}" height="25" class="rounded float-left" alt="..."></td>
		                              <td><span ng-bind="jor.nombreEquipoVisita"></span></td>
		                              <td>
			                              <button   
		                                  type="button" data-toggle="modal" data-target="#myModalJuego"  
		                                  ng-click="ctrl.juegoEdit = jor;
		                                   ctrl.equipos == null ? ctrl.buscarTodos() : ctrl.equipos = ctrl.equipos;
		                                   "
		                                  
		                                  class="btn btn-success btn-sm">Edit</button>
		                              </td>
		                             
		                          </tr>
		                      </tbody>
		    			</table>
							
<!-- 							<div class="list-group" > -->
<!-- 							  <span ng-repeat="jor in e.jornada"  class="list-group-item list-group-item-action"> -->
<!-- 							  	<div class="container"  -->
<!-- 							  	ng-click=" ctrl.findPlayersJornada(jor.idEquipoLocal,jor.idEquipoVisita); -->
<!-- 							  	ctrl.getJornada(e.idJornda,jor.id,jor.idEquipoLocal,jor.idEquipoVisita);  "  -->
<!-- 							  	data-toggle="modal" data-target="#exampleModalScrollable"> -->
<!-- 								  <div class="row text-center"> -->
<!-- 								    <div class="col "> -->
<!-- 								      {{jor.nombreEquipoLocal}} -->
<!-- 								    </div> -->
<!-- 								    <div class="col-sm-2"> -->
<!-- 								      {{jor.golesLocal}}-{{jor.golesVisita}} -->
<!-- 								    </div> -->
<!-- 								    <div class="col"> -->
<!-- 								      {{jor.nombreEquipoVisita}} -->
<!-- 								    </div> -->
<!-- 								  </div> -->
<!-- 								</div> -->
<!-- 							  </span> -->
							 
						
							
							
<!-- 							</div> -->
							</div>
						</div>
					
						
		    		</div> 
	    		</div>           
        	</div>                   
		</div>          
   	   </div>
   </body>
</html>