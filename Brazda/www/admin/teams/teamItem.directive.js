angular.module('myApp.admin.teams')
    .directive('teamItem', function () {
        return {
            restrict: 'E',
            scope: {
                teamItem: '='
            },
            templateUrl: 'admin/teams/teamItem.tpl.html'
        };
    });

