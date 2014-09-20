GameFactories = angular.module("GameFactories", [])


# MODAL CONTROLS
class ModalControls
  constructor: (@scope, @modal, @modalInstance) ->
    console.log "I'm in the Service"
    # @words = @GameCtrl.secretPhrase
    # console.log @words
    console.log @modalInstance

  cancel: ->
    console.log "CANCEL"
    @modalInstance.dismiss "canceled"

  play: =>
    console.log "PLAY"
    @modalInstance.close @words.secretPhrase

  hitEnter: (evt) ->
    console.log "ENTER"
    @play()  if angular.equals(evt.keyCode, 13) and not (angular.equals(@secretPhrase, null) or angular.equals(@secretPhrase, ""))





GameFactories.factory("ModalControls", [ModalControls])



