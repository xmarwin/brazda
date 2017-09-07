'use strict';

angular.module('myApp.waitDirective', [])
    .directive('pleaseWait', PleaseWait);

function PleaseWait() {
    return {
        restrict: 'E',
        replace: true,
        link: function (scope, element, attrs) {
            scope.$on('app-start-loading', function () {
                element.fadeIn();
            });
            scope.$on('app-finish-loading', function () {
                element.hide();
            });
        },
        template: '<div class="wait-please" style="display: none;"></div>'
    }
}
