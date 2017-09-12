'use strict';

angular.module('myApp.admin.result', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when('/admin/results', {
                templateUrl: 'admin/result/result.html',
                controller: 'ResultCtrl',
                controllerAs: 'ctrl'
            });
    }])

    .controller('ResultCtrl', ResultController);

ResultController.$inject = ['Notification', 'ResultService', 'PostService', 'TeamService', '$filter'];

function ResultController(notification, resultService, postService, teamService, $filter) {
    var vm = this;
    vm.logs = {};
    vm.posts = {};
    vm.teams = {};
    vm.stepDown = 3;
    vm.startTime = new Date("2016-10-01 08:00:00");
    vm.endTime = new Date("2016-10-01 19:00:00");
    vm.helpUsedPenalisation = 24 * 60 * 60 * 1000; // adds this amount of hours to timestamp of teams that used help (just for sake of ordering)

    var logsLoaded = false;
    var postsLoaded = false;
    var teamsLoaded = false;

    var init = function () {
        getPosts();
        getTeams();
        getLogs();

        checkForData();
    }

    function checkForData() {
        if (logsLoaded && postsLoaded && teamsLoaded) {
            processResultData();
        } else {
            setTimeout(function () { // nasty but works
                checkForData()
            }, 500);
        }
    }

    function getLogs() {
        resultService.getResult()
            .then(function successCallback(response) {
                vm.logs = response.data;
                logsLoaded = true
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    function getPosts() {
        postService.getPosts()
            .then(function successCallback(response) {
                vm.posts = response.data;
                postsLoaded = true;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    function getTeams() {
        teamService.getTeamsFull()
            .then(function successCallback(response) {
                vm.teams = response.data;
                teamsLoaded = true;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    function processResultData() {
        for (var i = 0; i < vm.posts.length; i++) {
            var post = vm.posts[i];
            post.logs = []
            for (var j = 0; j < vm.logs.length; j++) {
                var postTemp = $filter('filter')(vm.logs[j].logs, { post: post.post }, true)[0];
                if (!angular.isUndefined(postTemp)) {
                    var validMoment = angular.isUndefined(postTemp.logOutMoment) ? postTemp.moment : postTemp.logOutMoment;

                    if (postTemp.useHelp) {
                        postTemp.fakeMoment = new Date(new Date(validMoment).getTime() + vm.helpUsedPenalisation);
                    } else {
                        postTemp.fakeMoment = new Date(new Date(validMoment).getTime());
                    }
                }
                post.logs.push(postTemp);
            }

            post.logs.sort(function (a, b) {
                return a.fakeMoment - b.fakeMoment;
            });

            var maxScore = post.maxScore;
            for (var j = 0; j < post.logs.length; j++) {
                if (!angular.isUndefined(post.logs[j])) {
                    post.logs[j].score = Math.max(maxScore - j * vm.stepDown, 0);
                }
            }
        }
    }

    init();
}
