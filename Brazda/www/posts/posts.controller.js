'use strict';

angular.module('myApp.posts', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/posts', {
            templateUrl: 'posts/posts.html',
            controller: 'PostsCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('PostsCtrl', PostsController);

PostsController.$inject = ['AuthService', 'PostService', '$filter'];

function PostsController(authService, postService, $filter) {
    var vm = this;

    vm.postTypes = [];
    vm.filter = [];
    vm.showFilter = false;

    vm.init = function () {
        loadPosts();

        vm.postTypes = postService.getPostTypes();
        vm.postColors = postService.getPostColors();
    }

    vm.filter = function () {
        var postTypeFilter = (angular.isUndefined(vm.filter.postType) || vm.filter.postType === null) ? "" : angular.isUndefined(vm.filter.postType.postType) ? "" : vm.filter.postType.postType;
        var postColorFilter = (angular.isUndefined(vm.filter.color) || vm.filter.color === null) ? "" : angular.isUndefined(vm.filter.color.color) ? "" : vm.filter.color.color;

        vm.postsFiltered = $filter('filter')(vm.posts, { "postType": postTypeFilter, "color": postColorFilter });

        if (!(angular.isUndefined(vm.filter.state) || vm.filter.state === '')) {
            vm.postsFiltered = $filter('filter')(vm.postsFiltered, { "isDone": vm.filter.state === 'found' });
        }
    }

    vm.toggleFilter = function () {
        vm.showFilter = !vm.showFilter;
    }

    vm.resetFilter = function () {
        vm.filter.postType = null;
        vm.filter.color = null;
        vm.filter.state = '';

        vm.filter();
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

    vm.init();
}
