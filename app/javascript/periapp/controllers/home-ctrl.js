
angular.module('periop').controller('HomeCtrl', function($scope, $rootScope, $state, list) {
    "use strict";

    $scope.initialize = function () {
        $scope.count  = 1
        console.log(list)
        $scope.currentQuestion = list.data[0]
    };
    
    $scope.initialize();

    $scope.get_assesment = function(code){
        $state.go('assetments', {'code': code})
    }
    
});



