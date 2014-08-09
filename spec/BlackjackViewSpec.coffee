assert = chai.assert
expect = chai.expect

describe 'app', ->
  app = null
  deck = null
  hand = null

  beforeEach ->

  describe 'Manually set hands', ->
    it "should expect dealer score to equal 8", ->
      app = new AppView(model: new App())
      app.model.get('dealerHand').models[0].set('value', 3)
      app.model.get('dealerHand').models[1].set('value', 5)

      expect(app.model.get('dealerHand').scores()[0]).to.equal(8)


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
      console.log('playerHand1', app.model.get('playerHand'))
      app.model.get('playerHand').models[0].set('value', 10)
      app.model.get('playerHand').models[1].set('value', 7)
      console.log('playerHand2', app.model.get('playerHand'))

      console.log('dealerHand1', app.model.get('dealerHand'))
      app.model.get('dealerHand').models[0].set({'value': 10, 'revealed':true})
      app.model.get('dealerHand').models[1].set('value', 1)
      console.log(app.model.get('dealerHand').scores(), app.model.get('playerHand').scores())
      # debugger;
      # compareScores is failing! Fix this
      assert.strictEqual app.model.compareScores(), 'you lose'

  describe 'User Win', ->
    it "should award win to user if user's score is closest to 21 and neither have busted", ->
      assert.strictEqual app.model.compareScores(), undefined

  describe 'Dealer Hit', ->
    it "should keep hitting until dealer has a score greater than or equal to 17", ->
      assert.strictEqual app.model.compareScores(), undefined

  describe 'Dealer Bust', ->
    it "should stop hitting dealer's hand when they've busted", ->
      assert.strictEqual app.model.compareScores(), undefined
