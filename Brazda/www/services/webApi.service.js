'use strict';

angular.module('myApp.webApiService', [])
    .service('WebApiService', WebApiService)

WebApiService.$inject = ['$http', '$q', '$rootScope', '$log'];

function WebApiService($http, $q, $rootScope, $log) {
    var vm = this;
    vm.online;

    vm.get = function (endpointName, parameters, method, showLoader) {
        var deferred = $q.defer();
        var data;
        var url;

        showLoader = showLoader && true;

        if (!vm.online) {
            var data = {}
            data.message = "Offline";
            deferred.reject(data)
        }

        if (showLoader) {
            $rootScope.$broadcast('app-start-loading');
        }

        //$log.log('broadcasting app-start-loading');

        if (angular.isUndefined(method) || method === '') {
            method = 'GET';
        }

        if (method === 'POST') {
            data = JSON.stringify(parameters);
            url = buildUrl(endpointName, [])
        } else {
            url = buildUrl(endpointName, parameters);
        }

        $http({
            method: method,
            url: url,
            data: data
        }).then(function successCallback(response) {
            if (showLoader) {
                $rootScope.$broadcast('app-finish-loading');
            }
            //$log.log('broadcasting app-finish-loading');
            deferred.resolve(response);
        }, function errorCallback(err) {
            if (showLoader) {
                $rootScope.$broadcast('app-finish-loading');
            }
            //$log.log('broadcasting app-finish-loading');
            deferred.reject(err);
        });

        return deferred.promise;
    }

    vm.isOnline = function () {
        return vm.online;
    }

    $rootScope.$watch('online', function (newStatus) {
        vm.online = newStatus;
    });

    function buildUrl(endpointName, parametersArray) {
        var parameters = '';

        if (!angular.isUndefined(parametersArray) && parametersArray.length > 0) {
            parameters = '?';

            for (var i = 0; i < parametersArray.length; i++) {
                for (var key in parametersArray[i]) {
                    parameters += key + '=' + parametersArray[i][key] + '&';
                }
            }
        }

        if (parameters.endsWith('&')) {
            parameters = parameters.substr(0, parameters.length - 1);
        }

        return '/api/' + endpointName + parameters;
    }
}