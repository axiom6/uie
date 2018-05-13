// Generated by CoffeeScript 1.10.0
(function() {
  var Data, Model, Trip,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    hasProp = {}.hasOwnProperty;

  Data = require('js/exit/app/Data');

  Trip = require('js/exit/app/Trip');

  Model = (function() {
    module.exports = Model;

    function Model(stream, rest, dataSource) {
      this.stream = stream;
      this.rest = rest;
      this.dataSource = dataSource;
      this.onMilePostsError = bind(this.onMilePostsError, this);
      this.onTownForecastError = bind(this.onTownForecastError, this);
      this.onForecastsError = bind(this.onForecastsError, this);
      this.onDealsError = bind(this.onDealsError, this);
      this.onConditionsError = bind(this.onConditionsError, this);
      this.onSegmentsError = bind(this.onSegmentsError, this);
      this.doTownForecast = bind(this.doTownForecast, this);
      this.doForecasts = bind(this.doForecasts, this);
      this.doMilePosts = bind(this.doMilePosts, this);
      this.doDeals = bind(this.doDeals, this);
      this.doConditions = bind(this.doConditions, this);
      this.doSegments = bind(this.doSegments, this);
      this.onDestination = bind(this.onDestination, this);
      this.onSource = bind(this.onSource, this);
      this.first = true;
      this.subsReq = 0;
      this.subsRes = 0;
      this.status = true;
      this.source = '?';
      this.destination = '?';
      this.trips = {};
      this.segments = [];
      this.conditions = [];
      this.deals = [];
      this.forecasts = {};
      this.forecastsPending = 0;
      this.forecastsCount = 0;
      this.milePosts = [];
      this.segmentIds = Data.WestSegmentIds;
      this.segmentIdsReturned = [];
    }

    Model.prototype.ready = function() {
      return this.subscribe();
    };

    Model.prototype.subscribe = function() {
      this.stream.subscribe('Source', (function(_this) {
        return function(source) {
          return _this.onSource(source);
        };
      })(this));
      this.stream.subscribe('Destination', (function(_this) {
        return function(destination) {
          return _this.onDestination(destination);
        };
      })(this));
      this.stream.subscribe(this.rest.toSubject('Segments', 'get'), this.doSegments, this.onSegmentsError);
      this.stream.subscribe(this.rest.toSubject('Conditions', 'get'), this.doConditions, this.onConditionsError);
      this.stream.subscribe(this.rest.toSubject('Deals', 'get'), this.doDeals, this.onDealsError);
      this.stream.subscribe(this.rest.toSubject('MilePosts', 'get'), this.doMilePosts, this.onMilePostsError);
      return this.stream.subscribe(this.rest.toSubject('Forecasts', 'get'), this.doForecasts, this.onForecastsError);
    };

    Model.prototype.onSource = function(source) {
      this.source = source;
      if (this.destination !== '?' && this.source !== this.destination) {
        this.createTrip(this.source, this.destination);
      }
    };

    Model.prototype.onDestination = function(destination) {
      this.destination = destination;
      if (this.source !== '?' && this.source !== this.destination) {
        this.createTrip(this.source, this.destination);
      }
    };

    Model.prototype.tripName = function(source, destination) {
      return source + "To" + destination;
    };

    Model.prototype.trip = function() {
      return this.trips[this.tripName(this.source, this.destination)];
    };

    Model.prototype.createTrip = function(source, destination) {
      var name;
      Util.dbg('Model.createTrip()', source, destination);
      this.source = source;
      this.destination = destination;
      name = this.tripName(this.source, this.destination);
      this.trips[name] = new Trip(this.stream, this, name, source, destination);
      switch (this.dataSource) {
        case 'Rest':
        case 'RestThenLocal':
          this.doTrip(this.trips[name]);
          break;
        case 'Local':
        case 'LocalForecasts':
          this.doTripLocal(this.trips[name]);
          break;
        default:
          Util.error('Model.createTrip() unknown dataSource', this.dataSource);
      }
    };

    Model.prototype.completeSubjects = function(froms, op) {
      var from, i, len, subs;
      subs = [];
      for (i = 0, len = froms.length; i < len; i++) {
        from = froms[i];
        subs.push(this.rest.toSubject(from, op));
      }
      return subs;
    };

    Model.prototype.doTrip = function(trip) {
      var froms, subs;
      froms = ['Segments', 'Conditions', 'Deals', 'Forecasts', 'MilePosts'];
      subs = this.completeSubjects(froms, 'get');
      this.subsReq = subs.length;
      this.subsRes = 0;
      this.stream.concat('TripDataComplete', subs, (function(_this) {
        return function() {
          return _this.launchTrip(trip);
        };
      })(this));
      this.rest.segmentsByPreset(trip.preset);
      this.rest.conditionsBySegments(trip.segmentIdsAll);
      this.rest.deals(this.app.dealsUI.latLon(), trip.segmentIdsAll);
      this.rest.forecastsFromLocal();
      this.rest.milePostsFromLocal();
    };

    Model.prototype.doTripLocal = function(trip) {
      var froms, subs;
      Util.dbg('Model.doTripLocal()', trip.source, trip.destination);
      froms = ['Segments', 'Conditions', 'Deals'];
      if (this.dataSource === 'Local') {
        froms = froms.concat('Forecasts', 'MilePosts');
      }
      subs = this.completeSubjects(froms, 'get');
      this.subsReq = subs.length;
      this.subsRes = 0;
      this.stream.concat('TripLocalComplete', subs, (function(_this) {
        return function() {
          return _this.launchTrip(trip);
        };
      })(this));
      this.rest.segmentsFromLocal(trip.direction);
      this.rest.conditionsFromLocal(trip.direction);
      this.rest.dealsFromLocal(trip.direction);
      if (this.dataSource === 'Local') {
        this.rest.forecastsFromLocal();
      }
      if (this.dataSource === 'Local') {
        this.rest.milePostsFromLocal();
      }
    };

    Model.prototype.launchTrip = function(trip) {
      this.first = false;
      trip.launch();
      this.stream.publish('Trip', trip);
      if (this.dataSource !== 'Local') {
        this.restForecasts(trip);
      }
    };

    Model.prototype.restForecasts = function(trip) {
      var date, name, ref, ref1, town;
      this.forecastsPending = 0;
      this.forecastsCount = 0;
      ref = trip.towns;
      for (name in ref) {
        if (!hasProp.call(ref, name)) continue;
        town = ref[name];
        date = new Date();
        town.date = date;
        town.time = town.date.getTime();
        this.forecastsPending++;
      }
      ref1 = trip.towns;
      for (name in ref1) {
        if (!hasProp.call(ref1, name)) continue;
        town = ref1[name];
        this.rest.forecastByTown(name, town, this.doTownForecast, this.onTownForecastError);
      }
    };

    Model.prototype.doSegments = function(object) {
      var args, id, key, num, ref, ref1, ref2, seg, segments, trip;
      ref = this.rest.fromRestObject(object), args = ref[0], segments = ref[1];
      trip = this.trip();
      trip.travelTime = segments.travelTime;
      trip.segments = [];
      trip.segmentIds = [];
      ref1 = segments.segments;
      for (key in ref1) {
        if (!hasProp.call(ref1, key)) continue;
        seg = ref1[key];
        ref2 = trip.segIdNum(key), id = ref2[0], num = ref2[1];
        if (trip.segInTrip(seg)) {
          seg['segId'] = num;
          seg.num = num;
          trip.segments.push(seg);
          trip.segmentIds.push(num);
        }
      }
      this.checkStatus(true);
    };

    Model.prototype.doConditions = function(object) {
      var args, conditions, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], conditions = ref[1];
      this.trip().conditions = conditions;
      this.checkStatus(true);
    };

    Model.prototype.doDeals = function(object) {
      var args, deals, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], deals = ref[1];
      this.trip().deals = deals;
      this.checkStatus(true);
    };

    Model.prototype.doMilePosts = function(object) {
      var args, milePosts, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], milePosts = ref[1];
      this.milePosts = milePosts;
      this.trip().milePosts = milePosts;
      this.checkStatus(true);
    };

    Model.prototype.doForecasts = function(object) {
      var args, forecast, forecasts, name, ref, trip;
      ref = this.rest.fromRestObject(object), args = ref[0], forecasts = ref[1];
      trip = this.trip();
      for (name in forecasts) {
        if (!hasProp.call(forecasts, name)) continue;
        forecast = forecasts[name];
        trip.forecasts[name] = forecast;
        trip.forecasts[name].index = Trip.Towns[name].index;
      }
      this.stream.publish('Forecasts', trip.forecasts, 'Model');
      this.checkStatus(true);
    };

    Model.prototype.doTownForecast = function(object) {
      var args, forecast, name, ref, trip;
      ref = this.rest.fromRestObject(object), args = ref[0], forecast = ref[1];
      name = args.name;
      trip = this.trip();
      trip.forecasts[name] = forecast;
      trip.forecasts[name].index = Trip.Towns[name].index;
      this.publishForecastsWhenComplete(trip.forecasts);
    };

    Model.prototype.onSegmentsError = function(object) {
      var args, error, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      Util.error('Model.onSegmentError()', args, error);
      this.checkStatus(false);
    };

    Model.prototype.onConditionsError = function(object) {
      var args, error, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      Util.error('Model.onConditionsError()', args, error);
      this.checkStatus(false);
    };

    Model.prototype.onDealsError = function(object) {
      var args, error, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      Util.error('Model.onDealsError()', args, error);
      this.checkStatus(false);
    };

    Model.prototype.onForecastsError = function(object) {
      var args, error, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      Util.error('Model.onForecastsError()', args, error);
      this.checkStatus(false);
    };

    Model.prototype.onTownForecastError = function(object) {
      var args, error, name, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      name = args.name;
      Util.error('Model.townForecastError()', {
        name: name
      }, args, error);
      this.publishForecastsWhenComplete(this.trip().forecasts);
    };

    Model.prototype.publishForecastsWhenComplete = function(forecasts) {
      this.forecastsCount++;
      if (this.forecastsCount === this.forecastsPending) {
        this.stream.publish('Forecasts', forecasts);
        this.forecastsPending = 0;
      }
    };

    Model.prototype.onMilePostsError = function(object) {
      var args, error, ref;
      ref = this.rest.fromRestObject(object), args = ref[0], error = ref[1];
      Util.error('Model.onMilePostsError()', args, error);
      this.checkStatus(false);
    };

    Model.prototype.checkStatus = function(status) {
      this.subsRes++;
      this.status = this.status && status;
      if (this.dataSource !== 'Local' && !this.status && this.subsRes === this.subsReq) {
        this.doTripLocal(this.trip());
      }
    };

    return Model;

  })();

}).call(this);