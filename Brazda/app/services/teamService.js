'use strict';

var module = angular.module('myApp.teamService', []);

module.service('TeamService', function () {
    var vm = this;

    vm.getTeams = function () {
        return [{ id: 1, team_type: 'ORG', name: 'BRAZDA', description: 'Organizační tým' },
            { id: 2, team_type: 'COM', name: 'Přes mrtvoly', description: '' },
            { id: 3, team_type: 'COM', name: 'Tři chlapi', description: '' },
            { id: 4, team_type: 'COM', name: 'Perun s náma', description: '' },
            { id: 5, team_type: 'COM', name: 'Ušaté myši', description: '' },
            { id: 6, team_type: 'COM', name: 'BO!!!', description: '' },
            { id: 7, team_type: 'COM', name: 'Ptakopysk', description: '' },
            { id: 8, team_type: 'COM', name: 'KaNaVo', description: '' },
            { id: 9, team_type: 'COM', name: 'Fantastické čtyřkY', description: '' },
            { id: 10, team_type: 'COM', name: 'Radegastova rota', description: '' },
            { id: 11, team_type: 'COM', name: 'Geokvočny', description: '' },
            { id: 12, team_type: 'COM', name: 'Hanáci', description: '' },
            { id: 13, team_type: 'COM', name: 'Čuňoši', description: '' }]
    }
});