
angular.module('periop').controller('ThankYouCtrl', function($scope, $rootScope, $state) {
    "use strict";

    $scope.initialize = function () {
        $scope.count  = 1
        console.log('thank you page')
    };
    $scope.initialize();
});



