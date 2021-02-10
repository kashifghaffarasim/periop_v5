
angular.module('periop').controller('AssesmentCtrl', function($scope, $rootScope, $state, list) {
    "use strict";

    $scope.initialize = function () {
        $scope.count  = 0 ;
        $scope.total = 0 ;
        $scope.currentIndex = 0;
        $scope.questions = list.data;
        $scope.activeQuestion = $scope.questions[0];
        $scope.activeList = [];
        $scope.activeList.push($scope.activeQuestion)
        console.log($scope.activeQuestion);
    };
    
    $scope.initialize();

    $scope.personalList = function(){
        $scope.count = 1 ;
        $scope.currentIndex = 1;
        $scope.activeQuestion = $scope.questions[1];
    }

    $scope.nextQuestion = function(){
        $scope.currentIndex = $scope.currentIndex + 1;
        $scope.activeQuestion = $scope.questions[$scope.currentIndex];
        $scope.count = $scope.count + 1
    }

    $scope.save_assesment = function(code){
       
    }

    $scope.activeshow = function(){

    }

    $scope.nextquestion =  function(){

    }

    $scope.backquestion = function(){

    }

    $scope.selectQuestion = function(){

    }

    $scope.saveQuestion = function(){

    }

    $scope.updateQuestion =  function(){

    }

    
});



