'use strict';

angular.module('myApp.postNote', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/postNote/:postId', {
            templateUrl: 'posts/postNote.html',
            controller: 'PostNoteCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('PostNoteCtrl', PostNoteController);

PostNoteController.$inject = ['PostService', '$routeParams', '$filter', 'Notification', '$location'];

function PostNoteController(postService, $routeParams, $filter, notification, $location) {
    var vm = this;
    vm.password = "";
    vm.post = {};

    var init = function () {
        vm.postId = $routeParams.postId;
        postService.getPost(parseInt(vm.postId))
            .then(function (data) {
                vm.post = data.data;
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.saveNote = function () {
        var data = { post: vm.postId, note: vm.post.postNote };

        postService.saveNote(data)
            .then(function (response) {
                $location.path("postDetail/" + vm.postId);
                notification.success('Poznámka byla uložena.');
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    vm.cancel = function () {
        $location.path("postDetail/" + vm.postId);
    };

    init();
}
