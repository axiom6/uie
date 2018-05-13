
$ = require('jquery')

class NavigateUI

  module.exports = NavigateUI # Util.Export( NavigateUI, 'exit/page/NavigateUI' )

  constructor:( @stream ) ->

  ready:() ->
    @$ = $( @html() )

  position:(   screen ) ->
    Util.noop( screen )
    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Screen', (screen)   => @onScreen( screen ) )

  onScreen:( screen ) ->
    Util.noop( 'NavigateUI.onScreen()', screen )

  html:() ->
    """<div id="#{Util.htmlId('NavigateUI')}" class="#{Util.css('NavigateUI')}">Navigate</div>"""

  show:() -> @$.show()

  hide:() -> @$.hide()