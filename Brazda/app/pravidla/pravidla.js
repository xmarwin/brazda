'use strict';

angular.module('myApp.pravidla', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/pravidla', {
            templateUrl: 'pravidla/pravidla.html',
            controller: 'PravidlaCtrl'
        });
    }])

    .controller('PravidlaCtrl', [function () {

    }]);