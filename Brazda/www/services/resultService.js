'use strict';

angular.module("myApp.resultService", [])
    .service("ResultService", ResultService)

ResultService.$inject = ['WebApiService'];

function ResultService(webApiService) {
    var vm = this;

    vm.getResult = function () {
        return webApiService.get('result/list');
    }
}