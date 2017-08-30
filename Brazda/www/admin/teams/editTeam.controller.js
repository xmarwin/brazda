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
                alert(err);
            });
    }

    vm.editTeam = function (team) {
        var input = {
            "team": vm.team.team,
            "name": vm.team.name,
            "shibboleth": vm.team.shibboleth,
            "role": "COM", //vm.team.type,
            "isActive": vm.team.active,
            "allowTracking": vm.team.allowTracking,
            "description": vm.team.description,
            "telephone": vm.team.phone
        }

        teamService.updateTeam(input)
            .then(function (data) {
                $location.path("admin/teams");
                notification.success("Tým " + vm.team.name + " byl upraven.");
            }, function (err) {
                notification.error(err);
            });
    }

    init();
}