angular.module('myApp.admin.posts')
    .directive('postItemAdmin', function () {
        return {
            restrict: 'E',
            scope: {
                postItemAdmin: '='
            },
            templateUrl: 'admin/posts/postItemAdmin.tpl.html'
        };
    });

