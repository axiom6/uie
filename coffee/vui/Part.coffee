
$  = require( 'jquery'   )
UI = require( 'js/ui/UI' )

class Part

  module.exports = Part

  constructor:( @ui, @stream, @pane, @ext, @rgba, @left, @top, @width, @height, @title="" ) ->
    @htmlId   = @ui.htmlId( @pane.name, @ext )
    @$        = UI.$empty
    @css      = 'ikw-hues'
    @addClass = ''

  ready:() ->
    @$ = $( @createHtml() )
    @reset()
    @pane.$.append( @$ )
    @show()

  show:()  ->  @$.show()

  hide:()  -> @$.hide()

  pc:(v) -> @pane.pc(v)

  rgbaStr:() ->
    n = (f) -> Math.round(f)
    [r,g,b,a] = @rgba
    """rgba(#{n(r)},#{n(g)},#{n(b)},#{n(a)})"""

  createHtml:() -> """<div id="#{@htmlId}" class="#{@css}" style="background-color:#{@rgbaStr()};" title="#{@title}"></div>"""

  resize:() ->
    @adjustAddClass( @addClass ) if Util.isStr( @addClass )
    @show
    return

  adjustAddClass:( addClass ) ->
    @addClass = addClass
    @$.removeClass( addClass )
    [w1,h1] = @whOuter()
    @$.addClass( addClass )
    [w2,h2] = @whOuter()
    width   = @width  * w1/w2
    height  = @height * h1/h2
    @resetCss( @left, @top, width, height )
    return

  whOuter:() ->
      [ @$.outerWidth(), @$.outerHeight() ]

  cssProps:() ->
    { backgroundColor:@rgbaStr(), left:@pc(@left), top:@pc(@top), width:@pc(@width), height:@pc(@height), position:'absolute' }

  reset:() ->
    @$.css( @cssProps() )
    return

  resetCss:(  left, top, width, height ) ->
    @left = left; @top = top; @width = width; @height = height
    @$.css( @cssProps() )
    return

  animate:( left, top, width, height, aniLinks=false, callback=null ) ->
    @$.show().animate( @cssProps() , @pane.speed, () => callback(@) if callback? )
    return

  log:( msg  ) ->
    Util.log( msg, { "background-color":@rgbaStr(), left:Util.toFixed(@left), top:Util.toFixed(@top), width:Util.toFixed(@width), height:Util.toFixed(@height) } )

  geom:() ->
    w = @$.innerWidth()
    h = @$.innerHeight()
    r  = Math.min( w, h ) * 0.2  # Use for hexagons
    x0 = w * 0.5
    y0 = h * 0.5
    { w:w, h:h, r:r, x0:x0, y0:y0 }
