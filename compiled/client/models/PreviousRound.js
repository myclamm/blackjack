// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.PreviousRound = (function(_super) {
    __extends(PreviousRound, _super);

    function PreviousRound() {
      return PreviousRound.__super__.constructor.apply(this, arguments);
    }

    PreviousRound.prototype.initialize = function(playerHand, dealerHand) {
      console.log('previous round set', playerHand, dealerHand);
      return this.set({
        playerHand: playerHand,
        dealerHand: dealerHand
      });
    };

    return PreviousRound;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=PreviousRound.map
