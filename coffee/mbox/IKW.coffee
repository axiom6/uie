
Vis     = require( 'js/util/Vis'  )
Build   = require( 'js/prac/Build' )

class IKW

  module.exports = IKW
  MBox   = require( 'js/mbox/MBox' )
  MBox.IKW = IKW

  constructor:( @mbox, @coord, @color, @width, @height, @depth ) ->
    #@docFonts( '36px FontAwesome' )
    @mathbox  = @mbox.mathbox
    @build    = @createBuild()
    @ni       = 0
    @nt       = 4

  createBuild:() ->
    args     = { name:'Muse', plane:'Information', op:''  }
    build    = new Build(   args )  # Build App by processing the specs in the Build module based on 'buildName'
    build

  canvasContext:() ->
    canvas   = document.querySelector('canvas')
    ctx      = canvas.getContext('2d')
    ctx      = canvas.getContext('webgl'   )     if not ctx?
    Util.log( 'MBox.IKW.canvasContext() null' ) if not ctx?
    ctx

  canvasText:( icon, x, y ) ->
    uc       = Vis.unicode( icon )
    ctx      = @canvasContext()
    ctx.font = 'bold 24px FontAwesome'
    ctx.fillText( uc, x, y )
    return

  contextFont:( fontSpec='36px FontAwesome' ) ->
    ctx      = @canvasContext()
    ctx.font = fontSpec
    Util.log( 'MBox.IKW.contextFont()', fontSpec )
    return

  logContextFont:( msg ) ->
    ctx      = @canvasContext()
    Util.log( 'MBox.IKW().logContextFont', msg, ctx.font )
    return

  museCartesian:( range=[[0,120],[0,120],[0,120]], scale=[2,2,2], divide=[12,12] ) ->
    @mathbox.camera( { position:[3,3,3], proxy:true } )
    view  = @mathbox.cartesian( { range:range, scale:scale } )
    @coord.axesXYZ( view,  8, 0xFFFFFF )
    @coord.gridXYZ( view,  4, 0xFFFFFF, divide[1], 0.7, '10' )
    @coord.tickXYZ( view, 64, 0xFFFFFF, divide[2], 2 )
    view

  createArrays:() ->
    xyzs = []
    cubp = []
    cubc = []
    hexp = []
    hexc = []
    hexq = []
    hext = []
    hexi = []
    prcp = []
    prct = []
    prci = []
    conv = []
    conc = []
    conb = []
    cone = []
    conp = []
    flow = []
    floc = []
    flob = []
    floe = []
    flop = []
    pipv = []
    pipc = []
    pipb = []
    pipe = []
    pipp = []
    sprac = 10
    for plane   in [ {name:'Information',z:105}, {name:'Augment',z:75}, {name:'Knowledge',z: 45}, {name:'Wisdom',z:15} ]
    #or plane   in [ {name:'Information',z:105} ]
      for row   in [ {name:'Learn',      y:100}, {name:'Do',         y:60}, {name:'Share',    y: 20} ]
        for col in [ {name:'Embrace',    x: 20}, {name:'Innovate',   x:60}, {name:'Encourage',x:100} ]
          x = col.x
          y = row.y
          z = plane.z
          xyzs.push( [ x,y,z,1] )
          @cubeFaces(  x, y, z, sprac, cubp ) #studySlots( x, y, z, sprac, hexs )
          practice = @build.getPractice( plane.name, row.name, col.name )
          studies  = @build.getStudies(     plane.name, practice.name )
          for key, study of studies
            @fourTier( x, y, z, 4, study, hexp, hexc, hexq, hext, hexi )
          [h,c,v]  = practice.hsv
          cubc.push( Vis.toRgbHsv( h, c, v, true ) ) for i in [0...6] # Colors for 6 faces
          prcp.push( [ x,y-sprac+2,z,1] )
          prct.push( practice.name )
          prci.push( "#{Vis.unicode( practice.icon )}" )
        for con in [ {name:'west', x:40, hsv:{h:90,s:60,v:90}, colName:'Embrace' }, {name:'east', x:80, hsv:{h:0,s:60,v:90}, colName:'Innovate' } ]
          practice = @build.getPractice( plane.name, row.name, con.colName )
          @convey(  practice, 'east', con.x, row.y, plane.z, sprac, practice.hsv, conv, conc, conb, cone, conp )
      for flo in [  {name:'north', y:80, rowName:'Learn'}, {name:'south', y:40, rowName:'Do'} ]
        for col in [ {name:'Embrace', x:20, hsv:{h:210,s:60,v:90} }, {name:'Innovate', x:60, hsv:{h:60,s:60,v:90} }, {name:'Encourage',x:100, hsv:{h:255,s:60,v:90} } ]
          practice = @build.getPractice( plane.name, flo.rowName, col.name )
          @flow( practice, 'south', col.x, flo.y, plane.z, sprac, practice.hsv, flow, floc, flob, floe, flop )
    for pla     in [ {name:'Information',   z: 90}, {name:'Augment',   z:60}, {name:'Knowledge', z: 30} ]
      for row   in [ {name:'Learn',      y:100}, {name:'Do',         y:60}, {name:'Share',    y: 20} ]
        for col in [ {name:'Embrace',    x: 20}, {name:'Innovate',   x:60}, {name:'Encourage',x:100} ]
          practice = @build.getPractice( pla.name, row.name, col.name )
          @conduit( practice, 'next', col.x, row.y, pla.z, sprac, practice.hsv, pipv, pipc, pipb, pipe, pipp )
    [xyzs,cubp,cubc,hexp,hexc,hexq,hext,hexi,prcp,prct,prci,conv,conc,conb,cone,conp,flow,floc,flob,floe,flop,pipv,pipc,pipb,pipe,pipp]

  cubePlanes:( build ) ->
    sprac = 10
    for     own plnKey, pln of build.Planes when plnKey isnt 'Hues'
      for   own rowKey, row of build.Rows
        for own colKey, col of build.Columns
          x = col.cube.x
          y = row.cube.y
          z = pln.cube.z
          practice = @build.getPractice( pln.name, row.name, col.name )
          studies  = @build.getStudies(  pln.name, practice.name )
          prac     = pln.prac
          tier     = pln.tier
          [h,s,v]  = practice.hsv
          @cubeFaces(  x, y, z, sprac, prac.faces )
          prac.rgbs.push( Vis.toRgbHsv( h, s, v, true ) ) for i in [0...6] # Colors for 6 faces
          prac.centers.push( [ x,y-sprac+2,z,1] )
          prac.pracs.push( practice.name )
          prac.icons.push( "#{Vis.unicode( practice.icon )}" )
          for studyKey, study of studies
            @fourTier( x, y, z, 4, study, tier.hexes, tier.rgbs, tier.centers, tier.studies, tier.icons )
    for     own plnKey, pln of build.Planes when @inIAKW(plnKey)
      for   own rowKey, row of build.Rows    
        for own colKey, col of build.Columns when colKey isnt 'Encourage'
          practice = @build.getPractice( pln.name, row.name, col.name )
          convey   = pln.convey
          @convey(  practice, 'east', col.cube.xc, row.cube.y, pln.cube.z, sprac, practice.hsv, convey.rects, convey.rgbs, convey.begs, convey.ends, convey.centers )
    for     own plnKey, pln of build.Planes when @inIAKW(plnKey)
      for   own rowKey, row of build.Rows when rowKey isnt 'Share'
        for own colKey, col of build.Columns
          practice = @build.getPractice( pln.name, row.name, col.name )
          flow = pln.flow
          @flow( practice, 'south', col.cube.x, row.cube.yc, pln.cube.z, sprac, practice.hsv, flow.rects, flow.rgbs, flow.begs, flow.ends, flow.centers )
    for     own plnKey, pln of build.Planes when @inIAK(plnKey)
      for   own rowKey, row of build.Rows
        for own colKey, col of build.Columns
          practice = @build.getPractice( pln.name, row.name, col.name )
          conduit = pln.conduit
          #conduit( practice, 'next', col.cube.x, row.cube.y, pln.cube.zc, sprac, practice.hsv, conduit.rects, conduit.rgbs, conduit.begs, conduit.ends, conduit.centers )
          @conduit( practice, 'next', col.x,      row.y,       pln.z,      sprac, practice.hsv, conduit.rects, conduit.rgbs, conduit.begs, conduit.ends, conduit.centers )
    return build.Planes

  inIAKW:( plane ) ->
    array = ['Information','Augment','Knowledge','Wisdom']
    Util.inArray( array, plane )

  inIAK:( plane ) ->
    array = ['Information','Augment','Knowledge']
    Util.inArray( array, plane )

  cubeFaces:( x, y, z, s, cubp ) ->
    cubp.push( [[x-s,y-s,z-s],[x-s,y+s,z-s],[x-s,y+s,z+s],[x-s,y-s,z+s]] )
    cubp.push( [[x+s,y-s,z-s],[x+s,y+s,z-s],[x+s,y+s,z+s],[x+s,y-s,z+s]] )
    cubp.push( [[x-s,y-s,z-s],[x+s,y-s,z-s],[x+s,y-s,z+s],[x-s,y-s,z+s]] )
    cubp.push( [[x-s,y+s,z-s],[x+s,y+s,z-s],[x+s,y+s,z+s],[x-s,y+s,z+s]] )
    cubp.push( [[x-s,y-s,z-s],[x+s,y-s,z-s],[x+s,y+s,z-s],[x-s,y+s,z-s]] )
    cubp.push( [[x-s,y-s,z+s],[x+s,y-s,z+s],[x+s,y+s,z+s],[x-s,y+s,z+s]] )
    return

  convey:( practice, dir, x, y, z, s, hsv, conv, conc, conb, cone, conp ) ->
    q = s/2
    [beg,end] = @build.connectName( practice, dir )
    conv.push( [[x-s,y-q,z],[x-s,y+q,z],[x+s,y+q,z],[x+s,y-q,z]] )
    conc.push( Vis.toRgbHsv( hsv[0], hsv[1], hsv[2], true ) )
    conb.push( beg )
    cone.push( end )
    conp.push( [x,y,z] )
    #Util.log( 'Convey', { beg:beg, end:end, x:x, y:y, z:z } )
    return

  flow:( practice, dir, x, y, z, s, hsv, flow, floc, flob, floe, flop ) ->
    q = s/2
    [beg,end] = @build.connectName( practice, dir )
    flow.push( [[x-q,y-s,z],[x-q,y+s,z],[x+q,y+s,z],[x+q,y-s,z]] )
    floc.push( Vis.toRgbHsv( hsv[0], hsv[1], hsv[2], true ) )
    flob.push( beg )
    floe.push( end )
    flop.push( [x,y,z] )
    return

  conduit:( practice, dir, x, y, z, s, hsv, pipv, pipc, pipb, pipe, pipp ) ->
    q = s / 2
    [beg,end] = @build.connectName( practice, dir )
    pipv.push( [[x-q,y,z-q],[x+q,y,z-q],[x+q,y,z+q],[x-q,y,z+q]] )
    pipc.push( Vis.toRgbHsv( hsv[0], hsv[1], hsv[2], true ) )
    pipb.push( beg )
    pipe.push( end )
    pipp.push( [x,y,z] )
    return

  fourTier:( x, y, z, s, study, hexp, hexc, hexq, hext, hexi ) ->
    cos30s = Vis.cos(30) * s
    cos30y = cos30s      * 2
    switch study.dir
      when 'north','northd' then hexp.push( @hex( x,       y+cos30s, z, s, hexq ) )
      when 'west', 'westd'  then hexp.push( @hex( x-1.5*s, y,        z, s, hexq ) )
      when 'east', 'eastd'  then hexp.push( @hex( x+1.5*s, y,        z, s, hexq ) )
      when 'south','southd' then hexp.push( @hex( x,       y-cos30s, z, s, hexq ) )
      when 'nw',   'nwd'    then hexp.push( @hex( x-1.5*s, y+cos30y, z, s, hexq ) )
      when 'ne',   'ned'    then hexp.push( @hex( x+1.5*s, y+cos30y, z, s, hexq ) )
      when 'sw',   'swd'    then hexp.push( @hex( x-1.5*s, y-cos30y, z, s, hexq ) )
      when 'se',   'sed'    then hexp.push( @hex( x+1.5*s, y-cos30y, z, s, hexq ) )
      else                       hexp.push( @hex( x,       y+cos30s, z, s, hexq ) )
    hexc.push( Vis.toRgba( study ) )
    hext.push( study.name )  # Vis.unicode( """'#{study.icon}'""" )
    hexi.push( Vis.unicode( study.icon ) )
    return

  hex:( x, y, z, s, hexq ) ->
    hexq.push( [x,y,z])
    pts = []
    for ang in [ 0, 60, 120, 180, 240, 300 ]
      pts.push( [ x+s*Vis.cos(ang), y+s*Vis.sin(ang), z ] )
    pts

  studySlots:( x, y, z, sprac, subs ) ->
    s = sprac/3
    for t     in [ s, s*3, s*5 ]
      for u   in [ s, s*3, s*5 ]
        @cubeFaces( x+t-sprac,y+u-sprac,z-s*2, s, subs )
    return

  # {style: {border: '4px dashed rgba(192, 32, 48, .5)', color: 'rgba(96, 16, 32, 1)', background: 'rgba(255, 255, 255, .75)'}},
  flotExpr:( emit, el ) => # i, j, k, l, time ) =>
    emit( el('div', {}, 'Practice' ) )

  viewXyzsRgbs:( view ) =>
    [xyzs,cubp,cubc,hexp,hexc,hexq,hext,hexi,prcp,prct,prci,conv,conc,conb,cone,conp,flow,floc,flob,floe,flop,pipv,pipc,pipb,pipe,pipp] = @createArrays()
    cont = []
    len  = conb.length
    for i in [0...len]
      cont.push( conb[i]+' '+cone[i] )
    view.array( { data:xyzs, id:"xyzs", items:1, channels:4, live:false, width:xyzs.length } )
    view.array( { data:cubp, id:"cubp", items:4, channels:3, live:false, width:cubp.length } ) # 4 sides = 4 items
    view.array( { data:cubc, id:"cubc", items:1, channels:4, live:false, width:cubc.length } )
    view.array( { data:hexp, id:"hexp", items:6, channels:3, live:false, width:hexp.length } ) # 6 sides = 6 items
    view.array( { data:hexc, id:"hexc", items:1, channels:4, live:false, width:hexc.length } )
    view.array( { data:hexq, id:"hexq", items:1, channels:3, live:false, width:hexq.length } )
    view.array( { data:prcp, id:"prcp", items:1, channels:4, live:false, width:prcp.length } )
    view.array( { data:conv, id:"conv", items:4, channels:3, live:false, width:conv.length } )
    view.array( { data:conc, id:"conc", items:1, channels:4, live:false, width:conc.length } )
    view.array( { data:conp, id:"conp", items:1, channels:3, live:false, width:conp.length } )
    view.array( { data:flow, id:"flow", items:4, channels:3, live:false, width:flow.length } )
    view.array( { data:floc, id:"floc", items:1, channels:4, live:false, width:floc.length } )
    view.array( { data:flop, id:"flop", items:1, channels:3, live:false, width:flop.length } )
    view.array( { data:pipv, id:"pipv", items:4, channels:3, live:false, width:pipv.length } )
    view.array( { data:pipc, id:"pipc", items:1, channels:4, live:false, width:pipc.length } )
    view.array( { data:pipp, id:"pipp", items:1, channels:3, live:false, width:pipp.length } )
    view.face(  { points:"#cubp", colors:"#cubc", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:1, opacity:0.3 } )
    view.face(  { points:"#hexp", colors:"#hexc", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:2, opacity:1.0 } )
    view.face(  { points:"#conv", colors:"#conc", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
    view.face(  { points:"#flow", colors:"#floc", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
    view.face(  { points:"#pipv", colors:"#pipc", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
    view.text(  { data:prct, font:'Font Awesome', width:prct.length, height:1, depth:1 } ) # , style:'bold'
    view.label( { points:"#prcp", color:'#ffffff', snap:false, size:24, offset:[0,-72], depth:0.5, zIndex:3, outline:0 } )
    view.text(  { data:prci, font:'FontAwesome', width:prci.length, height:1, depth:1 } ) # , style:'bold'
    view.label( { points:"#prcp", color:'#ffffff', snap:false, size:72, offset:[0,-6], depth:0.5, zIndex:3, outline:0 } )
    view.text(  { data:hext, font:'Font Awesome', width:hext.length, height:1, depth:1 } )
    view.label( { points:"#hexq", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:3, outline:0 } )
    view.text(  { data:hexi, font:'FontAwesome', width:hexi.length, height:1, depth:1 } )
    view.label( { points:"#hexq", color:'#000000', snap:false, size:36, offset:[0, 15], depth:0.5, zIndex:3, outline:0 } )
    view.text(  { data:cont, font:'FontAwesome', width:cont.length, height:1, depth:1 } )
    view.label( { points:"#conp", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )
    view.text(  { data:flob, font:'FontAwesome', width:flob.length, height:1, depth:1 } )
    view.label( { points:"#flop", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )
    view.text(  { data:floe, font:'FontAwesome', width:floe.length, height:1, depth:1 } )
    view.label( { points:"#flop", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:4, outline:0 } )
    view.text(  { data:pipb, font:'FontAwesome', width:pipb.length, height:1, depth:1 } )
    view.label( { points:"#pipp", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:4, outline:0 } )
    view.text(  { data:pipe, font:'FontAwesome', width:pipe.length, height:1, depth:1 } )
    view.label( { points:"#pipp", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )

    # @mbox.createMenuBar( [['Info',()=>@doInfo()],['Data',()=>@doData()],['Know',()=>@doKnow()],['Wise',()=>@doWise()]])
    return

  doInfo:() -> Util.log( 'IKW plane', 'Info' )
  doData:() -> Util.log( 'IKW plane', 'Augm' )
  doData:() -> Util.log( 'IKW plane', 'Data' )
  doKnow:() -> Util.log( 'IKW plane', 'Know' )
  doWise:() -> Util.log( 'IKW plane', 'Wise' )

  viewPlanes:( view ) =>
    planes = @cubePlanes( @build )
    for own plnKey, pln of planes
      p    = plnKey.charAt(0)
      q    = '#'+p
      prac = pln.prac
      tier = pln.tier
      conv = pln.convey
      flow = pln.flow
      cond = pln.conduit

      conv.pairs = []
      len  = conv.begs.length
      for i in [0...len]
        conv.pairs.push( conv.begs[i]+' '+conv.ends[i] )
      
      view.array( { data:prac.faces,   id:p+"faces", items:4, channels:3, live:false, width:prac.faces.length   } ) # 4 sides = 4 items
      view.array( { data:prac.rgbs,    id:p+"frgbs", items:1, channels:4, live:false, width:prac.rgbs.length    } )
      view.array( { data:prac.centers, id:p+"pcens", items:1, channels:4, live:false, width:prac.centers.length } )
      view.array( { data:tier.hexes,   id:p+"hexes", items:6, channels:3, live:false, width:tier.hexes.length   } ) # 6 sides = 6 items
      view.array( { data:tier.rgbs,    id:p+"hrgbs", items:1, channels:4, live:false, width:tier.rgbs.length    } )
      view.array( { data:tier.centers, id:p+"hcens", items:1, channels:3, live:false, width:tier.centers.length } )

      view.array( { data:conv.rects,   id:p+"crecs", items:4, channels:3, live:false, width:conv.rects.length   } )
      view.array( { data:conv.rgbs,    id:p+"crgbs", items:1, channels:4, live:false, width:conv.rgbs.length    } )
      view.array( { data:conv.centers, id:p+"ccens", items:1, channels:3, live:false, width:conv.centers.length } )
      view.array( { data:flow.rects,   id:p+"frecs", items:4, channels:3, live:false, width:flow.rects.length   } )
      view.array( { data:flow.rgbs,    id:p+"frgbx", items:1, channels:4, live:false, width:flow.rgbs.length    } )
      view.array( { data:flow.centers, id:p+"fcens", items:1, channels:3, live:false, width:flow.centers.length } )
      view.array( { data:cond.rects,   id:p+"precs", items:4, channels:3, live:false, width:cond.rects.length   } )
      view.array( { data:cond.rgbs,    id:p+"prgbs", items:1, channels:4, live:false, width:cond.rgbs.length    } )
      view.array( { data:cond.centers, id:p+"pcenx", items:1, channels:3, live:false, width:cond.centers.length } )

      view.face(  { points:q+"faces", colors:q+"frgbs", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:1, opacity:0.3 } )
      view.face(  { points:q+"hexes", colors:q+"hrgbs", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:2, opacity:1.0 } )
      view.face(  { points:q+"crecs", colors:q+"crgbs", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
      view.face(  { points:q+"frecs", colors:q+"frgbx", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
      view.face(  { points:q+"precs", colors:q+"prgbs", color:0xffffff, shaded:true, fill:true, line:true, closed:true, zIndex:3, opacity:0.5 } )
      
      view.text(  { data:prac.pracs,  font:'Font Awesome', width:prac.pracs.length, height:1, depth:1 } ) # , style:'bold'
      view.label( { points:q+"pcens", color:'#ffffff', snap:false, size:24, offset:[0,-72], depth:0.5, zIndex:3, outline:0 } )
      view.text(  { data:prac.icons,  font:'FontAwesome', width:prac.icons.length, height:1, depth:1 } ) # , style:'bold'
      view.label( { points:q+"pcens", color:'#ffffff', snap:false, size:72, offset:[0,-6], depth:0.5, zIndex:3, outline:0 } )
      view.text(  { data:tier.studies, font:'Font Awesome', width:tier.studies.length, height:1, depth:1 } )
      view.label( { points:q+"hcens", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:3, outline:0 } )
      view.text(  { data:tier.icons, font:'FontAwesome', width:tier.icons.length, height:1, depth:1 } )
      view.label( { points:q+"hcens", color:'#000000', snap:false, size:36, offset:[0, 15], depth:0.5, zIndex:3, outline:0 } )
      view.text(  { data:conv.pairs, font:'FontAwesome', width:conv.pairs.length, height:1, depth:1 } )
      view.label( { points:q+"ccens", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )
      view.text(  { data:flow.begs, font:'FontAwesome', width:flow.begs.length, height:1, depth:1 } )
      view.label( { points:q+"fcens", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )
      view.text(  { data:flow.ends, font:'FontAwesome', width:flow.ends.length, height:1, depth:1 } )
      view.label( { points:q+"fcens", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:4, outline:0 } )
      view.text(  { data:cond.begs, font:'FontAwesome', width:cond.begs.length, height:1, depth:1 } )
      view.label( { points:q+"pcenx", color:'#000000', snap:false, size:16, offset:[0,-15], depth:0.5, zIndex:4, outline:0 } )
      view.text(  { data:cond.ends, font:'FontAwesome', width:cond.ends.length, height:1, depth:1 } )
      view.label( { points:q+"pcenx", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )
    return


  toRgbHexxFaces:( len ) ->
    rgbh = []
    for   prac in [0...len]
      for rgba in [[180,50,90],[60,50,90],[90,50,90],[30,50,90]]
        rgbh.push( Vis.toRgbHsv( rgba[0], rgba[1], rgba[2], true ) )
    rgbh

  musePoints:() ->
    obj =  { id:'musePoints', width:@width, height:@height, depth:@depth, items:1, channels:4 }
    obj.expr = ( emit, x, y, z ) =>
       emit( @center(x), @center(y), @center(z), 1 ) # emit( x, y, z, 1 )
    obj

  center:( u ) ->
    v = u
    v =  20 if  0 <= u and u <   40
    v =  60 if 80 <= u and u <   80
    v = 100 if 80 <= u and u <= 120
    v

  museColors:() ->
    obj  =  { id:'museColors', width:@width, height:@height, depth:@depth, channels:4 } #
    obj.expr  = ( emit, x, y, z ) =>
      [r,g,b,a] = @practiceColor( x, y, z, i, j, k )
      emit( r, g, b, a )
    obj

  musePoint:() ->
    obj = { id:"musePoint", points: "#musePoints", colors: "#museColors", shape:"square", color: 0xffffff, size:600 }
    obj

  museText:() ->
    str = (n) -> Util.toStr(n)
    obj = { font:'Helvetica', style:'bold', width:16, height:5, depth:2 } # point:"#musePoint"
    obj.expr = ( emit, i, j, k, time ) =>
      Util.noop( time )
      if @ni < @nt
        @ni = @ni + 1
        #Util.log( "Hi #{str(i)} #{str(j)} #{str(k)}" )
      emit( "Hi #{str(i)} #{str(j)} #{str(k)}" )
    obj

  museLabel:() ->
    { points: "#musePoints", color:'#000000', snap:false, outline:2, size:24 , depth:.5,zIndex:5 }

  # emit( "Hi #{Util.toStr(i)} #{Util.toStr(j)} #{Util.toStr(k)}" )


  museCube:( view ) ->
    view.volume( @musePoints() )
    view.volume( @museColors() )
    view.point(  @musePoint()  )
        .text(   @museText()   )
        .label(  @museLabel()  )

  practiceColor:( x, y, z ) ->

    if       0 <= x and x <   40 then hue = 210
    else if 40 <= x and x <   80 then hue =  60
    else if 80 <= x and x <= 120 then hue = 300

    if       0 <= y and y <   40 then c   = 40
    else if 40 <= y and y <   80 then c   = 60
    else if 80 <= y and y <= 120 then c   = 80

    if       0 <= z and z <   40 then v   = 40
    else if 40 <= z and z <   80 then v   = 60
    else if 80 <= z and z <= 120 then v   = 80

    Vis.toRgbHsv( hue, c, v, true )

  ###

  #iew.html(  { width:1, height:1, depth:1, expr:@flotExpr } )
  #iew.html(  { data:flot, width:flot.length, height:1, depth:1 } )
  #iew.dom(   { points:"#flop", color:'#000000', snap:false, size:16, offset:[0, 15], depth:0.5, zIndex:4, outline:0 } )

  fontFace:( name, uri ) ->
    fontFace = new FontFace( name, uri ) # "url(x)"
    fontFace.load()

  docFonts:( fontSpec='36px FontAwesome' ) ->
    document.fonts.load( fontSpec )
      .then( Util.log( 'MBox.IKW().docFonts loaded', fontSpec), Util.error('MBox.IKW.docFonts()' ) )
    return
  ###
    

