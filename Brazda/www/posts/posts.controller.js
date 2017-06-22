'use strict';

angular.module('myApp.posts', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/posts', {
            templateUrl: 'posts/posts.html',
            controller: 'PostsCtrl'
        });
    }])

    .controller('PostsCtrl', PostsController);

PostsController.$inject = ['AuthService', 'PostService'];

function PostsController(authService, postService) {
    var vm = this;

    var init = function () {
        vm.posts = postService.getPosts(authService.team.id);
    }






    init();
}
