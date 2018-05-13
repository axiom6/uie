

window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

class Test
  
  constructor:( @ui, @trip, @destinationUI, @goUI, @tripUI, @navigateUI ) ->
    Util.log( 'Page Test.constructor' )

  # Trip
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->
    
  # UI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->
    # orient:( orientation ) ->
    # changeRecommendation:( recommendation ) ->
    # select:( name ) =>
    # width
    # height

  # DestinationUI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # GoUI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # TripUI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # DealsUI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->

  # NavigateUI
    # html:() ->
    # ready:() ->
    # $ready;() ->
    # position:() ->
    # subscribe:() ->
    # onLocation:( location ) ->
    # layout:( orientation ) ->




