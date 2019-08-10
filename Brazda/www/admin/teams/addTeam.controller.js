'use strict';

angular.module('myApp.admin.addTeam', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/teams/add', {
                templateUrl: 'admin/teams/addTeam.html',
                controller: 'AddTeamCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('AddTeamCtrl', AddTeamController);

AddTeamController.$inject = ['$routeParams', '$location', 'Notification', 'AuthService', 'TeamService'];

function AddTeamController($routeParams, $location, notification, authService, teamService) {
    var vm = this;
    vm.team = {};

    var init = function () {

    };

    vm.addTeam = function (team) {
        var input = {
            "name": vm.team.name,
            "shibboleth": vm.team.shibboleth,
            "role": vm.team.role,
            "isActive": vm.team.active,
            "allowTracking": vm.team.allowTracking,
            "description": vm.team.description,
            "telephone": vm.team.phone,
            "email": vm.team.email
        };

        teamService.addTeam(input)
            .then(function (data) {
                $location.path("admin/teams");
                notification.success("Tým " + vm.team.name + " byl upraven.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}
