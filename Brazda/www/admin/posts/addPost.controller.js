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

AddPostController.$inject = ['$routeParams', '$location', 'Notification', 'AuthService', 'PostService', 'ngDialog', '$filter'];

function AddPostController($routeParams, $location, notification, authService, postService, ngDialog, $filter) {
    var vm = this;
    vm.showDescriptionHtml = false;
    vm.showSupportHtml = false;
    vm.showInstructionsHtml = false;

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
    vm.attributes = [];

    var init = function () {
        vm.postTypes = postService.getPostTypes();
        vm.cacheTypes = postService.getCacheTypes();
        vm.postSizes = postService.getPostSizes();
        vm.postColors = postService.getPostColors();
        vm.postTerrains = postService.getTerrains();
        vm.postDifficulties = postService.getDifficulties();
        postService.getAttributes().then(function (data) {
            vm.attributes = data.data;
        });
        vm.waypointTypes = postService.getWaypointTypes();
        vm.waypointVisibilities = postService.getWaypointVisibilities();
    };

    vm.addWaypoint = function () {
        ngDialog.openConfirm({
            template: 'admin/posts/addWaypointModal.html',
            className: 'ngdialog-theme-default',
            controller: 'AddPostCtrl',
            controllerAs: 'vm'
        }).then(function (data) {
            data.wpt = vm.post.waypoints.length + 1;

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
        let attribute = $filter('filter')(vm.attributes, { 'attribute': att }, true)[0];
        if (angular.isUndefined(attribute.status) || attribute.status === null) {
            attribute.status = true;
        } else if (attribute.status === true && attribute.status_count === 2 || attribute.status === false && attribute.status_count === 3) {
            attribute.status = null;
        } else {
            attribute.status = false;
        }
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

        let atts = [];
        for (let i = 0; i < vm.attributes.length; i++) {
            let status = null;
            if (angular.isUndefined(vm.attributes[i].status) || vm.attributes[i].status === null) {
                status = null;
            } else {
                status = vm.attributes[i].status;
            }

            let att = '"' + vm.attributes[i].attribute + '": ' + status;
            atts.push(att);
        }

        var input = {
            "postType": angular.isUndefined(post.postType) ? null : post.postType.postType,
            "color": angular.isUndefined(post.color) ? null : post.color.color,
            "name": post.name,
            "difficulty": angular.isUndefined(post.difficulty) ? null : post.difficulty.value,
            "terrain": angular.isUndefined(post.terrain) ? null : post.terrain.value,
            "cacheSize": angular.isUndefined(post.postSize) ? null : post.postSize.size,
            "hint": post.hint,
            "help": post.help,
            "bonusCode": post.bonusCode,
            "shibboleth": post.shibboleth,
            "shibbolethKid": post.shibboleth_kid,
            "description": post.description,
            "instructions": post.instructions,
            "support": post.support,
            "cacheType": angular.isUndefined(post.cacheType) ? null : post.cacheType.cacheType,
            "maxScore": post.maxScore,
            "latitude": (vm.latitudeDeg + vm.latitudeDecimals / 60) || 0,
            "longitude": (vm.longitudeDeg + vm.longitudeDecimals / 60) || 0,
            "withStaff": post.withStaff,
            "waypoints": waypoints,
            "openFrom": $filter("date")(post.openFrom, "shortTime"),
            "openTo": $filter("date")(post.openTo, "shortTime"),
            "passwordCharacter": post.passwordCharacter,
            "passwordPosition": post.passwordPosition,
            "time_estimate": post.time_estimate,
            "attributes": JSON.parse('{' + atts.join() + '}')
        };

        postService.addPost(input)
            .then(function (data) {
                $location.path("admin/posts");
                notification.success("Stanoviště " + vm.post.name + " bylo přidáno.");
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}
