
$           = require( 'jquery'                 )
ThresholdUC = require( 'js/exit/uc/ThresholdUC' )
Data        = require( 'js/exit/app/Data' )

class DestinationUI

  module.exports = DestinationUI # Util.Export( DestinationUI, 'exit/page/DestinationUI' )

  constructor:( @stream ) ->
    @thresholdUC  = new ThresholdUC( @stream, 'Destination', [0,60,100,40], [ 50, 20, 50, 80]  )

    @sources      = Data.Destinations # For now we access sources     from static data
    @destinations = Data.Destinations # For now we access destinations from static data

  ready:() ->
    @thresholdUC.ready()
    @$ = $( @html() )
    @$.append( @thresholdUC.$  )
    @$sourceBody        = @$.find('#SourceBody'       )
    @$sourceSelect      = @$.find('#SourceSelect'     )
    @$destinationBody   = @$.find('#DestinationBody'  )
    @$destinationSelect = @$.find('#DestinationSelect')

  position:(   screen ) ->
    @onScreen( screen )
    @thresholdUC.position( screen )
    @events()
    @subscribe()

  # publish is called by
  events:() ->
    @stream.publish( 'Source',      'Source',      @$sourceSelect,      'change' ) # TODO need to get Source      selection
    @stream.publish( 'Destination', 'Destination', @$destinationSelect, 'change' ) # TODO need to get Destination selection

  subscribe:() ->
    @stream.subscribe( 'Source',      (source)      => @onSource(source)           )
    @stream.subscribe( 'Destination', (destination) => @onDestination(destination) )
    @stream.subscribe( 'Screen',      (screen)      => @onScreen(screen)           )

  onSource:( source ) ->
    Util.noop( 'DestU.onSource()', source )

  onDestination:( destination ) ->
    Util.noop( 'DestU.onDestin()', destination )

  id:(   name, type     ) -> Util.htmlId(   name, type     )
  css:(  name, type     ) -> Util.css(  name, type     )
  icon:( name, type, fa ) -> Util.icon( name, type, fa )

  html:() ->
    htm = """<div      id="#{@id('DestinationUI')}"         class="#{@css('DestinationUI')}">
              <!--div  id="#{@id('DestinationLabelInput')}" class="#{@css('DestinationLabelInput')}">
                <span  id="#{@id('DestinationUserLabel' )}" class="#{@css('DestinationUserLabel' )}">User:</span>
                <input id="#{@id('DestinationUserInput' )}" class="#{@css('DestinationUserInput' )}"type="text" name="theinput" />
              </div-->
              <div      id="#{@id('SourceBody')}"           class="#{@css('SourceBody')}">
                <div    id="#{@id('SourceWhat')}"            class="#{@css('SourceWhat')}">Where are You Now?</div>
                <select id="#{@id('SourceSelect')}"          class="#{@css('SourceSelect')}" name="Sources">"""
    htm += """<option>#{source}</option>""" for source in @sources
    htm += """</select></div>
              <div      id="#{@id('DestinationBody')}"      class="#{@css('DestinationBody')}">
              <div     id="#{@id('DestinationWhat')}"       class="#{@css('DestinationWhat')}">What is your</div>
              <div     id="#{@id('DestinationDest')}"       class="#{@css('DestinationDest')}">Destination?</div>
              <select  id="#{@id('DestinationSelect')}"     class="#{@css('DestinationSelect')}" name="Desinations">"""
    htm += """<option>#{destination}</option>""" for destination in @destinations
    htm += """</select></div></div>"""
    htm

  onScreen:( screen ) ->
    Util.cssPosition( @$sourceBody,      screen, [0, 0,100,25], [0, 0,50,40] )
    Util.cssPosition( @$destinationBody, screen, [0,25,100,25], [0,40,50,40] )


  show:() -> @$.show()
  hide:() -> @$.hide()

  showBody:() -> @$destinationBody.show()
  hideBody:() -> @$destinationBody.hide()
