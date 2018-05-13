
d3  = require( 'd3'          )
Vis = require( 'js/util/Vis' )

class Tree

  module.exports = Tree

  constructor:( @ui, @spec, @g, @w, @h ) ->
    @margin = 0.05
    @sizepc = 1 - @margin * 2
    @tree = d3.tree()
    @tree.size([@h*@sizepc,@w*@sizepc])
    #Util.log( 'Tree.size', @w, @h )
    @root = d3.hierarchy( @spec )
    @tree(   @root )  # d3 call
    @doTree( @root, @g )

  doTree:( root, g ) ->
    link = @doLinks( root, g )
    node = @doNodes( root, g )
    @iconNode( node )
    @textNode( node )
    Util.noop( link )
    return

  doNodes:( root, g ) ->
    g.selectAll("g.node")
     .data(root.descendants())
     .enter().append("svg:g")
     .attr("class", "node")
     .attr("transform", (d) => @nodeTo(d) )

  doLinks:( root, g ) ->
    g.selectAll("g.link")
     .data(root.descendants().slice(1))
     .enter().append("svg:path")
     .attr("class",  'link')
     .attr("stroke", 'blue' )
     .attr("fill",   "none" )
     .attr("d", (d) => @linkTo(d) )
    
  dydx:( d ) ->
    [d.y+@h*@margin,d.x+@w*@margin]
    
  nodeTo:( d ) =>
    [dy,dx] = @dydx( d )
    """translate(#{dy},#{dx})"""

  linkTo:(d) =>
    [dy,dx] = @dydx( d )
    [py,px] = @dydx( d.parent )
    """M#{dy},#{dx}C#{py+50},#{dx} #{py+50},#{px} #{py},#{px}"""

  isEnd:( d ) ->
    #Util.log('Tree.isEnd', d.data.name, d.depth, d.depth > 2 )
    d.depth is 0 or d.depth > 2

  textNode:( node ) ->
    node.append("svg:text")
        .attr("dy", 1 )
        .attr("x", (d) => if @isEnd(d) then 8 else -10 )
        .attr("y", 2 ) #.
        .attr("stroke", 'black')
        .attr("font-size","1.4em")
        .attr("font-family","FontAwesome")
        .attr("text-anchor", (d) => if @isEnd(d) then "start" else "end" )
        .text( (d) -> d.data.name )
    return

  iconNode:( node ) ->
    node.append("svg:text")
        .attr("dy", 4 )
        .attr("stroke", 'black')
        .attr("font-size","1.4em")
        .attr("font-family","FontAwesome")
        .attr("text-anchor","middle")
        .text( (d) => @iconUnicode(d) )
    return

  iconUnicode:( d ) ->
    icon = if d.data.icon? then d.data.icon else 'fa-circle'
    Vis.unicode( icon )
