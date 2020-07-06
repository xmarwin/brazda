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
    vm.showHtml = false;
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

                vm.latitudeDeg = Math.floor(vm.post.latitude);
                vm.latitudeDecimals = Math.round((((vm.post.latitude - vm.latitudeDeg) * 60) + Number.EPSILON) * 1000) / 1000;
                vm.longitudeDeg = Math.floor(vm.post.longitude);
                vm.longitudeDecimals = Math.round((((vm.post.longitude - vm.longitudeDeg) * 60) + Number.EPSILON) * 1000) / 1000;

                if (vm.post.open_to !== null) {
                    vm.post.open_to = new Date("2017-01-01 " + vm.post.open_to + ":00");
                }

                angular.forEach(vm.post.waypoints, function (value) {
                    value.waypointType = $filter('filter')(vm.waypointTypes, { 'waypointType': value.waypoint_type }, true)[0];
                    value.waypointVisibility = $filter('filter')(vm.waypointVisibilities, { 'waypointVisibility': value.waypoint_visibility }, true)[0];
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
            if (data.latitudeDeg & data.latitudeDecimals) {
                data.latitude = data.latitudeDeg + data.latitudeDecimals / 60;
            } else {
                data.latitude = 0;
            }

            if (data.longitudeDeg & data.longitudeDecimals) {
                data.longitude = data.longitudeDeg + data.longitudeDecimals / 60;
            } else {
                data.longitude = 0;
            }

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

    vm.changeAttribute = function (att) {
        let attribute = $filter('filter')(vm.post.attributes, { 'attribute': att }, true)[0];
        if (angular.isUndefined(attribute.status) || attribute.status === null) {
            attribute.status = true;
        } else if (attribute.status === true && attribute.status_count === 2 || attribute.status === false && attribute.status_count === 3) {
            attribute.status = null;
        } else {
            attribute.status = false;
        }
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

        let atts = [];
        for (let i = 0; i < vm.post.attributes.length; i++) {
            let status = null;
            if (angular.isUndefined(vm.post.attributes[i].status) || vm.post.attributes[i].status === null) {
                status = null;
            } else {
                status = vm.post.attributes[i].status;
            }

            let att = '"' + vm.post.attributes[i].attribute + '": ' + status;
            atts.push(att);
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
            "bonusCode": post.bonus_code,
            "shibboleth": post.shibboleth,
            "description": post.description,
            "cacheType": angular.isUndefined(post.cacheType) ? null : post.cacheType.cacheType,
            "maxScore": post.max_score,
            "latitude": (vm.latitudeDeg + vm.latitudeDecimals / 60) || 0,
            "longitude": (vm.longitudeDeg + vm.longitudeDecimals / 60) || 0,
            "withStaff": post.withStaff,
            "waypoints": waypoints,
            "openFrom": $filter("date")(post.open_from, "shortTime"),
            "openTo": $filter("date")(post.open_to, "shortTime"),
            "passwordCharacter": post.password_character,
            "passwordPosition": post.password_position,
            "timeEstimate": post.time_estimate,
            "attributes": JSON.parse('{' + atts.join() + '}')
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