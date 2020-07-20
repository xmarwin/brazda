'use strict';

angular.module('myApp.admin.race', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/race', {
                templateUrl: 'admin/race/race.html',
                controller: 'RaceCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('RaceCtrl', RaceController);

RaceController.$inject = ['Notification', 'RaceService', '$filter', 'SystemService'];

function RaceController(notification, raceService, $filter, systemService) {
    var vm = this;

    var init = function () {
        systemService.getSystemInfo()
            .then(function (response) {
                vm.details = response.data;
            }, function (err) {
                notification.error(err.data.message);
            });
    }

    vm.setRaceDetails = function () {
        raceService.setRaceDetails(vm.details)
            .then(function (response) {
                notification.success("Nastavení uloženo.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.startRace = function () {
        raceService.startRace()
            .then(function (data) {
                notification.success("Závod zahájen pro obě kategorie.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.startRace_COM = function () {
        raceService.startRace_COM()
            .then(function (data) {
                notification.success("Dospělácká kategorie zahájena.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.startRace_KID = function () {
        raceService.startRace_KID()
            .then(function (data) {
                notification.success("Dětská kategorie zahájena.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}
