'use strict';

angular.module('myApp.postDetail', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postDetail/:postId', {
            templateUrl: 'posts/postDetail.html',
            controller: 'PostDetailCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('PostDetailCtrl', PostDetailController);

PostDetailController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService', 'ngDialog', 'AuthService', '$location', 'Notification'];

function PostDetailController(postService, $routeParams, $filter, downloadService, ngDialog, authService, $location, notification) {
    var vm = this;
    vm.postSizes = [];
    vm.cacheTypes = [];
    vm.waypointTypes = [];
    vm.post = [];
    vm.securityToken;
    vm.disableHelpButton = true;
    vm.disableLogButton = true;

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.postSizes = postService.getPostSizes();
        vm.cacheTypes = postService.getCacheTypes();

        postService.getPost(vm.postId)
            .then(function (data) {
                vm.post = data.data

                vm.disableHelpButton = !vm.post.hasHelp || vm.post.isDone || vm.post.logHelpMoment !== null;
                vm.disableLogButton = vm.post.isDone || ((vm.post.postType === 'BON' || vm.post.postType === 'SBN') && !vm.post.isUnlocked);
            }, function (err) {

            });

        vm.waypointTypes = postService.getWaypointTypes();

        vm.post.postSize = $filter('filter')(vm.postSizes, { 'size': vm.post.postSize }, true)[0];
        vm.post.cacheType = $filter('filter')(vm.cacheTypes, { 'cacheType': vm.post.cacheType }, true)[0];

        angular.forEach(vm.post.waypoints, function (value) {
            value.waypoint_type = $filter('filter')(vm.waypointTypes, { 'waypointType': value.waypoint_type }, true)[0];
        });

        getSecurityToken();
    }

    var getSecurityToken = function () {
        if (authService.team) {
            vm.securityToken = authService.team.securityToken;
        } else {
            setTimeout(function () {
                getSecurityToken();
            }, 100);
        }
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

    vm.logPost = function () {
        $location.path("/postLog/" + vm.post.post);
    }

    vm.unlockBonus = function () {
        $location.path("/bonusUnlock/" + vm.post.post);
    }

    function getHelpInt() {
        postService.getHelp(vm.postId)
            .then(function (data) {
                notification.success('Nápověda použita.');
                vm.post.help = data.data.help;
                vm.disableHelpButton = true;
            }, function (err) {
                notification.error(err.message);
            });
    }

    init();
}
