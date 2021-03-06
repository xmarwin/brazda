'use strict';

angular.module('myApp.login', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/login', {
            templateUrl: 'login/login.html',
            controller: 'LoginCtrl',
            controllerAs: 'ctrl'
        });
        $routeProvider.when('/logout', {
            templateUrl: 'login/logout.html',
            controller: 'LoginCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('LoginCtrl', LoginController);

LoginController.$inject = ['$location', 'AuthService', 'TeamService', 'Notification'];

function LoginController($location, authService, teamService, notification) {
    var vm = this;
    //vm.password = 'Mocn8Klika'; //TODO: pred zavodem odstranit

    var init = function () {
        teamService.getTeamsLight()
            .then(function successCallback(response) {
                vm.teams = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
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
                    notification.error(retval.message);
                }
            }, function (err) {
                notification.error(err.message);
            });      
    }

    vm.logout = function () {
        authService.logout()
            .then(function (data) {
                $location.path('/login');
            }, function (err) {
                notification.error(err.message);
            });        
    }

    init();
}