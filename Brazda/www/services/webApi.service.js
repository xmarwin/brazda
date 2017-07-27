'use strict';

angular.module('myApp.webApiService', [])
    .service('WebApiService', WebApiService)

WebApiService.$inject = ['$http', '$q'];

function WebApiService($http, $q) {
    var vm = this;

    vm.get = function (endpointName, parameters, method) {
        var deferred = $q.defer();

        if (angular.isUndefined(method)) {
            method = 'GET';
        }

        var url = buildUrl(endpointName, parameters)

        $http({
            method: method,
            url: url
        }).then(function successCallback(response) {
            deferred.resolve(response);
        }, function errorCallback(err) {
            deferred.reject(err);
        });

        return deferred.promise;
    }

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

        return 'http://brazda/api/' + endpointName + parameters;
    }
}