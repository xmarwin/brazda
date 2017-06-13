angular.module('myApp.posts')
    .directive('postItem', function () {
        return {
            restrict: 'E',
            scope: {
                postItem: '='
            },
            templateUrl: 'posts/postItem.tpl.html'
        };
    });

