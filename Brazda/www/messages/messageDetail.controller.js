'use strict';

angular.module('myApp.messageDetail', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/messageDetail/:messageId', {
                templateUrl: 'messages/messageDetail.html',
                controller: 'MessageDetailCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('MessageDetailCtrl', MessageDetailController);

MessageDetailController.$inject = ['$routeParams', 'MessageService'];

function MessageDetailController($routeParams, messageService) {
    var vm = this;
    vm.message = {};

    var init = function () {
        var messageId = $routeParams.messageId;
        vm.getMessage(messageId);
    }

    vm.getMessage = function (id) {
        messageService.getMessageById(id)
            .then(function successCallback(response) {
                vm.message = response.data[id - 1];
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    init();
}
