class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="previous-hands-container"></div>
  '

  events:
    "click .hit-button": ->
      if @model.get('playerHand').scores().length == 2
        if @model.get('playerHand').scores()[0] < 21 || @model.get('playerHand').scores()[1] < 21
          @model.get('playerHand').hit()
      else
        if @model.get('playerHand').scores()[0] < 21
          @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->

    @render()

    @model.on 'win', =>
      @model.get('previousRounds').add new PreviousRound(@model.get('playerHand'), @model.get('dealerHand'))
      # console.log(@model.get 'previousRounds')
      @$el.append('<span>You Win!</span>')
    @model.on 'lose', =>
      @model.get('previousRounds').add new PreviousRound(@model.get('playerHand'), @model.get('dealerHand'))
      # console.log(@model.get 'previousRounds')
      @$el.append('<span>You Lose!</span>')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.previous-hands-container').html new PreviousRoundsView(collection: @model.get 'previousRounds').el
