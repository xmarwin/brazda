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
    var postId;

    vm.deletePost = function (id) {
        ngDialog.openConfirm({
            template: 'admin/posts/deletePostConfirmation.html'
        }).then(function (data) {
            deletePostInt(id);
        }, function (err) {

        })
    }
    
    var init = function () {
        postService.getPosts()
            .then(function successCallback(response) {
                vm.posts = response.data;
            }, function errorCallback(err) {
                alert(err);
            });
    }

    init();

    function deletePostInt(id) {
        postService.deletePost(id)
            .then(function successCallback(response) {
                
            }, function errorCallback(err) {
                alert(err);
            });
    }
}
