'use strict';

angular.module("myApp.resultService", [])
    .service("ResultService", ResultService);

ResultService.$inject = ['WebApiService'];

function ResultService(webApiService) {
    var vm = this;

    vm.getResultsAdults = function () {
        return webApiService.get('result/list');
    };

    vm.getResultsKids = function () {
        return webApiService.get('result/list-kid');
    };

    vm.getResultsAll = function () {
        return webApiService.get('result/list-all');
    };
}