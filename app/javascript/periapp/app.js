
var periop = angular.module('periop', [
            'ui.router',
            'ui.bootstrap',
            'angular-loading-bar',
]);
     
periop.config(["$provide", function ($provide) {
        $provide.value("$apiRoot", "/api");
}]);

periop.config(["$provide", function ($provide) {
        $provide.value("$locationRoot", "localhost:3001");
}]);


periop.factory("QuestionService", function ($http, $q, $apiRoot) {

        var resourcePath = $apiRoot;
        return {
            list: function () {
                var url = resourcePath + "/questions";
                var defer = $q.defer();
                $http({
                    method: 'GET',
                    url: url
    
                }).then(function (data, status, header, config) {
                    defer.resolve(data);
                }).then(function (data, status, header, config) {
                    defer.reject(data);
                });
                return defer.promise;
            },
           
        };
    
});

periop.config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) {
        
        $urlRouterProvider.otherwise('/');

        $locationProvider.html5Mode({
                enabled: true,
                requireBase: false
        });

        $stateProvider
                // Start: Static Pages
                .state('index', {
                    url: '/',
                    templateUrl: require('./templates/_welcome.html'),
                    controller: 'HomeCtrl',
                    resolve: {
                                list: function (QuestionService) {
                                        return QuestionService.list();
                                },
                        }   
                })
                .state('assesments', {
                        url: '/assessment/:code',
                        templateUrl: require('./templates/_assesment.html'),
                        controller: 'AssesmentCtrl',
                        resolve: {
                                list: function (QuestionService) {
                                        return QuestionService.list();
                                },
                        }   
                })
                .state('thank-you', {
                        url: '/thank-you',
                        templateUrl: require('./templates/_thankyou.html'),
                        controller: 'ThankYouCtrl',
                })
                .state('hq', {
                        url: '/hq',
                        templateUrl: require('./templates/_welcome.html'),
                        controller: 'HomeCtrl',
                })

    
 });


 