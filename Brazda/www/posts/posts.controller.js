'use strict';

angular.module('myApp.posts', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/posts', {
            templateUrl: 'posts/posts.html',
            controller: 'PostsCtrl'
        });
    }])

    .controller('PostsCtrl', PostsController);

PostsController.$inject = ['AuthService', 'PostService', '$filter'];

function PostsController(authService, postService, $filter) {
    var vm = this;

    vm.postTypes = [];
    vm.filter = [];
    vm.showFilter = false;

    var init = function () {
        loadPosts();

        vm.postTypes = postService.getPostTypes();
        vm.postColors = postService.getPostColors();
    }

    vm.filter = function () {
        var postTypeFilter = (angular.isUndefined(vm.filter.post_type) || vm.filter.post_type == null) ? "" : angular.isUndefined(vm.filter.post_type.post_type) ? "" : vm.filter.post_type.post_type;
        var postColorFilter = (angular.isUndefined(vm.filter.color) || vm.filter.color == null) ? "" : angular.isUndefined(vm.filter.color.color) ? "" : vm.filter.color.color;

        vm.postsFiltered = $filter('filter')(vm.posts, { "postType": postTypeFilter, "color": postColorFilter });
    }

    vm.toggleFilter = function() {
        vm.showFilter = !vm.showFilter;
    }

    vm.refresh = function () {
        loadPosts();
    }

    var loadPosts = function () {
        postService.getPosts()
            .then(function successCallback(response) {
                vm.posts = response.data;
                vm.filter();
            }, function errorCallback(err) {
                alert(err);
            });
    }

    init();
}
