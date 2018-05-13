
Visual  = require( 'js/visual/Visual' )
#Plotly = require( 'plotly' )

class PlotlyV

  module.exports = PlotlyV # Util.Export( PlotlyV, 'visual/PlotlyV' )

  constructor:( @stream ) ->

  barAa:( divId ) ->
    data = [ {x:[0,1,2], y:[3,2,1], type:'bar'} ]
    opts = { fileopt:"extend", filename:"nodenodenode" }
    Plotly.plot( divId, data, opts )
