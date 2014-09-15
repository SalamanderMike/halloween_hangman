# Define App               name          dependencies
GameApp = angular.module("GameApp", ["ngRoute", "templates", "ngAnimate", "ui.bootstrap", "dialogs.main"])

# Setup the angular router [inject dependencied]
GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "index.html",
      controller: "GameCtrl"
  # .when "/dialogs/",
  #   templateUrl: "whatsyoursecret.html",
  #   controller: "whatsYourSecretCtrl"
  .otherwise
    redirectTo: "/"

  $locationProvider.html5Mode(true)
]

GameApp.controller "GameCtrl", ["$scope", "$rootScope", ($scope, $rootScope, $dialogs) ->




# Reset Board
  $scope.resetAll = ->
    $scope.inputVisible = true
    $scope.secretWord = ""
    $scope.secretDisplay = []
    $scope.alpha = []
    $scope.lose = 0
    $scope.win = 0
    $scope.generateAlpha()

# Generate alphabet
  $scope.generateAlpha = ->
   for i in [0..25] by 1
    $scope.abc = String.fromCharCode('A'.charCodeAt() + i)
    $scope.alpha[i] = {chr: $scope.abc, secret: false, hidden: false}

  $scope.resetAll()

  $scope.makeSecretWord = (testWord) ->
    $scope.resetAll()
    $scope.generateAlpha()
    $scope.inputVisible = false
    $scope.secretWord = $scope.testWord.toUpperCase().split('')
    $scope.win = $scope.secretWord.length

    console.log $scope.secretDisplay
    # console.log $scope.secretDisplay

    for character in $scope.secretWord
      for object in $scope.alpha
        if character == object.chr
          $scope.secretDisplay.push(object)


# Show/Hide letters in word
  $scope.showLetter = (letter) ->
    if letter.chr in $scope.secretWord
      letter.hidden = true
      $scope.win -= 1
      console.log $scope.win
      # todo: must account for multiple same letters
      if $scope.win == 1
        $scope.resetAll()
    else
      $scope.lose += 1

      if $scope.lose == 6
        console.log "ACK!!! You be hunged!"
        $scope.resetAll()



# # MODAL
#   $scope.secretWindow = ->
#     dlg = null
#     dlg = $dialogs.create("/dialogs/whatsyoursecret.html", "whatsYourSecretCtrl", {},
#       key: false
#       back: "static"
#     )
#     dlg.result.then ((secretPhrase) ->
#       $scope.secretPhrase = secretPhrase
#       return
#     ), ->
#       $scope.secretPhrase = "You decided not to enter a secret, that makes me sad."
#       return
#     return
]


# # MODAL
# GameApp.controller "whatsYourSecretCtrl", ["$scope", "$modalInstance", ($scope, $modalInstance, data) ->
#   $scope.words = secretPhrase: ""
#   $scope.cancel = ->
#     $modalInstance.dismiss "canceled"
#     return

#   # end cancel
#   $scope.save = ->
#     $modalInstance.close $scope.words.secretPhrase
#     return

#   # end save
#   $scope.hitEnter = (evt) ->
#     $scope.save()  if angular.equals(evt.keyCode, 13) and not (angular.equals($scope.secretPhrase, null) or angular.equals($scope.secretPhrase, ""))
#     return
#   return

# ]

# # MODAL
# GameApp.run [
#   "$templateCache"
#   ($templateCache) ->
#     $templateCache.put "/dialogs/whatsyoursecret.html", "<div class=\"modal\"><div class=\"modal-dialog\"><div class=\"modal-content\"><div class=\"modal-header\"><h4 class=\"modal-title\"><span class=\"glyphicon glyphicon-star\"></span> Halloween Hangman!</h4></div><div class=\"modal-body\"><ng-form name=\"inputDialog\" novalidate role=\"form\"><div class=\"form-group input-group-lg\" ng-class=\"{true: 'has-error'}[inputDialog.inputSecret.$dirty && inputDialog.inputSecret.$invalid]\"><label class=\"control-label\" for=\"inputSecret\">Type Secret Word:</label><input type=\"text\" class=\"form-control\" name=\"inputSecret\" id=\"inputSecret\" ng-model=\"words.secretPhrase\" ng-keyup=\"hitEnter($event)\" required autofocus><span class=\"help-block\">Just enter one word until I get smarter</span></div></ng-form></div><div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-default\" ng-click=\"cancel()\">Cancel</button><button type=\"button\" class=\"btn btn-primary\" ng-click=\"save()\" ng-disabled=\"(inputDialog.$dirty && inputDialog.$invalid) || inputDialog.$pristine\">Save</button></div></div></div></div>"
# ]

# # UNUSED
# GameApp.controller "WinLoseCtrl", ["$scope", ($scope) ->
# ]

# Define Config for CSRF token (security)
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
