'use strict';

angular.module('myApp.admin.deleteTeam', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams/delete/:teamId', {
                templateUrl: 'admin/teams/deleteTeam.html',
                controller: 'DeleteTeamCtrl'
            });
    }])

    .controller('DeleteTeamCtrl', DeleteTeamController);

DeleteTeamController.$inject = ['$routeParams', '$location', '$filter', 'Notification', 'AuthService', 'TeamService'];

function DeleteTeamController($routeParams, $location, $filter, notification, authService, teamService) {
    var vm = this;

    var init = function () {
        var teams = teamService.getTeams();
        var teamId = parseInt($routeParams.teamId);
        vm.team = $filter('filter')(teams, { id: teamId }, true)[0];
    }

    vm.deleteTeam = function () {
        notification.success("Tým " + vm.team.name + " byl odstraněn.");
        $location.path("admin/teams");
    }

    vm.cancel = function () {
        $location.path("admin/teams");
    }

    init();
}
