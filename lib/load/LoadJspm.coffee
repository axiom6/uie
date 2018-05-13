



class LoadJspm

  @loadWithConfig:( moduleImport, jspmPath="../../lib/jspm_packages/system.js", configPath="../target/Config.js" ) ->
    onLoad = () ->
      LoadJspm.System = System
      LoadJspm.loadMathBox(   moduleImport )
      LoadJspm.System.import( moduleImport )
    Util.loadScript( jspmPath, () -> Util.loadScript( configPath, onLoad ) )
    return

  @loadMathBox:( moduleImport, fn=null ) ->
    if Util.parseURI( moduleImport ).file is 'MainBox'
      Util.loadScript( "../../node_modules/mathbox/build/mathbox-bundle.js", fn )
    else if fn?
      fn()
    return