'use strict';

angular.module('myApp.postLog', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postLog/:postId', {
            templateUrl: 'posts/postLog.html',
            controller: 'PostLogCtrl'
        });
    }])

    .controller('PostLogCtrl', PostLogController);

PostLogController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService'];

function PostLogController(postService, $routeParams, $filter, downloadService) {
    var vm = this;
    vm.shibboleth = "";

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.post = postService.getPost(parseInt(vm.postId));
    }

    vm.log = function () {
        alert("Heslo je " + vm.shibboleth);
    }

    init();
}
