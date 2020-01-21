
angular.module( 'App', [ 'dropdown-multiselect' ] )
.controller("MyController", function($scope){
    var options = [ {
          'Id': 1,
          'Name': 'Batman',
          'Costume': 'Black',
          'selected': true
      }, {
          'Id': 2,
          'Name': 'Superman',
          'Costume': 'Red & Blue'
      }, {
          'Id': 3,
          'Name': 'Hulk',
          'Costume': 'Green'
      }, {
          'Id': 4,
          'Name': 'Flash',
          'Costume': 'Red'
      }, {
          'Id': 5,
          'Name': 'Dare-Devil',
          'Costume': 'Maroon'
      }, {
          'Id': 6,
          'Name': 'Wonder-woman',
          'Costume': 'Red'
      }];
  
  $scope.config = {
      options: options,
      trackBy: 'Id',
      displayBy: [ 'Name', 'Costume' ],
      divider: ':',
      icon: 'glyphicon glyphicon-heart',
      displayBadge: true,
      height: '200px',
      filter: true,
      multiSelect: true,
      preSelectItem: true,
      preSelectAll: false
  };
});