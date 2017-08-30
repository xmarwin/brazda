'use strict';

angular.module("myApp.teamService", [])
    .service("TeamService", TeamService)

TeamService.$inject = ['WebApiService'];

function TeamService(webApiService) {
    var vm = this;

    vm.getTeamsLight = function () {
        return webApiService.get('sign/teams-list');
    }

    vm.getTeamsFull = function (teamId) {
        return webApiService.get('team/list');
    }

    vm.getTeam = function (teamId) {
        return webApiService.get('team/detail', [{ 'team': teamId }]);
    }


//    http://brazda/api/team/create?securityToken=...
//      {
//        "name": "Název týmu",
//        "shibboleth": "Heslo pro přihlášení",
//        "team_type": "COM",
//        "is_active": true,
//        "allow_tracking": true,
//        "description": "Popis týmu", // nepovinná položka
//        "telephone": "+420 123 456 789", // nepovinná položka
//      }
    vm.addTeam = function (data) {
        return webApiService.get('team/create', data, 'POST');
    }

    vm.updateTeam = function (data) {
        return webApiService.get('team/update', data, 'POST');
    }

    vm.deleteTeam = function (teamId) {
        return webApiService.get('team/delete', [{ 'team': teamId }]);
    }
}