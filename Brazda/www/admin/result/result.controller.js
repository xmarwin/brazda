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
    vm.results = [];
    vm.stepDown = 3;
    vm.startTime = new Date("2016-10-01 08:00:00");
    vm.endTime = new Date("2016-10-01 19:00:00");
    vm.helpUsedPenalisation = 24 * 60 * 60 * 1000; // adds this amount of hours to timestamp of teams that used help (just for sake of ordering)
    vm.delayPenalisation = 10; // points/min
    vm.delayDisc = 20; // mins

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
                vm.teams = $filter("filter")(response.data, { role: 'COM' }, true);
                teamsLoaded = true;
            }, function errorCallback(err) {
                notification.error(err.data.message);
            });
    }

    function processResultData() {
        for (var i = 0; i < vm.posts.length; i++) {
            var post = vm.posts[i];
            post.logs = []

            // upravi timestamp tymum, ktere si braly napovedu.
            for (var j = 0; j < vm.logs.length; j++) {
                var postTemp = $filter('filter')(vm.logs[j].logs, { post: post.post, logType: 'OUT' }, true)[0];
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

            // seradi podle toho upraveneho timestampu
            post.logs.sort(function (a, b) {
                return a.fakeMoment - b.fakeMoment;
            });

            // spocita skore
            var maxScore = post.maxScore;
            for (var j = 0; j < post.logs.length; j++) {
                if (!angular.isUndefined(post.logs[j])) {
                    post.logs[j].score = Math.max(maxScore - j * vm.stepDown, 0);
                }
            }
        }


        //spocita celkovy pocet bodu
        for (var i = 0; i < vm.logs.length; i++) {
            vm.logs[i].totalPoints = 0;

            for (var j = 0; j < vm.logs[i].logs.length; j++) {
                if (!angular.isUndefined(vm.logs[i].logs[j]) && (vm.logs[i].logs[j].logType !== 'BON' && vm.logs[i].logs[j].logType !== 'FIN' && vm.logs[i].logs[j].logType !== 'STR')) {
                    vm.logs[i].totalPoints += vm.logs[i].logs[j].score;
                }

                if (vm.logs[i].logs[j].logType === 'STR') {
                    var moment = new Date(vm.logs[i].logs[j].moment);
                    vm.logs[i].logs[j].score = moment.getHours() + ":" + padLeft2(moment.getMinutes()) + ":" + padLeft2(moment.getSeconds());
                }

                if (vm.logs[i].logs[j].logType === 'FIN') {
                    var moment = new Date(vm.logs[i].logs[j].moment);
                    vm.logs[i].logs[j].score = moment.getHours() + ":" + padLeft2(moment.getMinutes()) + ":" + padLeft2(moment.getSeconds());
                }
            }
        }

        for (var i = 0; i < vm.logs.length; i++) {
            var result = {};
            var teamLog = vm.logs[i];

            result.team = teamLog.team;
            result.teamName = teamLog.name;
            result.posts = [];
            result.penalty = 0;

            for (var j = 0; j < teamLog.logs.length; j++) {
                if (teamLog.logs[j].logType === 'OUT' || teamLog.logs[j].logType === 'STR' || teamLog.logs[j].logType === 'FIN') {
                    result.posts.push({ post: teamLog.logs[j].post, postName: teamLog.logs[j].postName, score: teamLog.logs[j].score });
                }

                if (teamLog.logs[j].logType === 'FIN') {
                    var finished = new Date(teamLog.logs[j].moment);
                    if (vm.endTime < finished) {
                        var difference = (finished - vm.endTime) / 1000 / 60;

                        if (difference > vm.delayDisc) {
                            result.penalty = 9999;
                        } else {
                            result.penalty = Math.ceil(difference) * vm.delayPenalisation;
                        }
                    }
                }
            }
            result.totalPoints = Math.max(teamLog.totalPoints - result.penalty, 0);

            vm.results.push(result);
        }
    }

    vm.getScore = function (teamId, postId) {
        var team = $filter("filter")(vm.results, { team: teamId }, true)[0];

        if (angular.isUndefined(team)) {
            return "-";
        } else {
            var log = $filter("filter")(team.posts, { post: postId }, true)[0];

            if (angular.isUndefined(log)) {
                return "-";
            } else {
                return log.score;
            }
        }
    }

    vm.getTotal = function (teamId) {
        var retval = $filter("filter")(vm.results, { team: teamId }, true)[0];

        if (angular.isUndefined(retval) || retval.totalPoints == null) {
            return "-";
        } else {
            return retval.totalPoints;
        }
    }

    vm.getPenalty = function (teamId) {
        var retval = $filter("filter")(vm.results, { team: teamId }, true)[0];

        if (angular.isUndefined(retval)) {
            return "-";
        } else {
            return retval.penalty;
        }
    }

    function padLeft2(str) {
        var x = '0000' + str
        return x.substr(x.length-2, 2);
    }

    init();
}
