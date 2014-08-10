class window.PreviousRounds extends Backbone.Collection

  model: PreviousRound
  localStorage: new Backbone.LocalStorage("PreviousRounds")

  initialize: () ->
    @on 'add', (round) =>
      # @fetch()
      console.log('this', this)
      # round.save()

