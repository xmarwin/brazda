'use strict';

angular.module('myApp.systemService', [])
    .service('SystemService', SystemService)

SystemService.$inject = ['$interval', 'WebApiService', 'localStorageService', '$rootScope', 'AuthService'];

function SystemService($interval, webApiService, localStorageService, $rootScope, authService) {
    var vm = this;

    vm.start = function () {
        setTimeout(function () {
            if (authService.isAuthorized()) {
                vm.getSystemInfo().then(function (response) {
                    var version = response.data.version;

                    if (version && version !== '') {
                        saveSourceVersion(version);
                    }
                });
            } else {
                vm.getVersionInfo().then(function (response) {
                    var version = response.data.version;

                    if (version && version !== '') {
                        saveSourceVersion(version);
                    }
                });
            }

            vm.checkValidSource();
            vm.instance = $interval(vm.checkValidSource, 1000 * 60 * 3);
            //vm.instance = $interval(vm.checkValidSource, 1000 * 10);
        }, 100);
    };

    vm.getSystemInfo = function () {
        return webApiService.get('system', '', '', false);
    };

    vm.getVersionInfo = function () {
        return webApiService.get('version', '', '', false);
    };

    vm.checkValidSource = function () {
        if (authService.isAuthorized()) {
            vm.getSystemInfo().then(function (response) {
                var version = response.data.version;

                if (version && version !== '' && getSourceVersion() !== version) {
                    $rootScope.$broadcast('oldCode');
                }

                var newMessagesNumber = response.data.newMessages;
                //if (newMessagesNumber > 0) {
                $rootScope.$broadcast('messageUpdate', newMessagesNumber);
                //}
            });
        } else {
            vm.getVersionInfo().then(function (response) {
                var version = response.data.version;

                if (version && version !== '') {
                    saveSourceVersion(version);
                }
            });
        }
    };

    function saveSourceVersion(sourceVersion) {
        return localStorageService.set('sourceVersion', sourceVersion);
    }

    function getSourceVersion() {
        return localStorageService.get('sourceVersion');
    }

    function removeSourceVersion() {
        return localStorageService.remove('sourceVersion');
    }
}