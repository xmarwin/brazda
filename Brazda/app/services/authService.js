'use strict';

var module = angular.module('myApp.authService', []);

module.service('AuthService', function () {
    var vm = this;
    var isLoggedIn = false;

    vm.isLoggedIn = function () {
        return isLoggedIn;
    }

    vm.login = function (username, password) {
        if (username === 1 && password === 'a') {
            isLoggedIn = true;
            return { 'status': 'OK' }
        } else {
            return { 'status': 'Error', 'message': 'Nesprávné heslo' }
        }
    }

    vm.logout = function () {
        isLoggedIn = false;
    }

    return {
        isLoggedIn: vm.isLoggedIn,
        login: vm.login,
        logout: vm.logout
    }
});