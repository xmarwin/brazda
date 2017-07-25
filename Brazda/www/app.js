'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute',
    'LocalStorageModule',
    'ngSanitize',
    'ngAnimate',

    //3rd party
    'star-rating',
    'ui-notification',
    'ngQuill',
    'ngDialog',
    'angular-loading-bar',

    //interceptors
    'myApp.webApiInterceptor',

    //Services
    'myApp.webApiService',
    'myApp.authService',
    'myApp.teamService',
    'myApp.postService',
    'myApp.downloadService',

    //App
    'myApp.rules',
    'myApp.contact',
    'myApp.posts',
    'myApp.postDetail',
    'myApp.postLog',
    'myApp.bonusUnlock',

    //Admin
    'myApp.admin.teams',
    'myApp.admin.addTeam',
    'myApp.admin.editTeam',
    'myApp.admin.deleteTeam',

    'myApp.admin.posts',
    'myApp.admin.addPost',
    'myApp.admin.editPost',

    //Common
    'myApp.nav',
    'myApp.login',
    'myApp.version'
])
    .config(['$locationProvider', '$routeProvider', function ($locationProvider, $routeProvider) {
        $locationProvider.hashPrefix('');
        $routeProvider.otherwise({ redirectTo: 'posts' });
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
    })

    .config(['cfpLoadingBarProvider', function (cfpLoadingBarProvider) {
        cfpLoadingBarProvider.includeSpinner = false;
    }])

    .config(['$httpProvider', function ($httpProvider) {
        $httpProvider.interceptors.push('SessionInjector');
    }]);
