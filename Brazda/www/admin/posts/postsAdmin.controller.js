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
                var blob = new Blob([response], { type: "application/pdf" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
            }), function errorCallback(err) {
                notification.error(err.data.message);
            };
    };

    vm.getInstructionsAll = function () {
        postService.getInstructionsAll()
            .then(function successCallback(response) {
                var blob = new Blob([response], { type: "application/pdf" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
            }), function errorCallback(err) {
                notification.error(err.data.message);
            };
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
