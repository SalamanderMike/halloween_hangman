# Define App               name          dependencies
GameApp = angular.module("GameApp", ["ngRoute", "templates", "ngAnimate"])

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
  $scope.secretWord = "PUMPKIN".split('') # test word
  $scope.secretDisplay = []
  $scope.alpha = []

# Generate alphabet
  for i in [0..25] by 1
    $scope.abc = String.fromCharCode('A'.charCodeAt() + i)
    $scope.alpha[i] = {chr: $scope.abc, secret: false, hidden: false}

# Generate secret word display
  for character in $scope.secretWord
    for object in $scope.alpha
      if character == object.chr
        $scope.secretDisplay.push(object)

# Show/Hide letters in word
  $scope.showLetter = (letter) ->
    if letter.chr in $scope.secretWord
      letter.hidden = true










]


GameApp.controller "WinLoseCtrl", ["$scope", ($scope) ->
]

# Define Config for CSRF token (security)
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
