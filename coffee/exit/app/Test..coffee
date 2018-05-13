
window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

class Test

  constructor:( @app, @stream,  @simulate, @rest, @model ) ->
    Util.log( 'Test.constructor' )
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Trip', (trip) => @onTrip( trip ) )

  onTrip:( trip ) ->
    Util.noop( 'App.Test.onTrip()', trip )

# App - not a lot of testing
describe("app/App.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
)

# Stream
describe("app/Stream.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
  # publish
  # subscribe
  # push
  # getContent
  # createRxJQuery
  # subscribeEvent
)

# Simulate  - Drives a lot of functional testing
describe("app/Simulate.coffee", () ->
   it("constructor:() ->         ", () -> expect(true).toBe(true)  )
   # generateLocationsFromMilePosts
)

# Rest
describe("app/Rest.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
  # segmentsFromLocal:(   direction, onSuccess, onError ) ->
  # conditionsFromLocal:( direction, onSuccess, onError ) ->
  # dealsFromLocal:(      direction, onSuccess, onError ) ->
  # milePostsFromLocal:(  onSuccess, onError ) ->
  # forecastsFromLocal:(  onSuccess, onError ) ->
  # segmentsByPreset:( preset, onSuccess, onError  ) ->
  # conditionsBySegments:( segments, onSuccess, onError  ) ->
  # deals:( latlon, segments, onSuccess, onError  ) ->
  # forecastByTown:( name, town, onSuccess, onError ) ->
  # getForecast:( args, onSuccess, onError ) ->
  # forecastByLatLonTime:( lat, lon, time, onSuccess, onError ) ->
  # requestSegmentsBy:( query, onSuccess, onError  ) ->
  # requestConditionsBy:( query, onSuccess, onError  ) ->
  # requestDealsBy:( query, onSuccess, onError  ) ->
  # segmentsByLatLon:( slat, slon, elat, elon, onSuccess, onError ) ->
  # segmentsBySegments:( segments, onSuccess, onError ) ->
  # conditionsBySegmentsDate:( segments, date, onSuccess, onError ) ->
  # dealsByUrl:( url, onSuccess, onError ) ->
  # toCsv:( array ) ->
  # segIdNum:( segment ) ->
)

# Model
describe("app/Model.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
  # ready:() ->
  # subscribe:() ->
  # resetCompletionStatus:() ->
  # createTrip:( source, destination ) ->
  # doTrip:( trip ) ->
  # doTripLocal:( trip ) ->
  # checkComplete:() =>
  # launchTrip:( trip ) ->
  # restForecasts:( trip ) ->
  # doSegments:( args, segments ) =>
  # doConditions:( args, conditions ) =>
  # doDeals:( args, deals ) =>
  # doMilePosts:( args, milePosts ) =>
  # doForecasts:( args, forecasts ) =>
  # doTownForecast:( args, forecast ) =>
  # onSegmentsError:( obj ) =>
  # onConditionsError:( obj ) =>
  # onDealsError:( obj ) =>
  # onForecastsError:( obj ) =>
  # onTownForecastError:( obj ) =>
  # pushForecastsWhenComplete:( forecasts ) ->
  # onMilePostsError:( obj ) =>
  # errorsDetected:() =>
)

# Trip
describe("app/Trip.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
  # initByDirection:( direction ) ->
  # launch:() ->
  # etaFromCondtions:() =>
  # etaHoursMins:() =>
  # makeRecommendation:( ) =>
  # getDealsBySegId:( segId ) ->
  # dealHasSegId:( deal, segId ) ->
)

# Spatial
describe("app/Spatial.coffee", () ->
  # @direction:( source, destination ) ->
  # subscribe:() =>
  # onLocation:( position ) =>
  # segInTrip:( seg ) ->
  # segIdNum:( key ) ->
  # locationFromPosition:( position ) ->
  # locationFromGeo:( geo ) ->
  # pushLocations:() ->
  # pushNavLocations:() ->
  # pushGeoLocators:() ->
  # pushAddressForLatLon:( latLon ) ->
  # seg:( segNum ) ->
  # milePosts:() ->
  # mileSeg:( seg ) ->
  # mileSegs:() ->
  # mileLatLonFCC:( lat1, lon1, lat2, lon2 ) ->
  # mileLatLonSpherical:( lat1, lon1, lat2, lon2 ) ->
  # mileLatLon2:(lat1, lon1, lat2, lon2 ) ->
)
