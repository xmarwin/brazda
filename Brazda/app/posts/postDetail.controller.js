'use strict';

angular.module('myApp.postDetail', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postDetail/:postId', {
            templateUrl: 'posts/postDetail.html',
            controller: 'PostDetailCtrl'
        });
    }])

    .controller('PostDetailCtrl', PostDetailController);

PostDetailController.$inject = ['PostService', '$routeParams'];

function PostDetailController(postService, $routeParams) {
    var vm = this;

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.post = postService.getPost(parseInt(vm.postId))
    }

    init();
}
