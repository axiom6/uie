
Vis  = require('js/util/Vis')
Prac = require('js/prac/Prac' )

class Encourage

  module.exports = Encourage
  Prac.Encourage = Encourage

  constructor:( @ui, @spec, @prac ) ->
    @hasSvg  = true
    @studies = @prac.arrange( @spec.studies )
    @innovs  = @ui.build.adjacentStudies( @spec, 'west' )
    @shapes  = @prac.shapes

  drawSvg:( g, $g, geom, defs ) ->
    lay  = @shapes.layout( geom, @spec.column, @prac.size(@studies), @prac.size(@innovs) )
    $g.hide()
    fill = @prac.toFill(@spec)
    @shapes.keyHole( g, lay.xc, lay.yc, lay.xk, lay.yk, lay.ro, lay.hk, fill, lay.stroke )
    yl = lay.yl
    a1 = lay.a1
    xr = lay.xr + lay.wr
    yr = lay.yr
    for key, study of @studies
      fill = @prac.toFill(study)
      wedgeId = @prac.htmlId( study.name, 'Wedge' )
      @shapes.wedge( g, lay.ro, lay.rs, a1, a1-lay.da, lay.xc, lay.yc, fill, study.name, wedgeId  )
      for a in [a1-lay.li...a1-lay.da] by -lay.ds
        @shapes.link( g, a, lay.ro, lay.ri, lay.xc, lay.yc, lay.xc, yl, xr, yl, fill, lay.thick )
        yl += lay.dl
      a1 -= lay.da
      yr += lay.hr
    #@innovateStudies( g, lay )
    x  = 0 # lay.xr+lay.wr
    r0 = lay.ri # geom.x0/2 - 36
    y  = geom.y0 - r0/2 # lay.yr
    w  = lay.xr + lay.wr
    h  = r0 # lay.ri
    nodeWidth   = 24 # lay.wr
    nodePadding = 0
    yt = geom.y0 + geom.h * 0.5
    @shapes.conveySankey( false, defs, g, @studies, @innovs, x, y, w, h, nodeWidth, nodePadding, false )
    @shapes.icon( g, geom.x0, geom.y0, @spec.name, @prac.htmlId(@spec.name,'IconSvg'), Vis.unicode(@spec.icon) )
    @shapes.text( g, w-12,         yt, @spec.name, @prac.htmlId(@spec.name,'TextSvg'), 'black' )
    @shapes.practiceFlow( g, geom, @spec )
    $g.show()
    return

  # Not called but matches Sankey
  innovateStudies:( g, lay ) ->
    yi = lay.yi
    for key, innov of @innovs
      fill = @prac.toFill(innov)
      @shapes.rect( g, lay.xi, yi, lay.wi, lay.hi, fill, lay.stroke )
      yi += lay.hi
    return
