
d3 = require( 'd3' )

class Color

  module.exports = Color # Util.Export( Color, 'd3d/Color' )

  @PaneBack:{ id:'Pane', hsla:'hsla( 330,40%,30%,1.0)' }
  @ViewBack:{ id:'View', hsla:'hsla( 330,40%,15%,0.5)' }

  @Prac: {
    b: { id:'behave',    rgba:'rgba(180,210,185,1.00)' }
    p: { id:'people',    rgba:'rgba(208,240,171,1.00)' }
    s: { id:'service',   rgba:'rgba(254,254,150,1.00)' }
    i: { id:'integrate', rgba:'rgba(245,232,189,1.00)' }
    c: { id:'config',    rgba:'rgba(240,180,120,1.00)' }
    d: { id:'data',      rgba:'rgba(250,200,167,1.00)' }
    m: { id:'motivate',  rgba:'rgba(170,153,170,1.00)' }
    t: { id:'trace',     rgba:'rgba(180,230,185,1.00)' }
    r: { id:'realize',   rgba:'rgba(170,153,170,1.00)' }
    g: { id:'gap',       rgba:'rgba(180,180,220,1.00)' } }

  @Prac2: {
    b: { id:'behave',    rgba:'rgba(180,210,185,0.80)' }
    p: { id:'people',    rgba:'rgba(208,240,171,0.80)' }
    s: { id:'service',   rgba:'rgba(254,254,150,0.50)' }
    i: { id:'integrate', rgba:'rgba(245,232,189,0.80)' }
    c: { id:'config',    rgba:'rgba(240,180,120,0.50)' }
    d: { id:'data',      rgba:'rgba(250,200,167,0.80)' }
    m: { id:'motivate',  rgba:'rgba(255,180,180,0.80)' }
    t: { id:'trace',     rgba:'rgba(180,230,185,0.90)' }
    r: { id:'realize',   rgba:'rgba(255,205,190,0.90)' }
    g: { id:'gap',       rgba:'rgba(180,180,220,0.60)' } }

  @Hue: {
    red:     { hsla:'hsla(  0,100%,50%,0.5)' }
    orange:  { hsla:'hsla( 30,100%,50%,0.5)' }
    yellow:  { hsla:'hsla( 60,100%,50%,0.5)' }
    spring:  { hsla:'hsla( 90,100%,50%,0.5)' }
    green:   { hsla:'hsla(120,100%,50%,0.5)' }
    teal:    { hsla:'hsla(150,100%,50%,0.5)' }
    cyan:    { hsla:'hsla(180,100%,50%,0.5)' }
    azure:   { hsla:'hsla(210,100%,50%,0.5)' }
    blue:    { hsla:'hsla(240,100%,50%,0.5)' }
    violet:  { hsla:'hsla(270,100%,50%,0.5)' }
    magenta: { hsla:'hsla(300,100%,50%,0.5)' }
    rose:    { hsla:'hsla(330,100%,50%,0.5)' }
    trans:   { hsla:'hsla(  0,100%, 0%,0.0)' } }

  @Fills: ['hsla(  0,100%,50%,1.0)', 'hsla( 30,100%,50%,1.0)', 'hsla( 60,100%,50%,1.0)',
           'hsla( 90,100%,50%,1.0)', 'hsla(120,100%,50%,1.0)', 'hsla(150,100%,50%,1.0)',
           'hsla(180,100%,50%,1.0)', 'hsla(210,100%,50%,1.0)', 'hsla(240,100%,50%,1.0)',
           'hsla(270,100%,50%,1.0)', 'hsla(300,100%,50%,1.0)', 'hsla(330,100%,50%,1.0)',
           'hsla(  0,100%,50%,1.0)', 'hsla( 30,100%,50%,1.0)', 'hsla( 60,100%,50%,1.0)'  ]

  ###
  class Brewer

    Color.Brewer = Brewer

    constructor:( @pane, @w, @h ) ->
      i = 0
      parts = @pane.parts
      @colorbrewer = Util.getGlobal('colorbrewer')
      for key, palette of @colorbrewer when i < parts.length
        part = parts[i]
        part.adjustAddClass('palette')
        part.$.attr('title', key )
        swatch = @maxSwatch( palette )
        height = @pane.pc( 100 / Math.max(swatch.length,1) )
        for color in swatch
          part.$.append("""<div class="swatch" style="background-color:#{color}; height:#{height};"></div>""")
        i++
      for k in [i...parts.length]
        parts[k].adjustAddClass('palette')

    maxSwatch:( palette ) ->
      max = 1
      for key of palette
        max = key if parseInt(key) > max
      palette[max]

    resize:( pane ) ->
      part.resize() for part in pane.parts
      return

    d3constructor:( pane, @w, @h ) ->
      if pane.page?
        d3.select('#'+pane.page.contents.svg.gId )
        .selectAll(".palette")
        .data(d3.entries(@colorbrewer))
        .enter().append("span")
        .attr("class", "palette")
        .attr("title", (d) -> d.key )
        #.on("click",   (d) -> console.log(d3.values(d.value).map(JSON.stringify).join("\n")) )
        .selectAll(".swatch")
        .data(   (d) -> d.value[d3.keys(d.value).map(Number).sort(d3.descending)[0]] )
        .enter().append("span")
        .attr("class", "swatch")
        .style("background-color", (d) -> d )
     ###