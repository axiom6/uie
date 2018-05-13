
$  = require('jquery')
UI = require( 'js/ui/UI' )

class View

  module.exports = View

  constructor:( @ui, @stream ) ->
    @speed     = 400
    @$view     = UI.$empty
    @plane     = @ui.plane
    @build     = @ui.build
    @margin    = @build.margin
    @ncol      = @plane.spec.ncol
    @nrow      = @plane.spec.nrow
    [@wpane,@hpane,@wview,@hview,@wscale,@hscale] = @percents( @nrow, @ncol, @margin )
    @panes     = @createPanes()
    @groups    = @createGroups( @build, @plane )
    @overview  = null # Built by ui.createPages()
    @assignPanesToGroups( @panes, @groups )
    @sizeCallback  = null
    @paneCallback  = null
    @lastPaneName  = ''
    @lastStudyName = ''
    @lastTopicName = ''
    @lastItemsName = ''
    @emptyPane      = new UI.Pane( @ui, @stream, @, @build.None )
    @allCells = [ 1, @ncol, 1, @nrow ]
    @select   = { name:@plane.name, intent:UI.Build.SelectPlane }

  ready:() ->
    parent = $('#'+Util.getHtmlId('View','App') ) # parent is outside of planes
    htmlId = @ui.htmlId( 'View' )
    html   = $( """<div id="#{htmlId}" class="ikw-view-plane"></div>""" )
    parent.append( html )
    @$view = parent.find('#'+htmlId )
    pane.ready()  for pane  in @panes
    group.ready() for group in @groups
    @overview.ready()
    @overview.hide()
    @$view.append( @$allIcon() )
    @subscribe()
    return

  subscribe:() ->
    @stream.subscribe( 'Select', (select) => @onSelect(select) )

  percents:( nrow, ncol, margin ) ->
    wpane  = 100 / ncol
    hpane  = 100 / nrow
    wview  = 1.0 - ( margin.west   + margin.east  ) / 100
    hview  = 1.0 - ( margin.north  + margin.south ) / 100
    wscale = 1.0 - ( margin.west  + (ncol-1) * margin.width  + margin.east  ) / 100  # Scaling factor for panes once all
    hscale = 1.0 - ( margin.north + (nrow-1) * margin.height + margin.south ) / 100  # margins gutters are accounted for
    [wpane,hpane,wview,hview,wscale,hscale]

  pc:(v) -> v.toString() + if v isnt 0 then '%' else ''
  xs:(x) -> @pc( x * @wscale )
  ys:(y) -> @pc( y * @hscale )

  left:(j)    -> j * @wpane
  top:(i)     -> i * @hpane
  width:(m)   -> m * @wpane + (m-1) * @margin.width  / @wscale
  height:(n)  -> n * @hpane + (n-1) * @margin.height / @hscale

  widthpx:()  -> @$view.innerWidth()    # Use @viewp because
  heightpx:() -> @$view.innerHeight()   # Use @viewp because @$view

  wPanes:()   -> @wview * @widthpx()
  hPanes:()   -> @hview * @heightpx()

  north:(  top,  height, h, scale=1.0, dy=0 ) -> scale * ( top           - h + dy/@hscale )
  south:(  top,  height, h, scale=1.0, dy=0 ) -> scale * ( top  + height     + dy/@hscale )
  east:(   left, width,  w, scale=1.0, dx=0 ) -> scale * ( left + width      + dx/@wscale )
  west:(   left, width,  w, scale=1.0, dx=0 ) -> scale * ( left          - w + dx/@wscale )

  isRow:( specPaneGroup ) -> specPaneGroup.css is 'ikw-row'
  isCol:( specPaneGroup ) -> specPaneGroup.css is 'ikw-col'

  jmin:( cells ) -> UI.jmin( cells )

  positionUnionPane:( unionCells, paneCells, spec, xscale=1.0, yscale=1.0 ) ->
    [ju,mu,iu,nu] = UI.jmin( unionCells )
    [jp,mp,ip,np] = UI.jmin(  paneCells )
    @position( (jp-ju)*@ncol/mu, mp*@ncol/mu, (ip-iu)*@nrow/nu, np*@nrow/nu, spec, xscale, yscale )

  positionGroup:( groupCells, spec, xscale=1.0, yscale=1.0 ) ->
    [j,m,i,n] = UI.jmin( groupCells )
    @position( j,m,i,n, spec, xscale, yscale )

  position:( j,m,i,n, spec, xscale=1.0, yscale=1.0 ) ->
    #Util.log('UI.View.position spec', spec.name,  )
    wStudy = if spec.practice? then @margin.wStudy else 0
    hStudy = if spec.practice? then @margin.hStudy else 0
    left   = xscale * ( @left(j)   + ( wStudy + @margin.west  + j * @margin.width  ) / @wscale )
    top    = yscale * ( @top(i)    + ( hStudy + @margin.north + i * @margin.height ) / @hscale )
    width  = xscale * ( @width(m)  -   wStudy * 2 / @wscale )
    height = yscale * ( @height(n) -   hStudy * 2 / @hscale )
    [left,top,width,height]

  positionpx:( j,m,i,n, spec ) ->
    [left,top,width,height] = @position( j,m,i,n, spec, @wscale, @hscale )
    [width*@widthpx()/100, height*@heightpx()/100]

  reset:( select ) ->
    @select.name   = select.name
    @select.intent = select.intent
    pane. reset(@select) for pane  in @panes
    group.reset(@select) for group in @groups
    return

  resize:() =>
    saveId  = @lastPaneName
    @lastPaneName = ''
    @onSelect( UI.Build.select( saveId, 'View', UI.Build.SelectPractice ) )
    @lastPaneName  = saveId
    return

  hide:() ->
    @$view.hide()
    return

  show:() ->
    @$view.show() if @inPlane()
    return

  hideAll:() ->
    pane. hide() for pane  in @panes
    group.hide() for group in @groups
    @overview.hide() if @overview
    @$view.hide()
    return

  hideGroups:() ->
    group.hide() for group in @groups
    return

  showAll:() ->
    return if not @inPlane()
    @$view.hide()
    @reset( @select )
    pane.  show() for pane  in @panes
    group. show() for group in @groups
    @$view.show( @speed, () => @sizeCallback(@) if @sizeCallback )
    return

  onSelect:( select ) ->
    return if @ui.notInPlane()
    Util.msg( 'UI.view.select', select )
    name    = select.name
    intent  = select.intent
    ub      = UI.Build
    @select = select
    switch intent
      when ub.SelectPlane     then @expandAllPanes()
      when ub.SelectAllPanes  then @expandAllPanes()
      when ub.SelectOverview  then @expandOverview()
      when ub.SelectGroup     then @expandGroup( name, intent )
      when ub.SelectRow       then @expandGroup( name, intent )
      when ub.SelectCol       then @expandGroup( name, intent )
      when ub.SelectPractice  then @expandPane(  name )
      when ub.SelectStudy     then @expandStudy( name )
      when ub.SelectTopic     then @expandTopic( name )
      when ub.SelectItems     then @expandItems( name )
      else Util.error( 'UI.View.select() name not processed for intent', name, select.intent )
    return

  inPlane:() ->
    @plane.id is UI.ThePlane.id

  $allIcon:() ->
    id       = @ui.htmlId( UI.Build.SelectAllPanes )
    htm      = """<div id="#{id}" class="ikw-all-icon"><i class="fa fa-th"></i></div>"""
    $all     = $(htm)
    select   = UI.Build.select( 'None', 'AllIcon', UI.Build.SelectAllPanes )
    @stream.publish( 'Select', select, $all, 'click' ) # View is the select subscriber
    $all.css( { left:0, top:0, width:@pc(@margin.west), height:@pc(@margin.north) } )
    $all

  expandAllPanes:() ->
    @hideAll()
    @reset( @reset )
    @showAll()

  expandOverview:() ->
    @hideAll()
    @overview.page.onContent( UI.Build.content( 'Overview', 'View', UI.Build.SelectOverview ) )
    @overview.show()
    @$view.show()

  expandGroup:( group, intent, callback=null ) ->
    paneCallback = if  callback? then callback else @paneCallback
    group = @getPaneOrGroup( group, true ) # don't issue errors
    ub    = UI.Build
    return unless group?
    @hideAll()
    if  group.panes?
      for pane in group.panes
        pane.show()
        gells = if intent is ub.SelectGroup and group.spec.gells? then group.spec.gells else group.cells
        dells = if intent is ub.SelectGroup and group.spec.dells? then group.spec.dells else group.cells
        pells = if intent is ub.SelectGroup and pane .spec.gells? then pane .spec.gells else pane .cells
        [left,top,width,height] = @positionUnionPane( gells, pells, pane.spec, @wscale, @hscale )
        Util.log( 'View.expandGroup()', pane.name, [left,top,width,height], pells, dells ) if intent is ub.SelectGroup and pane .spec.gells?
        pane.animate( left, top, width, height, @select, true, paneCallback )
    else
      Util.error( 'View.expandGroup group.panes null' )
    @show()
    @lastPaneName  = 'None'
    return

  expandPane:( pane,  callback=null ) ->  # , study=null
    #return if pane is @lastPaneName and @lastStudyName is 'None'
    paneCallback = if callback? then callback else @paneCallback
    pane = @getPaneOrGroup( pane, false ) # don't issue errors
    return unless pane?
    @hideAll()
    pane.show()
    pane.animate( @margin.west, @margin.north, 100*@wview, 100*@hview, @select, true, paneCallback )
    @show()
    @lastPaneName   = pane.name
    @lastStudyName  = 'None'
    return

  expandStudy:( studyName ) ->
    return if   studyName is @lastStudyName
    pane = @getPaneFromStudyName( studyName, false )
    @expandPane( pane )
    #Util.log( 'View.expandStudy()', pane.name, studyName )
    pane.pageContent( @select, studyName ) if pane?
    @lastStudyName  = studyName
    return

  expandTopic:( topicName ) ->
    return if   topicName is @lastTopicName or not Util.isStr(@lastStudyName)
    pane = @getPaneFromStudyName( @lastStudyName, false )
    @expandPane( pane )
    #Util.log( 'View.expandTopic()', pane.name, topicName )
    pane.pageContent( @select, topicName ) if pane?
    @lastTopicName  = topicName
    return

  expandItems:( itemsName ) ->
    return if   itemsName is @lastItemsName or not Util.isStr(@lastStudyName)
    pane = @getPaneFromStudyName( @lastStudyName, false )
    @expandPane( pane )
    #Util.log( 'View.expandItems()', pane.name, itemsName )
    pane.pageContent( @select, itemsName ) if pane?
    @lastItemsName  = itemsName
    return

  # Not called but interesting
  expandUnion:( array, callback=null ) ->
    paneCallback = if  callback? then callback else @paneCallback
    @hideAll()
    unionCells = array[0]
    unionCells = UI.unionCells( unionCells, array[i] ) for i in [1...array.length]
    Util.log( 'UI.View.expandUnion unionCells', unionCells )
    for pane in @panes when @paneInUnion( pane.cells, unionCells )
      pane.show()
      [left,top,width,height] = @positionUnionPane( unionCells, pane.cells, pane.spec, @wscale, @hscale )
      pane.animate( left, top, width, height, true, @select, paneCallback )
    @show()
    return

  getPaneOrGroup:( keyOrPane, issueError=true  ) ->
    return keyOrPane if not keyOrPane? or Util.isObj(keyOrPane)
    key =  keyOrPane
    for pane in @panes
      return pane if pane.name is key
    if @groups?
      for group in @groups
        return group if group.name is key
    Util.error( 'UI.View.getPaneOrGroup() null for key ', key ) if issueError
    @emptyPane

  createPanes:() ->
    panes = []
    for own keyPractice, practice of @build.getPractices( @plane.name )
      console.log( 'View.createPanes() missing practice cells', practice ) if not practice.cells?
      pane = new UI.Pane( @ui, @stream, @, practice )
      panes.push( pane )
      practice.pane = pane
      # @createStudyPanes( practice, panes )
    panes

  createOverview:() ->
    spec           = @build.createOverview(  @plane )
    @overview      = new UI.Pane( @ui, @stream, @, spec )
    @overview.page = new UI.Page( @ui, @stream, @, @overview, @ui.prac )
    return

  createStudyPanes:( practice, panes ) ->
    for own keyStudy, study of practice.studies
      pane = new UI.Pane( @ui, @stream, @, study )
      panes.push( pane )
      study.pane = pane

  createGroups:( build, plane ) ->
    groups = []
    for own keyCol, objCol of build.Columns
      objCol.name = keyCol
      group = new UI.Group( @ui, @stream, @, objCol )
      groups.push( group )
    for own keyRow, objRow of build.Rows
      objRow.name = keyRow
      group = new UI.Group( @ui, @stream, @, objRow )
      groups.push( group )
    for own keyGroup, objGroup of plane.spec.groups
      #Util.log( 'View.createGroups()', keyGroup, objGroup )
      objGroup.key  = keyGroup
      objGroup.name = if objGroup.name? then objGroup.name else keyGroup
      group = new UI.Group( @ui, @stream, @, objGroup )
      groups.push( group )
    groups

  assignPanesToGroups:( panes, groups ) ->
    for pane in panes
      for group in groups
        if pane.name is group.name
           pane.panes = group.panes
    return

  getPaneFromStudyName:( studyName ) ->
    return @emptyPane if not @panes?
    for pane in @panes
      for own key, study of pane.spec.studies
        return pane if key is studyName
    @emptyPane

  paneInUnion:( paneCells, unionCells ) ->
    [jp,mp,ip,np] = UI.jmin(  paneCells )
    [ju,mu,iu,nu] = UI.jmin( unionCells )
    ju <= jp and jp+mp <= ju+mu and iu <= ip and ip+np <= iu+nu

  expandCells:( unionCells, allCells ) ->  # Not Implemented
    [ju,mu,iu,nu] = UI.jmin( unionCells )
    [ja,ma,ia,na] = UI.jmin(   allCells )
    [ (ju-ja)*ma/mu, ma, (iu-ia)*na/nu, na ]
