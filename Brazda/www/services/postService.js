"use strict";

angular.module("myApp.postService", [])
    .service("PostService", PostService)

PostService.$inject = ['WebApiService', '$filter'];

function PostService(webApiService, $filter) {
    var vm = this;

    vm.getPosts = function (teamId) {
        return webApiService.get('post/list');
    }

    vm.getPost = function (id) {
        return $filter("filter")(vm.getPosts(), { "post": id }, true)[0];
    }

    vm.getCacheTypes = function () {
        return [
            { "cacheType": "TRA", "name": "Tradiční keš" },
            { "cacheType": "MLT", "name": "Multi keš" },
            { "cacheType": "MYS", "name": "Mystery keš" },
            { "cacheType": "ERT", "name": "Earth keš" },
            { "cacheType": "WIG", "name": "Where I Go keš" }
        ];
    }

    vm.getLogTypes = function () {
        return [
            { "logType": "STR", "name": "Start" },
            { "logType": "FIN", "name": "Cíl" },
            { "logType": "OUT", "name": "Splněno" },
            { "logType": "BON", "name": "Bonus" },
            { "logType": "ERR", "name": "Chyba" },
            { "logType": "HLP", "name": "Nápověda" }
        ];
    }

    vm.getPostColors = function () {
        return [
            { "color": "TRA", "name": "Žádná", "code": "transparent" },
            { "color": "RED", "name": "Červená", "code": "rgb(247, 150, 70)" },
            { "color": "YEL", "name": "Žlutá", "code": "rgb(255, 255, 153)" },
            { "color": "GRN", "name": "Zelená", "code": "rgb(146, 208, 80)" },
            { "color": "BLU", "name": "Modrá", "code": "rgb(66, 133, 244)" },
            { "color": "WHT", "name": "Bílá", "code": "rgb(255, 255, 255)" }
        ];
    }

    vm.getTerrains = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1.5", "value": "1,5" },
            { "name": "2", "value": "2" },
            { "name": "2.5", "value": "2,5" },
            { "name": "3", "value": "3" },
            { "name": "3.5", "value": "3,5" },
            { "name": "4", "value": "4" },
            { "name": "4.5", "value": "4,5" },
            { "name": "5", "value": "5" },
        ];
    }

    vm.getDifficulties = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1.5", "value": "1,5" },
            { "name": "2", "value": "2" },
            { "name": "2.5", "value": "2,5" },
            { "name": "3", "value": "3" },
            { "name": "3.5", "value": "3,5" },
            { "name": "4", "value": "4" },
            { "name": "4.5", "value": "4,5" },
            { "name": "5", "value": "5" },
        ];
    }

    vm.getPostSizes = function () {
        return [
            { "size": "M", "name": "Mikro" },
            { "size": "S", "name": "Malá" },
            { "size": "R", "name": "Střední" },
            { "size": "L", "name": "Velká" },
            { "size": "O", "name": "Jiná" }
        ];
    }

    vm.getPostTypes = function () {
        return [
            { "postType": "BEG", "name": "Start" },
            { "postType": "END", "name": "Cíl" },
            { "postType": "ORG", "name": "Organizace" },
            { "postType": "ACT", "name": "Aktivita" },
            { "postType": "CIP", "name": "Šifra" },
            { "postType": "CGC", "name": "Keš" },
            { "postType": "BON", "name": "Bonus" }
        ];
    }

    vm.getWaypointTypes = function () {
        return [
            { "waypointType": "FIN", "rank": "1", "name": "Finální umístění" },
            { "waypointType": "STA", "rank": "2", "name": "Stage" },
            { "waypointType": "REF", "rank": "3", "name": "Zajímavé místo" },
            { "waypointType": "PAR", "rank": "4", "name": "Parkoviště" },
            { "waypointType": "WAY", "rank": "5", "name": "Stezka" }
        ];
    }

    vm.getWaypointVisibilities = function () {
        return [
            { "waypointVisibility": "VW", "name": "Viditelná" },
            { "waypointVisibility": "HC", "name": "Bez souřadnic" },
            { "waypointVisibility": "HW", "name": "Skrytá" }
        ];
    }
}