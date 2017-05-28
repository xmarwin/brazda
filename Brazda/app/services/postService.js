'use strict';

var module = angular.module('myApp.postService', []);

module.service('PostService', function () {
    var vm = this;

    vm.getPosts = function (teamId) {
        return [{ "name": "Start", "post_type": "STA", "post_color": "TRA" },
        { "name": "Transport", "post_type": "ACT", "post_color": "RED" },
        { "name": "Klíčová pakárna", "post_type": "ACT", "post_color": "RED" },
        { "name": "Přepravky", "post_type": "ACT", "post_color": "RED" },
        { "name": "Titanic", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Váhy", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Mozaika", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Morseovka", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Housenka", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Trajektorie", "post_type": "ACT", "post_color": "YEL" },
        { "name": "Tunel", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Substituce", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Plotny", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Pod Mísnú", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Kání", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Kostel sv. Zdislavy", "post_type": "CIP", "post_color": "GRN" },
        { "name": "Nořičí trail 1", "post_type": "CIP", "post_color": "YEL" },
        { "name": "Nořičí trail 2", "post_type": "CIP", "post_color": "YEL" },
        { "name": "Špionáž", "post_type": "CGC", "post_color": "YEL" },
        { "name": "Trigonometrická", "post_type": "CGC", "post_color": "YEL" },
        { "name": "Šipky", "post_type": "CGC", "post_color": "RED" },
        { "name": "Křížovka", "post_type": "CGC", "post_color": "RED" },
        { "name": "Nořičí trail 3", "post_type": "CGC", "post_color": "RED" },
        { "name": "Nořičí trail 4", "post_type": "CGC", "post_color": "RED" },
        { "name": "Kostel sv.Antonína Paduánského", "post_type": "CGC", "post_color": "RED" },
        { "name": "Lom Kněhyně", "post_type": "CGC", "post_color": "BLU" },
        { "name": "Zelený bonus", "post_type": "BON", "post_color": "BLU" },
        { "name": "Modrý bonus", "post_type": "BON", "post_color": "BLU" },
        { "name": "Žlutý bonus", "post_type": "BON", "post_color": "BLU" },
        { "name": "Červený bonus", "post_type": "BON", "post_color": "BLU" },
        { "name": "Cíl", "post_type": "CIL", "post_color": "TRA" },
        { "name": "Můstek", "post_type": "CGC", "post_color": "BLU" }];
    }
});