'use strict';

angular.module('myApp.webApiInterceptor2', [])
    .factory('ResponseObserver', ResponseObserver)

ResponseObserver.$inject = ['$q', '$window'];

function ResponseObserver($q, $window) {
    var responseObserver = {
        'responseError': function (errorResponse) {
            switch (errorResponse.status) {
                case 403:
                    $window.location = '#/login';
                    break;
                //case 500:
                //    $window.location = './500.html';
                //    break;
            }
            return $q.reject(errorResponse);
        }
    };

    return responseObserver;
}