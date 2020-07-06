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

PostsController.$inject = ['AuthService', 'PostService', '$filter', 'Notification'];

function PostsController(authService, postService, $filter, notification) {
    var vm = this;

    vm.postTypes = [];
    vm.filter = [];
    vm.showFilter = false;
    vm.securityToken;

    vm.init = function () {
        loadPosts();

        vm.postTypes = postService.getPostTypes();
        vm.postColors = postService.getPostColors();

        getSecurityToken();

        var filterType = postService.getFilterType();
        var filterColor = postService.getFilterColor();

        vm.filter.state = postService.getFilterStatus() || '';
        vm.filter.postType = $filter('filter')(vm.postTypes, { "post_type": filterType }, true)[0];
        vm.filter.color = $filter('filter')(vm.postColors, { "color": filterColor }, true)[0];
    };

    var getSecurityToken = function () {
        if (authService.getTeam()) {
            vm.securityToken = authService.getTeam().securityToken;
        } else {
            setTimeout(function () {
                getSecurityToken();
            }, 100);
        }
    };

    vm.filter = function () {
        var postTypeFilter = (angular.isUndefined(vm.filter.postType) || vm.filter.postType === null) ? "" : angular.isUndefined(vm.filter.postType.postType) ? "" : vm.filter.postType.postType;
        var postColorFilter = (angular.isUndefined(vm.filter.color) || vm.filter.color === null) ? "" : angular.isUndefined(vm.filter.color.color) ? "" : vm.filter.color.color;

        vm.postsFiltered = $filter('filter')(vm.posts, { "post_type": postTypeFilter, "color": postColorFilter });

        if (!(angular.isUndefined(vm.filter.state) || vm.filter.state === '')) {
            vm.postsFiltered = $filter('filter')(vm.postsFiltered, { "is_done": vm.filter.state === 'found' });
        }

        postService.saveFilterStatus(vm.filter.state);
        postService.saveFilterType(postTypeFilter);
        postService.saveFilterColor(postColorFilter);
    };

    vm.toggleFilter = function () {
        vm.showFilter = !vm.showFilter;
    };

    vm.resetFilter = function () {
        vm.filter.postType = null;
        vm.filter.color = null;
        vm.filter.state = '';

        vm.filter();
    };

    vm.refresh = function () {
        loadPosts();
    };

    vm.isOpen = function (post) {
        var now = new Date();
        
        if ((!post.open_from || post.open_from <= now) && (!post.open_to || post.open_to > now)) {
            return true;
        }
        else {
            return false;
        }
    }

    vm.isClosing = function (post) {
        var future = new Date().setHours(new Date().getHours() + 1);        

        if (!post.open_to || post.open_to <= future && vm.isOpen(post)) {
            return true;
        }

        return false;
    }

    var loadPosts = function () {
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

                vm.filter();
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    };

    vm.init();
}
