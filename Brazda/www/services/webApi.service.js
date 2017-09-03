'use strict';

angular.module('myApp.webApiService', [])
    .service('WebApiService', WebApiService)

WebApiService.$inject = ['$http', '$q', '$rootScope'];

function WebApiService($http, $q, $rootScope) {
    var vm = this;
    vm.online;

    vm.get = function (endpointName, parameters, method) {
        var deferred = $q.defer();
        var data;
        var url;

        if (!vm.online) {
            var data = {}
            data.message = "Offline";
            deferred.reject(data)
        }

        if (angular.isUndefined(method)) {
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
            deferred.resolve(response);
        }, function errorCallback(err) {
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