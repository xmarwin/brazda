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

NavController.$inject = ['AuthService', '$rootScope', '$scope', 'Notification'];

function NavController(authService, $rootScope, scope, notification) {
    var vm = this;

    vm.isAuthorized = authService.isAuthorized;
    vm.isAdmin = authService.isAdmin;
    vm.isOnline;

    $rootScope.$watch('online', function (newStatus) {
        vm.isOnline = newStatus;
    });

    scope.$on('oldCode', function () {
        notification.warning({ message: "POZOR! Organizátoři vydali novou verzi aplikace, prosím obnovte co nejdříve stránku ve vašem prohlížeči.", title:"Varování", delay: 20000 });
    });
};