GameControllers = angular.module("GameControllers", ["ngResource", "ngAnimate", "ui.bootstrap"])

class GameCtrl
  constructor: (@scope, @modal, @log) ->
    console.log "HELLO!"
    @log.info "Hello Again!"

#   # Generate alphabet
#   generateAlpha: ->
#    for i in [0..25] by 1
#     $scope.abc = String.fromCharCode('A'.charCodeAt() + i)
#     $scope.alpha[i] = {chr: $scope.abc, secret: false, hidden: false}

  test: () ->
    console.log "Test Function!"




#   # Reset Board
  # resetAll: ->
  #   @scope.inputVisible = true
  #   @scope.secretWord = ""
  #   @scope.secretDisplay = []
  #   @scope.alpha = []
  #   @scope.lose = 0
  #   @scope.win = 0
  #   # generateAlpha()
  #   console.log inputVisible

  # resetAll() # RUN THIS ON LOAD

#   $scope.makeSecretWord = ->
#     $scope.resetAll()
#     $scope.generateAlpha()
#     $scope.inputVisible = false
#     $scope.secretWord = $scope.secretPhrase.toUpperCase().split('')
#     $scope.win = $scope.secretWord.length
#     $scope.secretPhrase = ""

#     console.log $scope.secretDisplay
#     # console.log $scope.secretDisplay

#     for character in $scope.secretWord
#       for object in $scope.alpha
#         if character == object.chr
#           $scope.secretDisplay.push(object)


#   # Show/Hide letters in word
#   $scope.showLetter = (letter) ->
#     if letter.chr in $scope.secretWord
#       letter.hidden = true
#       $scope.win -= 1
#       console.log $scope.win
#       # todo: must account for multiple same letters
#       if $scope.win == 1
#         $scope.resetAll()
#     else
#       $scope.lose += 1

#       if $scope.lose == 6
#         console.log "ACK!!! You be hunged!"
#         $scope.resetAll()


#   # MODAL
#   $scope.secretWindow = (size) ->
#     modalInstance = $modal.open(
#       templateUrl: "myModalContent.html"
#       controller: modalControls
#       size: size
#     )
#     modalInstance.result.then (secretPhrase) ->
#       $scope.secretPhrase = secretPhrase
#       if $scope.secretPhrase.length > 1
#         $scope.makeSecretWord($scope.secretPhrase)
#     , ->
#       $log.info "Modal dismissed"


# # MODAL CONTROLS
# class ModalControls
#   constructor: (@scope, @modalInstance) ->
#     $scope.words = secretPhrase: ""

#   $scope.cancel = ->
#     $modalInstance.dismiss "canceled"

#   # end cancel
#   $scope.play = ->
#     $modalInstance.close $scope.words.secretPhrase

#   # end save
#   $scope.hitEnter = (evt) ->
#     $scope.play()  if angular.equals(evt.keyCode, 13) and not (angular.equals($scope.secretPhrase, null) or angular.equals($scope.secretPhrase, ""))



GameControllers.controller("GameCtrl", ["$scope", "$modal", "$log", GameCtrl])

# GameControllers.controller("whatsYourSecretCtrl", [ModalControls])


# # AUTOFOCUS FOR MODAL
# # ALSO altered ui-bootstrap-tpls.js:1856 to be friendlier to autofocus
# GameApp.directive "autofocus", ($timeout) ->
#   link: (scope, element) ->
#     $timeout ->
#       element[0].focus()














