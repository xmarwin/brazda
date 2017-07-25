'use strict';

angular.module('myApp.admin.posts', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts', {
                templateUrl: 'admin/posts/postsAdmin.html',
                controller: 'PostsAdminCtrl'
            });
    }])

    .controller('PostsAdminCtrl', PostsAdminController);

PostsAdminController.$inject = ['$routeParams', 'Notification', 'AuthService', 'PostService'];

function PostsAdminController($routeParams, notification, authService, postService) {
    var vm = this;

    var init = function () {
        postService.getPosts()
            .then(function successCallback(response) {
                vm.posts = response.data;
            }, function errorCallback(err) {
                alert(err);
            });
    }

    init();
}
