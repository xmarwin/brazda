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
        vm.teams = teamService.getTeams();
    }

    vm.login = function () {
        var team = vm.team;
        var password = vm.password;

        var retval = authService.login(team, password);

        if (retval.status === 'OK') {
            vm.showError = false;
            $location.path('/posts');
        } else {
            vm.showError = true;
            vm.errorMessage = retval.message;
        }
    }

    vm.logout = function () {
        authService.logout();
        $location.path('/login');
    }

    init();
}