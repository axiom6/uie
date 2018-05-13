
$          = require('jquery')
WeatherUC  = require( 'js/exit/uc/WeatherUC'  )
AdvisoryUC = require( 'js/exit/uc/AdvisoryUC' )
DriveBarUC = require( 'js/exit/uc/DriveBarUC' )

class TripUI

  module.exports = TripUI # Util.Export( TripUI, 'exit/page/TripUI' )

  constructor:( @stream ) ->

    @weatherUC    = new WeatherUC(  @stream, 'Trip', [0,  0, 100, 54], [0,  0, 100, 50] )
    @advisoryUC   = new AdvisoryUC( @stream, 'Trip', [0, 54, 100, 10], [0, 50, 100, 10] )
    @driveBarUC   = new DriveBarUC( @stream, 'Trip', [4, 64,  92, 36], [4, 60,  92, 40] )

  ready:() ->
    @weatherUC.ready()
    @advisoryUC.ready()
    @driveBarUC.ready()
    @$ = $( @html() )
    @$.append( @weatherUC.$, @advisoryUC.$, @driveBarUC.$ )

  position:( screen ) ->
    @weatherUC.position(  screen )
    @advisoryUC.position( screen )
    @driveBarUC.position( screen )
    @subscribe()

  # Trip subscribe to the full Monty of change
  subscribe:() ->
    @stream.subscribe( 'Screen', (screen)   => @onScreen( screen ) )

  # All positioning happens in the components
  onScreen:( screen ) ->
    Util.noop( 'TripUI.onScreen()', screen )

  html:() ->
    """<div id="#{Util.htmlId('TripUI')}" class="#{Util.css('TripUI')}"></div>"""

  show:() -> @$.show()

  hide:() -> @$.hide()


