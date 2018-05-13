
$ = require('jquery')

class IconsUC

  module.exports = IconsUC # Util.Export( IconsUC, 'exit/uc/IconsUC' )

  constructor:( @stream, @subject, @port, @land, @specs, @hover=true, @stayHorz=true ) ->

  ready:() ->
    @$ = $( @html() )

  html:() ->
    htm  = """<div id="#{Util.htmlId('IconsUC',   @subject)}" class="#{Util.css('IconsUC')}">"""
    htm += """<div id="#{Util.htmlId('IconsHover',@subject)}" class="#{Util.css('IconsHover')}"></div>""" if @hover
    htm += """<div id="#{Util.htmlId('Icons',     @subject)}" class="#{Util.css('Icons')}"><div>"""
    for spec in @specs
      htm += """<div id="#{Util.htmlId(spec.name,'Icon',@subject)}" class="#{Util.css(spec.css)}"><i class="fa fa-#{spec.icon}"></i><div>#{spec.name}</div></div>"""
    htm += """</div></div></div>"""
    htm

  position:(   screen ) ->
    @onScreen( screen )
    @events()
    @subscribe()
    @$Icons      = @$.find('#Icons'+@subject)
    if @hover
      @$IconsHover = @$.find('#IconsHover'+@subject)
      @$IconsHover.mouseenter( () => @$Icons.show() )
      @$Icons     .mouseleave( () => @$Icons.hide() )
    else
      @$Icons.show()

  $find:( name ) =>
    @$.find('#'+name+'Icon'+@subject)

  events:() ->
    for spec in @specs
      @stream.publish( @subject, spec.name, @$find(spec.name), 'click' )

  subscribe:() ->
    @stream.subscribe( 'Screen', (screen)  => @onScreen(screen)     )

  onScreen:( screen ) ->
    isHorz = if @stayHorz then true else if screen.orientation is 'Portrait' then true else false
    Util.cssPosition( @$, screen, @port, @land )
    n = @specs.length
    x = 0
    y = 0
    w = if isHorz then 100/n else 100
    h = if isHorz then 100   else 100/n
    for spec in @specs
      @$find(spec.name).css( { left:x+'%', top:y+'%', width:w+'%', height:h+'%'} )
      if isHorz then x += w else y += h
    return
