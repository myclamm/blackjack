#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'loses', =>
      @compareScores()

    (@get 'playerHand').on 'stand', =>

      (@get 'dealerHand').at(0).flip()
      @dealerPlay()


  dealerPlay: ->
    dealerScore = (@get 'dealerHand').scores()
    console.log(dealerScore)

    if dealerScore.length == 2
      if dealerScore[0] == 21 || dealerScore[1] == 21
        @compareScores()
      else while (dealerScore[0] < 17 || dealerScore[1] < 17)
        (@get 'dealerHand').hit()
        dealerScore = (@get 'dealerHand').scores()

    else
      while (dealerScore[0] < 17)
        (@get 'dealerHand').hit()
        dealerScore = (@get 'dealerHand').scores()
        if dealerScore.length == 2
          @dealerPlay()

    @compareScores()


  compareScores: ->
    playerScore = (@get 'playerHand').scores()
    dealerScore = (@get 'dealerHand').scores()

    if playerScore.length == 2
      playerScore = (@get 'playerHand').onlyOneScore()
    else
      playerScore = (@get 'playerHand').scores()[0]
    console.log('player Score', playerScore)

    if dealerScore.length == 2
      dealerScore = (@get 'dealerHand').onlyOneScore()
      console.log('dealer Score', dealerScore)
    else
      dealerScore = (@get 'dealerHand').scores()[0]

    if dealerScore > 21
      @trigger('win')
      return 'you win'
    else if playerScore > 21
      @trigger('lose')
      return 'you lose'
    else if 21 - playerScore < 21 - dealerScore
      @trigger('win')
      return 'you win'
    else
      @trigger('lose')
      return 'you lose'
