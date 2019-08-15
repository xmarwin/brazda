'use strict';

angular.module('myApp.admin.messages', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/messages', {
                templateUrl: 'admin/messages/messagesAdmin.html',
                controller: 'MessagesAdminCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('MessagesAdminCtrl', MessagesAdminController);

MessagesAdminController.$inject = ['$routeParams', 'Notification', 'AuthService', 'MessageService', 'ngDialog'];

function MessagesAdminController($routeParams, notification, authService, messageService, ngDialog) {
    var vm = this;

    var init = function () {
        getMessages();
    }

    var getMessages = function () {
        messageService.getAllMessages()
            .then(function successCallback(response) {
                vm.messages = response.data;

                for (let i = 0; i < vm.messages.length; i++) {
                    vm.messages[i].moment = new Date(vm.messages[i].moment.date);
                }
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    init();
}
