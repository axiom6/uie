
Data = require( 'js/exit/app/Data' )  # We occasionally need to key of some static data at this point of the project
Trip = require( 'js/exit/app/Trip' )

class Model

  module.exports = Model # Util.Export( Model, 'exit/app/Model' )

  constructor:( @stream, @rest, @dataSource ) ->

    @first       = true                       # Implies we have not acquired enough data to get started
    @subsReq     = 0
    @subsRes     = 0
    @status      = true
    @source      = '?'
    @destination = '?'
    @trips       = {}
    @segments           = []
    @conditions         = []
    @deals              = []
    @forecasts          = {}
    @forecastsPending    = 0
    @forecastsCount     = 0
    @milePosts          = []
    @segmentIds         = Data.WestSegmentIds  # CDOT road speed segment for Demo I70 West from 6th Ave to East Vail
    @segmentIdsReturned = []                    # Accumulate by doSegments()

  ready:() ->
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Source',      (source)      => @onSource(      source      ) )
    @stream.subscribe( 'Destination', (destination) => @onDestination( destination ) )
    @stream.subscribe( @rest.toSubject('Segments',  'get'), @doSegments,   @onSegmentsError   )
    @stream.subscribe( @rest.toSubject('Conditions','get'), @doConditions, @onConditionsError )
    @stream.subscribe( @rest.toSubject('Deals',     'get'), @doDeals,      @onDealsError      )
    @stream.subscribe( @rest.toSubject('MilePosts', 'get'), @doMilePosts,  @onMilePostsError  )
    @stream.subscribe( @rest.toSubject('Forecasts', 'get'), @doForecasts,  @onForecastsError  )

  onSource:(  source ) =>
    #Util.dbg( 'Model.onSource()', source )
    @source = source
    if @destination isnt '?' and @source isnt @destination
      @createTrip( @source, @destination )
    return

  onDestination:(  destination ) =>
    #Util.dbg( 'Model.onDestin()', destination )
    @destination = destination
    if @source isnt '?'  and @source isnt @destination
      @createTrip( @source, @destination )
    return

  tripName:( source, destination ) ->
    "#{source}To#{destination}"

  trip:() ->
    @trips[ @tripName( @source, @destination ) ]

# The Trip parameter calculation process here needs to be refactored
  createTrip:( source, destination ) ->
    Util.dbg( 'Model.createTrip()', source, destination )
    @source      = source
    @destination = destination
    name         = @tripName( @source, @destination )
    @trips[name] = new Trip( @stream, @, name, source, destination )
    switch @dataSource
      when 'Rest',  'RestThenLocal'  then @doTrip(      @trips[name] )
      when 'Local', 'LocalForecasts' then @doTripLocal( @trips[name] )
      else Util.error( 'Model.createTrip() unknown dataSource', @dataSource )
    return

  completeSubjects:( froms, op ) ->
    subs = []
    for from in froms
      subs.push( @rest.toSubject(from,op) )
    subs

  doTrip:( trip ) ->
    froms    =['Segments','Conditions','Deals','Forecasts','MilePosts']
    subs     = @completeSubjects(froms,'get')
    @subsReq = subs.length
    @subsRes = 0
    @stream.concat( 'TripDataComplete', subs, () => @launchTrip(trip)  )
    @rest.segmentsByPreset(             trip.preset        )
    @rest.conditionsBySegments(         trip.segmentIdsAll )
    @rest.deals( @app.dealsUI.latLon(), trip.segmentIdsAll )
    @rest.forecastsFromLocal(                              )
    @rest.milePostsFromLocal(                              )
    return

  doTripLocal:( trip ) ->
    Util.dbg( 'Model.doTripLocal()', trip.source, trip.destination )
    froms = ['Segments','Conditions','Deals']
    froms = froms.concat( 'Forecasts','MilePosts' )  if @dataSource is 'Local'
    subs  = @completeSubjects(froms,'get')
    @subsReq = subs.length
    @subsRes = 0
    # Util.dbg( 'Model.doTripLocal()', @dataSource, @subsReq, @subsRes, froms, subs )
    @stream.concat( 'TripLocalComplete', subs, () => @launchTrip(trip)    )
    @rest.segmentsFromLocal(   trip.direction )
    @rest.conditionsFromLocal( trip.direction )
    @rest.dealsFromLocal(      trip.direction )
    @rest.forecastsFromLocal(                 ) if @dataSource is 'Local'
    @rest.milePostsFromLocal(                 ) if @dataSource is 'Local'
    return

  launchTrip:( trip ) ->
    # Util.dbg( 'Model.launchTrip()' )
    @first = false
    trip.launch()
    @stream.publish( 'Trip', trip )
    if @dataSource isnt 'Local'
      @restForecasts( trip ) # Will punlish forecasts on Stream when completed
    return

  # Makes a rest call for each town in the Trip, and checks completion for each town
  #   so it does not have forecastComplete or forecastCompleteWithError flags
  restForecasts:( trip ) ->
    @forecastsPending  = 0
    @forecastsCount    = 0
    for own name, town of trip.towns
      date             = new Date()
      town.date        = date
      town.time        = town.date.getTime()
      #town.isoDateTime = Util.isoDateTime(date)
      @forecastsPending++
    for own name, town of trip.towns
      @rest.forecastByTown( name, town, @doTownForecast, @onTownForecastError )
    return

  doSegments:( object ) =>
    [args,segments] = @rest.fromRestObject( object )
    trip            = @trip()
    trip.travelTime = segments.travelTime
    trip.segments   = []
    trip.segmentIds = []
    for own key, seg of segments.segments
      [id,num]  = trip.segIdNum( key )
      # Util.dbg( 'Model.doSegments id num', { id:id, num:num, beg:seg.StartMileMarker, end:seg.EndMileMarker } )
      if trip.segInTrip( seg )
        seg['segId'] = num
        seg.num = num
        trip.segments.  push( seg )
        trip.segmentIds.push( num )
    @checkStatus( true )
    return

  doConditions:( object ) =>
    [args,conditions]   = @rest.fromRestObject( object )
    @trip().conditions  = conditions
    @checkStatus( true )
    return

  doDeals:( object ) =>
    [args,deals]  = @rest.fromRestObject( object )
    @trip().deals = deals
    @checkStatus( true )
    return

  doMilePosts:( object ) =>
    [args,milePosts]  = @rest.fromRestObject( object )
    @milePosts = milePosts
    @trip().milePosts = milePosts
    @checkStatus( true )
    return

  doForecasts:( object ) =>
    [args,forecasts]  = @rest.fromRestObject( object )
    trip = @trip()
    for own name, forecast of forecasts
      trip.forecasts[name]       = forecast
      trip.forecasts[name].index = Trip.Towns[name].index
    @stream.publish( 'Forecasts', trip.forecasts, 'Model' )
    @checkStatus( true )
    return

  doTownForecast:( object ) =>
    [args,forecast]            = @rest.fromRestObject( object )
    name                       = args.name
    trip                       = @trip()
    trip.forecasts[name]       = forecast
    trip.forecasts[name].index = Trip.Towns[name].index
    @publishForecastsWhenComplete( trip.forecasts )
    return

  onSegmentsError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    Util.error( 'Model.onSegmentError()', args, error )
    @checkStatus( false )
    return

  onConditionsError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    Util.error( 'Model.onConditionsError()', args, error )
    @checkStatus( false )
    return

  onDealsError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    Util.error( 'Model.onDealsError()', args, error )
    @checkStatus( false )
    return

  onForecastsError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    Util.error( 'Model.onForecastsError()', args, error )
    @checkStatus( false )
    return

  onTownForecastError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    name = args.name
    Util.error( 'Model.townForecastError()', { name:name }, args, error )
    @publishForecastsWhenComplete( @trip().forecasts ) # We push on error because some forecasts may have made it through
    return

  publishForecastsWhenComplete:( forecasts ) ->
    @forecastsCount++
    if @forecastsCount is @forecastsPending
      @stream.publish( 'Forecasts', forecasts )
      @forecastsPending = 0 # No more pending forecasts after push
    return

  onMilePostsError:( object ) =>
    [args,error] = @rest.fromRestObject( object )
    Util.error( 'Model.onMilePostsError()', args, error )
    @checkStatus( false )
    return

  # Still a hold over for not being able to detect partial completion on streams
  checkStatus:( status ) ->
    @subsRes++
    @status = @status and status
    #Util.dbg( 'Model.checkStatus()', { complete:@status, status:status, subsReq:@subsReq, subsRes:@subsRes } )
    @doTripLocal( @trip() ) if @dataSource isnt 'Local' and not @status and @subsRes is @subsReq
    return
