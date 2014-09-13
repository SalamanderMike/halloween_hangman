# Define App               name          dependencies
GameApp = angular.module("GameApp", ["ngRoute", "templates"])

# Setup the angular router [inject dependencied]
GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "index.html",
      controller: "GameCtrl"
  .when "/winLose/:win",
    templateUrl: "show.html",
    controller: "WinLoseCtrl"
  .otherwise
    redirectTo: "/"

  $locationProvider.html5Mode(true)
]

GameApp.controller "GameCtrl", ["$scope", ($scope) ->
  $scope.alpha = [
    {chr: 'A', hidden: false},{chr: 'B', hidden: false},
    {chr: 'C', hidden: false},{chr: 'D', hidden: false},
    {chr: 'E', hidden: false},{chr: 'F', hidden: false},
    {chr: 'G', hidden: false},{chr: 'H', hidden: false},
    {chr: 'I', hidden: false},{chr: 'J', hidden: false},
    {chr: 'K', hidden: false},{chr: 'L', hidden: false},
    {chr: 'M', hidden: false},{chr: 'N', hidden: false},
    {chr: 'O', hidden: false},{chr: 'P', hidden: false},
    {chr: 'Q', hidden: false},{chr: 'R', hidden: false},
    {chr: 'S', hidden: false},{chr: 'T', hidden: false},
    {chr: 'U', hidden: false},{chr: 'V', hidden: false},
    {chr: 'W', hidden: false},{chr: 'X', hidden: false},
    {chr: 'Y', hidden: false},{chr: 'Z', hidden: false}]

  $scope.secret = [ {chr: 'p', hidden: false},
                    {chr: 'u', hidden: false},
                    {chr: 'm', hidden: false},
                    {chr: 'p', hidden: false},
                    {chr: 'k', hidden: false},
                    {chr: 'i', hidden: false},
                    {chr: 'n', hidden: false}]

  $scope.showLetter = (letter) ->
    letter.hidden = true




# if letter in secret
#   console.log("test")
#   hidden = false





]


GameApp.controller "WinLoseCtrl", ["$scope", ($scope) ->
]

# Define Config for CSRF token (security)
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
