
d3   = require('d3')
Vis  = require('js/util/Vis')
UI   = require('js/ui/UI')
Prac = require( 'js/prac/Prac')

class Shapes

  module.exports = Shapes

  Prac.Shapes = Shapes

  constructor: ( @stream, @prac ) ->

  ready:() ->

  isWest:(column) ->
    column is 'Embrace'

  layout:( geom, column, ns, ni ) ->
    lay        = {}                                    # Layout ob
    lay.dir    = if( @isWest(column) ) then 1 else -1     # convey direction
    lay.xc     = geom.x0                               # x center
    lay.yc     = geom.y0                               # y center
    lay.w      = geom.wp                                # pane width
    lay.h      = geom.hp                                # pane height
    lay.hk     = lay.h / 8                             # height keyhole rect
    lay.xk     = if( @isWest(column) ) then lay.w else 0  # x keyhole rect
    lay.yk     = lay.yc - lay.hk                       # y keyhole rect
    lay.rs     = lay.yc * 0.85                         # Outer  study section radius
    lay.ro     = lay.rs - lay.hk                       # Inner  study section radius
    lay.ri     = lay.ro - lay.hk / 4                   # Icon   intersction radiu
    lay.yt     = lay.yc + lay.ro + lay.rs * 0.65       # y for practice text
    lay.a1     = if( @isWest(column)) then  60 else  120  # Begin  study section angle
    lay.a2     = if( @isWest(column)) then 300 else -120  # Ending study section angle
    lay.ns     = ns                                    # Number of studies
    lay.da     = (lay.a1-lay.a2) / lay.ns              # Angle of each section
    lay.ds     = lay.da / 12                           # Link angle dif
    lay.li     = lay.ds / 2                            # Link begin inset
    lay.wr     = 8                                     # Width  study rect  24
    lay.hr     = lay.ri / lay.ns                       # Height study rect
    lay.xr     = lay.xc + lay.dir * (lay.rs/2+lay.wr)  # x orgin study rect
    lay.yr     = lay.yc - lay.ri/2                     # r orgin study rect
    lay.dl     = lay.hr / 12                           # link dif on study rect
    lay.xl     = lay.xr + lay.wr                       # x link   on study rect
    lay.yl     = lay.yr + lay.dl / 2                   # y link   on study rect
    lay.ni     = ni                                    # Number of innovative studies
    lay.xi     = 0                                     # x innovative study rects
    lay.yi     = lay.yc - lay.ri / 2                   # y innovative study rects
    lay.wi     = lay.wr                                # w innovative study rects
    lay.hi     = lay.ri / lay.ni                       # h innovative study rects
    lay.thick  = 1                                     # line thickness
    lay.stroke = 'none'                                # line stroke
    #Util.log( 'Shapes.layout()', lay )
    lay

  click:( path, text) ->
    path.style( 'z-index','4') #.style("pointer-events","all").style("visibility", "visible" )
    path.on("click", () =>
      #Util.log( 'Prac.Shape.click',  text )
      select = UI.Build.select(  Util.toSelect(text), 'Shapes', UI.Build.SelectStudy )
      @stream.publish( 'Select', select ) )
    return

  wedge:( g, r1, r2, a1, a2, x0, y0, fill, text, wedgeId ) ->
    arc  = d3.arc().innerRadius(r1).outerRadius(r2).startAngle(@radD3(a1)).endAngle(@radD3(a2))
    g.append("svg:path").attr("d",arc).attr("fill",fill).attr("stroke","none").attr("transform", "translate(#{x0},#{y0})")
    @wedgeText( g, r1, r2, a1, a2, x0, y0, fill, text, wedgeId )
    return

  wedgeText:( g, r1, r2, a1, a2, x0, y0, fill, text, wedgeId ) ->
    th = 14
    at = (a1+a2)/2
    if (210<=at and at<=330) or (-150<=at and at<=-30)
      rt = (r1+r2)/2 + th * 0.25
      as = 270-at
    else
      rt = (r1+r2)/2 - th * 0.5
      as = 90-at
    x  = x0 + rt * Prac.cos(at)
    y  = y0 + rt * Prac.sin(at)
    path = g.append("svg:text").text(text).attr("x",x).attr("y",y).attr("transform", "rotate(#{as} #{x} #{y})" )
            .attr("text-anchor","middle").attr("font-size","#{th}px").attr("font-family","FontAwesome").attr('fill','#000000' ) # @textFill(fill))
    @click( path, text )
    return

  icon:( g, x0, y0, name, iconId, uc ) ->
    path = g.append("svg:text").text(uc).attr("x",x0).attr("y",y0+12).attr("id",iconId)
            .attr("text-anchor","middle").attr("font-size","2em").attr("font-family","FontAwesome")
    @click( path, name )
    return

  text:( g, x0, y0, name, textId, color ) ->
    path = g.append("svg:text").text(name).attr("x",x0).attr("y",y0).attr("id",textId).attr("fill",color)
             .attr("text-anchor","middle").attr("font-size","1.4em").attr("font-family","FontAwesome")
    @click( path, name )
    return

  link:( g, a, ra, rb, xc, yc, xd, yd, xe, ye, stroke, thick ) ->
    xa = xc + ra * Prac.cos(a)
    ya = yc + ra * Prac.sin(a)
    xb = xc + rb * Prac.cos(a)
    yb = yc + rb * Prac.sin(a)
    data  = """M#{xa},#{ya} C#{xb},#{yb} #{xd},#{yd} #{xe},#{ye}"""
    @curve( g, data, stroke, thick )
    return

  curve:( g, data, stroke, thick ) ->
    g.append("svg:path").attr("d",data).attr("stroke-linejoin","round").attr("fill","none").attr("stroke",stroke).attr("stroke-width",thick)
    return

  keyHole:( g, xc, yc, xs, ys, ro, ri, fill, stroke='none', thick=0 ) ->
    h      = yc - ys
    a      = Math.asin( h/ro )
    rx     = Math.cos( a ) * ro
    rh     = ri
    osweep = 0 # Negative
    isweep = 1 # Positive
    if xs <  xc
      rx     = -rx
      rh     = -ri
      osweep = 1 # Positive
      isweep = 0 # Negative
    data  = """M#{xs},   #{ys}"""
    data += """L#{xc+rx},#{ys} A#{ro},#{ro} 0, 1,#{osweep} #{xc+rx},#{yc+h}"""
    data += """L#{xs},   #{yc+h} L#{xs},#{ys}"""
    data += """M#{xc+rh},#{yc} A#{ri},#{ri} 0, 1,#{isweep} #{xc+rh},#{yc-0.001}"""  # Donut hole
    #Util.log( 'Prac.shapes.keyhole()', { xc:xc, yc:yc, xs:xs, ys:ys, ro:ro, ri:ri, h:h, a:a, rx:rx } )
    @poly( g, data, fill, stroke, thick )
    return

  poly:( g, data, fill ) ->
    g.append("svg:path").attr("d",data).attr("stroke-linejoin","round").attr("fill",fill)
    return

  # svg:rect x="0" y="0" width="0" height="0" rx="0" ry="0"
  rect:( g, x0, y0, w, h, fill, stroke, text='', ts=1.0 ) ->
    g.append("svg:rect").attr("x",x0).attr("y",y0).attr("width",w).attr("height",h)
     .attr("fill",fill).attr("stroke",stroke)
    if text isnt ''
      g.append("svg:text").text(text).attr("x",x0+w/2).attr("y",y0+h/2+14).attr('fill','black')
       .attr("text-anchor","middle").attr("font-size","#{ts*1.2}em").attr("font-family","FontAwesome")
    return

  round:( g, x0, y0, w, h, rx, ry, fill, stroke ) ->
    g.append("svg:rect").attr("x",x0).attr("y",y0).attr("width",w).attr("height",h).attr("rx",rx).attr("ry",ry)
     .attr("fill",fill).attr("stroke",stroke)
    return

  # svg:ellipse cx="0" cy="0" rx="0" ry="0"
  elipse:( g, cx, cy, rx, ry, fill, stroke ) ->
    g.append("svg:ellipse").attr("cx",cx).attr("cy",cy).attr("rx",rx).attr("ry",ry)
     .attr("fill",fill).attr("stroke",stroke)
    return

  # svg:ellipse cx="0" cy="0" rx="0" ry="0"
  circle:( g, cx, cy, r, fill, stroke ) ->
    g.append("svg:ellipse").attr("cx",cx).attr("cy",cy).attr("r",r)
     .attr("fill",fill).attr("stroke",stroke)
    return

  pathPlot:( g, stroke, thick, d )->
    g.append('svg:path').attr( 'd', d ).attr('stroke',stroke).attr('stroke-width',thick)
     .attr('fill','none').attr("stroke-linejoin",'round')
    return

  embraceSankeyNodesLinks:( studies, innovs ) ->
    nodes = []
    nodes.push( { name:key, color:@prac.toFill(study) } ) for own key, study of studies
    nodes.push( { name:key, color:@prac.toFill(innov) } ) for own key, innov of innovs
    links = []
    for own sKey, study of studies
      for own iKey, innov of innovs
        links.push( { source:sKey, target:iKey, value:1 } )
    { nodes:nodes, links:links }

  encourageSankeyNodesLinks:( studies, innovs ) ->
    nodes = []
    nodes.push( { name:key, color:@prac.toFill(innov) } ) for own key, innov of innovs
    nodes.push( { name:key, color:@prac.toFill(study) } ) for own key, study of studies
    links = []
    for own iKey, innov of innovs
      for own sKey, study of studies
        links.push( { source:iKey, target:sKey, value:1 } )
    { nodes:nodes, links:links }

  # nodeWidth = lay.wr nodePadding = 0
  conveySankey:( embrace, defs, g, studies, innovs, x, y, w, h, nodeWidth, nodePadding ) ->
    Sankey     = require( 'js/d3d/Sankey' )
    sankey     = new Sankey( defs, g, x, y, w, h, nodeWidth, nodePadding, false )
    nodesLinks = {}
    if embrace
      nodesLinks = @embraceSankeyNodesLinks(   studies, innovs )
    else
      nodesLinks = @encourageSankeyNodesLinks( studies, innovs )
    sankey.doData( nodesLinks )
    return

  practiceFlow:( g, geom, spec ) ->
    return if not spec.row?
    switch spec.row
      when 'Learn'
        @flow( g, geom, [90,90,90], 'South' )
      when 'Do'
        @flow( g, geom, [90,90,90], 'North' )
        @flow( g, geom, [60,90,90], 'South' )
      when 'Share'
        @flow( g, geom, [60,90,90], 'North' )
      else
        Util.error( ' unknown spec row ', spec.name, spec.row )
        @flow( g, geom, [90,90,90], 'South' )
    return

  flow:( g, geom, hsv, dir ) ->
    w    = 18
    h    = 24
    x0   = geom.x0 - w / 2
    y0   = if dir is 'South' then geom.h  - h else 0
    fill = Vis.toRgbHsvStr( hsv )
    @rect( g, x0, y0, w, h, fill, 'none' )
    return

  # Convert degress to radians and make angle counter clockwise
  rad:( deg )    -> (360-deg) * Math.PI / 180.0
  degSVG:( deg ) -> 360-deg
  radD3:( deg )  -> (450-deg) * Math.PI / 180.0
  degD3:( rad )  -> -rad * 180.0 / Math.PI
  cos:( deg )    -> Vis.cosSvg(deg)
  sin:( deg )    -> Vis.sinSvg(deg)
  textFill:( hex, dark='#000000', light='#FFFFFF') ->
    if hex > 0x888888 then dark else light
  textFill1:( fill, dark='#000000', light='#FFFFFF') ->
    if fill? and Vis.Palettes.hex(fill) > 0xffffff/2 then dark else light
