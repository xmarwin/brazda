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

        teamService.getTeams()
            .then(function successCallback(response) {
                vm.team = $filter('filter')(response.data, { team: teamId }, true)[0];
            }, function errorCallback(err) {
                alert(err);
            });
    }

    vm.editTeam = function () {
        notification.success("Tým " + vm.team.name + " byl upraven.");
        $location.path("admin/teams");
    }

    init();
}
