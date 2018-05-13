
$   = require('jquery')
d3  = require('d3')
Vis = require('js/util/Vis')
UI  = require('js/ui/UI')

class Viewer

  module.exports = Viewer
  
  constructor:( @pane, @page, @prac ) ->
    @spec      = @pane.spec
    @name      = @spec.name
    @contents  = @createContents( @spec )
    @$         = UI.$empty
    @css       = "ikw-pane"
    @build     = @pane.ui.build
    @ub        = UI.Build
    @showArray = [@ub.SelectRow,@ub.SelectGroup,@ub.SelectTopic,@ub.SelectItems]
    @studyName = 'None'
    @toggleItems = false

  createContents:( spec ) ->
    {
      center:  { name:'Center',  has:true,          layout:@centerLayout,   create:@center,   $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      svg:     { name:'Svg',     has:@hasSvg(),     layout:@svgLayout,      create:@svg,      $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, defs:0, svg:0, g:0, $g:UI.$empty, gId:@htmlId('G'), draw:undefined }
      tree:    { name:'Tree',    has:@hasStudies(), layout:@treeLayout,     create:@tree,     $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, defs:0, svg:0, g:0, $g:UI.$empty, gId:@htmlId('G'), draw:undefined }
      radial:  { name:'Radial',  has:@hasStudies(), layout:@radialLayout,   create:@radial,   $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, defs:0, svg:0, g:0, $g:UI.$empty, gId:@htmlId('G'), draw:undefined }
      overview:{ name:'Overview',has:true,          layout:@overviewLayout, create:@overview, $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, defs:0, svg:0, g:0, $g:UI.$empty, gId:@htmlId('G'), draw:undefined }
      studies: { name:'Studies', has:@hasStudies(), layout:@studiesLayout,  create:@studies,  $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, $topics:UI.$empty, $items:UI.$empty }
      study:   { name:'Study',   has:@hasStudies(), layout:@studyLayout,    create:@study,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, $topics:UI.$empty, $items:UI.$empty }
      topic:   { name:'Topic',   has:@hasStudies(), layout:@studyLayout,    create:@study,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, $topics:UI.$empty, $items:UI.$empty }
      items:   { name:'Items',   has:@hasStudies(), layout:@studyLayout,    create:@study,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty, $topics:UI.$empty, $items:UI.$empty }
      inven:   { name:'Inven',   has:true,          layout:@invenLayout,    create:@inven,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      oper:    { name:'Oper',    has:true,          layout:@operLayout,     create:@oper,     $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      connect: { name:'Connect', has:true,          layout:@connectLayout,  create:@connect,  $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      pivot:   { name:'Pivot',   has:true,          layout:@pivotLayout,    create:@pivot,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      plot:    { name:'Plot',    has:true,          layout:@plotLayout,     create:@plot,     $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      mathbox: { name:'MathBox', has:true,          layout:@mathboxLayout,  create:@mathbox,  $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
      slide:   { name:'Slide',   has:true,          layout:@slideLayout,    create:@slide,    $:UI.$empty, $on:UI.$empty, studies:{}, $btn:UI.$empty }
    }

  ready:() ->
    @$     = @pane.$
    @contents.svg.$.hide()
    return

  getContent:( contentName ) ->
    for own ckey, content of @contents when content.has
      return content if content.name is contentName
    @contents.center

  assignNames:( msg ) ->
    @studyName = msg.name if msg.intent is @ub.SelectStudy
    return

  layout:( geom, msg ) =>
    @assignNames( msg )
    boun = @generateBoun( geom, msg )
    c    = @getContent( msg.content )
    if c.has and UI.isEmpty( c.$ ) or msg.content is 'Study' or msg.content is 'Topic' or msg.content is 'Items'
      [c.$,c.$on,c.studies] = c.create( boun )
      @$.append(  c.$ )
      @page.publish( c.$on )
      @page.publishJQueryObjects( c.studies, @ub.SelectStudy ) if not Util.isObjEmpty( c.studies )
      #page.publishJQueryObjects( c.topics,  @ub.SelectTopic ) if not Util.isObjEmpty( c.studies )
      #page.publishJQueryObjects( c.items,   @ub.SelectItems ) if not Util.isObjEmpty( c.studies )
    @hideAll()
    c.layout( boun )
    c.$.show()
    return

  generateBoun:( geom, msg ) ->
    # Util.log( 'Msg', msg )
    b          = {}
    b.geom     = geom
    b.msg      = msg
    pc         = 0.42
    b.w        = geom.w*pc / geom.s
    b.h        = geom.h*pc / geom.s
    b.wp       = geom.wp
    b.hp       = geom.hp
    b.wg       = geom.w
    b.hg       = geom.h
    b.left     = geom.x0-b.w/2
    b.top      = geom.y0-b.h/2
    b.sf       = geom.s
    b.sx       = geom.sx # if b.wg >b. wp + 10 then 1.0 else geom.sx
    b.sy       = geom.sy # if b.hg > b.hp + 10 then 1.0 else geom.sy
    b.intent   = msg.intent
    b.iconSize = Math.min(b.w,b.h)* b.sf
    b.fontSize = @calcFontSize( b.intent, b.iconSize, b.msg )
    @adjustBoun( b, msg )

  adjustBoun:( b, msg ) ->
    isCol = Util.inArray( ['Embrace','Innovate','Encourage'], msg.name )
    isRow = Util.inArray( ['Learn',  'Do',      'Share'    ], msg.name )
    if isCol
      b.wg = b.wg / 3
      b.sx = b.sx / 3
    if isRow
      b.hg = b.hg / 3
      b.sy = b.sy / 3
    b

  calcFontSize:( intent, iconSize, msg ) ->
    s = switch intent
      when @ub.SelectRow   then 0.6
      when @ub.SelectGroup then 0.4
      when @ub.SelectPractice
        if @toggleItems then 0.3 else 0.7
      when @ub.SelectStudy then 0.7
      when @ub.SelectTopic then 0.5
      when @ub.SelectItems then 0.5
      else                      0.6
    s *= 1.35 if msg.content is 'Center'
    #Util.trace( 'Viewer.calcFontSize') if msg.source is 'Viewer.ready()'
    #Util.log(   'Viewer.calcFontSize', { name:@name, source:msg.source, intent:intent, iconSize:iconSize, s:s } )
    s * Math.max(iconSize*0.25,13)

  centerLayout:(  boun ) => @layoutCenter( @contents.center,  boun )
  invenLayout:(   boun ) => @layoutCenter( @contents.inven,   boun )
  operLayout:(    boun ) => @layoutCenter( @contents.oper,    boun )
  pivotLayout:(   boun ) => @layoutCenter( @contents.pivot,   boun )
  plotLayout:(    boun ) => @layoutCenter( @contents.plot,    boun )
  mathboxLayout:( boun ) => @layoutCenter( @contents.mathbox, boun )
  slideLayout:(   boun ) => @layoutCenter( @contents.slide,   boun )

  svgLayout:( boun ) =>
    c    = @contents.svg
    c.svg.attr("width",boun.wg).attr("height",boun.hg)
    c.g  .attr( 'transform', """scale(#{boun.sx+','+boun.sy})""" )
    return

  treeLayout:( boun ) =>
    c    = @contents.tree
    c.svg.attr("width",boun.wg).attr("height",boun.hg)
    c.g  .attr( 'transform', """scale(#{boun.sx},#{boun.sy})""" )
    #.g  .attr( 'transform', """scale(#{boun.sx},#{boun.sy}) translate(#{boun.wg*0.065+','+boun.hg*0.17})""" )
    return

  overviewLayout:( boun ) =>
    c    = @contents.overview
    c.svg.attr("width",boun.wg).attr("height",boun.hg)
    c.g  .attr( 'transform', """scale(.75,.75) translate(#{(boun.wg/2+40)+','+(boun.hg/2+90)})""" )
    return

  radialLayout:( boun ) =>
    c    = @contents.radial
    c.svg.attr("width",boun.wg).attr("height",boun.hg)
    c.g  .attr( 'transform', """scale(1,1) translate(#{(boun.wg/2+40)+','+(boun.hg/2+90)})""" )
    return

  studiesLayout:( boun ) =>
    c = @contents.studies
    c.$.css( { 'font-size':boun.fontSize } )
    @showTopicItems( boun, c )
    return

  studyLayout:( boun ) =>
    c = @contents.study
    c.$.css( { fontSize:boun.fontSize } )
    @showTopicItems( boun, c )
    return

  showTopicItems:( boun, c ) ->
    showTopics = true
    showItems  = Util.inArray( @showArray, boun.intent ) or @toggleItems
    if showTopics then c.$topics.show() else c.$topics.hide()
    if showItems  then c.$items .show() else c.$items .hide()
    # Util.log( 'Viewer.showTopicItems', @toggleItems )
    @toggleItems = not @toggleItems if boun.intent is @ub.SelectPractice
    return

  connectLayout:( boun ) =>
    Util.noop( boun )

  layoutCenter:( c, b ) ->
    #.$.css( { transform:"scale(#{b.s})", left:b.left, top:b.top, width:b.w, height:b.h } )
    c.$.css( { transform:"scale(#{b.s})" } )
    c.$.find('.ikw-pane-center-div').css( { fontSize:b.fontSize } )
    c.$.find('.ikw-pane-icon')      .css( { fontSize:b.iconSize, display:'block'      } )
    return

  hideAll:() ->
    for own key, content of @contents when content.has and UI.isElem(content.$)
      if Util.isFunc(content.$.hide)
        content.$.hide()
      else
        Util.error( 'Viewer.hideAll()', content.name )
    return

# --- Content HTML Creators ---

  centerNameIcon:( content, name, icon, fill, boun ) =>
    Util.noop( boun )
    htmlId = @htmlId(content.name)
    style  = "" # """ style="color:wheat;" """
    if content.name isnt 'Center'
      style = """style="background-color:#{fill}; border-radius:12px; color:black;" """
    $ht = $("""<div   class="#{@css}-center" id="#{htmlId}">
             <div class="#{@css}-center-div" #{style}>
               #{@pracIcon(icon)}
             <div class="#{@css}-text">#{@toName(name)}</div>
           </div>
        </div>""")
    [$ht,$ht,{}]

  center:( boun ) =>
    @centerNameIcon( @contents.center, @spec.name, @spec.icon, @prac.toFill(@spec), boun )

  # d3 Svg  dependency
  svg:( boun ) =>
    content = @contents.svg
    svgId = @htmlId('Svg')
    gId   = @htmlId('SvgG')
    content.svg = d3.select('#'+@pane.htmlId).append("svg:svg").attr("id",svgId)
      .attr("width",boun.wp).attr("height",boun.hp).attr("xmlns","http://www.w3.org/2000/svg")
    content.defs   = content.svg.append("svg:defs")
    content.g      = content.svg.append("svg:g").attr("id",gId) # All tranforms are applied to g
    content.$      = @pane.$.find( '#'+svgId )
    content.$g     = @pane.$.find( '#'+gId   )
    content.draw   = @prac.createDraw( @pane, content, content.g, boun.wp, boun.hp )
    content.draw.drawSvg( content.g, content.$g, boun.geom, content.defs )
    content.htmlId = svgId
    [content.$,content.$,{}]

  tree:( boun ) =>
    content = @contents.tree
    svgId   = @htmlId('Tree')
    gId     = @htmlId('TreeG')
    content.svg = d3.select('#'+@pane.htmlId).append("svg:svg").attr("id",svgId)
           .attr("width",boun.wp).attr("height",boun.hp).attr("xmlns","http://www.w3.org/2000/svg")
    content.defs   = content.svg.append("svg:defs")
    content.g      = content.svg.append("svg:g").attr("id",gId) # All tranforms are applied to g
    content.$      = @pane.$.find( '#'+svgId )
    content.$g     = @pane.$.find( '#'+gId   )
    content.draw   = @prac.createDraw( @pane, content, content.g, boun.wp, boun.hp )
    [content.$,content.$,{}]

  overview:( boun ) =>
    content = @contents.overview
    svgId   = @htmlId('Overview')
    gId     = @htmlId('OverviewG')
    content.svg = d3.select('#'+@pane.htmlId).append("svg:svg").attr("id",svgId)
           .attr("width",boun.wp).attr("height",boun.hp).attr("xmlns","http://www.w3.org/2000/svg")
    content.defs   = content.svg.append("svg:defs")
    content.g      = content.svg.append("svg:g").attr("id",gId) # All tranforms are applied to g
    content.$      = @pane.$.find( '#'+svgId )
    content.$g     = @pane.$.find( '#'+gId   )
    content.draw   = @prac.createDraw( @pane, content, content.g, boun.wp, boun.hp )
    [content.$,content.$,{}]

  radial:( boun ) =>
    content = @contents.radial
    svgId   = @htmlId('Radial')
    gId     = @htmlId('RadialG')
    content.svg = d3.select('#'+@pane.htmlId).append("svg:svg").attr("id",svgId)
           .attr("width",boun.wp).attr("height",boun.hp).attr("xmlns","http://www.w3.org/2000/svg")
    content.defs   = content.svg.append("svg:defs")
    content.g      = content.svg.append("svg:g").attr("id",gId) # All tranforms are applied to g
    content.$      = @pane.$.find( '#'+svgId )
    content.$g     = @pane.$.find( '#'+gId   )
    content.draw   = @prac.createDraw( @pane, content, content.g, boun.wp, boun.hp )
    [content.$,content.$,{}]

  studies:( boun ) =>
    Util.noop( boun )
    id      = @htmlId('Studies')
    dirs    = @dirStudies()
    studs   = {}
    $ht     = $("""<div class="#{@css}-studies" id="#{id}" ></div>""")
    $on     = @studyPrac( @spec, id )
    $ht.append( $on )
    for key, dir of dirs
      studs[dir.name] = @studyDir( dir, id ) if dir.name isnt 'None'
      $ht.append( studs[dir.name] )
    @contents.studies.$topics = $ht.find('.'+@css+'-topin-ul')
    @contents.studies.$items  = $ht.find('.'+@css+'-item-ul' )
    @contents.studies.htmlId  = id
    [$ht,$on,studs]

  study:( boun ) =>
    Util.log( 'Viewer.study None', boun.msg ) if @studyName is 'None'
    c = @getContent( @studyName )
    c.$.remove() if UI.isElem( c.$ )
    id    = @htmlId('Study'+@studyName )
    study = @page.getStudy( @studyName )
    dir   = { name:@studyName, fill:@prac.toFill(study), icon:study.icon, dir:'choice', purpose:study.purpose, study:study }
    c.$   = @studyDir( dir, id )
    [ c.$, c.$, {} ]

  studyPrac:( spec, id ) ->
    [dir,tag,text] = if @spec.learn? then ['pracd','span',@toName(spec.name)] else ['prac','div',@toName(spec.name)]
    $("""<div     class="#{@css}-study-#{dir}" id="#{id+dir}" >
           <div   class="#{@css}-study-center" style="background-color:#{@prac.toFill(@spec)};" id="#{id}">#{ @pracIcon(@spec.icon)}
             <#{tag} class="#{@css}-text" title="#{spec.purpose}">#{text}</#{tag}>
           </div>
         </div>""" )

  studyDir:( dir, id ) ->
    name  = Util.toName(dir.name)
    [txTag,align] = ['div','center'] # if UI.ThePlane.id is 'Data' then ['span','left'] else ['div','center']
    html  = """<div   class="#{@css}-study-#{dir.dir}"  id="#{id+name}" >"""
    html += """  <div class="#{@css}-study-#{align}" style="background-color:#{dir.fill};" id="#{id+name+'icon'}">
                   #{@pracIcon(dir.icon)}<#{txTag} class="#{@css}-text" title="#{dir.purpose}">#{name}</#{txTag}>"""
    html += @studyTopics( dir.study, 1, 10 )
    html += """  </div>"""
    html += """</div>"""
    $(html)

  studyTopics:( study, beg, end ) ->
    i    = 1
    html = """<ul class="#{@css}-topin-ul">"""
    for tkey, topic of study.topics
      topicLi = if topic?.member is 'ten' then "-topin-lib" else "-topin-li"
      if beg <= i and i <= end
        html += """<li   class="#{@css}#{topicLi}" title="#{topic.purpose}">#{@htmlIcon(topic.icon)}
                   <span class="#{@css}-topin-text">#{@toName(topic.name)}</span>"""
        html += @topicItems( topic ) if @hasItems( topic )
        html += """</li>"""
      i++
    html += """</ul>"""

  topicItems:( topic ) ->
    html = """<ul class="#{@css}-item-ul">"""
    for key, item of topic.items
      itemLi = if item?.member is 'ten' then "-item-lib" else "-item-li"
      html += """<li class="#{@css}#{itemLi}" title="#{item.purpose}">
                     #{@htmlIcon(item.icon)}
                     <span class="#{@css}-item-text">#{@toName(item.name)}</span>
                 </li>"""
    html += """</ul>"""
    html

  connect:( boun ) =>
    Util.noop( boun )
    connectId = @htmlId('Connect')
    $ht = $("""<div   class="#{@css}-connect"           id="#{connectId}" >
                 <div class="#{@css}-connect-west" ><ul id="#{connectId}West"  ></ul></div>
                 <div class="#{@css}-connect-east" ><ul id="#{connectId}East"  ></ul></div>
                 <div class="#{@css}-connect-north"><ul id="#{connectId}North" ></ul></div>
                 <div class="#{@css}-connect-south"><ul id="#{connectId}South" ></ul></div>
                 <div class="#{@css}-connect-prev" ><ul id="#{connectId}Prev"  ></ul></div>
                 <div class="#{@css}-connect-next" ><ul id="#{connectId}Next"  ></ul></div>
               </div>""")
    $on = $ht.find('#'+connectId)
    [$ht,$on,{}]

  inven:(   boun ) => @centerNameIcon( @contents.inven,   'Inven',   @spec.icon, @prac.toFill(@spec), boun )
  oper:(    boun ) => @centerNameIcon( @contents.oper,    'Oper',    @spec.icon, @prac.toFill(@spec), boun )
  pivot:(   boun ) => @centerNameIcon( @contents.pivot,   'Pivot',   @spec.icon, @prac.toFill(@spec), boun )
  plot:(    boun ) => @centerNameIcon( @contents.plot,    'Plot',    @spec.icon, @prac.toFill(@spec), boun )
  mathbox:( boun ) => @centerNameIcon( @contents.mathbox, 'MathBox', @spec.icon, @prac.toFill(@spec), boun )
  slide:(   boun ) =>
    @doSlide()    if @contents.slide.has and @spec.page?
    @centerNameIcon( @contents.slide,   'Slide',   @spec.icon, @prac.toFill(@spec), boun )

  doSlide:() ->
    host = 'http://localhost:63342/ui/'
    book = @pane.ui.plane.spec.book
    url  = host + book + @spec.page
    name = @toName( @spec.name )
    Util.log( 'Viewer.doSlide()', url, name )
    window.open( url, name )
    return

  # --- HTML ----

  htmlId:( contentName ) ->
    Util.getHtmlId( @spec.name, @spec.plane, contentName )

  contains:( str, tok ) ->
    str? and str.indexOf(tok) isnt -1

  createTable:() ->
    tableId = @contents.table.htmlId
    """<div class="#{@css}-table" id="#{tableId}"></div>"""

  topicHtml:( topic ) ->
    """<li class="#{@css}-topic-li">
       #{@htmlIcon(topic.icon)}
       <span class="#{@css}-topic-text">#{@toName(topic.name)}</span>"""

  studyHtml:( study ) ->
    """<li class="#{@css}-study-li">
       #{@htmlIcon(study.icon)}
       <span class="#{@css}-topic-text">#{@toName(study.name)}</span>"""

  itemHtml:( item ) ->
    """<li class="#{@css}-item-li">
        #{@htmlIcon(item.icon)}
        <span class="#{@css}-item-text">#{@toName(item.name)}</span></li>"""

  createSlide:() ->
    slideId = @contents.slide.htmlId
    """<div id="#{slideId}" class="#{@css}-slide reveal"></div>"""

  createGroup:() ->
    groupId = @contents.group.htmlId
    """<div     class="#{@css}-center"     id="#{groupId}">
         <div   class="#{@css}-center-div">
           #{@htmlPracticeIcon(@css,@icon,true)}
           <div class="#{@css}-text">#{@toName(@name)}</div>
        </div>
      </div>"""

  pracIcon:( icon, isGroup=false ) ->
    Util.error( 'Viewer.practIcon()', @name ) if not Util.isStr(icon)
    id = if isGroup then @htmlId( @name,'GroupIcon') else @htmlId( @name,'Icon')
    if @contains(icon,'fa')
      """<i id="#{id}" class="#{@css}-icon fa #{icon}"></i>"""
    else if @contains(icon,'.png') or @contains(icon,'.jpg') or @contains(icon,'.svg')
      """<img id="#{id}" src="img/icon/#{icon}" class="#{@css}-img">"""
    else
      """<div id="#{id}" class="#{@css}">#{icon}</div>"""

  htmlIcon:( icon ) ->
    if @contains(icon,'fa')
      """<i class="#{@css}-topic-icon fa #{icon}"></i>"""
    else
      """<i class="#{@css}-topic-icon fa fa-circle"></i>"""

  studyIcon:( icon ) ->
    if @contains(icon,'fa')
      """<i class="#{@css}-study-icon fa #{icon}"></i>"""
    else
      """<i class="#{@css}-study-icon fa fa-circle"></i>"""

  # --- Inquiry ----

  isPractice:() ->
    @spec.column?

  # Return
  dirStudies:() ->
    none = { name:'None', fill:'None', icon:'None', hsv:'None', dir:'None', purpose:'None', study:'None' }
    dir  = { prac:none,  east: none,  west:none, north:none, south:none, nw:none, ne:none, se:none, sw:none, pracd:none, eastd:none, westd:none, northd:none, southd:none, nwd:none, ned:none, sed:none, swd:none, choice:none }
    for key, study of @spec.studies
      dir[study.dir] = { name:study.name, fill:@prac.toFill(study), icon:study.icon, dir:study.dir, purpose:study.purpose, study:study }
    dir

  hasSvg:() ->
    @spec.plane isnt 'Hues'

  # Search Studies and Topisc
  hasStudies:() ->
    for key, study of @spec.studies
      return true
    false

  anyTopics:() ->
    for   skey, study of @spec.studies
      for tkey, topic of study.topics
        return true
      false

  hasTopics:( study ) ->
    for tkey, topic of study.topics
      return true
    false

  hasItems:( topic ) ->
    for ikey, item  of topic.items
      return true
    false

  toName:( name ) ->
    Util.toName( name )
