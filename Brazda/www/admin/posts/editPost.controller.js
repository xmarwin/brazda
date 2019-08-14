'use strict';

angular.module('myApp.admin.editPost', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/posts/edit/:postId', {
                templateUrl: 'admin/posts/editPost.html',
                controller: 'EditPostCtrl',
                controllerAs: 'ctrl'
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

        postService.getPost(parseInt(postId))
            .then(function (data) {
                vm.post = data.data;

                vm.post.postType = $filter('filter')(vm.postTypes, { 'postType': vm.post.post_type }, true)[0];
                vm.post.color = $filter('filter')(vm.postColors, { 'color': vm.post.color }, true)[0];
                vm.post.difficulty = $filter('filter')(vm.postDifficulties, { 'value': vm.post.difficulty.toString() }, true)[0];
                vm.post.terrain = $filter('filter')(vm.postTerrains, { 'value': vm.post.terrain.toString() }, true)[0];
                vm.post.postSize = $filter('filter')(vm.postSizes, { 'size': vm.post.cache_size }, true)[0];
                vm.post.cacheType = $filter('filter')(vm.cacheTypes, { 'cacheType': vm.post.cache_type }, true)[0];
                if (vm.post.open_from !== null) {
                    vm.post.open_from = new Date("2017-01-01 " + vm.post.open_from + ":00");
                }

                if (vm.post.open_to !== null) {
                    vm.post.open_to = new Date("2017-01-01 " + vm.post.open_to + ":00");
                }

                angular.forEach(vm.post.waypoints, function (value) {
                    value.waypointType = $filter('filter')(vm.waypointTypes, { 'waypointType': value.waypointType }, true)[0];
                    value.waypointVisibility = $filter('filter')(vm.waypointVisibilities, { 'waypointVisibility': value.waypointVisibility }, true)[0];
                });
            }, function (err) {

            });
    };

    vm.addWaypoint = function () {
        ngDialog.openConfirm({
            template: 'admin/posts/addWaypointModal.html',
            className: 'ngdialog-theme-default',
            controller: 'EditPostCtrl',
            controllerAs: 'vm'
        }).then(function (data) {
            vm.post.waypoints.push(data);
        }, function (err) {

        });
    };

    vm.removeWaypoint = function (wpt) {
        var index = vm.post.waypoints.indexOf(wpt);
        vm.post.waypoints.splice(index, 1);
        return false;
    };

    vm.addWaypointOk = function () {
        $uibModalInstance.close($ctrl.selected.item);
    };

    vm.addWaypointCancel = function () {
        $uibModalInstance.dismiss('cancel');
    };

    vm.editPost = function (post) {
        var waypoints = [];

        for (var i = 0; i < post.waypoints.length; i++) {
            waypoints.push({
                "post": post.post,
                "waypoint": post.waypoints[i].waypoint,
                "name": post.waypoints[i].name,
                "description": post.waypoints[i].description,
                "waypointType": post.waypoints[i].waypointType.waypointType,
                "waypointVisibility": post.waypoints[i].waypointVisibility.waypointVisibility,
                "latitude": post.waypoints[i].latitude,
                "longitude": post.waypoints[i].longitude
            });
        }
        
        var input = {
            "post": post.post,
            "postType": post.postType.postType,
            "color": angular.isUndefined(post.color) ? null : post.color.color,
            "name": post.name,
            "difficulty": angular.isUndefined(post.difficulty) ? null : post.difficulty.value,
            "terrain": angular.isUndefined(post.terrain) ? null : post.terrain.value,
            "cacheSize": angular.isUndefined(post.postSize) ? null : post.postSize.size,
            "hint": post.hint,
            "help": post.help,
            "bonusCode": post.bonusCode,
            "shibboleth": post.shibboleth,
            "description": post.description,
            "cacheType": angular.isUndefined(post.cacheType) ? null : post.cacheType.cacheType,
            "maxScore": post.max_score,
            "latitude": post.latitude,
            "longitude": post.longitude,
            "withStaff": post.withStaff,
            "waypoints": waypoints,
            "openFrom": $filter("date")(post.openFrom, "shortTime"),
            "openTo": $filter("date")(post.openTo, "shortTime"),
            "passwordCharacter": post.passwordCharacter,
            "passwordPosition": post.passwordPosition,
            "timeEstimate": post.time_estimate
        };

        postService.updatePost(input)
            .then(function (data) {
                $location.path("admin/posts");
                notification.success("Stanoviště " + vm.post.name + " bylo upraveno.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}