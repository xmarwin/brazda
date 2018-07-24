'use strict';

angular.module('myApp.systemService', [])
    .service('SystemService', SystemService)

SystemService.$inject = ['$interval', 'WebApiService', 'localStorageService', '$rootScope'];

function SystemService($interval, webApiService, localStorageService, $rootScope) {
    var vm = this;

    vm.start = function () {
        setTimeout(function () {
            vm.getSystemInfo().then(function (response) {
                var version = response.data.version;

                if (version && version !== '') {
                    saveSourceVersion(version);
                }
            });

            vm.checkValidSource();
            vm.instance = $interval(vm.checkValidSource, 1000 * 60 * 15);
        }, 100);
    }

    vm.getSystemInfo = function () {
        return webApiService.get('system', '', '', false);
    }

    vm.checkValidSource = function () {
        vm.getSystemInfo().then(function (response) {
            var version = response.data.version;

            if (version && version !== '' && getSourceVersion() !== version) {
                $rootScope.$broadcast('oldCode');
            }
        });
    }

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