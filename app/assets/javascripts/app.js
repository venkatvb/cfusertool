var app = angular.module('todoApp', ['angularUtils.directives.dirPagination']);

app.controller('ListController', ["$scope", "$http", function($scope, $http) {
	$http({ method: 'GET', url: '/api/todos' }).
		success(function (data, status, headers, config) {
			$scope.data = data;
		}).
		error(function (data, status, headers, config) {
		}
	);
}]);

app.controller('SpojController', ["$scope", "$http", function($scope, $http) {
	$http({ method: 'GET', url: '/api/spoj/venkatvb' }).
		success(function (data, status, headers, config) {
			$scope.problems = data
		}).
		error(function (data, status, headers, config) {

		}
	);
	$scope.predicate = 'age';
  	$scope.reverse = true;
  	$scope.order = function(predicate) {
  		console.log("came here");
    	$scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;
    	$scope.predicate = predicate;
  	};
}]);

