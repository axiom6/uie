
#mathbox = require('mathbox')       # Mathbox has to be loaded from main HTML
#$       = require('jquery')        # For createMenuBar
Vis      = require( 'js/util/Vis' ) # MBox modules are loaded as needed as in htm/mbox/MainBox
Build    = require( 'js/prac/Build' )

class MBox

  module.exports = MBox # Util.Export( MBox, 'mbox/MBox' )

  constructor:() ->
    THREE     = window['THREE']
    @mathbox  = mathBox(
      plugins:['core','controls','cursor', 'stats']
      controls: { klass: THREE.OrbitControls } ) # TrackballControls  OrbitControls
    Util.error('mathbox WebGL not supported') if @mathbox.fallback
    Util.mathbox = @mathbox
    @three = @mathbox.three
    @three.renderer.setClearColor( new THREE.Color(0x000000), 1.0 )
    #@mathbox.set( { focus:3, scale: 720 } )
    Util.time  = 0
    @setupTime()

  createBuild:() ->
    args     = { name:'Muse', plane:'Information', op:'' }
    new Build(   args )

  setupTime:() ->
    @three.on('update', () -> Util.time = @three.Time.clock )
    Util.noop()
    return

  ###
  createMenuBar:( ncs ) ->
    liStyle = "display:inline; margin-right:10px; position:relative; left:0; top:0; width:auto; height:auto;"
    $ul = $("""<ul style="position:absolute; left:20px; top:10px; background:white; display:inline; list-style:none; list-style-image:none;">""")
    for nc in ncs
      [n,c] = nc
      $li = $("""<li style="#{liStyle}"><buttons>#{n}</buttons></li>""")
      $li.on( 'click', c )
      $ul.append($li)
    $('body').append($ul)
    return
  ###

  ###
  """<button style="position: absolute; bottom: 15px; left: 50%; margin-left: -60px; width: 120px; font-size: 20px;" onclick="#{c}">#{n}</button>"""
  ###

  pv1v2:( p, v1, v2 ) ->
    p1 = p * 0.01
    p2 = 1.0 - p1
    v3 = [0,0,0]
    for i in [0...3]
      v3[i] = v1[i]*p1 + v2[i]*p2
    v3

  toRad:( i, n ) ->
    hue = ( i * 360/n) % 360
    Vis.toRadian( hue )

  toHue:( i, n ) ->
    h = ( i * 360/n) % 360
    Util.toInt(h)

  sin9:(      x, y ) -> 0.5 + 0.25*Math.sin( 12*x + Util.time*0.3 ) + 0.25*Math.sin( 12*y + Util.time*0.3 )

  sin12:(     x, y ) -> 0.5 + 0.50*Math.sin( 12*x + Util.time*0.3 ) + 0.50*Math.sin( 12*y + Util.time*0.3 )

  sinNorm:(   x, y ) -> Math.sin( 12*x + Util.time*0.3 ) + Math.sin( 12*y + Util.time*0.3 )

  sin9Pq:(    a, r ) -> 0.5 + 0.25*Math.sin( 12*(r+a) + Util.time*1.2 + π/12 ) + 0.25*Math.cos( 12*(a)  )

  sin9P:(     a, r ) -> 0.5*Math.sin( 12*(a+r) + Util.time*1.2 + π/12) + 0.5*Math.cos( 12*(a) )

  sin9R:(     a, r ) -> 0.5 + 0.25*Math.sin( 12*r*a + Util.time*1.2 ) + 0.25*Math.sin( 6*a )

  sin9P:(     a, r ) -> 0.5 + 0.25*Math.sin( 12*r + Util.time*0.3 + π/12 )    + 0.25*Math.sin( 12*a + π/12 )

  sin9PJan:(  a, r ) -> 0.5 *      Math.sin( 12*(a+r) + Util.time*1.2 + π/12) + 0.50*Math.cos( 12*(a) )


  sin9QJan:(  a, r ) -> 0.5 + 0.25*Math.sin( 12*r + Util.time*0.3 + π/12 ) + 0.25*Math.sin( 12*a + π/12 )

  sin12P:(    a, r ) -> 0.5*Math.sin( 12*(r+a) + Util.time*1.2 )  + 0.5*Math.cos( 12*(a)  )
  sin12R:(    a, r ) -> .5 + 0.25*Math.sin( r + a ) + 0.25*Math.cos( r + a * Util.time*0.5 )


  sin12PMar:( a, r ) -> .5 + .5 * Math.sin( 12 * (r + a) + Util.time ) * Math.sin(  9*a + Util.time )
  sin12CMar:( a, r ) -> .5 + .5 * Math.sin( 12 * (r + a) + Util.time ) * Math.sin(  9*a + Util.time ) * Math.cos(r)
  sin09PMar:( a, r ) -> .5 + .5 * Math.sin(  9 * (r + a) + Util.time ) * Math.sin(  9*a + Util.time )
  sin01Oct:(  a, r ) -> .5 + .5 * Math.sin(  a           + Util.time ) * Math.sin(    r + Util.time )
  sin09Oct:(  a, r ) -> .5 + .5 * Math.sin(  9 *  a      + Util.time ) * Math.sin(  9*r + Util.time )
  sin12Oct:(  a, r ) -> .5 + .5 * Math.sin( 12 *  a      + Util.time ) * Math.sin( 12*r + Util.time )
  cos01Oct:(  a, r ) -> .5 + .5 * Math.cos(       a      + Util.time ) * Math.cos(    r + Util.time )

  sin12AMay:( a, r ) -> .5 + .50 * Math.cos( 12 * a + Util.time )
  sin12RMay:( a, r ) -> .5 + .50                                  *        Math.cos( 12 * r + Util.time )
  sin12MMay:( a, r ) -> .5 + .50 * Math.cos( 12 * a + Util.time ) * 1.00 * Math.cos( 12 * r + Util.time )


  sin12PMay:( a, r ) -> .5 + .25 * Math.cos( 12 * a + Util.time ) +  .25 * Math.cos( 12 * r + Util.time )
  sin12QMay:( a, r ) -> .5 + .25 * Math.cos( 12 * a + Util.time ) +  .25 * Math.cos( 12 * r + Util.time )

  sin12QJan:( a, r ) -> .50 + .50 * Math.sin( 12 * (r + a) + Util.time * 1.2  )
  sin12AJan:( a, r ) -> .50 + .50 * Math.sin( 12 *      a  + Util.time * 1.2  )
  sin06AJan:( a, r ) -> .50 + .50 * Math.sin(  3 *      a  + Util.time * 1.2  )         # Keep

  sin06B:(    a, r ) -> .55 + .45 * Math.sin(  3 * a + Util.time )
  sin06C:(    a, r ) -> .60 + .40 * Math.sin(  3 * a + Util.time )
  sin03D:(    a, r ) -> .60 + .40 * Math.sin(  3 * a + Util.time ) * Math.sin( r * 0.11 + Util.time )
  sin06D:(    a, r ) -> .60 + .40 * Math.sin(  6 * a + Util.time ) * Math.sin( r * 0.11 + Util.time )
  sin06E:(    a, r ) -> .60 + .40 * Math.sin(  6 * a + Util.time ) * Math.sin( r / 12   + Util.time )
  sin06F:(    a, r ) -> .60 + .40 * Math.sin(  6 * a + Util.time ) * Math.sin( r /  8   + Util.time )

  sigmoidal:( x, k, x0=0.5 ) ->
    1 / ( 1 + Math.exp(-k*(x-x0)) )

  depth:() ->
    Math.abs( Math.cos( Util.time*0.5  ) )

  toDep:( a, r ) ->
    Math.abs( Math.cos( 6*(r+a) + Util.time*0.5  ) )




