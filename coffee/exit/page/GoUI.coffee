
$          = require( 'jquery'                )
BannerUC   = require( 'js/exit/uc/BannerUC'   )
DealsUC    = require( 'js/exit/uc/DealsUC'    )
DriveBarUC = require( 'js/exit/uc/DriveBarUC' )

class GoUI

  module.exports = GoUI # Util.Export( GoUI, 'exit/page/GoUI' )

  constructor:( @stream ) ->
    @bannerUC   = new BannerUC(   @stream, 'Go', [4, 2,92,16], [ 2,  4, 24, 46] )
    @dealsUC    = new DealsUC(    @stream, 'Go', [4,20,92,46], [26,  4, 72, 46] )
    @driveBarUC = new DriveBarUC( @stream, 'Go', [4,68,92,30], [ 2, 54, 96, 42] )

  ready:() ->
    @bannerUC.ready()
    @dealsUC.ready()
    @driveBarUC.ready()
    @$ = $( @html() )
    @$.append( @bannerUC.$, @dealsUC.$, @driveBarUC.$ )

  position:( screen ) ->
    @bannerUC  .position( screen )
    @dealsUC   .position( screen )
    @driveBarUC.position( screen )
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Screen', (screen) => @onScreen( screen ) )
    @stream.subscribe( 'Trip',   (trip)   => @onTrip(   trip   ) )

  onScreen:( screen ) ->
    Util.noop( 'GoUI.screen()', screen )

  onTrip:( trip ) ->
    Util.noop('GoUI.onTrip()',   trip.recommendation )

  html:() ->
    """<div id="#{Util.htmlId('GoUI')}" class="#{Util.css('GoUI')}"></div>"""

  show:() -> @$.show()
  hide:() -> @$.hide()