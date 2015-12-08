var app = angular.module('todoApp', []);

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
	$scope.handles = [
		{user: "venkatvb", check: true},
		{user: "vb", check: false},
		{user: "sunil", check: true}
	];
	$scope.addHandle = function (name) {
		$scope.handles.push({user: "roopesh", check: true});
	}
}]);

