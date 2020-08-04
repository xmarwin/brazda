'use strict';

angular.module('myApp.admin.posts', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts', {
                templateUrl: 'admin/posts/postsAdmin.html',
                controller: 'PostsAdminCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('PostsAdminCtrl', PostsAdminController);

PostsAdminController.$inject = ['$routeParams', 'Notification', 'AuthService', 'PostService', 'ngDialog'];

function PostsAdminController($routeParams, notification, authService, postService, ngDialog) {
    var vm = this;
    vm.securityToken;

    vm.deletePost = function (id) {
        ngDialog.openConfirm({
            template: 'admin/posts/deletePostConfirmation.html'
        }).then(function (data) {
            deletePostInt(id);
        }, function (err) {
            notification.error(err.data.message);
        });
    };

    var init = function () {
        getPosts();
        getSecurityToken();
    };

    var getPosts = function () {
        postService.getPosts()
            .then(function successCallback(response) {
                vm.posts = response.data;
                for (var i = 0; i < vm.posts.length; i++) {
                    if (vm.posts[i].open_from) {
                        vm.posts[i].open_from = new Date(vm.posts[i].open_from.date);
                    }

                    if (vm.posts[i].open_to) {
                        vm.posts[i].open_to = new Date(vm.posts[i].open_to.date);
                    }
                }
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    };

    init();

    function deletePostInt(id) {
        postService.deletePost(id)
            .then(function successCallback(response) {
                getPosts();
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    };

    vm.getInstructions = function (id) {
        postService.getInstructions(id)
            .then(function successCallback(response) {
                //showFile(response.data);
                var blob = new Blob([response.data], { type: "application/pdf" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
            }), function errorCallback(err) {
                notification.error(err.data.message);
            };
    };

    vm.getInstructionsAll = function () {
        alert("WIP");

        //postService.getInstructionsAll()
        //    .then(function successCallback(response) {
        //        var blob = new Blob([response], { type: "application/pdf" });
        //        var objectUrl = URL.createObjectURL(blob);
        //        window.open(objectUrl);
        //    }), function errorCallback(err) {
        //        notification.error(err.data.message);
        //    };
    };

    function showFile(blob) {
        // It is necessary to create a new blob object with mime-type explicitly set
        // otherwise only Chrome works like it should
        var newBlob = new Blob([blob], { type: "application/pdf" })

        // IE doesn't allow using a blob object directly as link href
        // instead it is necessary to use msSaveOrOpenBlob
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(newBlob);
            return;
        }

        // For other browsers: 
        // Create a link pointing to the ObjectURL containing the blob.
        const data = window.URL.createObjectURL(newBlob);
        var link = document.createElement('a');
        link.href = data;
        link.download = "file.pdf";
        link.click();
        setTimeout(function () {
            // For Firefox it is necessary to delay revoking the ObjectURL
            window.URL.revokeObjectURL(data);
        }, 100);
    };

    function getSecurityToken() {
        if (authService.getTeam()) {
            vm.securityToken = authService.getTeam().securityToken;
        } else {
            setTimeout(function () {
                getSecurityToken();
            }, 100);
        }
    };
}
