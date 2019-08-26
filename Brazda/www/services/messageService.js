'use strict';

angular.module('myApp.messageService', [])
    .service('MessageService', MessageService);

MessageService.$inject = ['$interval', 'WebApiService', 'localStorageService', '$rootScope'];

function MessageService($interval, webApiService, localStorageService, $rootScope) {
    var vm = this;

    vm.createMessage = function (data) {
        return webApiService.get('message/create', data, 'POST');
    };

    vm.getAllMessages = function (data) {
        return webApiService.get('message/all', data, 'GET');
    };

    vm.getNewMessages = function (data) {
        return webApiService.get('message/new', data, 'GET');
    };

    vm.getMessageById = function (id) {
        return webApiService.get('message/show', [{ 'message': id }], 'GET');
    };
}