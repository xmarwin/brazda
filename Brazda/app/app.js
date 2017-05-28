'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute',
    'LocalStorageModule',

    'myApp.authService',
    'myApp.teamService',
    'myApp.postService',

    'myApp.rules',
    'myApp.contact',
    'myApp.posts',
    'myApp.nav',
    'myApp.login',
    'myApp.version'
])
    .config(['$locationProvider', '$routeProvider', function ($locationProvider, $routeProvider) {
        $locationProvider.hashPrefix('!');

        $routeProvider.otherwise({ redirectTo: '/posts' });
    }])

    .config(function (localStorageServiceProvider) {
        localStorageServiceProvider
            .setPrefix('brazda')
            .setNotify(false, false)
    });
