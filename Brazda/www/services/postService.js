"use strict";

angular.module("myApp.postService", [])
    .service("PostService", PostService)

PostService.$inject = ['WebApiService', '$filter'];

function PostService(webApiService, $filter) {
    var vm = this;
    
    vm.getPosts = function (teamId) {
        return webApiService.get('post/list');
    }

    // https://brazda/api/post/bonus-list?securityToken=<security token>
    vm.getBonuses = function () {
        return webApiService.get('post/bonus-list');
    }

    // http://brazda/api/post/detail?securityToken=<security token>&post=<id postu>
    vm.getPost = function (id) {
        return webApiService.get('post/detail', [{ 'post': id }]);
    }

    // http://brazda/api/post/help?securityToken=<security token>&post=<id postu>
    vm.getHelp = function (id) {
        return webApiService.get('post/help', [{ 'post': id }]);
    }

    // http://brazda/api/post/log?securityToken=<security token>&post=<id postu>&shibboleth=<heslo>
    vm.log = function (id, shibboleth) {
        return webApiService.get('post/log', [{ 'post': id }, { 'shibboleth': shibboleth }]);
    }

    // http://brazda/api/post/bonus?securityToken=<security token>&post=<id postu>&bonusCode=<bonus kód>
    vm.bonus = function (id, bonusCode) {
        return webApiService.get('post/bonus', [{ 'post': id }, { 'bonusCode': bonusCode }]);
    }

    // http://brazda/api/post/create?securityToken=<...>
    vm.addPost = function (data) {
        return webApiService.get('post/create', data, 'POST');
    }

    // http://brazda/api/post/update?securityToken=<...>
    vm.updatePost = function (data) {
        return webApiService.get('post/update', data, 'POST');
    }

    // http://brazda/api/post/delete?securityToken=<...>&post=35
    vm.deletePost = function (id) {
        return webApiService.get('post/delete', [{ 'post': id }]);
    }

    // http://brazda/api/note/create?securityToken=...
    vm.createNote  = function (data) {
        return webApiService.get('note/create', data, 'POST');
    }

    // http://brazda/api/note/update?securityToken=...
    vm.updateNote  = function (data) {
        return webApiService.get('note/update', data, 'POST');
    }

    // http://brazda/api/note/delete?securityToken=...
    vm.deleteNote  = function (id) {
        return webApiService.get('note/delete', [{ 'post': id }]);
    }

    // http://brazda/api/note/save?securityToken=...
    vm.saveNote  = function (data) {
        return webApiService.get('note/save', data, 'POST');
    }

    vm.getCacheTypes = function () {
        return [
            { "cacheType": "TRA", "name": "Tradiční keš" },
            { "cacheType": "MLT", "name": "Multi keš" },
            { "cacheType": "MYS", "name": "Mystery keš" },
            { "cacheType": "ERT", "name": "Earth keš" },
            { "cacheType": "WIG", "name": "Where I Go keš" },
            { "cacheType": "LTB", "name": "Letterbox" },
            { "cacheType": "CIT", "name": "CITO" }
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
            { "color": "VLT", "name": "Fialová", "code": "rgb(139, 0, 255)" }
        ];
    }

    vm.getTerrains = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1,5", "value": "1.5" },
            { "name": "2", "value": "2" },
            { "name": "2,5", "value": "2.5" },
            { "name": "3", "value": "3" },
            { "name": "3,5", "value": "3.5" },
            { "name": "4", "value": "4" },
            { "name": "4,5", "value": "4.5" },
            { "name": "5", "value": "5" },
        ];
    }

    vm.getDifficulties = function () {
        return [
            { "name": "1", "value": "1" },
            { "name": "1,5", "value": "1.5" },
            { "name": "2", "value": "2" },
            { "name": "2,5", "value": "2.5" },
            { "name": "3", "value": "3" },
            { "name": "3,5", "value": "3.5" },
            { "name": "4", "value": "4" },
            { "name": "4,5", "value": "4.5" },
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
            { "waypointVisibility": "HC", "name": "Skryté souřadnice" },
            { "waypointVisibility": "HW", "name": "Skrytá" }
        ];
    }
}
