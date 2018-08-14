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
            .then(function (data) {
                vm.raceDuration = data.data.raceDuration;
            }, function (err) {
                notification.error(err.data.message);
            });
    }

    vm.setRaceDuration = function () {
        raceService.setRaceDuration(vm.raceDuration)
            .then(function (data) {
                notification.success("Nastavení uloženo.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.startRace = function () {
        raceService.startRace()
            .then(function (data) {
                notification.success("Závod zahájen.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}
