
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

periop.states = {}

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
        })
    
 });

