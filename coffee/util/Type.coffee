

class Type

  module.exports = Type # Util.Export( Type, 'util/Type' )

  # Types Javascript JS and Axiom Ax extended
  Type.typesJS = ['number','string','boolean','object','function','undefined', 'null']
  Type.typesJA = ['n',     's',     'b',      'o',    'f',        'u',         'q'   ]
  Type.typesAx = ['Array','Id','Int','Float','Currency','Date','Enum', 'Extend' ]
  Type.typesAA = ['A',    'P', 'I',  'F',    '$',       'D',   'E',    'X'      ]
  Type.types   = Type.typesJS.concat( Type.typesAx )
  Type.typesa  = Type.typesJA.concat( Type.typesAA )

  # Cardinality
  Type.Opts    = ['?','1','*','+'] # '*','+' are for arrays

  # UOM
  Type.cssUOM  = ['px','in','cm','mm','pc','pt','px','em','ex','ch','vb','vw','vmax','vmin']
  Type.siUOM   = ['m','kg','s','A','K','mol','cd']
  Type.axUOM   = ['deg','rad','colorname','hex','rgb','rgba','hsl','hsla'] # CSS colors - may not belong
  Type.UOMs    = Type.cssUOM.concat( Type.siUOM, Type.axUOM )

  Type.Props   =  { 'name', 'type','schema','enum','range', 'minmax', 'validator', 'format','default','uom','abstract', 'width' }
  Type.Propa   =  { 'n',    't',   's',     'e',   'r',     'm',      'v',         'f',     'd',      'u',  'a',        'w'    }

  @isType:( type )   -> Util.contains(Type.types,type) or Util.contains(Type.typesa,type)
  @toType:( decl )   -> index = Schema.typesa.indexOf(decl); if index >= 0 then Type.types[index] else 'null'

  @isProp:( key ) -> Util.contains(Type.Props,key) or Util.contains(Type.Propa,key)
  @toProp:( chr ) -> index = Schema.Propa.indexOf(chr); if index >= 0 then Schema.Props[index] else 'null'

  @isUOM:(  uom ) -> Util.contains(Schema.UOMs,uom)
  @isOpt:(  opt ) -> Util.contains(Schema.Opts,opt)

  Util.Check = {}

  @checkStart:( model, schema, name ) ->
    Type.checkModel( model, schema, Util.Check, name )
    Util.schema = schema
    Util.Check[name]

  @checkModel:( model, schema, check, key ) ->
    report = {}
    if Util.isArray(    model )
      Type.checkArray(  model, schema, report, key )
    else if Util.isObj( model )
      Type.checkObject( model, schema, report, key )
    else if Util.isVal( model )
      Type.checkValue(  model, schema, report, key )
    else
      report['error'] = { error:"Unknown model type #{typeof(model)}" }
    check[key] = report # if Type.isNotOk( report )
    return

  @checkArray:( array, schema, check, keyObj ) ->
    check['range'] = Type.checkRange( array, schema )
    for i in [0...array.length]
      branch = Type.branchSchema( schema, keyObj ) # Array keyVals not in Schema
      Type.checkModel( array[i], branch, check, i.toString() )
    return

  @checkObject:( object, schema, check, keyObj ) ->
    schemaObj = Type.branchSchema( schema, keyObj )
    Type.checkProps( object, schemaObj, check, keyObj )
    for own keyVal, val of object  # Check values
      schemaKey = Type.branchSchema( schemaObj, keyObj, keyVal )
      Type.checkModel( val, schemaKey, check, keyVal )
      if not schemaObj[keyVal]
        check[keyVal] = {}
        check[keyVal]['extra'] = true
    return

  @checkValue:( value, schema, check, key ) ->
    check['value'] = value
    check['types'] = schema.type
    check['match'] = typeof(value) is Type.typeJS(schema.type)
    check['enums'] = Util.contains(schema.Enum,value) if schema.Enum?
    return

  @checkProps:( object, schema, check, keyObj ) ->
    branch = Type.branchSchema( schema, keyObj )
    for own prop, spec of branch
      if not object[prop]? and Type.isRequired(spec.range)
        check[prop] = {}
        check[prop]['exist'] = false
        check[prop]['specs'] = spec.range if spec.range?

  @isNotOk:( report ) ->
    status  = true
    status &= report['range'] if report['range']?
    status &= report['exist'] if report['exist']?
    status &= report['match'] if report['match']?
    status &= report['enums'] if report['enums']?
    status &= not report['error']?
    status

  @branchSchema:( schema, keyObj, keyVal=null ) ->
    if      schema.schema?
            schema.schema
    else if keyVal? and schema[keyVal]?
            schema[keyVal]
    else if schema[keyObj]?
            schema[keyObj]
    else    schema

  @checkRange:( array, schema ) ->
    n = array.length
    if schema.minmax?
       schema.minmax[0] <= n and n <= schema.minmax[1]
    else if Type.isRequired(schema.range)
      n >  0
    else if Type.notRequired(schema.range)
      n >= 0

  @isRequired:(   range ) ->
    not range? or range is '1' or range is '+'

  @notRequired:( range ) ->
    range? and ( range is '?'  or range is '*' )

  @typeJS:( type ) ->
    switch  type
      when 'number','Int','Float','Currency' then 'number'
      when 'string', 'Date','Id','Enum'      then 'string'
      when 'boolean'                         then 'boolean'
      when 'object', 'Array'                 then 'object'
      when 'function'                        then 'function'
      when 'undefined'                       then 'undefined'
      when 'null'                            then 'null'
      else                                        'undefined'

  # Not complete
  @toValue:( str, type ) ->
    switch type
      when 'number','Int'     then parseInt(   str )
      when 'Float','Currency' then parseFloat( str )
      when 'Date', 'Time'     then Date.parse( str )
      else                         str

  @align:(  type ) ->
    switch  type
      when 'number','Int','Float','Currency' then 'right'
      when 'string','Date','Id','Enum'       then 'left'
      when 'boolean'                         then 'center'
      when 'object', 'Array'                 then 'left'
      when 'function'                        then 'left'
      when 'undefined','null'                then 'left'
      else                                        'center'

  @cell:( value, type ) ->
    switch  type
      when 'number','Int'               then value
      when 'Float','Currency'           then Util.toFixed(value,2)
      when 'string','Date','Id','Enum'  then value
      when 'boolean'                    then value
      when 'object'                     then value
      when 'Array'                      then """[#{value.join(',')}]"""
      when 'function'                   then "function"
      when 'undefined','null'           then ''
      else                                   value

  @toObjType:( obj ) ->
    ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()

  @toClass:( obj ) ->
    if obj.constructor? then obj.constructor.name else 'null'

  # Return and ISO formated data string
  @isoDateString:( date ) ->
    pad = (n) -> if n < 10 then '0'+n else n
    date.getUTCFullYear()  +'-'+pad(date.getUTCMonth()+1)+'-'+pad(date.getUTCDate())+'T'+
    pad(date.getUTCHours())+':'+pad(date.getUTCMinutes())+':'+pad(date.getUTCSeconds())+'Z'

  # Return a number with fixed decimal places
  @toFixed:( arg, dec ) ->
    num = switch typeof(arg)
      when 'number' then arg
      when 'string' then parseFloat(arg)
      else 0
    num.toFixed(dec)

  ###
    where = () -> true
    model = Util.toObjects( model, where, schema.aaa.key )
    Type.checkObject( model, schema, check, key )
  ###