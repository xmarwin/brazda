'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute',
    'LocalStorageModule',

    //3rd party
    'star-rating',
    'ui-notification',

    //Services
    'myApp.authService',
    'myApp.teamService',
    'myApp.postService',

    //App
    'myApp.rules',
    'myApp.contact',
    'myApp.posts',
    'myApp.postDetail',

    //Admin
    'myApp.admin.teams',
    'myApp.admin.addTeam',
    'myApp.admin.editTeam',
    'myApp.admin.deleteTeam',

    //Common
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
    })

    .config(function (NotificationProvider) {
        NotificationProvider.setOptions({
            delay: 3000,
            startTop: 20,
            startRight: 10,
            verticalSpacing: 20,
            horizontalSpacing: 20,
            positionX: 'right',
            positionY: 'bottom'
        });
    });
