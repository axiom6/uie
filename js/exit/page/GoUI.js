// Generated by CoffeeScript 1.10.0
(function() {
  var $, BannerUC, DealsUC, DriveBarUC, GoUI;

  $ = require('jquery');

  BannerUC = require('js/exit/uc/BannerUC');

  DealsUC = require('js/exit/uc/DealsUC');

  DriveBarUC = require('js/exit/uc/DriveBarUC');

  GoUI = (function() {
    module.exports = GoUI;

    function GoUI(stream) {
      this.stream = stream;
      this.bannerUC = new BannerUC(this.stream, 'Go', [4, 2, 92, 16], [2, 4, 24, 46]);
      this.dealsUC = new DealsUC(this.stream, 'Go', [4, 20, 92, 46], [26, 4, 72, 46]);
      this.driveBarUC = new DriveBarUC(this.stream, 'Go', [4, 68, 92, 30], [2, 54, 96, 42]);
    }

    GoUI.prototype.ready = function() {
      this.bannerUC.ready();
      this.dealsUC.ready();
      this.driveBarUC.ready();
      this.$ = $(this.html());
      return this.$.append(this.bannerUC.$, this.dealsUC.$, this.driveBarUC.$);
    };

    GoUI.prototype.position = function(screen) {
      this.bannerUC.position(screen);
      this.dealsUC.position(screen);
      this.driveBarUC.position(screen);
      return this.subscribe();
    };

    GoUI.prototype.subscribe = function() {
      this.stream.subscribe('Screen', (function(_this) {
        return function(screen) {
          return _this.onScreen(screen);
        };
      })(this));
      return this.stream.subscribe('Trip', (function(_this) {
        return function(trip) {
          return _this.onTrip(trip);
        };
      })(this));
    };

    GoUI.prototype.onScreen = function(screen) {
      return Util.noop('GoUI.screen()', screen);
    };

    GoUI.prototype.onTrip = function(trip) {
      return Util.noop('GoUI.onTrip()', trip.recommendation);
    };

    GoUI.prototype.html = function() {
      return "<div id=\"" + (Util.htmlId('GoUI')) + "\" class=\"" + (Util.css('GoUI')) + "\"></div>";
    };

    GoUI.prototype.show = function() {
      return this.$.show();
    };

    GoUI.prototype.hide = function() {
      return this.$.hide();
    };

    return GoUI;

  })();

}).call(this);