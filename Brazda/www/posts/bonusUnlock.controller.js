'use strict';

angular.module('myApp.bonusUnlock', ['ngRoute'])

    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/bonusUnlock/:postId', {
            templateUrl: 'posts/bonusUnlock.html',
            controller: 'BonusUnlockCtrl',
            controllerAs: 'ctrl'
        });
    }])

    .controller('BonusUnlockCtrl', BonusUnlockController);

BonusUnlockController.$inject = ['PostService', '$routeParams', '$filter', 'DownloadService', 'Notification', '$location'];

function BonusUnlockController(postService, $routeParams, $filter, downloadService, notification, $location) {
    var vm = this;
    vm.password = "";

    var init = function () {
        vm.postId = $routeParams.postId;
        postService.getPost(parseInt(vm.postId))
            .then(function (response) {
                vm.post = response.data;
            });
    };

    vm.unlock = function () {
        postService.bonus(vm.postId, vm.password)
            .then(function (response) {
                if (response.data.code === 404) {
                    notification.error('Zadali jste špatné heslo.');
                } else if (response.data.code === 408) {
                    notification.error({
                        message: "Další pokus o zadání heslo můžete udělat až v " + $filter('date')(response.data.nextTimestamp, 'mediumTime'), delay: null
                    });
                } else if (response.data.code === 200) {
                    $location.path('posts');
                    notification.success('Gratulujeme, to je správná odpověď.');
                } else {
                    notification.error({ message: "Stala se chyba: " + response.data.status, delay: null });
                }
            }, function (err) {
                notification.error(err.data.message);
            });
    };

    init();
}
