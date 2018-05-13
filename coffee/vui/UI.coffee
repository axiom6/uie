
$        = require('jquery')
di       = require('dom-to-image')
Database = require( 'js/util/Database')

class UI

  Util.UI        = UI
  module.exports = UI
  UI.Build       = require( 'js/prac/Build' )
  UI.Navb        = require( 'js/ui/Navb'    )
  UI.Tocs        = require( 'js/ui/Tocs'    )
  UI.View        = require( 'js/ui/View'    )
  UI.Pane        = require( 'js/ui/Pane'    )
  UI.Part        = require( 'js/ui/Part'    )
  UI.Group       = require( 'js/ui/Group'   )
  UI.Btn         = require( 'js/ui/Btn'     )
  UI.Page        = require( 'js/ui/Page'    )
  UI.Prac        = require( 'js/prac/Prac'  )
  UI.$empty      = $() # Empty jQuery singleton for intialization

  @isEmpty:( $elem ) -> $elem? and $elem.length? and $elem.length is 0

  @isElem:(  $elem ) -> not UI.isEmpty( $elem )

  @jmin:( cells ) ->
    Util.trace('UI.jmin') if not cells?
    [ cells[0]-1,cells[1],cells[2]-1,cells[3] ]

  @toCells:( jmin ) ->
    [ jmin[0]+1,jmin[1],jmin[2]+1,jmin[3] ]

  @unionCells:( cells1, cells2 ) ->
    [j1,m1,i1,n1] = UI.jmin( cells1 )
    [j2,m2,i2,n2] = UI.jmin( cells2 )
    [ Math.min(j1,j2)+1, Math.max(j1+m1,j2+m2)-Math.min(j1,j2), Math.min(i1,i2)+1, Math.max(i1+n1,i2+n2)-Math.min(i1,i2) ]

  @intersectCells:( cells1, cells2 ) ->
    [j1,m1,i1,n1] = UI.jmin( cells1 )
    [j2,m2,i2,n2] = UI.jmin( cells2 )
    [ Math.max(j1,j2)+1, Math.min(j1+m1,j2+m2), Math.max(i1,i2)+1, Math.min(i1+n1,i2+n2) ]

  @Planes =
    Information: { name:"Information", id:"Info", spec:{}, ui:null }
    Augment:     { name:"Augment",     id:"Augm", spec:{}, ui:null }
    DataScience: { name:"DataScience", id:"Data", spec:{}, ui:null }
    Knowledge:   { name:"Knowledge",   id:"Know", spec:{}, ui:null }
    Wisdom:      { name:"Wisdom",      id:"Wise", spec:{}, ui:null }
    Hues:        { name:"Hues",        id:"Hues", spec:{}, ui:null }

  @ThePlane  = null
  @TheBuild  = null
  @TheStream = null

  @createUI:( planeName, build, stream ) ->
    UI.TheStream     = stream
    UI.ThePlane      = UI   .Planes[planeName]
    UI.ThePlane.spec = build.Planes[planeName]
    UI.ThePlane.ui   = new UI( build, stream, UI.ThePlane )
    UI.ThePlane.ui.ready()
    UI.TheBuild    = build
    UI.subscribe()
    UI.publish()
    return

  @subscribe:() ->
    UI.TheStream.subscribe( 'Plane', (name) => UI.onPlane(name) )  # if not UI.Build? # Subscribe only when ui.ready()
    UI.TheStream.subscribe( 'Image', (name) => UI.onImage(name) )
    return

  @publish:() ->
    #UI.TheStream.publish( 'Content', UI.Build.content( 'Studies', 'createUI', Build.SelectAllPanes ) )
    return

  @onPlane:( planeName ) ->
    return Util.error( "UI.createUI() has not been called yet") if not UI.ThePlane?
    return if planeName is UI.ThePlane.name
    UI.ThePlane.ui?.view?.hideAll()
    UI.ThePlane = UI.Planes[planeName]
    UI.hideAllPlanes()
    if not UI.ThePlane.ui?
      UI.createUI( planeName, UI.TheBuild, UI.TheStream )
    else
      UI.ThePlane.ui.view.reset( { name:planeName, intent:UI.Build.SelectPlane } )
      UI.TheStream.publish( 'Content', UI.Build.content( 'Tree', 'onPlane', UI.Build.SelectPlane ) ) # Publish content choice to AllPanes
    UI.ThePlane.ui.show()
    return

  @imageNodeId:() ->
    "ViewApp"

  @onImage:() ->
    ida   = "ImageLinkApp"
    link  = document.getElementById( ida )
    node  = document.getElementById( UI.imageNodeId() )
    name  = UI.ui.view.select.name
    isCol = Util.inArray( ['Embrace','Innovate','Encourage'], name )
    isRow = Util.inArray( ['Learn',  'Do',      'Share'    ], name )
    w     = if isCol then 600 else 1400
    h     = if isRow then 400 else  960
    opts  = { width:w, height:h }
    type  = 'png'
    save  = ( href ) ->
      link.download = name + '.' + type
      link.href     = href
      link.click()
      Util.log( 'UI.onImage()', link.download, name )
    switch type
      when 'png' then di.toPng(  node, opts ).then( save )
      when 'svg' then di.toSvg(  node, opts ).then( save )
      else            di.toJpeg( node, opts ).then( save )
    return

  @hideAllPlanes:() ->
    plane.ui.hide() for own key, plane of UI.Planes when plane.ui?

  constructor:( @build, @stream, @plane ) ->
    @tocs  = new UI.Tocs(  @, @stream )
    @view  = new UI.View(  @, @stream )
    @prac  = new UI.Prac(  @, @stream, @view )
    @pages = @createPages( @, @stream, @view )
    @expandGroup = false
    UI.ui = @

  notInPlane:() ->
    UI.ThePlane.name isnt @plane.name

  createPages:( ui, stream, view ) ->
    view.createOverview( @build )
    pages = []
    for pane in view.panes
      pane.page = new UI.Page( ui, stream, view, pane, @prac )
      pages.push( pane.page )
    pages

  ready:() ->
    @tocs.ready()
    @view.ready()
    return

  show:() ->
    @tocs.show()
    @view.showAll()
    return

  hide:() ->
    @tocs.hide()
    @view.hideAll()
    return

  resize:() =>
    @view.resize()
    return

  htmlId:( name, ext='' ) ->
    Util.htmlId( name, @plane.id, ext )

  getHtmlId:( name, ext='' ) ->
    Util.getHtmlId( name, @plane.id, ext )

  chooseCells:( spec ) ->
    if spec.dells? and @plane.id is 'Data' then spec.dells else spec.cells

  findConnectMsg:( id ) ->
    for own key, plane of UI.Planes when plane.ui?
      for pane in plane.ui.view.panes when pane.page? and pane.page.connect?
        connect = pane.page.connect
        msg     = connect.msgs[id]
        return [connect,msg] if msg?
    Util.error( 'Build.findConnectMsg() msg not found for', id )
    [undefined,undefined]

  migrateConnectMsg:( id, dir ) ->
    [connect,msg] = @findConnectMsg( id )
    connect.migrate( id, dir ) if connect? and msg?
    return

  slideUrl:( talk ) ->
    if @Slides[talk]?
      @Slides.SymLink.url + @Slides[talk].url
    else if @isPractice(talk)
      @Slides.SymLink.url + @Slides[@ui.plane.id].url + talk
    else
      Util.error( 'Build.talkUrl()', talk, 'not found' )
      undefined

