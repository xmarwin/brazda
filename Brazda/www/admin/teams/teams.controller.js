'use strict';

angular.module('myApp.admin.teams', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams', {
                templateUrl: 'admin/teams/teams.html',
                controller: 'TeamsCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('TeamsCtrl', TeamsController);

TeamsController.$inject = ['$routeParams', 'Notification', 'AuthService', 'TeamService', 'ngDialog'];

function TeamsController($routeParams, notification, authService, teamService, ngDialog) {
    var vm = this;

    var init = function () {
        getTeams();
    }

    vm.deleteTeam = function (id) {
        ngDialog.openConfirm({
            template: 'admin/teams/deleteTeamConfirmation.html'
        }).then(function (data) {
            deleteTeamInt(id);
        }, function (err) {

        })
    }

    function getTeams() {
        teamService.getTeams()
            .then(function successCallback(response) {
                vm.teams = response.data;
            }, function errorCallback(err) {
                alert(err);
            });
    }

    function deleteTeamInt(id) {
        teamService.deleteTeam(id)
            .then(function successCallback(response) {
                getTeams();
            }, function errorCallback(err) {
                alert(err);
            });
    }

    init();
}
