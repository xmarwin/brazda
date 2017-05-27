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

LoginController.$inject = ['AuthService'];

function LoginController(authService) {
    var vm = this;

    vm.login = function () {
        var name = vm.name;
        var password = vm.password;

        authService.login(name, password);
    }

    vm.logout = function () {
        authService.logout();
    }
}