'use strict';

var app = angular.module('myApp', ["ngTable"]);

app.controller('MainCtrl', function($scope, NgTableParams) {
  $scope.name = 'World';

  var data = [{name: "Moroni", age: 50},
              {name: "Tiancum", age: 43},
              {name: "Jacob", age: 27},
              {name: "Nephi", age: 29},
              {name: "Enos", age: 34},
              {name: "Tiancum", age: 43},
              {name: "Jacob", age: 27},
              {name: "Nephi", age: 29},
              {name: "Enos", age: 34},
              {name: "Tiancum", age: 43},
              {name: "Jacob", age: 27},
              {name: "Nephi", age: 29},
              {name: "Enos", age: 34},
              {name: "Tiancum", age: 43},
              {name: "Jacob", age: 27},
              {name: "Nephi", age: 29},
              {name: "Enos", age: 34}];


  $scope.tableParams = new NgTableParams({}, { dataset: data});  
  


});