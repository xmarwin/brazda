'use strict';

angular.module('myApp.postService', [])
    .service('PostService', PostService)

function PostService($filter) {
    var vm = this;

    vm.getPosts = function (teamId) {
        return [{ "id": 0, "name": "Start", "post_type": "STA", "post_color": "TRA", "terrain": 1, "difficulty": 4.5 },
            { "id": 1, "name": "Transport", "post_type": "ACT", "post_color": "RED", "terrain": 1.5, "difficulty": 4.5},
            { "id": 2, "name": "Klíčová pakárna", "post_type": "ACT", "post_color": "RED", "terrain": 5, "difficulty": 1.5},
            { "id": 3, "name": "Přepravky", "post_type": "ACT", "post_color": "RED", "terrain": 3, "difficulty": 1},
            { "id": 4, "name": "Titanic", "post_type": "ACT", "post_color": "YEL", "terrain": 2, "difficulty": 4},
            { "id": 5, "name": "Váhy", "post_type": "ACT", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 6, "name": "Mozaika", "post_type": "ACT", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 7, "name": "Morseovka", "post_type": "ACT", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 8, "name": "Housenka", "post_type": "ACT", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 9, "name": "Trajektorie", "post_type": "ACT", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 10, "name": "Tunel", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 11, "name": "Substituce", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 12, "name": "Plotny", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 13, "name": "Pod Mísnú", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 14, "name": "Kání", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 15, "name": "Kostel sv. Zdislavy", "post_type": "CIP", "post_color": "GRN", "terrain": 1, "difficulty": 4},
            { "id": 16, "name": "Nořičí trail 1", "post_type": "CIP", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 17, "name": "Nořičí trail 2", "post_type": "CIP", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 18, "name": "Špionáž", "post_type": "CGC", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 19, "name": "Trigonometrická", "post_type": "CGC", "post_color": "YEL", "terrain": 1, "difficulty": 4},
            { "id": 20, "name": "Šipky", "post_type": "CGC", "post_color": "RED", "terrain": 1, "difficulty": 4},
            { "id": 21, "name": "Křížovka", "post_type": "CGC", "post_color": "RED", "terrain": 1, "difficulty": 4},
            { "id": 22, "name": "Nořičí trail 3", "post_type": "CGC", "post_color": "RED", "terrain": 1, "difficulty": 4},
            { "id": 23, "name": "Nořičí trail 4", "post_type": "CGC", "post_color": "RED", "terrain": 1, "difficulty": 4},
            { "id": 24, "name": "Kostel sv.Antonína Paduánského", "post_type": "CGC", "post_color": "RED", "terrain": 1, "difficulty": 4},
            { "id": 25, "name": "Lom Kněhyně", "post_type": "CGC", "post_color": "BLU", "terrain": 1, "difficulty": 4},
            { "id": 26, "name": "Zelený bonus", "post_type": "BON", "post_color": "BLU", "terrain": 1, "difficulty": 2.5},
            { "id": 27, "name": "Modrý bonus", "post_type": "BON", "post_color": "BLU", "terrain": 1, "difficulty": 2.5},
            { "id": 28, "name": "Žlutý bonus", "post_type": "BON", "post_color": "BLU", "terrain": 1, "difficulty": 5},
            { "id": 29, "name": "Červený bonus", "post_type": "BON", "post_color": "BLU", "terrain": 1, "difficulty": 1},
            { "id": 30, "name": "Cíl", "post_type": "CIL", "post_color": "TRA", "terrain": 1, "difficulty": 2.5},
            { "id": 31, "name": "Můstek", "post_type": "CGC", "post_color": "BLU", "terrain": 1, "difficulty": 1}];
    }

    vm.getPost = function (id) {
        return $filter("filter")(vm.getPosts(), { "id": id }, true)[0];
    }
}