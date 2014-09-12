# Define App               name          dependencies
GameApp = angular.module("GameApp", ["ngRoute", "templates"])

# Setup the angular router [inject dependencied]
GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "index.html",
      controller: "GameCtrl"
  .otherwise
      redirectTo: "/"

  $locationProvider.html5Mode(true)
]

GameApp.controller "GameCtrl", ["$scope", "$http", ($scope, $http) ->














]


# Define Config for CSRF token (security)
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
