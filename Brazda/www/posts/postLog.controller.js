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

function PostLogController(postService, $routeParams, $filter, downloadService, notification) {
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
                    notification.error('Zadali jste špatné heslo.');
                } else if (response.data.code === 408) {
                    notification.error({
                        message: "Další pokus o zadání heslo můžete udělat až v " + $filter('date')(response.data.nextAttempt, 'mediumTime'), delay: null
                    });
                } else if (response.data.code === 200) {
                    notification.success('Gratulujeme, to je správná odpověď.');
                } else {
                    notification.error({ message: "Stala se chyba: " + response.data.status, delay: null });
                }
            }, function (err) {

            });
    }

    init();
}
