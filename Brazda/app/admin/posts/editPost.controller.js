'use strict';

angular.module('myApp.admin.editPost', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts/edit/:postId', {
                templateUrl: 'admin/posts/editPost.html',
                controller: 'EditPostCtrl'
            });
    }])

    .controller('EditPostCtrl', EditPostController);

EditPostController.$inject = ['$routeParams', '$location', 'Notification', 'AuthService', 'PostService', 'ngDialog', '$filter'];

function EditPostController($routeParams, $location, notification, authService, postService, ngDialog, $filter) {
    var vm = this;
    vm.post = {};
    vm.postTypes = [];
    vm.cacheTypes = [];
    vm.postSizes = [];
    vm.postColors = [];
    vm.postTerrains = [];
    vm.postDifficulties = [];
    vm.modalInstance = [];
    vm.waypointTypes = [];
    vm.waypointVisibilities = [];

    var init = function () {
        var postId = parseInt($routeParams.postId);

        vm.postTypes = postService.getPostTypes();
        vm.cacheTypes = postService.getCacheTypes();
        vm.postSizes = postService.getPostSizes();
        vm.postColors = postService.getPostColors();
        vm.postTerrains = postService.getTerrains();
        vm.postDifficulties = postService.getDifficulties();

        vm.waypointTypes = postService.getWaypointTypes();
        vm.waypointVisibilities = postService.getWaypointVisibilities();


        vm.post = postService.getPost(postId);
        vm.post.post_type = $filter('filter')(vm.postTypes, { 'post_type': vm.post.post_type }, true)[0];
        vm.post.color = $filter('filter')(vm.postColors, { 'color': vm.post.color }, true)[0];
        vm.post.difficulty = $filter('filter')(vm.postDifficulties, { 'name': vm.post.difficulty }, true)[0];
        vm.post.terrain = $filter('filter')(vm.postTerrains, { 'name': vm.post.terrain }, true)[0];
        vm.post.postSize = $filter('filter')(vm.postSizes, { 'size': vm.post.postSize }, true)[0];
        vm.post.cacheType = $filter('filter')(vm.cacheTypes, { 'cache_type': vm.post.cacheType }, true)[0];

        angular.forEach(vm.post.waypoints, function (value) {
            value.waypoint_type = $filter('filter')(vm.waypointTypes, { 'waypoint_type': value.waypoint_type }, true)[0];
            value.waypoint_visibility = $filter('filter')(vm.waypointVisibilities, { 'waypoint_visibility': value.waypoint_visibility }, true)[0];
        });        
    }

    vm.addWaypoint = function () {
        ngDialog.openConfirm({
            template: 'admin/posts/addWaypointModal.html',
            className: 'ngdialog-theme-default',
            controller: 'EditPostCtrl',
            controllerAs: 'vm'
        }).then(function (data) {
            vm.post.waypoints.push(data);
        }, function (err) {

        })
    };

    vm.removeWaypoint = function (wpt) {
        var index = vm.post.waypoints.indexOf(wpt);
        vm.post.waypoints.splice(index, 1);
        return false;
    }

    vm.addWaypointOk = function () {
        $uibModalInstance.close($ctrl.selected.item);
    };

    vm.addWaypointCancel = function () {
        $uibModalInstance.dismiss('cancel');
    };

    vm.editPost = function (post) {
        notification.success("Stanoviště " + vm.post.name + " bylo upraveno.");
        $location.path("admin/posts");
    }

    init();
}
