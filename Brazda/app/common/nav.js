'use strict';

angular.module('myApp.nav', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/nav', {
            templateUrl: 'nav/nav.html',
            controller: 'NavCtrl'
        });
    }])

    .controller('NavCtrl', NavController);

NavController.$inject = ['AuthService'];

function NavController(authService) {
    var vm = this;

    vm.isAuthorized = authService.isAuthorized;
    vm.isAdmin = authService.isAdmin;
};