
angular.module('periop').controller('AssetmentCtrl', function($scope, $rootScope, $state) {
    "use strict";

    $scope.initialize = function () {
        $scope.count  = 1
       console.log('updated')
    };
    
    $scope.initialize();

    $scope.get_assesment = function(code){
        $state.go('assetments', {'code': code})
    }
    
});



