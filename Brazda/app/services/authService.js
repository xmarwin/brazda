'use strict';

angular.module('myApp.authService', [])
            .service('AuthService', AuthService)

//AuthService.$inject = ['LocalStorageModule'];

function AuthService(localStorageService) {
    var vm = this;

    return {
        isAuthorized: isAuthorized,
        isAdmin : isAdmin,
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
            return getTeam().team_type === 'ORG';
        } else {
            return false;
        }
    }

    function login(team, password) {
        if (team.id === 1 && password === 'a') {
            saveTeam(team);
            return { 'status': 'OK' }
        } else {
            return { 'status': 'Error', 'message': 'Nesprávné heslo' }
        }
    }

    function logout() {
        removeTeam();
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