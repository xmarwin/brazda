'use strict';

angular.module('myApp.raceService', [])
    .service('RaceService', RaceService)

RaceService.$inject = ['$interval', 'WebApiService', 'localStorageService', '$rootScope'];

function RaceService($interval, webApiService, localStorageService, $rootScope) {
    var vm = this;

    vm.setRaceDuration = function (data) {
        return webApiService.get('system/set', data, 'POST');
    }

    vm.startRace = function () {
        return webApiService.get('system/start', '{}', 'POST');
    }
}