'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute',
    'myApp.authService',
    'myApp.pravidla',
    'myApp.kontakt',
    'myApp.nav',
    'myApp.login',
    'myApp.version'
]).
    config(['$locationProvider', '$routeProvider', function ($locationProvider, $routeProvider) {
        $locationProvider.hashPrefix('!');

        $routeProvider.otherwise({ redirectTo: '/stanoviste' });
    }]);
