'use strict';

angular.module('myApp.webApiInterceptor', [])
    .factory('SessionInjector', SessionInjector)

SessionInjector.$inject = ['localStorageService'];

function SessionInjector(localStorageService) {
    var sessionInjector = {
        request: function (config) {
            var team = localStorageService.get('team');
            if (!angular.isUndefined(team)) {
                if (config.url.indexOf('?') > -1) {
                    config.url += '&securityToken=' + team.securityToken;
                } else {
                    config.url += '?securityToken=' + team.securityToken;
                }
            }
            return config;
        }
    };

    return sessionInjector;
}