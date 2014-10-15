GameControllers = angular.module("GameControllers", ["ngResource", "ngAnimate", "ui.bootstrap"])

class GameCtrl
  constructor: (@scope, @timeout, @modal, @ModalControls) ->
    @inputVisible = true
    @secretWord = ""
    @secretDisplay = []
    @alpha = []
    @lose = 0
    @win = 0
    @wrong = false
    # SPA View Pages
    @visiblePlayButton = true
    @visibleGameTitle = true
    @visibleGameBoard = false
    @visibleWin = false
    @visibleLose = false
    # Ghost Views in Pieces
    @visibleOne = false
    @visibleTwo = false
    @visibleThree = false
    @visibleFour = false
    @visibleFive = false
    @visibleSix = false

  # Generate alphabet
  generateAlpha: =>
    console.log "GENERATING ALPHABET"
    @alpha = []
    for i in [0..25] by 1
      @abc = String.fromCharCode('A'.charCodeAt() + i)
      @alpha[i] = {chr: @abc, secret: false, hidden: false}

  # Reset Board
  resetAll: =>
    console.log "RESET"
    @inputVisible = true
    @secretWord = ""
    @secretDisplay = []
    @alpha = []
    @lose = 0
    @win = 0
    @wrong = false
    @visiblePlayButton = true
    @visibleGameTitle = true
    @visibleGameBoard = false
    @generateAlpha()

  # Process Secret Word
  makeSecretWord: =>
    console.log "START GAME"
    @resetAll()
    @inputVisible = false
    @secretWord = @secretPhrase.toUpperCase().split('')
    @win = @secretWord.length
    @secretPhrase = ""
    for character in @secretWord
      for object in @alpha
        if character == object.chr
          @secretDisplay.push(object)
    @visiblePlayButton = false
    @visibleGameTitle = false
    @timeout (=>#To hide the redraw of the alphabet
      @visibleGameBoard = true
    ), 400
    @visibleWin = false
    @visibleLose = false
    # Remove Ghost in case of lost game
    @visibleOne = false
    @visibleTwo = false
    @visibleThree = false
    @visibleFour = false
    @visibleFive = false
    @visibleSix = false


  # Show/Hide letters in word and count wins/losses
      # todo: must keep spaces from drawing
  showLetter: (letter) =>
    if letter.chr in @secretWord
      letter.hidden = true
      @win -= 1
      if @win == 1
        @alpha = []
        @visibleWin = true
        @resetAll()
    else
      @wrongChoice()
      @lose += 1
      @showGhost()
      if @lose == 6
        @alpha = []
        @visibleLose = true
        @resetAll()

  # Flash screen if you make an incorrect choice
  wrongChoice: =>
    console.log "WRONG CHOICE"
    @wrong = true
    @timeout (=>
      @wrong = false
    ), 200

  # Show ghost piece by piece according to missed letter count
  showGhost: =>
    switch @lose
      when 1
        @visibleOne = true
      when 2
        @visibleTwo = true
      when 3
        @visibleThree = true
      when 4
        @visibleFour = true
      when 5
        @visibleFive = true
      when 6
        @visibleSix = true


  # MODAL
  secretWindow: (size) =>
    console.log "ENTER MODAL"
    modalInstance = @modal.open(
      templateUrl: "myModalContent.html"
      controller: "secretModal as modal"
      size: size
    )
    modalInstance.result.then (secretPhrase) =>
      @secretPhrase = secretPhrase
      if @secretPhrase.length > 1
        @makeSecretWord(secretPhrase)
    , ->
      console.log "Cancelled Game"




# MODAL CONTROLS
class ModalControls
  constructor: (@scope, @modalInstance) ->
    @secretPhrase = ""
    console.log "INSIDE MODAL CONTROL"

  cancel: ->
    console.log "CANCEL"
    @modalInstance.dismiss "canceled"

  play: =>
    @modalInstance.close @secretPhrase

  hitEnter: (evt) =>
    @play() if angular.equals(evt.keyCode, 13) and not (angular.equals(@secretPhrase, null) or angular.equals(@secretPhrase, ""))



GameControllers.controller("GameCtrl", ["$scope", "$timeout", "$modal", GameCtrl])
GameControllers.controller("secretModal", ["$scope", "$modalInstance", ModalControls])


# # AUTOFOCUS FOR MODAL
# # ALSO altered ui-bootstrap-tpls.js:1856 to be friendlier to autofocus
# GameApp.directive "autofocus", ($timeout) ->
#   link: (scope, element) ->
#     $timeout ->
#       element[0].focus()




