GameControllers = angular.module("GameControllers", ["ngResource", "ngAnimate", "ui.bootstrap"])

class GameCtrl
  constructor: (@scope, @timeout, @modal, @log, @ModalControls) ->
    console.log "HELLO!"
    @inputVisible = true
    @secretWord = ""
    @secretDisplay = []
    @alpha = []
    @lose = 0
    @win = 0
    @secretPhrase = "happy"
    @wrong = false
    @one = true
    @two = true
    @three = true
    @four = true
    @five = true
    @six = true
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
    @visiblePlayButton = true
    @visibleGameTitle = true
    @visibleGameBoard = false
    @generateAlpha()

  # Display Secret Word Blanks
  makeSecretWord: =>
    console.log "TESTING HERE"
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
    @visibleGameBoard = true
    @visibleWin = false
    @visibleLose = false
    # Remove Ghost in case of loss
    @visibleOne = false
    @visibleTwo = false
    @visibleThree = false
    @visibleFour = false
    @visibleFive = false
    @visibleSix = false


  # Show/Hide letters in word
      # todo: must keep spaces from drawing
  showLetter: (letter) =>
    if letter.chr in @secretWord
      letter.hidden = true
      @win -= 1
      console.log @win
      if @win == 1
        @visibleWin = true
        @resetAll()
    else
      @wrongChoice()
      @lose += 1
      @showGhost()
      if @lose == 6
        @visibleLose = true
        @resetAll()

  wrongChoice: =>
    console.log "WRONG CHOICE"
    @wrong = true
    @timeout (=>
      @wrong = false
    ), 200

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
      console.log "Modal dismissed"




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
    @play()  if angular.equals(evt.keyCode, 13) and not (angular.equals(@secretPhrase, null) or angular.equals(@secretPhrase, ""))



GameControllers.controller("GameCtrl", ["$scope", "$timeout", "$modal", "$log", GameCtrl])
GameControllers.controller("secretModal", ["$scope", "$modalInstance", ModalControls])


# # AUTOFOCUS FOR MODAL
# # ALSO altered ui-bootstrap-tpls.js:1856 to be friendlier to autofocus
# GameApp.directive "autofocus", ($timeout) ->
#   link: (scope, element) ->
#     $timeout ->
#       element[0].focus()














