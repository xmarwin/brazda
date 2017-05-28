'use strict';

angular.module('myApp.authService', [])
            .service('AuthService', AuthService)

//AuthService.$inject = ['LocalStorageModule'];

function AuthService(localStorageService) {
    var vm = this;

    return {
        isAuthorized: isAuthorized,
        login: login,
        logout: logout,
        team: getTeam()
    }

    //////////////////////////////////
   
    function isAuthorized() {
        return getTeam() !== null;
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
        //return { "id": 1, "team_type": "ORG", "name": "BRAZDA", "description": "Organizační tým" };
        return localStorageService.get('team');
    }

    function removeTeam() {
        return localStorageService.remove('team');
    }
}