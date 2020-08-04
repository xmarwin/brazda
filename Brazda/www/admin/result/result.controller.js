'use strict';

angular.module('myApp.admin.result', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/results', {
                templateUrl: 'admin/result/result.html',
                controller: 'ResultCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('ResultCtrl', ResultController);

ResultController.$inject = ['Notification', 'ResultService'];

function ResultController(notification, resultService) {
    var vm = this;
    vm.teamType = "";
    vm.resultsAdults = [];
    vm.resultsKids = [];

    var init = function () {
        getResultsAdults();
        getResultsKids();
    };

    vm.changeTeamType = function () {
        logsLoaded = false;
        checkForData();
    };

    function getResultsAdults() {
        resultService.getResultsAdults()
            .then(function successCallback(response) {
                vm.resultsAdults = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    function getResultsKids() {
        resultService.getResultsKids()
            .then(function successCallback(response) {
                vm.resultsKids = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    init();
}
