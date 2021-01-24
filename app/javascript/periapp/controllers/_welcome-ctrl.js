angular.module("periop").states["welcome"] = {
    url: '/',
    controller: function($scope, Assessment) {
       $scope.assessment = Assessment;
    }
};