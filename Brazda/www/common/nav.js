'use strict';

angular.module('myApp.nav', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/nav', {
            templateUrl: 'nav/nav.html',
            controller: 'NavCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('NavCtrl', NavController);

NavController.$inject = ['AuthService', '$rootScope'];

function NavController(authService, $rootScope) {
    var vm = this;

    vm.isAuthorized = authService.isAuthorized;
    vm.isAdmin = authService.isAdmin;
    vm.isOnline;

    $rootScope.$watch('online', function (newStatus) {
        vm.isOnline = newStatus;
    });
};