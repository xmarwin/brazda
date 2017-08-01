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
        teamService.getTeams()
            .then(function successCallback(response) {
                vm.teams = response.data;
            }, function errorCallback(err) {
                alert(err);
            });
    }

    vm.deleteTeam = function (id) {
        ngDialog.openConfirm({
            template: 'admin/teams/deleteTeamConfirmation.html'
        }).then(function (data) {
            deleteTeamInt(id);
        }, function (err) {

        })
    }

    function deleteTeamInt(id) {
        teamService.deleteTeam(id)
            .then(function successCallback(response) {

            }, function errorCallback(err) {
                alert(err);
            });
    }

    init();
}
