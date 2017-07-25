'use strict';

angular.module("myApp.teamService", [])
    .service("TeamService", TeamService)

TeamService.$inject = ['WebApiService'];

function TeamService(webApiService) {
    var vm = this;

    vm.getTeams = function () {
        return webApiService.get('http://brazda/api/sign/teams-list');
    }
}