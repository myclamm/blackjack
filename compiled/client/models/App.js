// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      return App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.initialize = function() {
      var deck, previousRounds;
      this.set('deck', deck = new Deck());
      this.set('playerHand', deck.dealPlayer());
      this.set('dealerHand', deck.dealDealer());
      this.set('previousRounds', previousRounds = new PreviousRounds());
      this.get('previousRounds').add(new PreviousRound(this.get('deck').dealPlayer(), this.get('deck').dealPlayer()));
      console.log('prevRound in App Model', this.get('previousRounds'));
      (this.get('playerHand')).on('loses', (function(_this) {
        return function() {
          return _this.compareScores();
        };
      })(this));
      return (this.get('playerHand')).on('stand', (function(_this) {
        return function() {
          (_this.get('dealerHand')).at(0).flip();
          return _this.dealerPlay();
        };
      })(this));
    };

    App.prototype.dealerPlay = function() {
      var dealerScore;
      dealerScore = (this.get('dealerHand')).scores();
      if (dealerScore.length === 2) {
        if (dealerScore[0] === 21 || dealerScore[1] === 21) {
          this.compareScores();
        } else {
          while (dealerScore[0] < 17 || dealerScore[1] < 17) {
            (this.get('dealerHand')).hit();
            dealerScore = (this.get('dealerHand')).scores();
          }
        }
      } else {
        while (dealerScore[0] < 17) {
          (this.get('dealerHand')).hit();
          dealerScore = (this.get('dealerHand')).scores();
          if (dealerScore.length === 2) {
            this.dealerPlay();
          }
        }
      }
      return this.compareScores();
    };

    App.prototype.compareScores = function() {
      var dealerScore, playerScore;
      playerScore = (this.get('playerHand')).scores();
      dealerScore = (this.get('dealerHand')).scores();
      if (playerScore.length === 2) {
        playerScore = (this.get('playerHand')).onlyOneScore();
      } else {
        playerScore = (this.get('playerHand')).scores()[0];
      }
      if (dealerScore.length === 2) {
        dealerScore = (this.get('dealerHand')).onlyOneScore();
      } else {
        dealerScore = (this.get('dealerHand')).scores()[0];
      }
      if (dealerScore > 21) {
        this.trigger('win');
        return 'you win';
      } else if (playerScore > 21) {
        this.trigger('lose');
        return 'you lose';
      } else if (21 - playerScore < 21 - dealerScore) {
        this.trigger('win');
        return 'you win';
      } else {
        this.trigger('lose');
        return 'you lose';
      }
    };

    return App;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=App.map
