'use strict';

angular.module('myApp.raceService', [])
    .service('RaceService', RaceService)

RaceService.$inject = ['$interval', 'WebApiService', 'localStorageService', '$rootScope'];

function RaceService($interval, webApiService, localStorageService, $rootScope) {
    var vm = this;

    vm.setRaceDetails = function (data) {
        return webApiService.get('system/set', {
            "disqualificationTime": data.disqualificationTime,
            "helpPenalization": data.helpPenalization,
            "orderPenalization": data.orderPenalization,
            "raceDuration_COM": data.raceDuration_COM,
            "raceDuration_KID": data.raceDuration_KID,
            "raceStart_COM": data.raceStart_COM,
            "raceStart_KID": data.raceStart_KID,
            "timePenalization": data.timePenalization,
            "raceTitle": data.raceTitle,
            "hotlineTelephone": data.hotlineTelephone
        }, 'POST');
    }

    vm.startRace = function () {
        return webApiService.get('system/start');
    }

    vm.startRace_COM = function () {
        return webApiService.get('system/start?role=COM');
    }

    vm.startRace_KID = function () {
        return webApiService.get('system/start?role=KID');
    }
}