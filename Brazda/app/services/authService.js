'use strict';

var module = angular.module('myApp.authService', []);

module.service('AuthService', function () {
    var vm = this;
    var isLoggedIn = false;

    vm.isLoggedIn = function () {
        return isLoggedIn;
    }

    vm.login = function(username, password) {
        isLoggedIn = true;
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