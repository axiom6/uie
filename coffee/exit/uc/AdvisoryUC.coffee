
$ = require('jquery')

class AdvisoryUC

  module.exports = AdvisoryUC # Util.Export( AdvisoryUC, 'exit/uc/AdvisoryUC' )

  constructor:( @stream, @role, @port, @land ) ->

  ready:() ->
    @$ = $( @html() )

  position:(   screen ) ->
    @onScreen( screen )
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Location', (location)  => @onLocation(location) )
    @stream.subscribe( 'Screen',   (screen)    => @onScreen(screen)     )

  onLocation:( location ) ->
    Util.noop( 'AdvisoryUC.onLocation()', @ext, location )

  onScreen:( screen ) ->
    Util.cssPosition( @$, screen, @port, @land )

  html:() ->
    """<div id="#{Util.htmlId('AdvisoryUC',@role)}" class="#{Util.css('AdvisoryUC')}"></div>"""
