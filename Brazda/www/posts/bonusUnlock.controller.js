'use strict';

angular.module('myApp.bonusUnlock', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/bonusUnlock/:postId', {
            templateUrl: 'posts/bonusUnlock.html',
            controller: 'BonusUnlockCtrl'
        });
    }])

    .controller('BonusUnlockCtrl', BonusUnlockController);

BonusUnlockController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService'];

function BonusUnlockController(postService, $routeParams, $filter, downloadService) {
    var vm = this;
    vm.password = "";

    var init = function () {
        vm.postId = $routeParams.postId;
        vm.post = postService.getPost(parseInt(vm.postId));
    }

    vm.unlock = function () {
        alert("Heslo je " + vm.password);
    }

    init();
}
