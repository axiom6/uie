
d3        = require('d3')
window.d3 = d3
d3Sankey  = require('d3-sankey')

class Sankey

  module.exports = Sankey

  # Patch for d3.sankey.link(d) plugin
  @sankeyLink = (d) ->
    curvature = .5
    x0 = d.source.x + d.source.dx
    x1 = d.target.x
    xi = d3.interpolateNumber(x0, x1)
    x2 = xi(curvature)
    x3 = xi(1 - curvature)
    y0 = d.source.y + d.sy + d.dy / 2
    y1 = d.target.y + d.ty + d.dy / 2 + 0.1 # 0.1 prevents a pure horizontal line that did not respond to color gradients
    'M' + x0 + ',' + y0 + 'C' + x2 + ',' + y0 + ' ' + x3 + ',' + y1 + ' ' + x1 + ',' + y1

  # Patch for d3.sankey.link2() pluging - added for initializing
  @sankeyLink2 = () ->
    curvature = .5

    link = (d) ->
      x0 = d.source.x + d.source.dx
      x1 = d.target.x
      xi = d3.interpolateNumber(x0, x1)
      x2 = xi(curvature)
      x3 = xi(1 - curvature)
      y0 = d.source.y + d.sy + d.dy / 2
      y1 = d.target.y + d.ty + d.dy / 2
      'M' + x0 + ',' + y0 + 'C' + x2 + ',' + y0 + ' ' + x3 + ',' + y1 + ' ' + x1 + ',' + y1

    link.curvature = (_) ->
      if !arguments.length
        return curvature
      curvature = +_
      link

    link

  constructor:( @defs, @g, @x, @y, @w, @h, @nodeWidth, @nodePadding, @label ) ->
    @uom = ''
    @gradientX( @defs, 'WhiteBlack', 'white', 'black' )
    @gSankey = @g.append("g").attr( 'transform', """translate(#{@x},#{@y})""" )

  doData:( data ) =>
    [@sankey,@path]     = @createSankey()
    @graph              = @createGraph( data )
    [@linkSvg,@nodeSvg] = @doSankey( @sankey, @graph  )
    return

  createSankey:() ->
    sankey = d3Sankey.sankey().nodeWidth(@nodeWidth).nodePadding(@nodePadding).size([@w,@h])
    sankey.link  = Sankey.sankeyLink
    sankey.link2 = Sankey.sankeyLink2
    path         = sankey.link2()
    [sankey,path]

  createGraph:( data ) ->
    graph   = data # JSON.parse( json )
    nodeMap = {}
    graph.nodes.forEach( (x) -> nodeMap[x.name] = x )
    graph.links = graph.links.map( (x) => @toLink( x, nodeMap ) )
    graph

  toLink:( x, nodeMap ) ->
    { source: nodeMap[x.source], target:nodeMap[x.target], value:x.value }

  doSankey:( sankey, graph ) ->
    sankey.nodes(graph.nodes).links(graph.links) #.layout( 32 )
    linkSvg = @doLinks()
    nodeSvg = @doNodes( linkSvg )
    [linkSvg,nodeSvg]

# .attr( "stroke", "url(#WhiteBlack)" ).attr( "fill","none")#
  doLinks:() ->
    gLinks = @gSankey.append("svg:g")
    for d in @graph.links
      id = d.source.name+d.target.name
      @gradientX( @defs, id, d.source.color, d.target.color )
      gLink = gLinks.append("svg:g").attr( "stroke", "url(##{id})" ).attr( "fill","none")
      path  = gLink.append("svg:path") #.attr("class", "link")
                   .attr("d", @sankey.link(d) )
                   .style("stroke-width", Math.max( 1, d.dy-1 ) )
                   .sort( (a, b) -> b.dy - a.dy )
                   .append("title").text( d.source.name + " → " + d.target.name ) #  + "\n" + d.value
      #rect  = gLink.append("svg:rect").attr("x",-1).attr("y",-1).attr("width",1000).attr("height",200).attr('fill','none').attr('stroke','none')
    gLinks

  doNodes:( linkSvg ) ->
    node = @gSankey.append("g").selectAll(".node")
      .data(@graph.nodes).enter()
      .append("g").attr("class", "node")
      .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")" )
    node.append("rect").attr("height", (d) -> d.dy )
      .attr("width", @sankey.nodeWidth())
      .attr("fill",   (d) => d.color ) ##.attr("stroke", (d) -> d3.rgb(d.color).darker(2) )
      .append("title").text( (d) => d.name )  #  + "\n" + d.value
    if @label
      node.append("text").attr("x", -6).attr("y", (d) -> d.dy / 2 )
        .attr("dy", ".35em").attr("text-anchor", "end")
        .attr("transform", null).text((d) -> d.name )
        .filter((d) => d.x < @w / 2 )
        .attr("x", 6 + @sankey.nodeWidth())
        .attr( "text-anchor", "start" )
    _this = this  # Same as CoffeeScript put here for lint checking
    node.call( d3.drag()
      #.origin( (d) -> d )
      .container( this.parentNode )
      .on( "start", ( ) ->   this.parentNode.appendChild(this) )
      .on( "drag",  (d) ->  _this.dragMove( d, this, linkSvg ) ) )
    node

  dragMove:( d, caller, linkSvg ) ->
    d.y = Math.max( 0, Math.min( @h-d.dy, d3.event.y ) )
    d3.select(caller).attr( "transform", "translate(#{d.x},#{d.y})" )
    @sankey.relayout()
    linkSvg.attr( "d", @path )
    return

  number:(d) -> d3.format( d, ",.0f")
  format:(d) -> @number(d) + @uom

  gradientX:( defs, id, color1, color2 ) ->
    grad = defs.append("svg:linearGradient")
    grad.attr("id", id ).attr("y1","0%").attr("y2","0%").attr("x1","0%").attr("x2","100%")
    grad.append("svg:stop").attr("offset", "10%").attr("stop-color", color1 )
    grad.append("svg:stop").attr("offset", "90%").attr("stop-color", color2 )
    return