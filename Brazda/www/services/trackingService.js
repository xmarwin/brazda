'use strict';

angular.module('myApp.trackingService', [])
    .service('TrackingService', TrackingService)

TrackingService.$inject = ['$interval', 'geolocation', 'WebApiService', 'localStorageService', '$log'];

function TrackingService($interval, geolocation, WebApiService, localStorageService, $log) {
    var vm = this;

    return {
        startTracking: startTracking,
        stopTracking: stopTracking
    }

    //////////////////////////////////

    function startTracking() {
        var team = getTeam();

        if (team !== null && team.allowTracking) {
            vm.deviceId = getDeviceId();

            if (vm.deviceId !== null) {
                vm.instance = $interval(track, 5000);
            }
        }
    }

    function stopTracking() {
        $interval.cancel(vm.instance);
    }

    function getDeviceId() {
        var deviceId = localStorageService.get('brazdaDeviceId');
        return deviceId;
    }

    function track() {
        try {
            geolocation.getLocation().then(function (data) {
                var lat = data.coords.latitude;
                var lon = data.coords.longitude;

                if (!(angular.isUndefined(lat) && angular.isUndefined(lon))) {
                    logCoordinates(lat, lon);
                }
            });
        } catch (ex) {
            $log.error("Cannot get the coordinates. -->" + ex);
        }
    }

    function logCoordinates(lat, lon) {
        //webApiService.get('track/track', data, 'POST');
        $log.log(lat + ", " + lon + ", " + vm.deviceId);
    }

    function getTeam() {
        return localStorageService.get('brazdaTeam');
    }
}