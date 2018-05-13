
$        = require( 'jquery')
Database = require( 'js/util/Database' )

class Rest

  module.exports = Rest # Util.Export( Rest, 'exit/app/Rest' )

  constructor:( @stream  ) ->
    @localURL      = Database.dataURI() + '/exit/'
    @baseURL       = "http://104.154.46.117/"
    @jessURL       = "https://exit-now-admin-jesseporter32.c9.io/"
    @forecastIoURL = "https://api.forecast.io/forecast/"
    @forecastIoKey = '2c52a8974f127eee9de82ea06aadc7fb'
    @currURL       = @baseURL
    @segmentURL    = @currURL + "api/segment"
    @conditionsURL = @currURL + "api/state"
    @dealsURL      = @currURL + "api/deals"
    @cors          = 'json' # jsonp for different origin
    @subscribe()

  subscribe:() ->
    #@stream.subscribe( 'RequestSegments',     (query) =>  @requestSegmentsBy(   query, doSegments,   onSegmentsError   ) )
    #@stream.subscribe( 'RequestConditionsBy', (query) =>  @requestConditionsBy( query, doConditions, onConditionsError ) )
    #@stream.subscribe( 'RequestDealsBy',      (query) =>  @requestDealsBy(      query, doDeals,      onDealsError      ) )
    
  segmentsFromLocal:( direction ) ->
    url  = "#{@localURL}Segments#{direction}.json"
    args = { url:url, direction:direction }
    @read( url, 'Segments', args  )
    return

  conditionsFromLocal:( direction ) ->
    url  = "#{@localURL}Conditions#{direction}.json"
    args = { url:url, direction:direction }
    @read( url, 'Conditions', args )
    return

  # At this point Deals are not queurid by direction
  dealsFromLocal:( direction ) ->
    url  = "#{@localURL}Deals.json"
    args = { url:url, direction:direction }
    @read( url, 'Deals', args )
    return

  milePostsFromLocal:( ) ->
    url  = "#{@localURL}I70Mileposts.json"
    args = { url:url }
    @read( url, 'MilePosts', args )
    return

  # Like the other fromLocal methods this is plural,
  #   because it gets all the forecasts for all the towns
  forecastsFromLocal:( ) ->
    url  = "#{@localURL}Forecasts.json"
    args = { url:url }
    @read( url, 'Forecasts', args)
    return

  segmentsByPreset:( preset ) ->
    args = { preset:preset }
    url  = "#{@segmentURL}?start=1,1&end=1,1&preset=#{preset}"
    @read( url, 'Segments', args )
    return

  conditionsBySegments:( segments ) ->
    args = { segments:segments }
    csv  = @toCsv( segments )
    url  = "#{@conditionsURL}?segments=#{csv}"
    @read( url, 'Conditions', args )
    return

  deals:( latlon, segments ) ->
    args = { segments:segments, lat:latlon[0], lon:latlon[1] }
    csv  = @toCsv( segments )
    url  = "#{@dealsURL}?segments=#{csv}&loc=#{latlon[0]},#{latlon[1]}"
    @read( url, 'Deals', args )
    return

  # Unlike the other rest methods this is singular,
  #   because it has to be called for each towm with its town.lon town.lat and town.time
  forecastByTown:( name, town ) ->
    args = {  name:name, town:town, lat:town.lat, lon:town.lon, time:town.time, hms:Util.toHMS(town.time) }
    #Util.dbg( 'Rest.forecastByTown', args )
    #url  = """#{@forecastIoURL}#{@forecastIoKey}}/#{town.lat},#{town.lon}"""  # ,#{town.time}
    #@read( url, 'Forecast', args, onSuccess, onError )
    @getForecast( args )
    return

  getForecast:( args ) ->
    town = args.town
    key = '2c52a8974f127eee9de82ea06aadc7fb'
    url = """https://api.forecast.io/forecast/#{key}/#{town.lat},#{town.lon}""" # ,#{town.isoDateTime}
    settings = { url:url, type:'GET', dataType:'jsonp', contentType:'text/plain' }
    settings.success = ( json, status, jqXHR ) =>
      @stream.publish( @toSubject('Forecast','get'), @toRestObject( args, json, { url:url, status:status } ) )
      return
    settings.error = ( jqXHR, status, error ) =>
      stream.publish( @toSubject('Forecast','get'), @toRestObject( args, error, { url:url, status:status, readyState:jqXHR.readyState } ) )
      return
    $.ajax( settings )


  # Unlike the other rest methods this is singular,
  #   because it has to be called for each lon lat and time
  forecastByLatLonTime:( lat, lon, time ) ->
    args = { lat:lat, lon:lon, time:Util.toTime(time) }
    url  = """#{@forecastIoURL}#{@forecastIoKey}}/#{lat},#{lon},#{time}"""
    @read( url, 'ForecastTime', args )
    return

  requestSegmentsBy:( query  ) ->
    Util.noop( 'Stream.requestSegmentsBy', query )
    return

  requestConditionsBy:( query  ) ->
    Util.noop( 'Stream.requestConditionsBy', query )
    return

  requestDealsBy:( query ) ->
    Util.noop( 'Stream.requestDealsBy', query )
    return

  segmentsByLatLon:( slat, slon, elat, elon ) ->
    args = { slat:slat, slon:slon, elat:elat, elon:elon }
    url  = "#{@segmentURL}?start=#{slat},#{slon}&end=#{elat},#{elon}"
    @read( url, 'Segments', args )
    return

  segmentsBySegments:( segments ) ->
    args = { segments:segments }
    csv  = @toCsv( segments )
    url  = "#{@segmentURL}?segments=#{csv}"
    @read( url, 'Segments', args )
    return

  # Date is format like 01/01/2015
  conditionsBySegmentsDate:( segments, date ) ->
    args = { segments:segments, date:date }
    csv  = @toCsv( segments )
    url  = "#{@conditionsURL}?segments=#{csv}&setdate=#{date}"
    @read( url, 'Conditions', args )
    return

  dealsByUrl:( url ) ->
    @read( url, 'Deals', {}  )
    return

  # Needs work
  accept:( userId, dealId, convert ) ->
    args = { userId:userId, dealId:dealId, convert:convert }
    url  = "#{@dealsURL}?userId=#{userId}&_id=#{dealId}&convert=#{convert}"
    @post( url, 'Accept', args )
    return

  toSubject:( from, op ) ->
    "#{from}?op=#{op}"

  toRestObject:( params, result, extras ) ->
    params = Util.copyProperties( extras )
    { params:params, result:result }

  fromRestObject:( object ) ->
    # Util.log( 'Rest.fromRestObject', object.params )
    [object.params, object.result]

  read:( url, from, args ) ->
    switch Util.parseURI( url ).protocol
      when 'file:' then @req( url, from, args )
      else              @get( url, from, args )
    return

  req:( url, from, args ) ->
    path = url.substring(5)
    json = Util.require( path )
    if json?
      @stream.publish( @toSubject(from,'get'), @toRestObject( args, json,  { subject:@toSubject(from,'get'), path:path } ) )
    else
      @stream.publish( @toSubject(from,'get'), @toRestObject( args, error, { subject:@toSubject(from,'get'), path:path } ) )
    return

  get:(  url, from, args ) ->
    settings = { url:url, type:'GET', dataType:@cors, contentType:'application/json; charset=utf-8' }
    settings.success = ( json, status, jqXHR ) =>
      @stream.publish( @toSubject(from,'get'), @toRestObject( args, json, { subject:@toSubject(from,'get'), url:url, status:status } ) )
      return
    settings.error = ( jqXHR, status, error ) =>
      @stream.publish( @toSubject(from,'get'), @toRestObject( args, error, { subject:@toSubject(from,'get'), url:url, status:status, readyState:jqXHR.readyState } ) )
      return
    $.ajax( settings )
    return

  # Needs work
  post:( url, from, args ) ->
    settings = { url:url, type:'POST', dataType:'jsonp' } # , contentType:'text/plain'
    settings.success = ( response, status, jqXHR ) =>
      @stream.publish( @toSubject(from,'post'), @toRestObject( args, response, { url:url, status:status } ) )
    settings.error = ( jqXHR, status, error ) =>
      @stream.publish(  @toSubject(from,'post'), @toRestObject( args, error,    { url:url, status:status, readyState:jqXHR.readyState } ) )
      return
    $.ajax( settings )
    return

  toCsv:( array ) ->
    csv = ''
    for a in array
      csv += a.toString() + ','
    csv.substring( 0, csv.length-1 ) # Trim last comma

  segIdNum:( segment ) ->
    id  = ""
    num = 0
    for own key, obj of segment
      len = key.length
      if len >= 2 and 'id' is key.substring(0,1)
        id    = key
        num   = key.substring(0,1)
    [id,num]

  logSegments:( args, obj ) =>
    args.size = segments.length
    segments = obj.segments
    Util.dbg( 'logSegments args', args )
    for segment in segments
      [id,num] = @segIdNum( segment )
      Util.dbg( 'logSegment', { id:id, num:num, name:segment.name } )

  logConditions:( args, conditions ) =>
    args.size = conditions.length
    Util.dbg( 'logConditions args',  args )
    Util.dbg( 'logConditions conds',  )
    for c in conditions
      cc = c['Conditions']
      Util.dbg( '  condition', { SegmentId:c['SegmentId'], TravelTime:cc['TravelTime'], AverageSpeed:cc['AverageSpeed'] } )
      Util.dbg( '  weather', cc['Weather'] )

  logDeals:( args, deals ) =>
    args.size = deals.length
    Util.dbg( 'logDeals args',  args )
    for d in deals
      dd = d['dealData']
      Util.dbg( '  ', { segmentId:dd['segmentId'], lat:d['lat'], lon:d['lon'],  buiness:d['businessName'], description:d['name'] } )

  logMileposts:( args, mileposts ) =>
    args.size = mileposts.length
    Util.dbg( 'logMileposts args',  args )
    for milepost in mileposts
      Util.dbg( '  ', milepost )

  logForecasts:( args, forecasts ) =>
    args.size = forecasts.length
    Util.dbg( 'logForecasts args',  args )
    for forecast in forecasts
      Util.dbg( '  ', forecast )

  # Deprecated
  jsonParse:( url, from, args, json, onSuccess ) ->
    json = json.toString().replace(/(\r\n|\n|\r)/gm,"")  # Remove all line breaks
    Util.dbg( '--------------------------' )
    Util.dbg( json )
    Util.dbg( '--------------------------' )
    try
      objs = JSON.parse(json)
      onSuccess( args, objs )
    catch error
      Util.error( 'Rest.jsonParse()', { url:url, from:from, args:args, error:error } )

  ###
   curl 'https://api.forecast.io/forecast/2c52a8974f127eee9de82ea06aadc7fb/39.759558,-105.654065?callback=jQuery21308299770827870816_1433124323587&_=1433124323588'

  # """https://api.forecast.io/forecast/#{key}/#{loc.lat},#{loc.lon},#{loc.time}"""
  ###