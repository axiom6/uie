// Generated by CoffeeScript 1.10.0
(function() {
  var Data, Spatial, Trip,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Data = require('js/exit/app/Data');

  Spatial = require('js/exit/app/Spatial');

  Trip = (function() {
    module.exports = Trip;

    Trip.Towns = {
      "Evergreen": {
        index: 1,
        lon: -105.334724,
        lat: 39.701735,
        name: "Evergreen"
      },
      "US40": {
        index: 2,
        lon: -105.654065,
        lat: 39.759558,
        name: "US40"
      },
      "EastTunnel": {
        index: 3,
        lon: -105.891111,
        lat: 39.681757,
        name: "East Tunnel"
      },
      "WestTunnel": {
        index: 4,
        lon: -105.878342,
        lat: 39.692400,
        name: "West Tunnel"
      },
      "Silverthorne": {
        index: 5,
        lon: -106.072685,
        lat: 39.624160,
        name: "Silverthorne"
      },
      "CopperMtn": {
        index: 6,
        lon: -106.147382,
        lat: 39.503512,
        name: "Copper Mtn"
      },
      "VailPass": {
        index: 7,
        lon: -106.216071,
        lat: 39.531042,
        name: "Vail Pass"
      },
      "Vail": {
        index: 8,
        lon: -106.378767,
        lat: 39.644407,
        name: "Vail"
      }
    };

    function Trip(stream, model, name1, source, destination) {
      this.stream = stream;
      this.model = model;
      this.name = name1;
      this.source = source;
      this.destination = destination;
      this.makeRecommendation = bind(this.makeRecommendation, this);
      this.etaHoursMins = bind(this.etaHoursMins, this);
      this.etaFromCondtions = bind(this.etaFromCondtions, this);
      this.eta = -1;
      this.travelTime = -1;
      this.recommendation = '?';
      this.preset = -1;
      this.segmentIdsAll = [];
      this.segmentIds = [];
      this.segments = [];
      this.conditions = [];
      this.deals = [];
      this.towns = Trip.Towns;
      this.forecasts = {};
      this.begTown = this.toTown(this.source, 'Source');
      this.endTown = this.toTown(this.destination, 'Destination');
      this.spatial = new Spatial(this.stream, this);
      this.direction = Spatial.direction(this.source, this.destination);
      this.initByDirection(this.direction);
    }

    Trip.prototype.toTown = function(name, role) {
      return {
        name: name,
        role: role,
        mile: Data.DestinationsMile[name]
      };
    };

    Trip.prototype.initByDirection = function(direction) {
      switch (direction) {
        case 'West':
          this.preset = 2;
          return this.segmentIdsAll = Data.WestSegmentIds;
        case 'East':
          this.preset = 1;
          return this.segmentIdsAll = Data.EastSegmentIds;
        default:
          return Util.error('Trip unknown direction', direction);
      }
    };

    Trip.prototype.begMile = function() {
      return this.begTown.mile;
    };

    Trip.prototype.endMile = function() {
      return this.endTown.mile;
    };

    Trip.prototype.segInTrip = function(seg) {
      return this.spatial.segInTrip(seg);
    };

    Trip.prototype.segIdNum = function(key) {
      return this.spatial.segIdNum(key);
    };

    Trip.prototype.launch = function() {
      this.eta = this.etaFromCondtions();
      this.recommendation = this.makeRecommendation();
      return this.log('Trip.launch()');
    };

    Trip.prototype.etaFromCondtions = function() {
      var condition, eta, i, len, ref;
      eta = 0;
      ref = this.conditions;
      for (i = 0, len = ref.length; i < len; i++) {
        condition = ref[i];
        eta += Util.toFloat(condition.Conditions.TravelTime);
      }
      return eta;
    };

    Trip.prototype.etaHoursMins = function() {
      return Util.toInt(this.eta / 60) + ' Hours ' + this.eta % 60 + ' Mins';
    };

    Trip.prototype.makeRecommendation = function() {
      if (this.destination === 'Copper Mtn') {
        return 'NO GO';
      } else {
        return 'GO';
      }
    };

    Trip.prototype.getDealsBySegId = function(segId) {
      var deal, i, len, ref, segDeals;
      segDeals = [];
      ref = this.deals;
      for (i = 0, len = ref.length; i < len; i++) {
        deal = ref[i];
        if (this.dealHasSegId(deal, segId)) {
          segDeals.push(deal);
        }
      }
      return segDeals;
    };

    Trip.prototype.dealHasSegId = function(deal, segId) {
      var i, len, ref, seq;
      ref = deal.dealData.onSegments;
      for (i = 0, len = ref.length; i < len; i++) {
        seq = ref[i];
        if (seq.segmentId === segId) {
          return true;
        }
      }
      return false;
    };

    Trip.prototype.log = function(caller) {
      return Util.dbg(caller, {
        source: this.source,
        destination: this.destination,
        direction: this.direction,
        preset: this.preset,
        recommendation: this.recommendation,
        eta: this.eta,
        travelTime: this.travelTime
      });
    };

    return Trip;

  })();

}).call(this);
