
# Static method utilities       - Util is a global without a functional wrapper
# coffee -c -bare Util.coffee   - prevents function wrap to put Util in global namespace
# Very important requires that Util.js be loaded first

class Util

  module.exports  = Util

  Util.myVar      =  'myVar'
  Util.isCommonJS =  false
  Util.isWebPack  =  false
  if typeof module is "object" && typeof module.exports  is "object"
    Util.isCommonJS = true
  else
    Util.isWebPack  = true

  Util.Load          = null
  Util.ModuleGlobals = []
  Util.app           = {}
  Util.testTrue      = true
  Util.debug         = false
  Util.$empty        = if $? then $() else [] # Empty jQuery singleton for intialization
  Util.count         = 0
  Util.modules       = []
  Util.instances     = []
  Util.globalPaths   = []
  Util.root          = '../../' # Used internally
  Util.rootJS        =  Util.root + 'js/'
  Util.databases     = {}
  Util.htmlIds       = {} # Object of unique Html Ids
  Util.logStackNum   = 0
  Util.logStackMax   = 100

  # ------ Modules ------

  @init:( moduleImport=undefined, moduleInit=null, root='../../'  ) ->
    Util.root   = root
    Util.rootJS = Util.root + 'js/'
    Util.resetModuleExports()
    Util.fixTestGlobals()
    if Util.isCommonJS and  moduleImport?
       require( moduleImport )
    else if Util.isJspm and moduleImport?
      if not System?
        Util.loadJspmWithConfig( moduleImport )
      else
        Util.loadMathBox( moduleImport )
        System.import(    moduleImport )
    else if Util.isYepNope
      Util.noop()
    else
      Util.error( """Bad arguments for Util.init() isCommonJS=#{Util.isCommonJS},
        isJspm=#{Util.isJspm} root=#{root}, moduleInit=#{moduleInit?}, moduleImport=#{moduleImport}""" )
    return

  @initJasime:() ->
    Util.resetModuleExports()
    if not Util.isCommonJS
      window.require = Util.loadScript
    else
      Util.fixTestGlobals()
      window.exports        = module.exports
      window.jasmineRequire = window.exports
    return

  @fixTestGlobals:() ->
    window.Util           = Util
    window.xUtil          = Util

  @loadScript:( path, fn ) ->
    head          = document.getElementsByTagName('head')[0];
    script        = document.createElement('script')
    script.src    = path
    script.async  = false
    script.onload = fn if Util.isFunc( fn )
    head.appendChild( script )
    return

  @resetModuleExports:() ->
    if Util.isCommonJS
       Util.module            = require('module')
       Util.module.globalPaths.push("/Users/ax/Documents/prj/ui/")
       #window.global = window
       #til.log( "Node Module Paths", Util.module.globalPaths )
    else
      window.module         = {}
      window.module.exports = {}
      for globName in Util.ModuleGlobals
        modu = window[globName.glob]
        if modu
          Util.setModule( modu, globName.name )
        else
          Util.error( 'Util.resetModuleExports() missing module for global', globName )
    return

  # Don't use not working yet
  @ready:( fn ) ->
    if not Util.isFunc( fn )                  # Sanity check
      return
    else if document.readyState is 'complete' # If document is already loaded, run method
      fn()
    else
      document.addEventListener( 'DOMContentLoaded', fn, false )
    return

  # ---- YepNope ----

  @loadYeoNopeModule:( path ) ->
    return if not Util.hasGlobal('yepnope')
    if Util.modules[path]?
       Util.modules[path]
    else
       yepnope( [{ load:path+'.js' }] )
    return

  @loadYeoNopeNodeModels:( paths ) ->
    return if not Util.hasGlobal('yepnope')
    Util.loadYepNopeModule( path ) for path in paths
    return

  # ---- Inquiry ----

  @hasMethod:( obj, method, issue=false ) ->
    has = typeof obj[method] is 'function'
    Util.log( 'Util.hasMethod()', method, has )  if not has and issue
    has

  @hasGlobal:( global, issue=true ) ->
    has = window[global]?
    Util.error( "Util.hasGlobal() #{global} not present" )  if not has and issue
    has

  @getGlobal:( global, issue=true ) ->
    if Util.hasGlobal( global, issue ) then window[global] else null

  @hasPlugin:( plugin, issue=true ) ->
    glob = Util.firstTok(plugin,'.')
    plug = Util.lastTok( plugin,'.')
    has  = window[glob]? and window[glob][plug]?
    Util.error( "Util.hasPlugin()  $#{glob+'.'+plug} not present" )  if not has and issue
    has

  @hasModule:( path, issue=true ) ->
    has = Util.modules[path]?
    Util.error( "Util.hasModule() #{path} not present" )  if not has and issue
    has

  @dependsOn:() ->
    ok = true
    for arg in arguments
      has = Util.hasGlobal(arg,false) or Util.hasModule(arg,false) or Util.hasPlugin(arg,false)
      Util.error( 'Missing Dependency', arg ) if not has
      ok = has if has is false
    ok

  # --- Export and Import ----

  # First add module the modules associative array.
  # Export is capitalized to avoid conflict with "export" JavaScript keyword
  @Export:( module, path, dbg=false ) ->
    if not  module? and path?
      Util.error('Util.setModule() module not defined for path', path )
    else if module? and not path?
      Util.error('Util.setModule() path not  defined for module', module.toString() )
    else
      Util.log( '# Util.Export', path ) if dbg
      Util.modules[path] = module
    module

  # First lookup module from modules associative array
  # Import is capitalized to avoid conflict with "import" JavaScript keyword
  @Import:( name, commonPath=null, globalVar=null ) ->
    path = if commonPath? then commonPath+name else name
    if Util.isCommonJS or Util.isJspm and require?
      module = require( path )
      window[globalVar] = module if globalVar?
      module
    else if Util.modules[path]?
      Util.modules[path]
    else if Util.modules[globalVar]?
      Util.modules[globalVar]
    else if  globalVar? and window[globalVar]?
      window[globalVar]
    else
      Util.error('Util.Import() module not defined for path', path, globalVar )
      null

  @ImportUtils:( names=['Stream','Vis','Type','GeoJson'], commonPath='js/util/' ) ->
    ImportModules( names, commonPath )

  @ImportModules:( names, commonPath ) ->
    mods = {}
    for name in names
      mods[name] = Util.Import( name, commonPath )
    mods

  # ---- Instances ----

  @setInstance:( instance, path ) ->
    Util.log( 'Util.setInstance()', path )
    if not instance? and path?
      Util.error('Util.setInstance() instance not defined for path', path )
    else if instance? and not path?
      Util.error('Util.setInstance() path not defined for instance', instance.toString() )
    else
      Util.instances[path] = instance
    return

  @getInstance:( path, dbg=false ) ->
    Util.log( 'getInstance', path ) if dbg
    instance = Util.instances[path]
    if not instance?
      Util.error('Util.getInstance() instance not defined for path', path )
    instance

  # ---- Logging -------

  # args should be the arguments passed by the original calling function
  # This method should not be called directly
  @toStrArgs:( prefix, args ) ->
    Util.logStackNum = 0
    str = if Util.isStr(prefix) then prefix + " "  else ""
    for arg in args
      str += Util.toStr(arg) + " "
    str

  @toStr:( arg ) ->
    Util.logStackNum++
    return '' if Util.logStackNum > Util.logStackMax
    switch typeof(arg)
      when 'null'   then 'null'
      when 'string' then Util.toStrStr(arg)
      when 'number' then arg.toString()
      when 'object' then Util.toStrObj(arg)
      else arg

  # Recusively stringify arrays and objects
  @toStrObj:( arg ) ->
    str = ""
    if not arg?
      str += "null"
    else if Util.isArray(arg)
      str += "[ "
      for a in arg
        str += Util.toStr(a) + ","
      str = str.substr(0, str.length - 1) + " ]"
    else if Util.isObjEmpty(arg)
      str += "{}"
    else
      str += "{ "
      for own key, val of arg
        str += key + ":" + Util.toStr(val) + ", "
      str = str.substr(0, str.length - 2) + " }" # Removes last comma
    str

  @toStrStr:( arg ) ->
    if arg.length > 0 then arg
    else '""'

  # Consume unused but mandated variable to pass code inspections
  @noop:() ->
    Util.log( arguments ) if false
    return

  # Conditional log arguments through console
  @dbg:() ->
    return if not Util.debug
    str = Util.toStrArgs( '', arguments )
    Util.consoleLog( str )
    #@gritter( { title:'Log', time:2000 }, str )
    return

  # Log Error and arguments through console and Gritter
  @error:() ->
    str  = Util.toStrArgs( 'Error:', arguments )
    Util.consoleLog( str )
    # @gritter( { title:'Error', sticky:true }, str ) if window['$']? and $['gritter']?
    # Util.trace( 'Trace:' )
    return

  # Log Warning and arguments through console and Gritter
  @warn:() ->
    str  = Util.toStrArgs( 'Warning:', arguments )
    Util.consoleLog( str )
    # @gritter( { title:'Warning', sticky:true }, str ) if window['$']? and $['gritter']?
    return

  @toError:() ->
    str = Util.toStrArgs( 'Error:', arguments )
    new Error( str )

  # Log arguments through console if it exists
  @log:() ->
    str = Util.toStrArgs( '', arguments )
    Util.consoleLog( str )
    #@gritter( { title:'Log', time:2000 }, str )
    return

  # Log arguments through gritter if it exists
  @called:() ->
    str = Util.toStrArgs( '', arguments )
    Util.consoleLog( str )
    #@gritter( { title:'Called', time:2000 }, str )
    return

  @gritter:( opts, args... ) ->
    return if not ( Util.hasGlobal('$',false)  and $['gritter']? )
    str = Util.toStrArgs( '', args )
    opts.title = if opts.title? then opts.title else 'Gritter'
    opts.text  = str
    # $.gritter.add( opts )
    return

  @consoleLog:( str ) ->
    console.log(str) if console?
    return

  @trace:(  ) ->
    str = Util.toStrArgs( 'Trace:', arguments )
    Util.consoleLog( str )
    try
      throw new Error( str )
    catch error
      Util.log( error.stack )
    return

  @alert:(  ) ->
    str = Util.toStrArgs( '', arguments )
    Util.consoleLog( str )
    alert( str )
    return

  # Does not work
  @logJSON:(json) ->
    Util.consoleLog(json)

  # ------ Validators ------

  @isDef:(d)         ->  d?
  @isNot:(d)         ->  not Util.isDef(d)
  @isStr:(s)         ->  s? and typeof(s)=="string" and s.length > 0
  @isNum:(n)         ->  n? and typeof(n)=="number" and not isNaN(n)
  @isObj:(o)         ->  o? and typeof(o)=="object"
  @isVal:(v)         ->  typeof(v)=="number" or typeof(v)=="string" or typeof(v)=="boolean"
  @isObjEmpty:(o)    ->  Util.isObj(o) and Object.getOwnPropertyNames(o).length is 0
  @isFunc:(f)        ->  f? and typeof(f)=="function"
  @isArray:(a)       ->  a? and typeof(a)!="string" and a.length? and a.length > 0
  @isEvent:(e)       ->  e? and e.target?
  @inIndex:(a,i)     ->  Util.isArray(a) and 0 <= i and i < a.length
  @inArray:(a,e)     ->  Util.isArray(a) and a.indexOf(e) > -1
  @inString:(s,e)    ->  Util.isStr(s)   and s.indexOf(e) > -1
  @atLength:(a,n)    ->  Util.isArray(a) and a.length==n
  @head:(a)          ->  if Util.isArray(a) then a[0]          else null
  @tail:(a)          ->  if Util.isArray(a) then a[a.length-1] else null
  @time:()           ->  new Date().getTime()
  @isStrInteger:(s)  -> /^\s*(\+|-)?\d+\s*$/.test(s)
  @isStrFloat:(s)    -> /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/.test(s)
  @isStrCurrency:(s) -> /^\s*(\+|-)?((\d+(\.\d\d)?)|(\.\d\d))\s*$/.test(s)
  #@isStrEmail:(s)   -> /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/.test(s)

  @isDefs:() ->
    for arg in arguments
      if not arg?
        return false
    true

  @copyProperties:( to, from ) ->
    for own key, val of from
      to[key] = val
    to

  @contains:( array, value ) ->
    Util.isArray(array) and array.indexOf(value) isnt -1

  # Screen absolute (left top width height) percent positioning and scaling

  # Percent array to position mapping
  @toPosition:( array ) ->
    { left:array[0], top:array[1], width:array[2], height:array[3] }

  # Adds Percent from array for CSS position mapping
  @toPositionPc:( array ) ->
    { position:'absolute', left:array[0]+'%', top:array[1]+'%', width:array[2]+'%', height:array[3]+'%' }

  @cssPosition:( $, screen, port, land ) ->
    array = if screen.orientation is 'Portrait' then port else land
    $.css( Util.toPositionPc(array) )
    return

  @xyScale:( prev, next, port, land ) ->
    [xp,yp] = if prev.orientation is 'Portrait' then [port[2],port[3]] else [land[2],land[3]]
    [xn,yn] = if next.orientation is 'Portrait' then [port[2],port[3]] else [land[2],land[3]]
    xs = next.width  * xn  / ( prev.width  * xp )
    ys = next.height * yn  / ( prev.height * yp )
    [xs,ys]

  # ----------------- Guarded jQuery dependent calls -----------------

  @resize:( callback ) ->
    window.onresize = () ->
      setTimeout( callback, 100 )
    return

  @resizeTimeout:( callback, timeout = null ) ->
    window.onresize = () ->
      clearTimeout( timeout ) if timeout?
      timeout = setTimeout( callback, 100 )
    return

  @isEmpty:( $elem ) ->
    $elem.length is 0
    ###
    if $elem.length is 0Util.hasGlobal('$')
      $elem.length is 0 # || if $elem.children()? then $elem.children().length is 0 else false
    else
      false
    ###

  @isJQuery:( $elem, $ = window['$'] ) ->
    $? and $elem? and ( $elem instanceof $ || 'jquery' in Object($elem) )

  # ------ Html ------------

  @getHtmlId:( name, type='', ext='' ) ->
    name + type + ext

  @htmlId:( name, type='', ext='' ) ->
    id = Util.getHtmlId( name, type, ext )
    Util.error( 'Util.htmlId() duplicate html id', id ) if Util.htmlIds[id]?
    Util.htmlIds[id] = id
    id

  # ------ Converters ------

  @extend:( obj, mixin ) ->
    for own name, method of mixin
      obj[name] = method
    obj

  @include:( klass, mixin ) ->
    Util.extend( klass.prototype, mixin )

  @eventErrorCode:( e ) ->
    errorCode = if e.target? and e.target.errorCode then e.target.errorCode else 'unknown'
    { errorCode:errorCode }

  @toName:( s1 ) ->
    s2 =  s1.replace('_',' ')
    s3 =  s2.substring(1)
    s4 =  s3.replace(/([A-Z][a-z])/g, ' $1' )
    s5 =  s1.charAt(0) + s4
    s5

  @indent:(n) ->
    str = ''
    for i in [0...n]
      str += ' '
    str

  @hashCode:( str ) ->
    hash = 0
    for i in [0...str.length]
      hash = (hash<<5) - hash + str.charCodeAt(i)
    hash

  @lastTok:( str, delim ) ->
    str.split(delim).pop()

  @firstTok:( str, delim ) ->
    if Util.isStr(str) and str.split?
      str.split(delim)[0]
    else
      Util.error( "Util.firstTok() str is not at string", str )
      ''
  ###
    parse = document.createElement('a')
    parse.href =  "http://example.com:3000/dir1/dir2/file.ext?search=test#hash"
    parse.protocol  "http:"
    parse.hostname  "example.com"
    parse.port      "3000"
    parse.pathname  "/dir1/dir2/file.ext"
    parse.segments  ['dir1','dir2','file.ext']
    parse.fileExt   ['file','ext']
    parse.file       'file'
    parse.ext        'ext'
    parse.search    "?search=test"
    parse.hash      "#hash"
    parse.host      "example.com:3000"
  ###

  @pdfCSS:( href ) ->
    return if not window.location.search.match(/pdf/gi)
    link      = document.createElement('link')
    link.rel  = 'stylesheet'
    link.type = 'text/css'
    link.href =  href
    document.getElementsByTagName('head')[0].appendChild link
    return

  @parseURI:( uri ) ->
    parse          = {}
    parse.params   = {}
    a              = document.createElement('a')
    a.href         = uri
    parse.href     = a.href
    parse.protocol = a.protocol
    parse.hostname = a.hostname
    parse.port     = a.port
    parse.segments = a.pathname.split('/')
    parse.fileExt  = parse.segments.pop().split('.')
    parse.file     = parse.fileExt[0]
    parse.ext      = if parse.fileExt.length==2 then parse.fileExt[1] else ''
    parse.dbName   = parse.file
    parse.fragment = a.hash
    parse.query    = if Util.isStr(a.search) then a.search.substring(1) else ''
    nameValues     = parse.query.split('&')
    if Util.isArray(nameValues)
      for nameValue in nameValues
        [name,value] = nameValue.split('=')
        parse.params[name] = value
    parse

  @quicksort:( array ) ->
    return [] if array.length == 0
    head = array.pop()
    small = ( a for a in array when a <= head )
    large = ( a for a in array when a >  head )
    (Util.quicksort(small)).concat([head]).concat( Util.quicksort(large) )

  @pad:( n ) ->
    if n < 10 then '0'+n else n

  @padStr:( n ) ->
    if n < 10 then '0'+n.toString() else n.toString()

  # Return and ISO formated data string
  @isoDateTime:( dateIn ) ->
    date = if dateIn? then dateIn else new Date()
    Util.log( 'Util.isoDatetime()', date )
    Util.log( 'Util.isoDatetime()', date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes, date.getUTCSeconds )
    pad = (n) -> Util.pad(n)
    date.getFullYear()     +'-'+pad(date.getUTCMonth()+1)+'-'+pad(date.getUTCDate())+'T'+
    pad(date.getUTCHours())+':'+pad(date.getUTCMinutes())+':'+pad(date.getUTCSeconds())+'Z'

  @toHMS:( unixTime ) ->
    date = if Util.isNum(unixTime) then new Date( unixTime * 1000 ) else new Date()
    hour = date.getHours()
    ampm = 'AM'
    if hour > 12
      hour = hour - 12
      ampm = 'PM'
    min  = ('0' + date.getMinutes()).slice(-2)
    sec  = ('0' + date.getSeconds()).slice(-2)
    time = "#{hour}:#{min}:#{sec} #{ampm}"
    time

  # Generate four random hex digits
  @hex4:() ->
    (((1+Math.random())*0x10000)|0).toString(16).substring(1)

  # Generate a 32 bits hex
  @hex32:() ->
    hex = @hex4()
    for i in [1..4]
      Util.noop(i)
      hex += @hex4()
    hex

  # Return a number with fixed decimal places
  @toFixed:( arg, dec=2 ) ->
    num = switch typeof(arg)
      when 'number' then arg
      when 'string' then parseFloat(arg)
      else 0
    num.toFixed(dec)

  @toInt:( arg ) ->
    switch typeof(arg)
      when 'number' then Math.floor(arg)
      when 'string' then  parseInt(arg)
      else 0

  @toFloat:( arg ) ->
    switch typeof(arg)
      when 'number' then arg
      when 'string' then parseFloat(arg)
      else 0

  @toCap:( str ) ->
    str.charAt(0).toUpperCase() + str.substring(1)

  @unCap:( str ) ->
    str.charAt(0).toLowerCase() + str.substring(1)

  @toArray:( objects, whereIn=null, keyField='id' ) ->
    where = if whereIn? then whereIn else () -> true
    array = []
    if Util.isArray(objects)
      for object in array  when where(object)
        object[keyField] = object['id'] if object['id']? and keyField isnt 'id'
        array.push( object )
    else
      for own key, object of objects when where(object)
        object[keyField] = key
        array.push(object)
    array

  @toObjects:( rows, whereIn=null, keyField='id' ) ->
    where = if whereIn? then whereIn else () -> true
    objects = {}
    if Util.isArray(rows)
      for row in rows when where(row)
        row[keyField] = row['id'] if row['id']? and keyField isnt 'id'
        objects[row[keyField]] = row
    else
      for key, row of rows when where(row)
        row[keyField] = key
        objects[key]  = row
    objects

  # Beautiful Code, Chapter 1.
  # Implements a regular expression matcher that supports character matches,
  # '.', '^', '$', and '*'.

  # Search for the regexp anywhere in the text.
  @match:(regexp, text) ->
    return Util.match_here(regexp.slice(1), text) if regexp[0] is '^'
    while text
      return true if Util.match_here(regexp, text)
      text = text.slice(1)
    false

  # Search for the regexp at the beginning of the text.
  @match_here:(regexp, text) ->
    [cur, next] = [regexp[0], regexp[1]]
    if regexp.length is 0 then return true
    if next is '*' then return Util.match_star(cur, regexp.slice(2), text)
    if cur is '$' and not next then return text.length is 0
    if text and (cur is '.' or cur is text[0]) then return Util.match_here(regexp.slice(1), text.slice(1))
    false

  # Search for a kleene star match at the beginning of the text.
  @match_star:(c, regexp, text) ->
    loop
      return true if Util.match_here(regexp, text)
      return false unless text and (text[0] is c or c is '.')
      text = text.slice(1)

  @match_test:() ->
    Util.log( Util.match_args("ex", "some text") )
    Util.log( Util.match_args("s..t", "spit") )
    Util.log( Util.match_args("^..t", "buttercup") )
    Util.log( Util.match_args("i..$", "cherries") )
    Util.log( Util.match_args("o*m", "vrooooommm!") )
    Util.log( Util.match_args("^hel*o$", "hellllllo") )

  @match_args:( regexp, text ) ->
    Util.log( regexp, text, Util.match(regexp,text) )

  @svgId:( name, type, svgType, check=false ) ->
    if check then @id( name, type, svgType ) else name + type + svgType
  @css:(   name, type=''       ) -> name + type
  @icon:(  name, type, fa      ) -> name + type + ' fa fa-' + fa

# Export Util as a convenience, since it is not really needed since Util is a global
# Need to export at the end of the file.
# module.exports = # Util.Export( Util, 'js/util/Util' )



