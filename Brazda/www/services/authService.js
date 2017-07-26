'use strict';

angular.module('myApp.authService', [])
    .service('AuthService', AuthService)

AuthService.$inject = ['WebApiService', 'localStorageService', '$q'];

function AuthService(webApiService, localStorageService, $q) {
    var vm = this;

    return {
        isAuthorized: isAuthorized,
        isAdmin: isAdmin,
        login: login,
        logout: logout,
        team: getTeam()
    }

    //////////////////////////////////

    function isAuthorized() {
        return getTeam() !== null;
    }

    function isAdmin() {
        if (isAuthorized()) {
            return getTeam().role === 'ORG';
        } else {
            return false;
        }
    }

    function login(team, password) {
        var deferred = $q.defer();

        webApiService.get('/api/sign/in?team=' + team.name + '&password=' + password + '&deviceId=')
            .then(function (data) {
                saveTeam(data.data);
                deferred.resolve({ 'status': 'OK' });
            },
            function (err) {
                if (err.status == 401) {
                    deferred.reject({ 'status': 'Error', 'message': 'Špatné heslo.' });
                } else {
                    deferred.reject({ 'status': 'Error', 'message': 'Nepodařilo se ověřit heslo, zkuste to za chvilku znova.' });
                }
            });

        return deferred.promise;
    }

    function logout() {
        var deferred = $q.defer();
        var token = getTeam().securityToken;

        webApiService.get('/api/sign/out?securityToken=' + token)
            .then(function (data) {
                removeTeam(data);
                deferred.resolve({ 'status': 'OK' });
            },
            function (err) {
                deferred.reject({ 'status': 'Error', 'message': 'Nepodařilo se ověřit heslo, zkuste to za chvilku znova.' });
            });

        return deferred.promise;
    }

    function saveTeam(team) {
        return localStorageService.set('team', team);
    }

    function getTeam() {
        return localStorageService.get('team');
    }

    function removeTeam() {
        return localStorageService.remove('team');
    }
}