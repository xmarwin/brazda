'use strict';

angular.module('myApp.authService', [])
    .service('AuthService', AuthService)

AuthService.$inject = ['WebApiService', 'localStorageService', '$q', 'TrackingService'];

function AuthService(webApiService, localStorageService, $q, trackingService) {
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
        var deviceId = getDeviceId();

        webApiService.get('sign/in', [{ 'team': team.team }, { 'password': password }, { 'deviceId': deviceId }])
            .then(function (data) {
                if (data.data.status === 'error') {
                    deferred.reject({ 'status': 'Error', 'message': data.data.message });
                } else {
                    saveTeam(data.data);
                    trackingService.startTracking(deviceId);
                    deferred.resolve({ 'status': 'OK' });
                }
            },
            function (err) {
                if (err.status == 401) {
                    deferred.reject({ 'status': 'Error', 'message': 'Špatné heslo.' });
                } else {
                    deferred.reject({ 'status': 'Error', 'message': 'Nepodařilo se ověřit heslo. Obnovte stránku a zkuste to za chvilku znova.' });
                }
            });

        return deferred.promise;
    }

    function logout() {
        var deferred = $q.defer();
        var token = getTeam().securityToken;

        webApiService.get('sign/out')
            .then(function (data) {
                trackingService.stopTracking();
                removeTeam(data);
                deferred.resolve({ 'status': 'OK' });
            },
            function (err) {
                deferred.reject({ 'status': 'Error', 'message': 'Nepodařilo se odhlásit. Obnovte stránku a zkuste to za chvilku znova.' });
            });

        return deferred.promise;
    }

    function saveTeam(team) {
        return localStorageService.set('brazdaTeam', team);
    }

    function getTeam() {
        return localStorageService.get('brazdaTeam');
    }

    function removeTeam() {
        return localStorageService.remove('brazdaTeam');
    }

    function getDeviceId() {
        var deviceId = localStorageService.get('brazdaDeviceId');

        if (deviceId === null) {
            deviceId = createDeviceId();
        }

        return deviceId;
    }

    function createDeviceId() {
        var deviceId = new Date().getTime();

        localStorageService.set('brazdaDeviceId', deviceId);
        return deviceId;
    }
}