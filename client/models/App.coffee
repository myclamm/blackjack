#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'stand', =>
      (@get 'dealerHand').at(0).flip()
      while (@get("dealerHand").scores()[0] < 17) or (@get("dealerHand").scores()[1] < 17 && @get("dealerHand").scores()[1])
        # console.log((@get 'dealerHand').scores())
        (@get 'dealerHand').hit()
        # console.log (@get 'dealerHand').length
      @compareScores()

  compareScores: ->
    if 21-(@get 'playerHand').scores()[0] < 21-(@get 'dealerHand').scores()[0]
      console.log 'you win'
      return 'you win'
    else if 21-(@get 'playerHand').scores()[1] < 21-(@get 'dealerHand').scores()[1]
      console.log 'you win'
      return 'you win'
    else if 21-(@get 'playerHand').scores()[1] < 21-(@get 'dealerHand').scores()[0]
      console.log 'you win'
      return 'you win'
    else if 21-(@get 'playerHand').scores()[0] < 21-(@get 'dealerHand').scores()[1]
      console.log 'you win'
      return 'you win'
    else
      console.log 'you lose in AppView'
      return 'you lose'
