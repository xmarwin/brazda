'use strict';

angular.module('myApp.postDetail', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postDetail/:postId', {
            templateUrl: 'posts/postDetail.html',
            controller: 'PostDetailCtrl'
        });
    }])

    .controller('PostDetailCtrl', PostDetailController);

PostDetailController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService', 'ngDialog',];

function PostDetailController(postService, $routeParams, $filter, downloadService, ngDialog) {
    var vm = this;
    vm.postSizes = [];
    vm.cacheTypes = [];
    vm.waypointTypes = [];
    vm.post = [];

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.postSizes = postService.getPostSizes();
        vm.cacheTypes = postService.getCacheTypes();
        postService.getPost(vm.postId)
            .then(function (data) {
                vm.post = data.data
            }, function (err) {

            });
        vm.waypointTypes = postService.getWaypointTypes();

        vm.post.postSize = $filter('filter')(vm.postSizes, { 'size': vm.post.postSize }, true)[0];
        vm.post.cacheType = $filter('filter')(vm.cacheTypes, { 'cacheType': vm.post.cacheType }, true)[0];

        angular.forEach(vm.post.waypoints, function (value) {
            value.waypoint_type = $filter('filter')(vm.waypointTypes, { 'waypointType': value.waypoint_type }, true)[0];
        });
    }

    vm.downloadGpx = function () {
        downloadService.getGpx(vm.post.post);
    }

    vm.getHelp = function () {
        ngDialog.openConfirm({
            template: 'posts/getHelpConfirmation.html'
        }).then(function (data) {
            getHelpInt();
        }, function (err) {

        });        
    }

    function getHelpInt() {
        postService.getHelp(vm.postId)
            .then(function (data) {
                notification.success('Stanoviště úspěšně odstraněno.');
            }, function (err) {

            });
    }

    init();
}
