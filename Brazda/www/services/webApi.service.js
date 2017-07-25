'use strict';

angular.module('myApp.webApiService', [])
    .service('WebApiService', WebApiService)

WebApiService.$inject = ['$http', '$q'];

function WebApiService($http, $q) {
    var vm = this;

    vm.get = function (url) {
        var deferred = $q.defer();

        $http({
            method: 'GET',
            url: url
        }).then(function successCallback(response) {
            deferred.resolve(response);
        }, function errorCallback(err) {
            deferred.reject(err);
        });

        return deferred.promise;
    }
}