var app = angular.module('todoApp', []);
app.controller('ListController', function ($scope, $http) {
	$http({ method: 'GET', url: 'http://localhost:3000/api/todos' }).
		success(function (data, status, headers, config) {
			$scope.data = data;
		}).
		error(function (data, status, headers, config) {
		}
	);
});