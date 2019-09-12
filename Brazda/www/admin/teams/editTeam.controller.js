'use strict';

angular.module('myApp.admin.editTeam', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams/edit/:teamId', {
                templateUrl: 'admin/teams/editTeam.html',
                controller: 'EditTeamCtrl',
                controllerAs: 'ctrl'
            });
    }])
    .controller('EditTeamCtrl', EditTeamController);

EditTeamController.$inject = ['$routeParams', '$location', '$filter', 'Notification', 'AuthService', 'TeamService'];

function EditTeamController($routeParams, $location, $filter, notification, authService, teamService) {
    var vm = this;
    vm.team = {};

    var init = function () {
        var teamId = parseInt($routeParams.teamId);

        teamService.getTeam(teamId)
            .then(function successCallback(response) {
                vm.team = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    };

    vm.editTeam = function (team) {
        var input = {
            "team": vm.team.team,
            "name": vm.team.name,
            "shibboleth": vm.team.shibboleth,
            "role": vm.team.role,
            "isActive": vm.team.is_active,
            "allowTracking": vm.team.allow_tracking,
            "description": vm.team.description,
            "telephone": vm.team.telephone,
            "email": vm.team.email
        };

        teamService.updateTeam(input)
            .then(function (data) {
                $location.path("admin/teams");
                notification.success("Tým " + vm.team.name + " byl upraven.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}