'use strict';

angular.module('myApp.login', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/login', {
            templateUrl: 'login/login.html',
            controller: 'LoginCtrl'
        });
        $routeProvider.when('/logout', {
            templateUrl: 'login/logout.html',
            controller: 'LoginCtrl'
        });
    }])

    .controller('LoginCtrl', LoginController);

LoginController.$inject = ['$location', 'AuthService', 'TeamService'];

function LoginController($location, authService, teamService) {
    var vm = this;

    var init = function () {
        teamService.getTeams()
            .then(function successCallback(response) {
                vm.teams = response.data;
            }, function errorCallback(err) {
                alert(err);
            });
    }

    vm.login = function () {
        var team = vm.team;
        var password = vm.password;

        authService.login(team, password)
            .then(function (data) {
                if (data.status === 'OK') {
                    vm.showError = false;
                    $location.path('/posts');
                } else {
                    vm.showError = true;
                    vm.errorMessage = retval.message;
                }
            }, function (err) {

            });      
    }

    vm.logout = function () {
        authService.logout();
        $location.path('/login');
    }

    init();
}