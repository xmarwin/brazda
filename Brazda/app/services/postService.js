"use strict";

angular.module("myApp.postService", [])
    .service("PostService", PostService)

function PostService($filter) {
    var vm = this;

    vm.getPosts = function (teamId) {
        return [
            { "id": "0", "name": "Start", "post_type": "STA", "post_color": "TRA", "terrain": "1", "difficulty": "4.5" },
            { "id": "1", "name": "Transport", "post_type": "ACT", "post_color": "RED", "terrain": "1.5", "difficulty": "4.5" },
            { "id": "2", "name": "Klíčová pakárna", "post_type": "ACT", "post_color": "RED", "terrain": "5", "difficulty": "1.5" },
            { "id": "3", "name": "Přepravky", "post_type": "ACT", "post_color": "RED", "terrain": "3", "difficulty": "1" },
            { "id": "4", "name": "Titanic", "post_type": "ACT", "post_color": "YEL", "terrain": "2", "difficulty": "4" },
            { "id": "5", "name": "Váhy", "post_type": "ACT", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "6", "name": "Mozaika", "post_type": "ACT", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "7", "name": "Morseovka", "post_type": "ACT", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "8", "name": "Housenka", "post_type": "ACT", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "9", "name": "Trajektorie", "post_type": "ACT", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "10", "name": "Tunel", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "11", "name": "Substituce", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "12", "name": "Plotny", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "13", "name": "Pod Mísnú", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "14", "name": "Kání", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "15", "name": "Kostel sv. Zdislavy", "post_type": "CIP", "post_color": "GRN", "terrain": "1", "difficulty": "4" },
            { "id": "16", "name": "Nořičí trail 1", "post_type": "CIP", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "17", "name": "Nořičí trail 2", "post_type": "CIP", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "18", "name": "Špionáž", "post_type": "CGC", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "19", "name": "Trigonometrická", "post_type": "CGC", "post_color": "YEL", "terrain": "1", "difficulty": "4" },
            { "id": "20", "name": "Šipky", "post_type": "CGC", "post_color": "RED", "terrain": "1", "difficulty": "4" },
            { "id": "21", "name": "Křížovka", "post_type": "CGC", "post_color": "RED", "terrain": "1", "difficulty": "4" },
            { "id": "22", "name": "Nořičí trail 3", "post_type": "CGC", "post_color": "RED", "terrain": "1", "difficulty": "4" },
            { "id": "23", "name": "Nořičí trail 4", "post_type": "CGC", "post_color": "RED", "terrain": "1", "difficulty": "4" },
            { "id": "24", "name": "Kostel sv.Antonína Paduánského", "post_type": "CGC", "post_color": "RED", "terrain": "1", "difficulty": "4" },
            { "id": "25", "name": "Lom Kněhyně", "post_type": "CGC", "post_color": "BLU", "terrain": "1", "difficulty": "4" },
            { "id": "26", "name": "Zelený bonus", "post_type": "BON", "post_color": "BLU", "terrain": "1", "difficulty": "2.5" },
            { "id": "27", "name": "Modrý bonus", "post_type": "BON", "post_color": "BLU", "terrain": "1", "difficulty": "2.5" },
            { "id": "28", "name": "Žlutý bonus", "post_type": "BON", "post_color": "BLU", "terrain": "1", "difficulty": "5" },
            { "id": "29", "name": "Červený bonus", "post_type": "BON", "post_color": "BLU", "terrain": "1", "difficulty": "1" },
            { "id": "30", "name": "Cíl", "post_type": "CIL", "post_color": "TRA", "terrain": "1", "difficulty": "2.5" },
            { "id": "31", "name": "Můstek", "post_type": "CGC", "post_color": "BLU", "terrain": "1", "difficulty": "1" }
        ];
    }

    vm.getPost = function (id) {
        return $filter("filter")(vm.getPosts(), { "id": id }, true)[0];
    }

    vm.getCacheTypes = function () {
        return [
            { "cache_type": "TRA", "name": "Tradiční keš" },
            { "cache_type": "MLT", "name": "Multi keš" },
            { "cache_type": "MYS", "name": "Mystery keš" },
            { "cache_type": "ERT", "name": "Earth keš" },
            { "cache_type": "WIG", "name": "Where I Go keš" }
        ];
    }

    vm.getLogTypes = function () {
        return [
            { "log_type": "STR", "name": "Start" },
            { "log_type": "FIN", "name": "Cíl" },
            { "log_type": "OUT", "name": "Splněno" },
            { "log_type": "BON", "name": "Bonus" },
            { "log_type": "ERR", "name": "Chyba" },
            { "log_type": "HLP", "name": "Nápověda" }
        ];
    }

    vm.getPostColors = function () {
        return [
            { "color": "TRA", "name": "žádná", "code": "transparent" },
            { "color": "RED", "name": "červená", "code": "rgb(247, 150, 70)" },
            { "color": "YEL", "name": "žlutá", "code": "rgb(255, 255, 153)" },
            { "color": "GRN", "name": "zelená", "code": "rgb(146, 208, 80)" },
            { "color": "BLU", "name": "modrá", "code": "rgb(66, 133, 244)" },
            { "color": "WHT", "name": "bílá", "code": "rgb(255, 255, 255)" }
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
            { "post_type": "BEG", "name": "Start" },
            { "post_type": "END", "name": "Cíl" },
            { "post_type": "ORG", "name": "Organizace" },
            { "post_type": "ACT", "name": "Aktivita" },
            { "post_type": "CIP", "name": "Šifra" },
            { "post_type": "CGC", "name": "Keš" },
            { "post_type": "BON", "name": "Bonus" }
        ];
    }

    vm.getWaypointTypes = function () {
        return [
            { "waypoint_type": "FIN", "rank": "1", "name": "Finální umístění" },
            { "waypoint_type": "STA", "rank": "2", "name": "Stage" },
            { "waypoint_type": "REF", "rank": "3", "name": "Zajímavé místo" },
            { "waypoint_type": "PAR", "rank": "4", "name": "Parkoviště" },
            { "waypoint_type": "WAY", "rank": "5", "name": "Stezka" }
        ];
    }

    vm.getWaypointVisibilities = function () {
        return [
            { "waypoint_visibility": "VW", "name": "Viditelná" },
            { "waypoint_visibility": "HC", "name": "Bez souřadnic" },
            { "waypoint_visibility": "HW", "name": "Skrytá" }
        ];
    }
}