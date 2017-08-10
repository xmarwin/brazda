'use strict';

angular.module('myApp.admin.addPost', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts/add', {
                templateUrl: 'admin/posts/addPost.html',
                controller: 'AddPostCtrl',
                controllerAs: 'ctrl'
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
        var waypoints = [];

        for (var i = 0; i < post.waypoints.length; i++) {
            waypoints.push({
                "name": post.waypoints[i].name,
                "description": post.waypoints[i].description,
                "waypointType": post.waypoints[i].waypointType.waypointType,
                "waypointVisibility": post.waypoints[i].waypointVisibility.waypointVisibility,
                "latitude": post.waypoints[i].latitude,
                "longitude": post.waypoints[i].longitude
            });
        }

        var input = {
            "postType": post.postType.postType,
            "color": angular.isUndefined(post.color) ? null : post.color.color,
            "name": post.name,
            "difficulty": angular.isUndefined(post.difficulty) ? null : post.difficulty.value,
            "terrain": angular.isUndefined(post.terrain) ? null : post.terrain.value,
            "size": angular.isUndefined(post.postSize) ? null : post.postSize.size,
            "hint": post.hint,
            "help": post.help,
            "bonusCode": post.bonusCode,
            "shibboleth": post.shibboleth,
            "description": post.description,
            "cacheType": angular.isUndefined(post.cacheType) ? null : post.cacheType.cacheType,
            "maxScore": post.maxScore,
            "latitude": post.latitude,
            "longitude": post.longitude,
            "withStaff": post.withStaff,
            "waypoints": waypoints
        }

        postService.addPost(input)
            .then(function (data) {
                $location.path("admin/posts");
                notification.success("Stanoviště " + vm.post.name + " bylo přidáno.");
            }, function (err) {
                notification.error(err);
            });
    }

    init();
}
