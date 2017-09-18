'use strict';

angular.module('myApp.bonuses', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/bonuses', {
            templateUrl: 'bonuses/bonuses.html',
            controller: 'BonusesCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('BonusesCtrl', BonusesController);

BonusesController.$inject = ['PostService', 'Notification'];

function BonusesController(postService, notification) {
    var vm = this;
    vm.bonuses = {};

    vm.init = function () {
        loadBonuses();
    }

    var loadBonuses = function () {
        postService.getBonuses()
            .then(function successCallback(response) {
                vm.bonuses = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    vm.init();
}