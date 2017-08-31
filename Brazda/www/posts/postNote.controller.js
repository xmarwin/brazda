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
    vm.note = "";

    var init = function () {
        vm.postId = $routeParams.postId;
        postService.getPost(parseInt(vm.postId))
            .then(function (data) {
                vm.post = data.data;
            }, function (err) {
                notification.error(err.data.message);
            });
    }

    vm.saveNote = function () {
        var data = JSON.stringify({post: vm.postId, note: vm.note, })

        postService.createNote(data)
            .then(function (response) {
                $location.path("#/post/" + vm.postDetail.post);
                notification.success('Poznámka byla uložena.');
            }, function (err) {
                notification.error(err.data.message);
            });
    }

    init();
}
