'use strict';

/* Controllers */

var phonecatApp = angular.module('phonecatApp', []);

phonecatApp.controller('PhoneListCtrl', ['$scope', '$http', function ($scope, $http) {
        $http.get('json/phones.json').success(function (data) {
            $scope.phones = data;
        });
        $scope.config = {
            itemsPerPage: 5,
            maxPages: 3,
            fillLastPage: true
        };
        $scope.list = $scope.phones;
        $scope.filteredItems = [];
        $scope.groupedItems = [];
        $scope.itemsPerPage = 5;
        $scope.pagedItems = [];
        $scope.currentPage = 0;
        $scope.orderProp = 'age';
    }]);