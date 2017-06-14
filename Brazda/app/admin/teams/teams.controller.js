'use strict';

angular.module('myApp.admin.teams', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams', {
                templateUrl: 'admin/teams/teams.html',
                controller: 'TeamsCtrl'
            });
    }])

    .controller('TeamsCtrl', TeamsController);

TeamsController.$inject = ['$routeParams', 'Notification', 'AuthService', 'TeamService'];

function TeamsController($routeParams, notification, authService, teamService) {
    var vm = this;

    var init = function () {
        vm.teams = teamService.getTeams();
    }

    init();
}
