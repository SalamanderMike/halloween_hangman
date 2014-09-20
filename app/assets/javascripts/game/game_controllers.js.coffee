GameControllers = angular.module("GameControllers", ["ngResource", "ngAnimate", "ui.bootstrap"])

class GameCtrl
  constructor: (@scope, @modal, @log, @ModalControls) ->
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
      # todo: must keep spaces from drawing
  showLetter: (letter) =>
    if letter.chr in @secretWord
      letter.hidden = true
      @win -= 1
      console.log @win
      if @win == 1
        @resetAll()
    else
      @lose += 1
      if @lose == 6
        console.log "ACK!!! You be hunged!"
        @resetAll()


  # MODAL
  secretWindow: (size) =>
    modalInstance = @modal.open(
      templateUrl: "myModalContent.html"
      controller: @ModalControls
      size: size
    )
    modalInstance.result.then (secretPhrase) ->
      @secretPhrase = secretPhrase
      if @secretPhrase.length > 1
        @makeSecretWord(secretPhrase)
    , ->
      console.log "Modal dismissed"


# MODAL CONTROLS
# class ModalControls
#   constructor: (@scope, @modalInstance, @GameCtrl) ->
#     @words = @GameCtrl.secretPhrase
#     console.log @words

#   cancel: ->
#     @modalInstance.dismiss "canceled"

  # end cancel
  # play: =>
  #   @modalInstance.close @words.secretPhrase

  # # end save
  # hitEnter: (evt) ->
  #   @play()  if angular.equals(evt.keyCode, 13) and not (angular.equals(@secretPhrase, null) or angular.equals(@secretPhrase, ""))



GameControllers.controller("GameCtrl", ["$scope", "$modal", "$log", "ModalControls", GameCtrl])

# GameControllers.controller("whatsYourSecretCtrl", [ModalControls])


# # AUTOFOCUS FOR MODAL
# # ALSO altered ui-bootstrap-tpls.js:1856 to be friendlier to autofocus
# GameApp.directive "autofocus", ($timeout) ->
#   link: (scope, element) ->
#     $timeout ->
#       element[0].focus()














