
$ = require('jquery')

class ThresholdUC

  module.exports = ThresholdUC # Util.Export( ThresholdUC, 'exit/uc/ThresholdUC' )

  constructor:( @stream, @ext, @port, @land ) ->

  ready:() ->
    @$ = $( @html() )

  position:(   screen ) ->
    @onScreen( screen )
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Screen', (screen)   => @onScreen( screen ) )

  onScreen:( screen ) ->
    Util.cssPosition( @$, screen, @port, @land )

  html:() ->
    """<div id="#{Util.htmlId('Threshold')}"       class="#{Util.css('Threshold')}">
       <div id="#{Util.htmlId('ThresholdAdjust')}" class="#{Util.css('ThresholdAdjust')}">Adjust Threshold</div>
       <img src="#{Util.root}img/exit/Threshold.png" width="300" height="200">
    </div>"""

  show:() -> @$.show()
  hide:() -> @$.hide()