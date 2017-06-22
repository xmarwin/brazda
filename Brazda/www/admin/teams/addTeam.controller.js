'use strict';

angular.module('myApp.admin.addTeam', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams/add', {
                templateUrl: 'admin/teams/addTeam.html',
                controller: 'AddTeamCtrl'
            });
    }])

    .controller('AddTeamCtrl', AddTeamController);

AddTeamController.$inject = ['$routeParams', '$location', 'Notification', 'AuthService', 'TeamService'];

function AddTeamController($routeParams, $location, notification, authService, teamService) {
    var vm = this;
    vm.team = {};

    var init = function () {

    }

    vm.addTeam = function (team) {
        notification.success("Tým " + vm.team.name + " byl přidán.");
        $location.path("admin/teams");
    }

    init();
}
