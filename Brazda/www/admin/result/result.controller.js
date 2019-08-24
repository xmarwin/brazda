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
    //vm.startTime = new Date("2018-09-15 08:00:00");
    vm.endTime = new Date("2019-09-15 20:00:00");
    vm.helpUsedPenalisation = 24 * 60 * 60 * 1000; // adds this amount of hours to timestamp of teams that used help (just for sake of ordering)
    vm.delayPenalisation = 10; // points/min
    vm.delayDisc = 20; // mins
    vm.stats = [];
    vm.teamType = "all";

    var logsLoaded = false;
    var postsLoaded = false;
    var teamsLoaded = false;

    var init = function () {
        getPosts();
        getTeams();
        getLogs();

        checkForData();
    };

    function checkForData() {
        if (logsLoaded && postsLoaded && teamsLoaded) {
            getTeamsResult();
            //getStats();
        } else {
            setTimeout(function () { // nasty but works
                checkForData();
            }, 500);
        }
    }

    vm.changeTeamType = function () {
        logsLoaded = false;
        getLogs();
        checkForData();
    };

    function getLogs() {
        switch (vm.teamType) {
            case 'all':
                resultService.getResultsAll()
                    .then(function successCallback(response) {
                        vm.logs = response.data;
                        logsLoaded = true;
                    }, function errorCallback(err) {
                        notification.error(err.data.message);
                    });
                break;

            case 'adults':
                resultService.getResultsAdults()
                    .then(function successCallback(response) {
                        vm.logs = response.data;
                        logsLoaded = true;
                    }, function errorCallback(err) {
                        notification.error(err.data.message);
                    });
                break;

            case 'kids':
                resultService.getResultsKids()
                    .then(function successCallback(response) {
                        vm.logs = response.data;
                        logsLoaded = true;
                    }, function errorCallback(err) {
                        notification.error(err.data.message);
                    });
                break;
        }
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

    function getTeamsResult() {
        vm.results = [];

        for (let i = 0; i < vm.posts.length; i++) {
            let post = vm.posts[i];
            post.logs = [];

            // upravi timestamp tymum, ktere si braly napovedu.
            for (let j = 0; j < vm.logs.length; j++) {
                let postTemp = $filter('filter')(vm.logs[j].logs, { post: post.post, log_type: 'OUT' }, true)[0];
                if (!angular.isUndefined(postTemp)) {
                    var validMoment = angular.isUndefined(postTemp.log_out_moment) ? postTemp.moment : postTemp.log_out_moment;

                    if (postTemp.use_help) {
                        postTemp.fakeMoment = new Date(new Date(validMoment.date).getTime() + vm.helpUsedPenalisation);
                    } else {
                        postTemp.fakeMoment = new Date(new Date(validMoment.date).getTime());
                    }
                }
                post.logs.push(postTemp);
            }

            // seradi podle toho upraveneho timestampu
            post.logs.sort(function (a, b) {
                return a.fakeMoment - b.fakeMoment;
            });

            // spocita skore
            var maxScore = post.max_score;
            for (let j = 0; j < post.logs.length; j++) {
                if (!angular.isUndefined(post.logs[j])) {
                    post.logs[j].score = Math.max(maxScore - j * vm.stepDown, 0);
                }
            }
        }

        //spocita celkovy pocet bodu
        for (let i = 0; i < vm.logs.length; i++) {
            vm.logs[i].totalPoints = 0;

            for (let j = 0; j < vm.logs[i].logs.length; j++) {
                if (!angular.isUndefined(vm.logs[i].logs[j]) && (vm.logs[i].logs[j].log_type !== 'BON' && vm.logs[i].logs[j].log_type !== 'FIN' && vm.logs[i].logs[j].log_type !== 'STR')) {
                    vm.logs[i].totalPoints += vm.logs[i].logs[j].score;
                }

                if (vm.logs[i].logs[j].log_type === 'STR') {
                    let moment = new Date(vm.logs[i].logs[j].moment.date);
                    vm.logs[i].logs[j].score = moment.getHours() + ":" + padLeft2(moment.getMinutes()) + ":" + padLeft2(moment.getSeconds());
                }

                if (vm.logs[i].logs[j].log_type === 'FIN') {
                    let moment = new Date(vm.logs[i].logs[j].moment.date);
                    vm.logs[i].logs[j].score = moment.getHours() + ":" + padLeft2(moment.getMinutes()) + ":" + padLeft2(moment.getSeconds());
                }
            }
        }

        for (let i = 0; i < vm.logs.length; i++) {
            let result = {};
            let teamLog = vm.logs[i];

            result.team = teamLog.team;
            result.teamName = teamLog.name;
            result.posts = [];
            result.penalty = 0;

            for (let j = 0; j < teamLog.logs.length; j++) {
                //if (teamLog.logs[j].log_type === 'OUT' && (!vm.stats.firstStart || vm.stats.firstStart.moment > teamLog.logs[j].moment)) {
                //    vm.stats.firstStart = teamLog.logs[j];
                //}
                //if (teamLog.logs[j].log_type === 'OUT' && (!vm.stats.lastStart || vm.stats.lastStart.moment < teamLog.logs[j].moment)) {
                //    vm.stats.lastStart = teamLog.logs[j];
                //}
                //if (teamLog.logs[j].log_type === 'FIN' && (!vm.stats.firstEnd || vm.stats.firstEnd.moment > teamLog.logs[j].moment)) {
                //    vm.stats.firstEnd = teamLog.logs[j];
                //}
                //if (teamLog.logs[j].log_type === 'FIN' && (!vm.stats.lastEnd || vm.stats.lastEnd.moment < teamLog.logs[j].moment)) {
                //    vm.stats.lastEnd = teamLog.logs[j];
                //}

                if (teamLog.logs[j].log_type === 'OUT' || teamLog.logs[j].log_type === 'STR' || teamLog.logs[j].log_type === 'FIN') {
                    result.posts.push({ post: teamLog.logs[j].post, postName: teamLog.logs[j].post_name, score: teamLog.logs[j].score });
                }

                if (teamLog.logs[j].log_type === 'FIN') {
                    let finished = new Date(teamLog.logs[j].moment);
                    if (vm.endTime < finished) {
                        let difference = (finished - vm.endTime) / 1000 / 60;

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

    function getStats() {
        //for (let i = 0; i < vm.logs.length; i++) {
        //    for()
        //}


        //var starts = $filter('orderBy')($filter('filter')(vm.logs, { log_type: 'OUT' }, true), 'moment');
        //vm.stats.firstStart = starts[0];
        //vm.stats.lastStart = starts[starts.length - 1];
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
    };

    vm.getTotal = function (teamId) {
        var retval = $filter("filter")(vm.results, { team: teamId }, true)[0];

        if (angular.isUndefined(retval) || retval.totalPoints === null) {
            return "-";
        } else {
            return retval.totalPoints;
        }
    };

    vm.getPenalty = function (teamId) {
        var retval = $filter("filter")(vm.results, { team: teamId }, true)[0];

        if (angular.isUndefined(retval)) {
            return "-";
        } else {
            return retval.penalty;
        }
    };

    function padLeft2(str) {
        var x = '0000' + str;
        return x.substr(x.length - 2, 2);
    }

    init();
}
