
d3  = require( 'd3' )   # may also require d3.layout

class Chord

  module.exports = Chord # Util.Export( Chord, 'd3d/Chord' )

  @matrix = [[0,20,20,20],
             [20,0,20,80],
             [20,20,0,20],
             [20,80,20,0]]
  @range  = ["#FF0000", "#00FF00", "#0000FF", "#888888"]
  @matrix2 = [[11975, 5871, 8916, 2868], [1951, 10048, 2060, 6171], [8010, 16145, 8090, 8045], [1013, 990, 940, 6907]]
  @range2  = ["#000000", "#FFDD89", "#957244", "#F26223"]

# From http://mkweb.bcgsc.ca/circos/guide/tables/

  constructor:( @g, @width=600, @height=600, @matrix=Chord.matrix, @range=Chord.range ) ->
    #@attrG( @g )
    @chord       = @createChord( @matrix )
    @fill        = @createFill(  @range  )
    @innerRadius = Math.min( @width, @height ) * .41
    @outerRadius = @innerRadius * 1.1
    @groups      = @createGroups()
    #@ticks      = @createTicks()
    @chords      = @createChords()

  createChord:( matrix ) ->
    #d3.layout.chord().padding(.05).sortSubgroups(d3.descending).matrix( matrix )
    d3.layout.chord().padding(.05).matrix( matrix )

  createFill:(  range  ) ->
    d3.scale.ordinal().domain( d3.range(4) ).range( range )

  createGroups:() ->
    groups = @g.append("g").selectAll("path").data(@chord.groups).enter().append("path")
      .style("fill",   (d) => @fill( d.index ) )
      .style("stroke", (d) => @fill( d.index ) )
    groups.attr( "d", d3.arc().innerRadius(@innerRadius).outerRadius(@outerRadius) )
    groups.on("mouseover", @fade(.1) ).on( "mouseout", @fade(1) )
    groups

  createChords:() ->
    chords = @g.append("g").attr("class", "chord").selectAll("path").data(@chord.chords).enter().append("path")
      .attr(  "d", d3.chord().radius(@innerRadius))
      .style( "fill", (d) => @fill( d.target.index ) )
      .style( "opacity", 1 )
    chords

  # Returns an array of tick angles and labels, given a group.
  createTicks:() ->
    ticks =  @g.append("g").selectAll("g").data( @chord.groups )
    ticks.enter().append("g").selectAll("g").data( @groupTicks   )
    #ticks.enter().append("g").attr("transform", (d) => "rotate(" + (d.angle * 180 / Math.PI - 90) + ")" + "translate(" + @outerRadius + ",0)" )
    ticks.append("line").attr("x1", 1).attr("y1", 0).attr("x2", 5).attr("y2", 0).style( "stroke", "#000" )
    ticks.append("text").attr("x",  8).attr("dy", ".35em")
     .attr( "transform", (d) -> ( if d.angle > Math.PI then "rotate(180)translate(-16)" else null ) )
    ticks.style("text-anchor", (d) -> ( if d.angle > Math.PI then "end" else null) )
    ticks.text( (d) -> d.label )
    ticks

  groupTicks: (d) ->
    k = (d.endAngle - d.startAngle) / d.value
    range = d3.range(0, d.value, 1000).map( (v, i) -> { angle: v * k + d.startAngle, label: (if i % 5 then null else v / 1000 + "k") } )
    Util.log( 'groupTicks', d, k )
    range

  # Returns an event handler for fading a given chord group.
  fade: (opacity) =>
    (i) =>
        @g.selectAll(".chord path").filter( (d) ->
          d.source.index isnt i and d.target.index isnt i ).transition().style( "opacity", opacity )




