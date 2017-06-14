'use strict';

angular.module('myApp.admin.editTeam', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams/edit/:teamId', {
                templateUrl: 'admin/teams/editTeam.html',
                controller: 'EditTeamCtrl'
            });
    }])

    .controller('EditTeamCtrl', EditTeamController);

EditTeamController.$inject = ['$routeParams', '$location', '$filter', 'Notification', 'AuthService', 'TeamService'];

function EditTeamController($routeParams, $location, $filter, notification, authService, teamService) {
    var vm = this;
    vm.team = {};

    var init = function () {
        var teams = teamService.getTeams();
        var teamId = parseInt($routeParams.teamId);
        vm.team = $filter('filter')(teams, { id: teamId }, true)[0];
    }

    vm.editTeam = function () {
        notification.success("Tým " + vm.team.name + " byl upraven.");
        $location.path("admin/teams");
    }

    init();
}
