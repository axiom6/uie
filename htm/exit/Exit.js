// Generated by CoffeeScript 1.10.0
(function() {
  var Exit;

  Exit = (function() {
    Exit.init = function() {
      return Util.ready(function() {
        return Util.app = new Exit('Local');
      });
    };

    function Exit(dataSource) {
      var $, Data, DealsUI, DestinationUI, GoUI, Model, NavigateUI, Page, Rest, Simulate, Stream, TripUI;
      this.dataSource = dataSource != null ? dataSource : 'RestThenLocal';
      this.subjectNames = ['Icons', 'Location', 'Screen', 'Source', 'Destination', 'Trip', 'Forecasts'];
      Stream = require('js/util/Stream');
      Rest = require('js/exit/app/Rest');
      Data = require('js/exit/app/Data');
      Model = require('js/exit/app/Model');
      Simulate = require('js/exit/app/Simulate');
      DestinationUI = require('js/exit/page/DestinationUI');
      GoUI = require('js/exit/page/GoUI');
      TripUI = require('js/exit/page/TripUI');
      DealsUI = require('js/exit/page/DealsUI');
      NavigateUI = require('js/exit/page/NavigateUI');
      Page = require('js/exit/page/Page');
      this.stream = new Stream(this.subjectNames);
      this.rest = new Rest(this.stream);
      this.model = new Model(this.stream, this.rest, this.dataSource);
      this.destinationUI = new DestinationUI(this.stream, this.thresholdUC);
      this.goUI = new GoUI(this.stream);
      this.tripUI = new TripUI(this.stream);
      this.dealsUI = new DealsUI(this.stream);
      this.navigateUI = new NavigateUI(this.stream);
      this.page = new Page(this.stream, this.destinationUI, this.goUI, this.tripUI, this.dealsUI, this.navigateUI);
      this.ready();
      this.position(this.page.toScreen('Portrait'));
      this.simulate = new Simulate(this, this.stream);
      if (Util.hasModule('exit/App.Test', false)) {
        $ = require('jquery');
        $('body').css({
          "background-image": "none"
        });
        $('#App').hide();
        this.appTest = new App.Test(this, this.stream, this.simulate, this.rest, this.model);
      }
      if (Util.hasModule('page/Page.Test', false)) {
        this.pageTest = new Page.Test(this.ui, this.trip, this.destinationUI, this.goUI, this.tripUI, this.navigateUI);
      }
    }

    Exit.prototype.ready = function() {
      this.model.ready();
      return this.page.ready();
    };

    Exit.prototype.position = function(screen) {
      return this.page.position(screen);
    };

    return Exit;

  })();

  Exit.init();

}).call(this);
