

window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

class Test
  
  constructor:( @ui, @trip ) ->
    Util.log( 'UC Test.constructor' )

  # Trip

  # ThresholdUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # BannerUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # DealsUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # WeatherUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->
    # createForecastHtml:( name, w ) ->
    # updateForecastHtml:( name, w ) ->

  # AdivsoryUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # SearchUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # DriveBarUC
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->
    # onTrip:( trip ) =>
    # createSvg:( $, htmlId, name, ext, width, height, barTop ) ->
    # createBars:( trip ) ->
    # createTravelTime:( trip, g, x, y, w, h ) ->
    # fillCondition:( segId, conditions ) ->
    # fillSpeed:( speed ) ->
    # updateFills:( trip ) ->
    # rect:( trip, g, seg, segId, x0, y0, w, h, fill, stroke, thick, text ) ->
    # onClick
    # doSeqmentDeals:( trip, segId, mile ) ->
    # updateRectFill:( segId, fill ) ->
    # layout2:( orientation ) -> # Transform version
    # svgWidth:()   -> if @orientation is 'Portrait' then @app.width()  * 0.92 else @app.height()
    # svgHeight:()  -> if @orientation is 'Portrait' then @app.height() * 0.33 else @app.width() * 0.50
    # barHeight:()  -> @svgHeight() * 0.33
    # barTop:()     -> @svgHeight() * 0.50



