'use strict';
 
angular.module('myApp')
.controller('CargaJugadoresController', ['$scope','$routeParams','CONFIG', 'CargarJugadorService', 
	function($scope, $routeParams,CONFIG,CargarJugadorService) {
	var self = this;
	
	$scope.data = [];
	
	self.result = null;
	
	self.datos = null;
	
	
	self.read                   = read;
	self.add                   = add;
	self.confirmar                   = confirmar;
	

	function read(datos){
		console.log(datos)
	}
	
	function confirmar(datos){
		CargarJugadorService.confirmarJugadores(datos)
            .then(
            function(d) {
                self.result = d;
                console.log("[cargarJugadores_controller] confirmar]:",self.result)
            },
            function(errResponse){
                console.error('[cargarJugadores_controller] Error while  confirmar');
            }
        );
    }
	
	
	 var clearAlerts = function() {
	      $scope.error = {}, $scope.warning = null
	    };
	      
	    $scope.download = function(){
	      var a = document.createElement("a");
	      var json_pre = '[{"Reference":"1","First_name":"Lauri","Last_name":"Amerman","Dob":"1980","Sex":"F"},{"Reference":"2","First_name":"Rebbecca","Last_name":"Bellon","Dob":"1977","Sex":"F"},{"Reference":"3","First_name":"Stanley","Last_name":"Benton","Dob":"1984","Sex":"M"}]'
	     
	      var csv = Papa.unparse(json_pre);
	 
	      if (window.navigator.msSaveOrOpenBlob) {
	        var blob = new Blob([decodeURIComponent(encodeURI(csv))], {
	          type: "text/csv;charset=utf-8;"
	        });
	        navigator.msSaveBlob(blob, 'sample.csv');
	      } else {
	 
	        a.href = 'data:attachment/csv;charset=utf-8,' + encodeURI(csv);
	        a.target = '_blank';
	        a.download = 'sample.csv';
	        document.body.appendChild(a);
	        a.click();
	      }
	    }

	
	
	    // Upload and read CSV function
	    $scope.submitForm = function(form) {
	        clearAlerts();
	        var filename = document.getElementById("bulkDirectFile");
	        if (filename.value.length < 1 ){
	            ($scope.warning = "Please upload a file");
	        } else {
	            $scope.title = "Confirm file";
	            var file = filename.files[0];
	            console.log(file)
	            var fileSize = 0;
	            if (filename.files[0]) {
	                 
	                var reader = new FileReader();
	                reader.onload = function (e) {
	                    var table = $("<table />").css('width','100%');
	                    
	                    var rows = e.target.result.split("\n");
	                    for (var i = 0; i < rows.length; i++) {
	                        var row = $("<tr  />");
	                        var cells = rows[i].split(",");
	                        for (var j = 0; j < cells.length; j++) {
	                            var cell = $("<td />").css('border','1px solid black');
	                            cell.html(cells[j]);
	                            row.append(cell);
	                        }
	                        table.append(row);
	                    }
	                    $("#dvCSV").html('');
	                    $("#dvCSV").append(table);
	                }
	                
	                reader.readAsText(filename.files[0]);
	            
	            }
	            return false;
	        }
	    }
	    
	    //   Convert to JSON function
	   function add (){
	        var Table = document.getElementById('Table');
	        var file = document.getElementById("bulkDirectFile").files[0];
	        $('.loading').show();
	        var allResults = [];
	        
	        Papa.parse(file, {
	            download: true,
	            header: true,
	            skipEmptyLines: true,
	            error: function(err, file, inputElem, reason) { },
	            complete: function(results) {
	                allResults.push(results.data);
	                $scope.data = results.data;
	                
	                console.log($scope.data);
	    	        self.datos= $scope.data;
	                
	                
	            }
	          });  
	        
	        console.log("Termina......"+allResults.length);
	        
	        }
	      

     
	
}]);