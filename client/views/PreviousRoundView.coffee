class window.PreviousRoundView extends Backbone.View

  className: 'previous-round'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    debugger;
    array = @collection.map (card) ->
      # card.$el
      console.log('card',card)
    @collection.on 'win lose', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      card.$el
    @$('.score').text @collection.scores()

