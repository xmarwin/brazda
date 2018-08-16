'use strict';

angular.module('myApp.admin.addMessage', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/messages/add', {
                templateUrl: 'admin/messages/addMessage.html',
                controller: 'AddMessageCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('AddMessageCtrl', AddMessageController);

AddMessageController.$inject = ['$routeParams', 'Notification', 'AuthService', 'MessageService', '$filter', '$location'];

function AddMessageController($routeParams, notification, authService, messageService, $filter, $location) {
    var vm = this;
    vm.content = "";

    var init = function () {

    }

    vm.addMessage = function (message) {
        var input = { "message": vm.content };

        messageService.createMessage(input)
            .then(function (data) {
                $location.path("admin/messages");
                notification.success("Zpráva byla odeslána všem týmům.");
            }, function (err) {
                notification.error(err.data.message);
            });
    }

    init();
}
