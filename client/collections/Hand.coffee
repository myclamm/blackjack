class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

    @on 'add', (card) -> if (@scores()[0] > 21) then @trigger 'loses'

    #   if(this.scores()[0] > 21 || this.scores()[1] > 21){
    #     this.trigger('loses')
    #   }


# @collection.on 'add remove change', => @render()

  stand: =>
    @trigger 'stand'

  hit: ->
    @add(@deck.pop()).last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if (hasAce && @models[0].get 'revealed') then [score, score + 10] else [score]

  onlyOneScore : ->
    if(@scores()[0] > 21 && @scores()[1] <= 21)
      return @scores()[1]
    else if(@scores()[1] > 21 && @scores()[0] <= 21)
      return @scores()[0]
    else if(21 - @scores()[0] < 21 - @scores()[1])
      return @scores()[0]
    else
      return @scores()[1]
