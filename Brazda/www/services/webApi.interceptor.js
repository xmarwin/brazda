'use strict';

angular.module('myApp.webApiInterceptor', [])
    .factory('SessionInjector', SessionInjector)

SessionInjector.$inject = ['localStorageService', '$q'];

function SessionInjector(localStorageService, $q) {
    var sessionInjector = {
        request: function (config) {
            debugger
            var team = localStorageService.get('brazdaTeam');
            if (!angular.isUndefined(team) && team != null) {
                if (config.url.indexOf('?') > -1) {
                    config.url += '&securityToken=' + team.securityToken;
                } else {
                    config.url += '?securityToken=' + team.securityToken;
                }
            }

            return config || $q.when(config);
        }
    };

    return sessionInjector;
}