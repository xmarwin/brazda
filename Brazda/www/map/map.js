'use strict';

angular.module('myApp.map', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/map', {
            templateUrl: 'map/map.html',
            controller: 'MapCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('MapCtrl', [function () {

    }]);