
$   = require( 'jquery'      )
Vis = require( 'js/util/Vis' )
UI  = require( 'js/ui/UI'    )

class Pane

  module.exports = Pane

  constructor:( @ui, @stream, @view, @spec ) ->
    @spec.pane = @
    @cells     = @ui.chooseCells( @spec )
    [j,m,i,n]  = UI.jmin(@cells)
    [@left,@top,@width,@height] = @view.position(j,m,i,n,@spec)
    @name      = @spec.name
    @css       = if Util.isStr(@spec.css) then @spec.css else 'ikw-pane'
    @$         = UI.$empty
    @wscale    = @view.wscale
    @hscale    = @view.hscale
    @margin    = @view.margin
    @speed     = @view.speed
    @parts     = @createParts( @spec.parts )
    @page      = null # set by UI.createPages()

  ready:() ->
    @htmlId = @ui.htmlId( @name, 'Pane' )
    @$      = $( @createHtml() )
    @view.$view.append( @$ )
    @hide()
    @adjacentPanes()
    @btn .ready() if @btn?
    @page.ready() if @page?
    @readyParts()
    select = UI.Build.select( @name, 'Pane.ready', UI.Build.SelectAllPanes )
    @reset(select)
    @show()

  geom:() ->
    [j,m,i,n] = UI.jmin(@spec.cells)
    [wp,hp]   = @view.positionpx( j,m,i,n, @spec ) # Pane size in AllPage usually 3x3 View
    wi        = @$.innerWidth()
    hi        = @$.innerHeight()
    w  = Math.max( wi, wp ) # wp from positionpx
    h  = Math.max( hi, hp ) # hp from positionpx
    wv = @view.wPanes()
    hv = @view.hPanes()
    r  = Math.min( w, h ) * 0.2  # Use for hexagons
    x0 = w * 0.5
    y0 = h * 0.5
    sx = w/wp
    sy = h/hp
    s  = Math.min( sx, sy )
    ex = wv*0.9 < w and w < wv*1.1
    geo = { w:w, h:h, wi:wi, hi:hi, wp:wp, hp:hp, wv:wv, hv:hv, r:r, x0:x0, y0:y0, sx:sx, sy:sy, s:s, ex:ex }
    #Util.log( 'Pane.geom()', geo )
    geo

  #Util.log( "Pane.geom()", { wp:wp, wi:@$.innerWidth(), w:w } )

  show:()  -> @$.show()
  hide:()  -> @$.hide()

  pc:(v) -> @view.pc(v)
  xs:(x) -> @view.xs(x)
  ys:(y) -> @view.ys(y)

  xcenter:( left, width,  w, scale=1.0, dx=0 ) -> scale * ( left + 0.5*width   - 11 )
  xcente2:( left, width,  w, scale=1.0, dx=0 ) -> scale * ( left + 0.5*width   - 0.5*w/@wscale + dx/@wscale )
  ycenter:( top,  height, h, scale=1.0, dy=0 ) -> scale * ( top  + 0.5*height  - 0.5*h/@hscale + dy/@hscale )
  right:(   left, width,  w, scale=1.0, dx=0 ) -> scale * ( left + width       - 0.5*w/@wscale + dx/@wscale )
  bottom:(  top,  height, h, scale=1.0, dy=0 ) -> scale * ( top  + height      - 0.5*h/@hscale + dy/@hscale )

  north:(  top,  height, h, scale=1.0, dy=0 ) -> scale * ( top           - h + dy/@hscale )
  south:(  top,  height, h, scale=1.0, dy=0 ) -> scale * ( top  + height     + dy/@hscale )
  east:(   left, width,  w, scale=1.0, dx=0 ) -> scale * ( left + width      + dx/@wscale )
  west:(   left, width,  w, scale=1.0, dx=0 ) -> scale * ( left          - w + dx/@wscale )

  adjacentPanes:() ->
    [jp,mp,ip,np] = UI.jmin(@cells)
    [@northPane,@southPane,@eastPane,@westPane] = [@view.emptyPane,@view.emptyPane,@view.emptyPane,@view.emptyPane]
    for pane in @view.panes
      [j,m,i,n] = UI.jmin(pane.cells)
      @northPane = pane if j is jp and m is mp and i is ip-n
      @southPane = pane if j is jp and m is mp and i is ip+np
      @westPane  = pane if i is ip and n is np and j is jp-m
      @eastPane  = pane if i is ip and n is np and j is jp+mp
    return

  createHtml:() ->
    """<div id="#{@htmlId}" class="#{@css}"></div>"""

  reset:(select) ->
    @$.css( { left:@xs(@left), top:@ys(@top), width:@xs(@width), height:@ys(@height) } )
    @pageContent(select)
    return

  css:(  left, top, width, height, select ) ->
    @$.css( { left:@pc(left), top:@pc(top), width:@pc(width), height:@pc(height) } )
    @pageContent(select)
    return

  animate:( left, top, width, height, select, aniLinks=false, callback=null ) ->
    @$.show().animate( { left:@pc(left), top:@pc(top), width:@pc(width), height:@pc(height) }, @view.speed, () => @animateCall(callback,select) )
    return

  animateCall:( callback, select ) =>
    @pageContent(select)
    callback(@) if callback?
    return

  pageContent:( select ) ->
    @page.paneContent( select ) if @page?
    return

  createParts:( partSpec ) ->
    parts = []
    return parts unless partSpec?
    [mcol,nrow] = [ partSpec.mcol, partSpec.nrow ]
    m  = { width:2, height:2, west:2, north:2, east:2, south:2 }
    [ww,hh,wp,hp,ws,hs] = @view.percents( nrow, mcol, m )
    Util.noop( wp, hp )
    left = (j) -> ws * j*ww +  ( m.west  + j * m.width  )
    top  = (i) -> hs * i*hh +  ( m.north + i * m.height )
    for i in [0...nrow]
      for j in [0...mcol]
        if j >= i
          ext       = Util.padStr(i) + Util.padStr(j)
          [h,s,v]   = [partSpec.hue,j*5,100-i*5]
          [r,g,b,a] = Vis.toRgbHsvSigmoidal( h, s, v*255, true )
          title     = h.toString() + ' ' + s.toString() + ' ' + v.toString()
          part      = new UI.Part( @ui, @stream, @, ext, [r,g,b,a], left(j), top(i), ww*ws, hh*hs, title )
          parts.push( part )
    parts

  readyParts:() ->
    part.ready() for part in @parts


