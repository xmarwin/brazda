'use strict';

angular.module('myApp.messages', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/messages', {
                templateUrl: 'messages/messages.html',
                controller: 'MessagesCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('MessagesCtrl', MessagesController);

MessagesController.$inject = ['$routeParams', 'MessageService', '$location'];

function MessagesController($routeParams, messageService, $location) {
    var vm = this;

    var init = function () {
        getMessages();
    }

    var getMessages = function () {
        messageService.getAllMessages()
            .then(function successCallback(response) {
                vm.messages = response.data;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    vm.showMessage = function (id) {
        $location.path("/messageDetail/" + id);
    };

    init();
}
