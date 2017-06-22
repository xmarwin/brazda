'use strict';

angular.module('myApp.downloadService', [])
    .service('DownloadService', DownloadService)

function DownloadService() {
    var vm = this;

    return {
        getGpx: getGpx,
        getRules: getRules
    }

    //////////////////////////////////
   
    function getGpx(id) {
        if (id != null) {
            alert("GPX pro stanoviste " + id);
        } else {
            alert("GPX pro vsechna stanoviste");
        }
    }

    function getRules() {
        alert("Pravidla");
    }
}