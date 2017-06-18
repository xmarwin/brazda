'use strict';

var module = angular.module("myApp");

module.filter('coordinate', function () {
    return function (value, prefix) {
        var deg = Math.floor(value);
        var min = Math.floor((value - deg) * 60);
        var dec = Math.round((((value - deg) * 60) - Math.floor(min)) * 1000);

        return prefix + deg + "° " +
            ("00" + min).slice(-2) + "," +
            ((("000" + dec).slice(-3))) + "'";
    };
});