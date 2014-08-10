class window.PreviousRound extends Backbone.Model

  initialize: (playerHand, dealerHand) ->
    console.log('previous round set', playerHand, dealerHand)
    @set
      playerHand: playerHand
      dealerHand: dealerHand
