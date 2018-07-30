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

RaceController.$inject = ['Notification', 'RaceService', '$filter'];

function RaceController(notification, raceService, $filter) {
    var vm = this;

    var init = function () {
        vm.raceDuration = 10;
    }

    vm.setRaceDuration = function () {
        var data = { "raceDuration": vm.raceDuration };

        raceService.setRaceDuration()
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
