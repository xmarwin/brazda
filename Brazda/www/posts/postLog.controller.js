'use strict';

angular.module('myApp.postLog', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postLog/:postId', {
            templateUrl: 'posts/postLog.html',
            controller: 'PostLogCtrl'
        });
    }])

    .controller('PostLogCtrl', PostLogController);

PostLogController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService', 'Notification'];

function PostLogController(postService, $routeParams, $filter, downloadService, Notification) {
    var vm = this;
    vm.shibboleth = "";

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.post = postService.getPost(parseInt(vm.postId));
    }

    vm.log = function () {
        postService.log(vm.postId, vm.shibboleth)
            .then(function (response) {
                if (response.data.code === 404) {
                    Notification.success('Blbe heslo');
                } else if (response.data.code === 408) {
                    Notification.error({
                        message: "Další pokus o zadání heslo můžete udělat až v " + $filter('date')(response.data.nextAttempt, 'mediumTime'), delay: null });;
                } else if (response.data.code === 200) {
                    alert("OK");
                } else {
                    alert(response.data.status);
                }
            }, function (err) {

            });
    }

    init();
}
