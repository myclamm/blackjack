assert = chai.assert
expect = chai.expect

describe 'app', ->
  app = null
  deck = null
  hand = null

  beforeEach ->

  describe 'Manually set hands', ->
    it "should expect dealer score to equal only the flipped card", ->
      app = new AppView(model: new App())
      app.model.get('dealerHand').models[0].set('value', 3)
      app.model.get('dealerHand').models[1].set('value', 5)

      expect(app.model.get('dealerHand').scores()[0]).to.equal(5)


  describe 'Automatically start dealer play', ->
    it "should automatically play the dealer's hand when user stands and dealer's score is under 17", ->

      app = new AppView(model: new App())
      app.model.get('playerHand').models[0].set('value', 10)
      app.model.get('playerHand').models[1].set('value', 7)
      app.model.get('dealerHand').models[0].set('value', 3)
      app.model.get('dealerHand').models[1].set('value', 5)

      app.model.get('playerHand').stand()

      expect(app.model.get('dealerHand').length).to.be.at.least(3)

  describe 'Dealer Win', ->
    it "should award win to dealer if dealer's score is to 21 and neither have busted", ->

      app = new AppView(model: new App())

      app.model.get('playerHand').models[0].set('value', 10)
      app.model.get('playerHand').models[1].set('value', 7)

      app.model.get('dealerHand').models[0].set({'value': 10, 'revealed':true})
      app.model.get('dealerHand').models[1].set('value', 1)

      assert.strictEqual app.model.compareScores(), 'you lose'

  describe 'User Win', ->
    it "should award win to user if user's score is closest to 21 and neither have busted", ->
      app = new AppView(model: new App())
      app.model.get('playerHand').models[0].set('value', 10)
      app.model.get('playerHand').models[1].set('value', 1)

      app.model.get('dealerHand').models[0].set({'value': 7, 'revealed':true})
      app.model.get('dealerHand').models[1].set('value', 3)

      assert.strictEqual app.model.compareScores(), 'you win'

  describe 'Ace two scores', ->
    it "should choose the closer of two scores to 21 that are not over 21 when an ace is in the hand", ->
      app = new AppView(model: new App())
      app.model.get('playerHand').models[0].set('value', 7)
      app.model.get('playerHand').models[1].set('value', 1)

      assert.strictEqual app.model.get('playerHand').onlyOneScore(), 18

  describe 'Hidden Ace', ->
    it "should only show the score of the flipped card even if the first card is an ace", ->
      app = new AppView(model: new App())
      app.model.get('playerHand').models[0].set('value', 10)
      app.model.get('playerHand').models[1].set('value', 7)

      app.model.get('dealerHand').models[0].set('value', 1)
      app.model.get('dealerHand').models[1].set('value', 7)

      assert.strictEqual app.model.get('dealerHand').scores().length, 1

  describe 'Storing Previous Rounds', ->
    it "should add the round to the previous rounds collection when game is complete", ->
      app = new AppView(model: new App())
      app.model.get('playerHand').stand()

      assert.strictEqual app.model.get('previousRounds').length, 1

