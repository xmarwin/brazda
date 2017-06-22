'use strict';

angular.module('myApp.postDetail', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postDetail/:postId', {
            templateUrl: 'posts/postDetail.html',
            controller: 'PostDetailCtrl'
        });
    }])

    .controller('PostDetailCtrl', PostDetailController);

PostDetailController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService'];

function PostDetailController(postService, $routeParams, $filter, downloadService) {
    var vm = this;
    vm.postSizes = [];
    vm.cacheTypes = [];
    vm.waypointTypes = [];

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.postSizes = postService.getPostSizes();
        vm.cacheTypes = postService.getCacheTypes();
        vm.post = postService.getPost(parseInt(vm.postId));
        vm.waypointTypes = postService.getWaypointTypes();

        vm.post.postSize = $filter('filter')(vm.postSizes, { 'size': vm.post.postSize }, true)[0];
        vm.post.cacheType = $filter('filter')(vm.cacheTypes, { 'cache_type': vm.post.cacheType }, true)[0];

        angular.forEach(vm.post.waypoints, function (value) {
            value.waypoint_type = $filter('filter')(vm.waypointTypes, { 'waypoint_type': value.waypoint_type }, true)[0];
        });
    }

    vm.downloadGpx = function () {
        downloadService.getGpx(vm.post.post);
    }

    vm.log = function () {

    }

    vm.unlock = function () {

    }

    vm.getHelp = function () {

    }

    init();
}
