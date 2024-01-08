var myApp = angular.module('myapp', ['ngAnimate', 'ui.bootstrap'])
    .filter('startForm', function () {
        return function (data, start) {
            if (!data || data.length) {
                return;
            }
            start = 0 + start;
            return data.slice(start);
        }
    })


var mySaleApp = angular.module('mySaleApp', ['ngAnimate', 'ui.bootstrap'])
    .filter('startForm', function () {
        return function (data, start) {
            if (!data || data.length) {
                return;
            }
            start = 0 + start;
            return data.slice(start);
        }
    })