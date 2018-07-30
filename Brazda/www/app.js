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
    'geolocation',

    //interceptors
    'myApp.webApiInterceptor',
    'myApp.webApiInterceptor2',

    //Services
    'myApp.webApiService',
    'myApp.authService',
    'myApp.teamService',
    'myApp.postService',
    'myApp.downloadService',
    'myApp.trackingService',
    'myApp.resultService',
    'myApp.systemService',
    'myApp.raceService',
    'myApp.messageService',

    // directives
    'myApp.waitDirective',

    //App
    'myApp.rules',
    'myApp.map',
    'myApp.contact',
    'myApp.bonuses',
    'myApp.posts',
    'myApp.postDetail',
    'myApp.postNote',
    'myApp.postLog',
    'myApp.bonusUnlock',

    //Admin
    'myApp.admin.teams',
    'myApp.admin.addTeam',
    'myApp.admin.editTeam',

    'myApp.admin.posts',
    'myApp.admin.addPost',
    'myApp.admin.editPost',

    'myApp.admin.race',

    'myApp.admin.messages',
    'myApp.admin.addMessage',

    'myApp.admin.result',

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
    }])

    .config(function ($httpProvider) {
        $httpProvider.interceptors.push('ResponseObserver');
    })

    .run(['TrackingService', 'SystemService', function (trackingService, systemService) {
        trackingService.startTracking();
        systemService.start();
    }])

    .run(function ($window, $rootScope) {
        $rootScope.online = navigator.onLine;
        $window.addEventListener("offline", function () {
            $rootScope.$apply(function () {
                $rootScope.online = false;
            });
        }, false);

        $window.addEventListener("online", function () {
            $rootScope.$apply(function () {
                $rootScope.online = true;
            });
        }, false);
    });