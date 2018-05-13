
chroma = require( 'chroma-js' )
Vis    = require( 'js/util/Vis' )

class Names

  module.exports = Names # Util.Export( Names, 'mbox/Names' )
  MBox = require( 'js/mbox/MBox' )
  MBox.Names = Names

  # prepareColorsData and findClosedColor for find in namer/main
  constructor:( @mbox ) ->
    @colors = prepareColorsData( GLOBAL_COLOR_LIST, GLOBAL_WIKI_COLOR_LIST )

  names:( find, colors ) ->
    for hue in [0..360]
      [r,g,b,a] = Vis.toRgbHsv( hue, 100, 100 )
      hex  = chroma.rgb( r*255,g*255,b*255 ).hex()
      name = find( hex, colors )
      Util.log( { name:name.name, hue:hue, rgb:name.rgb, hex:name.hex } )

  namesAll:( find, colors ) ->
    for hue in [0..360]
      for c in [0...100] by 10
        for v in [0...100] by 10
          [r,g,b,a] = Vis.toRgbHsv( hue, c, v )
          hex  = chroma.rgb( r*255,g*255,b*255 ).hex()
          name = find( hex, colors )
          Util.log( { name:name.name, hue:hue, rgb:name.rgb, hex:name.hex, sat:Util.toInt(rad*100), lum:Util.toInt(v*100), } )

  namesLch:( find, colors ) ->
    for hue in [0..360] by 30
      for sat in [0...100] by 10
        for lum in [0...100] by 10
          [r,g,b] = Vis.toRgbLch( lum, sat, hue )
          hex  = chroma.rgb( r*255,g*255,b*255 ).hex()
          lch  = chroma.rgb( r*255,g*255,b*255 ).lch()
          name = find( hex, colors )
          Util.log( { name:name.name, hue:hue, rgb:name.rgb, hex:name.hex, sat:sat, lum:lum, lch:lch } )

  namesRgb:( find, colors ) ->
    for r in [0..255]  by 5
      for g in [0..255]  by 5
        for b in [0..255]  by 5
          hex  = chroma.rgb( r,g,b ).hex()
          name = find( hex, colors )
          Util.log( { name:name.name, rgb1:[r,g,b], rgb2:name.rgb, hex:name.hex } )