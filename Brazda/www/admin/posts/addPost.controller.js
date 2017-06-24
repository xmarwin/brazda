'use strict';

angular.module('myApp.admin.addPost', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts/add', {
                templateUrl: 'admin/posts/addPost.html',
                controller: 'AddPostCtrl'
            });
    }])

    .controller('AddPostCtrl', AddPostController);

AddPostController.$inject = ['$routeParams', '$location', 'Notification', 'AuthService', 'PostService', 'ngDialog'];

function AddPostController($routeParams, $location, notification, authService, postService, ngDialog) {
    var vm = this;
    vm.post = {};
    vm.post.waypoints = [];

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
        vm.postTypes = postService.getPostTypes();
        vm.cacheTypes = postService.getCacheTypes();
        vm.postSizes = postService.getPostSizes();
        vm.postColors = postService.getPostColors();
        vm.postTerrains = postService.getTerrains();
        vm.postDifficulties = postService.getDifficulties();

        vm.waypointTypes = postService.getWaypointTypes();
        vm.waypointVisibilities = postService.getWaypointVisibilities();
    }

    vm.addWaypoint = function () {
        ngDialog.openConfirm({
            template: 'admin/posts/addWaypointModal.html',
            className: 'ngdialog-theme-default',
            controller: 'AddPostCtrl',
            controllerAs: 'vm'
        }).then(function (data) {
            data.wpt = vm.post.waypoints.length + 1;
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

    vm.addPost = function (post) {
        notification.success("Stanoviště " + vm.post.name + " bylo přidáno.");
        $location.path("admin/posts");
    }

    init();
}
