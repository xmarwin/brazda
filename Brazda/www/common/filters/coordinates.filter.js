'use strict';

var module = angular.module("myApp");

module.filter('coordinate', function () {
    return function (value, prefix) {
        var deg = Math.floor(value);
        var min = Math.round(1000 * (value - deg) * 60) / 1000;
        var minInt = Math.floor(min);
        var minDec = min - minInt;

        return prefix + deg + "° " +
            ("00" + minInt).slice(-2) + "," +
            ((("000" + minDec).slice(-3))) + "'";
    };
});