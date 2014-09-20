GameControllers = angular.module("GameControllers", ["ngResource", "ngAnimate", "ui.bootstrap"])

class GameCtrl
  constructor: (@scope, @modal, @log) ->
    console.log "HELLO!"
    @inputVisible = true
    @secretWord = ""
    @secretDisplay = []
    @alpha = []
    @lose = 0
    @win = 0
    @secretPhrase = "happy"
    @resetAll()

  # Generate alphabet
  generateAlpha: =>
    for i in [0..25] by 1
      @abc = String.fromCharCode('A'.charCodeAt() + i)
      @alpha[i] = {chr: @abc, secret: false, hidden: false}

  # Reset Board
  resetAll: =>
    @inputVisible = true
    @secretWord = ""
    @secretDisplay = []
    @alpha = []
    @lose = 0
    @win = 0
    @generateAlpha()

  # Display Secret Word Blanks
  makeSecretWord: =>
    @resetAll()
    @inputVisible = false
    @secretWord = @secretPhrase.toUpperCase().split('')
    @win = @secretWord.length
    @secretPhrase = ""

    for character in @secretWord
      for object in @alpha
        if character == object.chr
          @secretDisplay.push(object)


  # Show/Hide letters in word
  showLetter: (letter) =>
    if letter.chr in @secretWord
      letter.hidden = true
      @win -= 1
      console.log @win
      # todo: must account for multiple same letters
      if @win == 1
        @resetAll()
    else
      @lose += 1

      if @lose == 6
        console.log "ACK!!! You be hunged!"
        @resetAll()


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














