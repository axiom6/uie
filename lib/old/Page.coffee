

$  = require('jquery')
d3 = require('d3')
UI = require('js/ui/UI')

class Page

  module.exports = Page

  constructor: ( @ui, @stream, @view, @pane, @content='Center' ) ->
    Connect    = require( 'js/prac/Connect' )
    @spec      = @pane.spec
    @name      = @spec.name
    @key       = @spec.key
    @icon      = @spec.icon
    @pane.page = @
    @connect   = new Connect( @ui, @stream, @view, @, @spec   )
    @btn       = new UI.Btn(  @ui, @stream, @pane, @pane.spec )

    @contents = {
      center:  { name:'Center',  has:true,               $:Util.$empty, htmlId:@htmlId(@key,'Center'  ) }
      svg:     { name:'Svg',     has:@spec.svg?,         $:Util.$empty, htmlId:@htmlId(@key,'Svg'     ), defs:0, svg:0, g:0, $g:Util.$empty, gId:@htmlId(@key,'G') }
      topic:   { name:'Topic',   has:@specHasChildren(), $:Util.$empty, htmlId:@htmlId(@key,'Topic'   ), $items:Util.$empty }
      slide:   { name:'Slide',   has:true,               $:Util.$empty, htmlId:@htmlId(@key,'Slide'   ), loaded:false, height:700 }  # @spec.slide?
      table:   { name:'Table',   has:@spec.table?,       $:Util.$empty, htmlId:@htmlId(@key,'Table'   ) }
      connect: { name:'Connect', has:true,               $:Util.$empty, htmlId:@htmlId(@key,'Connect' ) }
      group:   { name:'Group',   has:false,              $:Util.$empty, htmlId:@htmlId(@key,'Group'   ) }
    }

  # Search Studies and Topisc
  specHasStudies:() ->
    if @specIsPractice()
      for key, study of @spec.Studies
        return true
    false

  # Search Studies and Topisc
  specHasTopics:() ->
    for key, topic of @spec.Topics
      return true
    false

  # Search Studies and Topisc
  specHasChildren:() ->
    @specHasStudies() or @specHasTopics()

  topicHasItems:( topic ) ->
    for key, topic of topic.Items
      return true
    false

  specIsPractice:() ->
    @spec.column?

  ready:() ->
    @$   = @pane.$
    @css = @pane.css

    cs = @createSvg( @pane, @contents.svg )
    if cs.has and @drawSvg?
      @drawSvg( cs.g, cs.$g, @pane.geom(), cs.defs )

    @contents.center.$  = $( @createCenter()  )
    @contents.table.$   = $( @createTable()   )
    @contents.topic.$   = $( @createTopic()   )
    @contents.slide.$   = $( @createSlide()   )
    @contents.connect.$ = $( @createConnect() )
    @contents.group.$   = $( @createGroup()   )

    @$.append( @contents.center.$  )
    @$.append( @contents.table.$   )
    @$.append( @contents.topic.$   )
    @$.append( @contents.slide.$   )
    @$.append( @contents.connect.$ )
    @$.append( @contents.group.$   )

    @contents.topic.$items = @contents.topic.$.find('.'+@css+'-item-ul')

    @publish()
    @subscribe()
    @connect.ready()
    @btn.ready()
    #@prac.saveSvg( @pane.page.contents.svg.htmlId, @name + '.svg' )
    return

  subscribe:() ->
    @stream.subscribe( 'Content', (object) => @onContent( object ) )
    @stream.subscribe( 'Select',  (select) => @onSelect(  select ) )

  # View is the select subscriber  Use uniquename for pane
  publish:() ->
    @stream.event( 'Select', @contents.center.$, 'click', @pane.key )

  onContent:( object ) ->
    name = object.name
    if @content isnt object.content and ( name is @pane.name or name is 'AllPanes' )
       @content =    object.content
       @layout( @pane.geom() )
    return

  onSelect:(  select ) ->
    return if select isnt @pane.key
    @content = 'Center'
    if @ui.plane.name is 'DataScience'
      @content = 'Topic'
      for own key, study of @pane.spec.Studies
        study.pane.page.content = 'Topic'
    else if @spec.svg?
      @content =  'Svg'
    return

  hideAll:() ->
    for own key, content of @contents when @content.has
      content.$.hide()
    return

  iconPC:() ->
    pc = 0.33
    if @ui.plane.name is 'DataScience'
      if @spec.column? then pc = 0.90 else pc = 0.75 # Group or Practice
    pc

  layout:( geom ) ->
    pc          = @iconPC()
    w           = geom.w*pc / geom.s
    h           = geom.h*pc / geom.s
    left        = geom.x0-w/2
    top         = geom.y0-h/2
    s           = 0.50 # if @ui.build.hasTopics then 0.50 else 0.66
    iconSize    = Math.min(w,h)*s
    fontSize    = iconSize * 0.5
    topicSize   = 24 # if @specIsPractice() then fontSize * 1.25 else fontSize * 1.80

    @btn .layout( geom ) # if @btn?  and @btn .layout?
    @hideAll()
    @content = @matchContent( geom )
    # Util.log('UI.Page.layout()', @name, contentBeg, @content, @contents.topic.has, geom.w, geom.h )

    switch @content
      when 'Svg'
        c = @contents.svg
        c.svg.attr("width",geom.w).attr("height",geom.h)
        c.g  .attr( 'transform', """scale(#{geom.sx+','+geom.sy})""" ) if @ui.build.name isnt 'Show'
        c.$.show()
      when 'Slide'
        c = @contents.slide
        if c.slideLoaded then c.$.show() else @loadSlide( geom )
      when 'Table'
        c = @contents.table
        c.$.show()
      when 'Topic'
        c = @contents.topic
        c.$.css( { fontSize:topicSize, display:'table-cell' } )
        if geom.ex then c.$items.show() else c.$items.hide()
        c.$.show()
      when 'Connect'
        c = @contents.connect
        c.$.show()
      when 'Group'
        c = @contents.group
        c.$.show()
      else
        c = @contents.center
        c.$.css( { left:left, top:top, width:w, height:h,  transform:"scale(#{geom.s})" } )
        c.$.find('.ikw-pane-center-div').css( { fontSize:fontSize, display:'table-cell' } )
        c.$.find('.ikw-pane-icon')      .css( { fontSize:iconSize, display:'block'      } )
        c.$.show()

    @stream.publish('Layout', { select:@pane.name, content:@content } ) # For 'Table' in Show

    return


  matchContent:( geom ) ->
    if      @content is 'Center'  and @contents.center .has                                   then 'Center'
    else if @content is 'Svg'     and @contents.svg    .has and geom.w > 200 and geom.h > 200 then 'Svg'
    else if @content is 'Topic'   and @contents.topic  .has and geom.w > 200 and geom.h > 200 then 'Topic'
    else if @content is 'Table'   and @contents.table  .has and geom.w > 400 and geom.h > 400 then 'Table'
    else if @content is 'Slide'   and @contents.slide  .has and geom.w > 300 and geom.h > 300 then 'Slide'
    else if @content is 'Connect' and @contents.connect.has and geom.w >  60 and geom.h >  60 then 'Connect'
    else if @content is 'Group'   and @contents.group  .has                                   then 'Group'
    else                                                                                           'Center'

  loadSlide:( geom ) ->
    c =  @contents.slide
    if not c.slideLoaded and c.has
      onLoad = () =>
        c.slideLoaded = true
        c.$.show()
      url = null
      if @spec.talk? and @spec.slide?
        url = @ui.build.slideUrl(   @spec.talk ) + @spec.slide + '.htm'
      else if @ui.build.isPractice( @spec.key  )
        url = @ui.build.slideUrl(   @spec.key  )  + '.htm'
      c.$.load( url, onLoad ) if url?
      # Util.log( 'UI.Page.loadSlide()', url ) if url?
    return

  contains:( str, tok ) ->
    str? and str.indexOf(tok) isnt -1

  getTopicsOrStudies:() ->
    if @specHasTopics()
      @spec.Topics
    else if @specHasStudies()
      @spec.Studies
    else
      null

  htmlId:( name, ext ) ->
    @ui.htmlId( name, ext )

  toName:( name ) ->
    Util.toName( name )

  create$Center:( pane ) ->
    centerId = @contents.center.htmlId
    $center  = $("""<div class="#{@css}-center" id="#{centerId}"></div>""")
    $center

  # d3 Svg  dependency
  createSvg:( pane, cs ) ->
    geom      = pane.geom()
    cs.svg    = d3.select('#'+@pane.htmlId).append("svg:svg").attr("id",cs.htmlId)
                  .attr("width",geom.w).attr("height",geom.h).attr("xmlns","http://www.w3.org/2000/svg")
    cs.defs   = cs.svg.append("svg:defs")
    cs.g      = cs.svg.append("svg:g").attr("id",cs.gId) # All tranforms are applied to g
    cs.$      = pane.$.find( '#'+cs.htmlId )
    cs.$g     = pane.$.find( '#'+cs.gId   )
    cs

  createCenter:() ->
    centerId = @contents.center.htmlId
    """<div     class="#{@css}-center"     id="#{centerId}">
         <div   class="#{@css}-center-div">
           #{@htmlPracticeIcon(@css,@icon)}
           <div class="#{@css}-text">#{@toName(@name)}</div>
        </div>
      </div>"""

  createTable:() ->
    tableId = @contents.table.htmlId
    """<div class="#{@css}-table" id="#{tableId}"></div>"""

  topicHtml:( c ) ->
    """<div  class="#{@css}-topic" id="#{c.htmlId}">
       <i    class="#{@css}-practice-icon fa #{@spec.icon}"></i>
       <span class="#{@css}-practice-text">#{@toName(@name)}</span>"""


  studyHtml:( study ) ->
    """<li class="#{@css}-study-li">
       #{@htmlIcon(@css,study.icon)}
       <span class="#{@css}-topic-text">#{@toName(study.name)}</span>"""

  topicHtml:( topic ) ->
    """<li class="#{@css}-topic-li">
       #{@htmlIcon(@css,topic.icon)}
       <span class="#{@css}-topic-text">#{@toName(topic.name)}</span>"""

  itemHtml:( item ) ->
    """<li class="#{@css}-item-li">
        #{@htmlIcon(@css,item.icon)}
        <span class="#{@css}-item-text">#{@toName(item.name)}</span></li>"""

  createTopic:() ->
    if @ui.plane.name is 'DataScience' then @createTopicData() else @createTopicMuse()

  createTopicMuse:() ->
    c     = @contents.topic
    return "" if not c.has
    html  = @practiceHtml( c )
    html += """<ul class="#{@css}-study-ul">""" if @spec.Studies?
    for key, study of @spec.Studies
      html += @studyHtml( study )
      html += """<ul class="#{@css}-topic-ul">""" if @spec.Topics?
      for key, topic of study.Topics when topic.fill isnt 'XXX'
        html += @topicHtml( topic )
        html += """<ul class="#{@css}-item-ul">""" if @spec.Items?
        for key, item of topic.Items
          html += @itemHtml( item )
        html += """</ul>""" if @spec.Items?
        html += """</li>"""
      html += """</ul>""" if @spec.Topics?
      html += "</li>"
    html += """</ul>""" if @spec.Studies?
    html += """</div>"""

  createTopicData:() ->
    c = @contents.topic
    html  = ""
    if c.has
      html += """<div    class="#{@css}-topic" id="#{c.htmlId}">
                   <i    class="#{@css}-study-icon fa #{@spec.icon}"></i>
                   <span class="#{@css}-study-text">#{@toName(@name)}</span>
                   <ul   class="#{@css}-topic-ul">"""
      topics = @getTopicsOrStudies()
      if topics?
        for key, topic of topics when topic.fill isnt 'XXX'
          html += """<li class="#{@css}-topic-li">
                       #{@htmlIcon(@css,topic.icon)}
                       <span class="#{@css}-topic-text">#{@toName(topic.name)}</span>"""
          html += @createItems( topic ) if @topicHasItems( topic )
          html += """</li>"""
      html += """</ul></div>"""
    html


  createItems:( topic ) ->
    html = """<ul class="#{@css}-item-ul">"""
    for key, item of topic.Items
      html += """<li class="#{@css}-item-li">
                     #{@htmlIcon(@css,item.icon)}
                     <span class="#{@css}-item-text">#{@toName(item.name)}</span>
                 </li>"""
    html += """</ul>"""
    html

  createSlide:() ->
    slideId = @contents.slide.htmlId
    """<div id="#{slideId}" class="#{@css}-slide reveal"></div>"""

  createConnect:() ->
    connectId = @contents.connect.htmlId
    """<div   class="#{@css}-connect"           id="#{connectId}" >
         <div class="#{@css}-connect-west" ><ul id="#{connectId}West"  ></ul></div>
         <div class="#{@css}-connect-east" ><ul id="#{connectId}East"  ></ul></div>
         <div class="#{@css}-connect-north"><ul id="#{connectId}North" ></ul></div>
         <div class="#{@css}-connect-south"><ul id="#{connectId}South" ></ul></div>
         <div class="#{@css}-connect-prev" ><ul id="#{connectId}Prev"  ></ul></div>
         <div class="#{@css}-connect-next" ><ul id="#{connectId}Next"  ></ul></div>
       </div>"""

  createGroup:() ->
    groupId = @contents.group.htmlId
    """<div     class="#{@css}-center"     id="#{groupId}">
         <div   class="#{@css}-center-div">
           #{@htmlPracticeIcon(@css,@icon,true)}
           <div class="#{@css}-text">#{@toName(@name)}</div>
        </div>
      </div>"""

  pracIcon:( css, icon, isGroup=false ) ->
    Util.error( 'UI.Page.htmlPracticeIcon()', @name ) if not Util.isStr(icon)
    id = if isGroup then @htmlId( @name,'GroupIcon') else @htmlId( @name,'Icon')
    if @contains(icon,'fa')
      """<i id="#{id}" class="#{css}-icon fa #{icon}"></i>"""
    else if @contains(icon,'.png') or @contains(icon,'.jpg') or @contains(icon,'.svg')
      """<img id="#{id}" src="img/icon/#{icon}" class="#{css}-img">"""
    else
      """<div id="#{id}" class="#{css}">#{icon}</div>"""

  htmlIcon:( css, icon ) ->
    if @contains(icon,'fa')
      """<i class="#{css}-topic-icon fa #{icon}"></i>"""
    else
      """<i class="#{css}-topic-icon fa fa-circle"></i>"""
