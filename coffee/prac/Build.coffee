
class Build

  module.exports = Build
  Build.Muse     = require( 'data/muse/Muse.json' )
  Build.Info     = require( 'data/muse/Info.json' )
  Build.Augm     = require( 'data/muse/Augm.json' )
  Build.Data     = require( 'data/muse/Data.json' )
  Build.Know     = require( 'data/muse/Know.json' )
  Build.Wise     = require( 'data/muse/Wise.json' )
  Build.Hues     = require( 'data/muse/Hues.json' )

  constructor:( args ) ->
    @name       = args.name
    @op         = args.op
    @Core       = @core( @name )
    @None       = @Core.None
    @NoneStudy  = @Core.NoneStudy
    @Rows       = @toRows(       @Core.Rows    )
    @Columns    = @toColumns(    @Core.Columns )
    @Planes     = @createPlanes( @Core.Planes  )
    @Routes     = @createRoutes()
    @NavbSpecs  = Build.NavbSpecs
    @margin     = @Core.Margin
    @maxLevel   = 5
    @fullUI     = true
    @topicFontFactor = @Core.topicFontFactor
    Util.noop( @op )
    Util.build = @
    #out = Util.toOut( Build.Data )
    #Util.log( out )
    @subscribe()
    #@createJsonDoc( Build.Data )
    #@logCore()
    #@logAdjacentPractices()

  isChild:( key ) ->
    a = key.charAt(0)
    a is a.toUpperCase()

  combine:() ->
    obj = {}
    for arg in arguments
      for own key, val of arg
        obj[key] = val
    obj

  subscribe:() ->
    window.onresize = @resize

  core:( name ) ->
    switch name
      when 'Muse'  then Build.Muse
      #when 'Spark' then require( './js/build/Spark' )
      #when 'Show'  then require( './js/build/Show'  )
      else
        Util.error('Build.core() unknown app name', name )
        Build.Muse

  logCore:() ->
    Util.log( '------ Beg Core ------' )
    Util.log( "Planes: ",    @Core.Planes    )
    Util.log( "None",        @Core.None      )
    Util.log( "Practices: ", @practices )
    Util.log( "Studies: ",   @studies   )
    Util.log( '------ End Core ------' )

  adjacentPractice:( practice, dir ) ->
    return @None if not practice? or not practice.name? or practice.name is 'None' or not practice.column?

    [col,row,pln] = switch dir
      when 'west'  then [@Columns[practice.column].west, practice.row, practice.plane ]
      when 'east'  then [@Columns[practice.column].east, practice.row, practice.plane ]
      when 'north' then [practice.column, @Rows[practice.row].north,   practice.plane ]
      when 'south' then [practice.column, @Rows[practice.row].south,   practice.plane ]
      when 'prev'  then [practice.column, practice.row, @Core.Planes[practice.plane].prev ]
      when 'next'  then [practice.column, practice.row, @Core.Planes[practice.plane].next ]
      else              ["","",""]
    return @None if [col,row,pln] is ["","",""]
    for key, plane of @Planes
      practices = @getPractices( key )
      for own key, prac of practices
        return prac if prac.column is col and prac.row is row and prac.plane is pln
    @None

  # Util.log( 'adj', practice.name, prac.name, practice.column, practice.row, practice.plane ) if dir is 'east'

  adjacentStudies:( practice, dir ) ->
    adjPrac = @adjacentPractice( practice, dir )
    if adjPrac.name isnt 'None' and adjPrac.studies? then adjPrac.studies else {}

  logAdjacentPractices:() ->
    @setAdjacents( @None )
    for key, plane of @Planes
      practices = @getPractices( key )
      for own key, p of practices
        @setAdjacents( p )
        Util.log( { p:key, column:p.column, west:p.west.name, east:p.east.name, north:p.north.name, south:p.south.name, prev:p.prev.name, next:p.next.name } )
    return

  connectName:( practice, dir ) ->
    adjacent = @adjacentPractice( practice, dir )
    if adjacent.name isnt 'None' then [practice.name,adjacent.name] else ['None','None']

  setAdjacents:( practice ) ->
    practice.west  = @adjacentPractice( practice, 'west'  )
    practice.east  = @adjacentPractice( practice, 'east'  )
    practice.north = @adjacentPractice( practice, 'north' )
    practice.south = @adjacentPractice( practice, 'south' )
    practice.prev  = @adjacentPractice( practice, 'prev'  )
    practice.next  = @adjacentPractice( practice, 'next'  )
    return

  toRows:( rows ) ->
    for key, row of rows
      row['key']     = key
      row['name']    = if row.name? then row.name else key
      row['cells']   = @toCells( row['quels'] ) if row['quels']?
    rows

  toColumns:( cols ) ->
    for key, col of cols
      col['key']     = key
      col['name']    = if col.name? then col.name else key
      col['cells']   = @toCells( col['quels'] ) if col['quels']?
    cols

  # Not used now. Use when you want to specify group in Muse.json
  toGroups:( groups ) ->
    for key, group of groups
      group['key']     = key
      group['name']    = if group.name? then group.name else key
      group['cells']   = @toCells( group['quels'] ) if group['quels']?
      group['border']  = if group['border']? then group['border'] else '0'
    groups

  # Only good for defining group from practices.
  # Not needed Groups define in planes
  planeGroups:( plane, practice ) ->
    return if not practice.groups?
    for group in  practice.groups
      plane.groups[group] = {} if not plane.groups[group]?
    return

  toCells:( quels ) ->
    [quels[0],quels[1]-quels[0]+1,quels[2],quels[3]-quels[2]+1]

  notContext:( key ) ->
    key isnt '@context'

  createFilteredPractices:( plane ) ->
    practices    = Build[plane.spec]
    filtered     = {}
    #plane.groups = {}
    #iltered.children = []
    for pkey, practice of practices when @isChild(pkey)
      #@planeGroups( plane, practice )
      practice['name']  = pkey
      practice.studies  = {}
      practice.children = []
      filtered[pkey]    = practice
      #iltered.children.push( practice )
      for skey, study of practice  when @isChild(skey)
        study['name']          = skey
        study.topics           = {}
        study.children         = []
        practice.studies[skey] = study
        practice.children.push(  study )
        for tkey, topic of study  when @isChild(tkey)
          topic['name']      = tkey
          topic.items        = {}
          topic.children     = []
          study.topics[tkey] = topic
          study.children.push( topic )
          for ikey, item of topic when @isChild(ikey)
            item['name']       = ikey
            topic.items[ikey]  = item
            #opic.children.push( item ) # Keep items out of D3
    filtered

  createOverview:( plane ) ->
    practices         = Build[plane.id]
    overview          = {}
    overview.name     = plane.id
    overview.cells    = [1,plane.spec.nrow,1,plane.spec.ncol ]
    overview.hsv      = [60,90,90]
    overview.icon     = "fa-group"
    overview.children = []
    for pkey, practice of practices when @isChild(pkey)
      overview.children.push( practice )
    #console.log( overview )
    overview

  createAsciiDoc:( practices ) ->
    adoc         = ""
    for pkey, practice of practices when @isChild(pkey)
      name  = Util.toName1(pkey)
      adoc += """\n= [black]##{name}#\n"""
      for skey, study of practice  when @isChild(skey)
        name  = Util.toName1(skey)
        adoc += """\n== [black]##{name}#\n"""
        for tkey, topic of study  when @isChild(tkey)
          name  = Util.toName1(tkey)
          adoc += """  #{name}\n"""
          for ikey, item of topic when @isChild(ikey)
            name  = Util.toName1(ikey)
            adoc += """    #{name}\n"""
    Util.saveFile( adoc, 'Data.adoc', 'adoc' )

  createJsonDoc:( practices ) ->
    doc         = {}
    toProp = (prop,name) -> if prop? and prop isnt 'None' then prop else Util.toName(name)
    pracs = ['Describe','Distill','Predict','Advise']
    for pkey, practice of practices when @isChild(pkey) and Util.inArray(pracs,pkey)
      doc[pkey] = {}
      for skey, study of practice  when @isChild(skey)  and study.dir is 'ned' or study.dir is 'nwd'
        doc[pkey][skey]  = {}
        for tkey, topic of study  when @isChild(tkey)
          doc[pkey][skey][tkey] = { title:toProp(topic.title,tkey), abstract:[""], purpose:[toProp(topic.purpose,"")] }
          for ikey, item of topic when @isChild(ikey)
            doc[pkey][skey][tkey][ikey] = { title:toProp(item.title,ikey), abstract:[""], purpose:[toProp(topic.purpose,"")], advantages:[""], disadvantages:[""], tools:{ spark:"", scikit:"", r:"" }, links:{ adoc:"", book:"", sklearn:"" } }
    Util.saveFile( JSON.stringify(doc), 'Desc.json', 'json' )

  orphanItems:( practice ) ->
    for   study in practice.children
      for topic in study   .children
          topic.orphans = topic.children
          delete topic.children
    practice

  adoptItems:( practice ) ->
    for   study in practice.children
      for topic in study   .children when topic.orphans?
          topic.children = topic.orphans
    practice

  createPlanes:( planes ) ->
    for key, plane of planes
      plane['name']      = key
      plane['practices'] = @createFilteredPractices( plane )
    planes

  toArray:( objects ) ->
    array = []
    for own key, obj of objects
      obj['id'] = key
      array.push( obj )
    array

  getPractices:(  plane ) ->
    if @Planes[plane]?
       @Planes[plane].practices
    else
       Util.error( 'Build.getPractices(plane) unknown plane', plane, 'returning Information practices' )
       @Planes['Information'].practices

  isPractice:(   key ) ->
    @practices()[key]?

  getStudies:( ikw, practice ) ->
    practices = @getPractices(ikw)
    if practices[practice]?
       practices[practice].studies
    else
       Util.error( 'Build.getStudies(ikw,practice) unknown practice', practice, 'returning Collaborate studies' )
       practices['Collaborate'].studies

  getTopics:( ikw, practice, study ) ->
    studies = @getStudies( ikw, practice )
    if studies[study]?
       studies[study].topics
    else
      Util.error( 'Build.getTopics(ikw,practice,study) unknown study', study, 'returning Team studies' )
      studies['Team'].topics

  # Create routes from practice for Flatiron Director
  createRoutes:() ->
    Routes = {}
    for own plane, objPlane of @Planes
      for own keyPractice, objPractice of objPlane.practices
        Routes['/'+keyPractice] = Util.noop( 'Route:', keyPractice )
    Routes

  queryPractices:( filter ) ->
    p = {}
    for own key, practice of @practices when @notContext(key) and filter
      p[key] = practice
    p

  getPractice:( plane, row, column ) ->
    practices = @getPractices( plane )
    for own key, practice of practices when practice.column is column and practice.row is row
      return practice
    Util.error( 'Build.getPractice() practice not found for', { plane:plane, column:column, row:row } )
    @None

  queryStudies:( filter ) ->
    s = {}
    for own key, study of @studies when @notContext(key) and filter
      s[key] = study
    s

  logPlanes:( Planes ) ->
    Util.log( '----- Beg Build ------' )
    for own plane, objPlane of Planes
      Util.log( "Plane: ", plane )
      for own keyPractice, objPractice of objPlane.practices
        Util.log( "  Practice: ", keyPractice ) #, objPractice )
        for own keyStudy, objStudy of objPractice.studies
          Util.log( "    Study: ", keyStudy ) #, objStudy )
    Util.log( '----- End Build ------' )
    return

  @SelectPlane     = 'SelectPlane'
  @SelectAllPanes  = 'SelectAllPanes'
  @SelectOverview  = 'SelectOverview'
  @SelectGroup     = 'SelectGroup'
  @SelectRow       = 'SelectRow'
  @SelectCol       = 'SelectCol'
  @SelectPractice  = 'SelectPractice'
  @SelectStudy     = 'SelectStudy'
  @SelectTopic     = 'SelectTopic'
  @SelectItems     = 'SelectItems'

  @content:( content,   source, intent='None', name='None' ) ->
     if intent is 'None'
        intent = switch content
          when 'Study' then Build.SelectStudy
          when 'Topic' then Build.SelectTopic
          when 'Items' then Build.SelectItems
          else              Build.SelectAllPanes
     { content:content, source:source, intent:intent, name:name }

  @select:( name, source,        intent=Build.SelectAllPanes ) ->
    {  name:name, source:source, intent:intent              }

  @NavbSpecs = [
    { type:"NavBarLeft" }
    { type:"Item",      name:"Home",  icon:"fa-home", topic:"muse.html", subject:"Navigate" }
    { type:"Dropdown",  name:"Planes", icon:"fa-sitemap", items: [
      { type:"Item",    name:"Information", topic:"Information",    subject:"Plane"  }
      { type:"Item",    name:"Augment",     topic:"Augment",        subject:"Plane"  }
      { type:"Item",    name:"DataScience", topic:"DataScience",    subject:"Plane"  }
      { type:"Item",    name:"Knowledge",   topic:"Knowledge",      subject:"Plane"  }
      { type:"Item",    name:"Wisdom",      topic:"Wisdom",         subject:"Plane"  }
      { type:"Item",    name:"Hues",        topic:"Hues",           subject:"Plane"  }
    ] }
    { type:"Dropdown",  name:"Content", icon:"fa-leanpub", items: [
      { type:"Item",    name:"Overview",    topic:Build.select( "Overview", 'Navb', Build.SelectOverview ), subject:"Select" }
      { type:"Item",    name:"Center",      topic:Build.content( "Center",  'Navb' ), subject:"Content" }
      { type:"Item",    name:"Graphs",      topic:Build.content( "Svg",     'Navb' ), subject:"Content" }
      { type:"Item",    name:"Studies",     topic:Build.content( "Studies", 'Navb' ), subject:"Content" }
      { type:"Item",    name:"Tree",        topic:Build.content( "Tree",    'Navb' ), subject:"Content" }
      { type:"Item",    name:"Radial",      topic:Build.content( "Radial",  'Navb' ), subject:"Content" }
      { type:"Item",    name:"Inventory",   topic:Build.content( "Inven",   'Navb' ), subject:"Content" }
      { type:"Item",    name:"Connects",    topic:Build.content( "Connect", 'Navb' ), subject:"Content" }
      { type:"Item",    name:"Pivot",       topic:Build.content( "Pivot",   'Navb' ), subject:"Content" }
      { type:"Item",    name:"Plot",        topic:Build.content( "Plot",    'Navb' ), subject:"Content" }
      { type:"Item",    name:"MathBox",     topic:Build.content( "MathBox", 'Navb' ), subject:"Content" }
      { type:"Item",    name:"Slide",       topic:Build.content( "Slide",   'Navb' ), subject:"Content" }
    ] }
    { type:"Dropdown",  name:"Tests", icon:"fa-stethoscope", items: [
      { type:"Item",    name:"Populate",    topic:"Populate",  subject:"Test" }
      { type:"Item",    name:"Migrate",     topic:"Migrate",   subject:"Test" }
      { type:"Item",    name:"Persist",     topic:"Persist",   subject:"Test" }
      { type:"Item",    name:"Rest",        topic:"Rest",      subject:"Test" }
      { type:"Item",    name:"Memory",      topic:"Memory",    subject:"Test" }
      { type:"Item",    name:"IndexedDB",   topic:"IndexedDB", subject:"Test" } ] }
    { type:"Image",     name:"Image", icon:"fa-picture-o", topic:'Image', subject:"Image" }
    { type:"NavBarEnd" }
    { type:"NavBarRight"}
    { type:"Search",    name:"Search",    icon:"fa-search",      size:"10", topic:'Search',    subject:"Submit" }
    { type:"Contact",   name:"Contact",   icon:"fa-twitter", topic:"http://twitter.com/TheTomFlaherty", subject:"Navigate" }
    { type:"Dropdown",  name:"Settings",  icon:"fa-cog", items: [
      { type:"Item",    name:"Preferences", topic:"Preferences", subject:"Settings" }
      { type:"Item",    name:"Connection",  topic:"Connection",  subject:"Settings" }
      { type:"Item",    name:"Privacy",     topic:"Privacy",     subject:"Settings" } ] }
    { type:"SignOn",    name:"SignOn", icon:"fa-sign-in", size:"10", topic:'SignOn', subject:"Submit" }
    { type:"NavBarEnd"  } ]

  ###
  { type:"FileInput", name:"FileInput", icon:"fa-file-text-o", size:"10", topic:'FileInput', subject:"Submit" }
  { type:"Dropdown",  name:"About", icon:"fa-book", items: [
    { type:"Item",    name:"DataScience", topic:"DataScience", subject:"About" }
    { type:"Item",    name:"Machine",     topic:"Machine",     subject:"About" }
    { type:"Item",    name:"Information", topic:"Information", subject:"About" }
    { type:"Item",    name:"Knowledge",   topic:"Knowledge",   subject:"About" }
    { type:"Item",    name:"Wisdom",      topic:"Wisdom",      subject:"About" } ] }
  ###