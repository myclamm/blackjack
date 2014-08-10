class window.PreviousRoundsView extends Backbone.View

  className: 'previous-rounds'

  #todo: switch to mustache
  template: _.template '<h2>Previous Rounds</h2>'

  initialize: ->
    console.log(@collection, 'Previous Rounds Collection View')
    @render();
    @collection.on 'add', => @render()
    # @collection.on 'win lose', => @render()
    # @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (hand) ->
      debugger;
      new PreviousRoundView(collection: hand)
    # @$('.score').text @collection.scores()

