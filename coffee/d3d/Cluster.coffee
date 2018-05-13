
d3  = require( 'd3'           )
Vis = require( 'js/util/Vis'  )

class Cluster

  module.exports = Cluster

  constructor:( @spec, @g, @w, @h ) ->
    @tree = d3.cluster()
    @tree.size([@h*0.6,@w*0.75])
    @root = d3.hierarchy(@spec)
    #@sort( @root )
    @tree( @root )
    @doLink()
    @doNode()

  sort:( root ) ->
    root.sort(  (a, b) -> (a.height - b.height) || a.id.localeCompare(b.id) )
    return

  doLink:() ->
    link = @g.selectAll(".link")
      .data(@root.descendants().slice(1))
      .enter().append("path")
      .attr("class", "link")
      .attr("d", (d) => @moveTo(d) )

  moveTo:(d) ->
    p = d.parent
    """M#{d.y},#{d.x}C#{p.y+100},#{d.x} #{p.y+100},#{p.x} #{p.y},#{p.x}"""

  doNode:() ->
    node = @g.selectAll(".node")
      .data(@root.descendants())
      .enter().append("g")
      .attr("class",     (d) -> "node" + (d.children ? " node--internal" : " node--leaf") )
      .attr("transform", (d) -> "translate(" + d.y + "," + d.x + ")" )
    node.append("circle").attr("r", 5.0)
    node.append("svg:text")
      .attr("dy", 3 )
      .attr("x",  (d) -> if d.children? then -8 else 8 )
      .attr("y",  3 )
      .text(      (d) -> d.name )
      .attr("stroke", "yellow" )
      .style("text-anchor", (d) -> if d.children? then "end" else "start" )
      #text(                (d) -> d.name.substring(d.name.lastIndexOf(".") + 1) )