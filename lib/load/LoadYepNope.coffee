
class LoadYepNope

  @modsNode  =
    "paths" : { "node":"node_modules/" }
    "node"  : [ "jquery/dist/jquery", "d3/d3", "c3/c3", "rx/dist/rx.all",
                "lodash/lodash", "chroma-js/chroma", "pouchdb/dist/pouchdb",
                "jquery-ui/jquery-ui","pivottable/dist/pivot",
                "pivottable/dist/c3_renderers", "pivottable/dist/export_renderers"]

  @modsMuse =
    "paths"   : { "custom":"lib/custom/","muse":"htm/target/","d3d":"js/d3d/","prac":"js/prac/","store":"js/store/","ui":"js/ui/","util":"js/util/","visual":"js/visual/","mbox":"js/mbox/","app":"js/exit/app/","page":"js/exit/page/","uc":"js/exit/uc/"}
    "custom"  : [ "rx.jquery" ]
    "muse"    : [ "Action", "Persist" ]
    "d3d"     : [ "Axes","Chord","Color","D3D","Link","Pallettes","Pres","Radar","Radial","Sankey","Tree","Wheel"]
    "prac"    : [ "Build","Connect","Embrace","Encourage","Innovate","Prac","Shape"]
    "store"   : [ "Database","Firebase","IndexedDB","Memory","Pivot","PouchDB","Reactor","Rest","Store"]
    "ui"      : [ "Btn","Group","Navb","Page","Pane","Part","Reactor","Tocs","UI","View"]
    "util"    : [ "Stream","Vis"]
    "visual"  : [ "C3V","D3V","MathBoxV","PlotlyV","Reactor","Visual"]
    "mbox"    : [ "Color","Coord","Faces","MBox","Muse","Names","Regress"]
    "app"     : [ "Data","Model","Rest","Simulate","Spatial","Trip"]
    "page"    : [ "Deals","UI","DestinationUI","GoUI","NavigateUI","Page","TripUI"]
    "uc"      : [ "AdvisoryUC","BannerUC","DealsUC","DriveBarUC","IconsUC","SearchUC","ThresholdUC","WeatherUC"]

  @load = ( init ) ->
    LoadYepNope.loadModules( Load.libsNode, Util.resetModuleExports )
    LoadYepNope.loadModules( Load.libsMuse, init )


  @loadModules:( mods, callback, dbg=false ) ->
    return if not Util.hasGlobal('yepnope')
    root = "../../"
    deps = []
    for path, dir of mods.paths
      for mod in mods[path]
        deps.push( root + dir + mod + '.js' )
        Util.log(  root + dir + mod + '.js' ) if dbg
    yepnope( [{ load:deps, complete:callback }] )
    return

  @verifyLoadModules:(lib,modules,global=undefined) ->
    ok  = true
    for module in modules
      has = if global? then Util.hasGlobal(global,false) or Util.hasPlugin(global) else Util.hasModule(lib+module,false)?
      Util.error( 'Util.verifyLoadModules() Missing Module', lib+module+'.js', {global:global} ) if not has
      ok &= has
    ok

  @modsName  =
    "paths" : { "node":"node_modules/" }
    "node"  : [ "jquery:jquery/dist/jquery", "d3:d3/d3", "c3:c3/c3", "rx:rx/dist/rx.all",
      "_:lodash/lodash", "chroma:chroma-js/chroma", "pouchdb:pouchdb/dist/pouchdb",
      "jquery-ui:jquery-ui/jquery-ui","pivottable:pivottable/dist/pivot",
      "pivottable/dist/c3_renderers", "pivottable/dist/export_renderers"]