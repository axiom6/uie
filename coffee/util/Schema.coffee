
class Schema

  module.exports = Schema # Util.Export( Schema, 'util/Schema' )
  
  Schema.cssUOM  = ['px','in','cm','mm','pc','pt','px','em','ex','ch','vb','vw','vmax','vmin']
  Schema.siUOM   = ['m','kg','s','A','K','mol','cd']
  Schema.sciUOM  = ['deg','rad']
  Schema.UOMs    = Schema.cssUOM.concat( Schema.siUOM, Schema.sciUOM )
  Schema.Opts    = ['?','1','*','+'] # '*','+' are for arrays
  Schema.Props   =  { 'type','schema','qschemas','prim','ref','Enum','opt','minmax','format','validator','default','uom','abstract','_ext' }
  Schema.Propa   =  { 't',   's',     'q',       'p',   'r',  'E',   'o',   'm',    'f',     'v',        'd',      'u',  'a',       '_'    }

  @toProp:( chr ) -> index = Schema.Propa.indexOf(chr); if index >= 0 then Schema.Props[index] else 'undefined'
  @isProp:( key ) -> Schema.Props.indexOf(key) != -1 or Schema.Propa.indexOf(key) != -1
  @isUOM:(  uom ) -> Schema.UOMs .indexOf(uom) != -1
  @isOpt:(  opt ) -> Schema.Opts .indexOf(opt) != -1

  ###
  @checkModel:( model, schema ) ->
    check = ''
    if Util.isArray( model )
      for obj in model
        check += Type.checkObj( key, schema[key] )
    else
      for key, obj of model
        check += Type.checkObj( key, schema[key] )
    check
   ###

  @checkProps:( key, spec ) ->
    check = ''
    for k, v of spec
      check += Schema.checkProp(     k,v,spec) if not Schema.isProp(k)
      check += Schema.checkType(     k,v,spec) if Schema.isKey(k,'type'     )
      check += Schema.checkPrim(     k,v,spec) if Schema.isKey(k,'prim'     )
      check += Schema.checkProp(     k,v,spec) if Schema.isKey(k,'spec'     )
      check += Schema.checkRef(      k,v,spec) if Schema.isKey(k,'ref'      )
      check += Schema.checkOpt(      k,v,spec) if Schema.isKey(k,'opt'      )
      check += Schema.checkMinMax(   k,v,spec) if Schema.isKey(k,'minmax'   )
      check += Schema.checkFormat(   k,v,spec) if Schema.isKey(k,'format'   )
      check += Schema.checkValid(    k,v,spec) if Schema.isKey(k,'validator')
      check += Schema.checkDefault(  k,v,spec) if Schema.isKey(k,'default'  )
      check += Schema.checkUom(      k,v,spec) if Schema.isKey(k,'uom'      )
      check += Schema.checkAbstract( k,v,spec) if Schema.isKey(k,'abstract' )
      check += Schema.checkExt(      k,v,spec) if Schema.isKey(k,'_ext'     )
    check
    
  @checkProp:(     k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkType:(     k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkPrim:(     k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkProp:(     k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkRef :(     k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkOpt:(      k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkMinMax:(   k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkFormat:(   k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkValid:(    k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkDefault:(  k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkUom:(      k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkAbstract:( k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"
  @checkExt:(      k, v, spec ) ->  "#{k} #{v} #{Util.toStr(spec)}"

  @validObj:( obj, model ) ->
    valid = ''
    for key, value of obj
      valid += Schema.validValue( key, value, model[key] )
    valid

  @validValue:( key, ov, spec ) ->
    valid = '' 
    return valid if not spec?
    for k, sv of spec
      valid += Schema.validType(   key,ov,sv) if Schema.isKey(k,'type')
      valid += Schema.validProp(   key,ov,sv) if Schema.isKey(k,'spec')
      valid += Schema.validRef(    key,ov,sv) if Schema.isKey(k,'ref' )
      valid += Schema.validEnum(   key,ov,sv) if Schema.isKey(k,'enum')
      valid += Schema.validOpt(    key,ov,sv) if Schema.isKey(k,'opt' )
      valid += Schema.validMinMax( key,ov,sv) if Schema.isKey(k,'minmax')
      valid += Schema.validFormat( key,ov,sv) if Schema.isKey(k,'format')
      valid += Schema.validValue(  key,ov,sv) if Schema.isKey(k,'validator')
    valid

  @validType:(   key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validProp:(   key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validRef :(   key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validEnum:(   key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validOpt:(    key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validMinMax:( key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validFormat:( key, ov, sv ) ->  "#{key} #{ov} #{sv}"
  @validValue:(  key, ov, sv ) ->
    isValid = sv(ov)
    if isValid then 'true' else 'false'

  @isKey:( k, key ) -> k is key or k is key.charAt(0)

  constructor:() ->


    