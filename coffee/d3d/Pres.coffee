
class Pres

  module.exports = Pres # Util.Export( Pres, 'd3d/Pres' )

  constructor:( @build, @stream, @view ) ->
    @Page     = require('js/ui/UI/Page')
    @Database = require('js/store/Database' )
    @Rest     = require('js/store/Rest')
    @Shows    = { Tree:{},Radial:{},Links:{},Axes:{},Radar:{},Wheel:{},Sankey:{},Brewer:{},Chord:{},Table:{},Schema:{},Pivot:{},Classify:{} }
    @stream.subscribe( 'Select', (select) => @onSelect(select) )
    @stream.subscribe( 'Layout', (layout) => @onLayout(layout) )

  onSelect:( select ) ->
    name = select.name
    selected = @Shows[name ]
    if selected?
       selected.d3d = @createD3D(  name  ) if not @Shows[name].d3d?
       selected.page.selected = if name  is 'Table' then 'Topic' else 'Svg'
       # Util.log( 'Pres.onSelect()', select, selected.page.selected )

  onLayout:( layout ) ->
    selected = @Shows[layout.select]
    if selected?
       selected.visual.resize() if layout.select is 'Table' and layout.content is 'Table'
      
  createShow:( pane ) ->
    page = new @Page( @build, @stream, @view, pane, 'Center' )
    if @Shows[pane.name]?
       @Shows[pane.name].pane = pane
       @Shows[pane.name].page = page
    else
       Util.error( 'Pres.createShow() unknown show', pane.name )
    page

  createD3D:( select ) ->
    pane = @Shows[select].pane
    # Util.log( 'Pres.createD3D', select )
    d3d = switch select
      when 'Tree'     then @instanciateTree(     pane  )
      when 'Radial'   then @instanciateRadial(   pane  )
      when 'Links'    then @instanciateLinks(    pane  )
      when 'Axes'     then @instanciateAxes(     pane  )
      when 'Radar'    then @instanciateRadar(    pane  )
      when 'Wheel'    then @instanciateWheel(    pane  )
      when 'Sankey'   then @instanciateSankey(   pane  )
      when 'Brewer'   then @instanciateBrewer(   pane  )
      when 'Chord'    then @instanciateChord(    pane  )
      when 'Table'    then @instanciateTable(    pane  )
      when 'Schema'   then @instanciateSchema(   pane  )
      when 'Pivot'    then @instanciatePivot(    pane  )
      when 'Classify' then @instanciateClassify( pane  )
      else Util.error( 'd3d/Pres.instanciate() unknown select', select ); null
    d3d

  svgGeom:( pane ) ->
    Util.error( 'Pres.svgGeom() missing page', pane.name ) if not pane.page?
    [pane.page.contents.svg,pane.geom()]

  transform:( pane, x, y, s ) ->
    cs = pane.page.contents.svg
    cs.$.hide()                          # Hide svg so it won't push out the pane
    cs.$g.attr( 'transform', """translate(#{x},#{y}) scale(#{s},#{s})""" )
    cs.$.show()
    return

  restData:( dbName, fileJson, doData ) ->
    rest = new @Rest( @stream, @Database.Databases[dbName].uriLoc )
    rest.key = 'name' if dbName is 'radar'
    rest.remember()
    rest.select( fileJson )
    onNext = (data) =>
      doData( data )
    rest.subscribe( Util.firstTok(fileJson,'.'), 'none', 'select', onNext )

  instanciateTree:( pane ) ->
    [svg,geom]= @svgGeom( pane )
    Tree   = require('js/d3d/Tree')
    tree   = new Tree( svg.g, geom.wv, geom.hv, false )
    @restData( 'radar', 'polyglot-principles.json', (data) => tree.doTree(data) )
    tree

  instanciateRadial:( pane ) ->
    [svg,geom]= @svgGeom( pane )
    Radial = require('js/d3d/Radial')
    radial = new Radial( svg.g, geom.wv, geom.hv )
    @restData( 'radar', 'polyglot-principles.json', (data) => radial.doRadial(data) )
    radial

  instanciateTable:( pane ) ->
    columns = [
      { n:'1st',   w:0, t:'null' },      { n:'i',     w:2, t:'Int'   }, { n:'Name',  w:15, t:'Id'     },
      { n:'Grade', w:5, t:'Float'     }, { n:'Angle', w:5, t:'Float' }, { n:'Title', w:0,  t:'string' } ]
    Table = require( 'js/table/Table')
    table = new Table(  'axiom-table', pane.page.contents.table.htmlId, columns )
    @restData( 'radar', 'axiom-table.json', (techs) => table.doData(techs) )
    table

  instanciateSchema:( pane ) ->
    Type   = require( 'js/util/Type' )
    Schema = require( 'js/build/Schema' )
    @restData( 'geo', 'errorLarimerGeo.json', (model) => Type.checkStart( model, Schema.GeoJSON, 'errorLarimer' ) )
    @instanciateLinks( pane )

  instanciatePivot:( pane ) ->
    Pivot = require( 'js/table/Pivot')
    pivot = new Pivot( @build, @stream )
    @restData( 'pivot', 'mps.json', (mps) => pivot.doMps( mps, pane.page.contents.table.htmlId ) )
    pivot

  instanciateClassify:( pane ) ->
    Pivot = require( 'js/table/Pivot')
    pivot = new Pivot( @build, @stream )
    @restData( 'muse', 'Practices.json', (practices) => pivot.doPractices( practices, pane.page.contents.table.htmlId ) )
    pivot

  instanciateSankey:( pane ) ->
    [svg,geom]= @svgGeom( pane )
    Sankey = require( 'js/d3d/Sankey' )
    sankey = new Sankey( svg.defs, svg.g, 0, 0, geom.wv, geom.hv, 36, 6, true )
    @restData( 'sankey', 'plot.json', (data) => sankey.doData(data) )
    sankey

  instanciateRadar:( pane  ) ->
    [svg,geom]= @svgGeom( pane )
    Radar = require('js/d3d/Radar')
    radar = new Radar( svg.g, true, geom.wv, geom.hv )
    @restData( 'radar', 'axiom-quads.json', (quads) => radar.doQuads(quads) )
    @restData( 'radar', 'axiom-techs.json', (techs) => radar.doTechs(techs) )
    radar
    
  instanciateWheel:( pane  ) ->
    [svg,geom]= @svgGeom( pane )
    Wheel = require('js/d3d/Wheel')
    wheel = new Wheel( svg.g, geom.wv, geom.hv )
    wheel

  instanciateBrewer:( pane  ) ->
    [svg,geom]= @svgGeom( pane )
    Color = require('js/d3d/Color')
    brewer = new Color.Brewer( pane, geom.wv, geom.hv )
    brewer

  instanciateAxes:( pane  ) ->
    [svg,geom]= @svgGeom( pane )
    Axes = require('js/d3d/Axes')
    axes = new Axes( svg.g, geom.wv, geom.hv, { x1:0, x2:100, xtick1:10, xtick2:1 }, { y1:0, y2:100, ytick1:10, ytick2:1 } )
    @transform( pane, 40, 40, 1.0 )
    axes

  instanciateChord:( pane  ) ->
    [svg,geom]= @svgGeom( pane )
    Chord = require('js/d3d/Chord')
    chord = new Chord( svg.g, geom.wv, geom.hv )
    @transform( pane, geom.wv/2, geom.hv/2, geom.s )
    chord

  instanciateLinks:( pane ) ->
    [svg,geom]= @svgGeom( pane )
    Link = require('js/d3d/Link')
    link = new Link( svg.g, geom.wv, geom.hv )
    link.ornament( 150 )
    link
