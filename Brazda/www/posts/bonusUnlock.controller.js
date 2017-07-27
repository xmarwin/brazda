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
        postService.bonus(vm.postId, vm.password)
            .then(function (response) {
                if (response.data.code === 404) {
                    alert("blbe heslo");
                } else if (response.data.code === 408) {
                    alert("predcasne - cekate do " + response.data.nextAttempt);
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
