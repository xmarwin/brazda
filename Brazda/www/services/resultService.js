'use strict';

angular.module("myApp.resultService", [])
    .service("ResultService", ResultService);

ResultService.$inject = ['WebApiService'];

function ResultService(webApiService) {
    var vm = this;

    vm.getResultsAdults = function () {
        return webApiService.get('result/com');
    };

    vm.getResultsKids = function () {
        return webApiService.get('result/kid');
    };
}