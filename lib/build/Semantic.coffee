
Build = require( "js/build/Build" )
Type  = require( 'js/util/Type'   )

class Semantic

  Build.Semantic = Semantic
  module.exports = Util.Export(   Semantic,  "build/Semantic"  )
  S              = Semantic

  @AxiomMuse   = 'http://axiom6.com/muse/'
  @AxiomSchema = 'http://axiom6.com/schema/'
  @SchemaOrg   = 'http://schema.org/'
  @Foaf        = 'http://xmlns.com/foaf/0.1/'
  @XMLSchema   = 'http://www.w3.org/2001/XMLSchema#'

  @rdf  = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
  @foaf = 'http://xmlns.com/foaf/0.1/'
  @dc   = 'http://purl.org/dc/elements/1.1/'
  @wiki = 'http://en.wikipedia.org/wiki/'

  @Prims = ['Reference','Title','FontAwesomeIcon','FontAwesomeUnicode','Muse.Less','Pallete.Group.Code','UI.Cells',
            'ConveyName','Subject','Predicate','Object','graphLabel']

  # Enummerated Types
  @Enums =
    TypeCategory:      [ "type","prim", "enum", "spec" ]
    Cardinality:       [ '1','?','+','*'] # 1 = One Default ? = Zero or 1 Optional + = One or Many * Zero or Many
    Inquisitive:       [ "When", "Who",   "How",      "What", "Where",   "Why"        ]
    ZachmanDimension:  [ "Time", "People","Function", "Data", "Network", "Motivation" ]
    ZachmanPerspecive: [ "Planner", "Owner","System", "Designer", "Contractor","Function" ]
    CynefinDomain:     [ "Simple","Complicated", "Complex",   "Chaotic" ]
    MatterPhase:       [ "Solid", "Liquid",      "Crystal",   "Gas"     ]
    WaterPhase:        [ "Ice",   "Water",       "Snowflake", "Vapor"   ]
    FAB:               [ "Feature", "Advantage", "Benefit"  ]
    Goal:              [ "Tactics", "Execute",   "Strategy" ]
    Pos:               [ "NW","N","NE","W","C","E","SW","S","SE"]
    BMG:               [ "Partner","Activity","Resources","Cost","Proposition","Customer","Relate","Channel","Revenue"]
    FEAReferenceModel: [ "BRM","ARM","ARM/Apps","ARM/System","DRM","IRM","SRM","PRM"]
    NavbType:          ["NavBarLeft","NavBarRight","NavBarEnd","Item","Dropdown","FileInput","Search","Contact","SignOn"]
    Tag:               ["!DOCTYPE","text","comment","html","head","title","base","link","meta","style","script","noscript",
                        "body","section","nav","article","aside","h1","h2","h3","h4","h5","h6","footer","address","main",
                        "p","hr","pre","blockquote","ol","ul","li","dl","dt","dd","figure","figcaption","div",
                        "a","em","strong","small","s","cite","q","dfn","abbr","data","time","code","var","samp","kbd",
                        "sub","sup","i","b","u","mark","ruby","rt","rp","bdi","bdo","span","br","wbr",
                        "ins","del","img","iframe","embed","object","param","video","audio","track","canvas","map","area","svg","math",
                        "table","caption","colgroup","col","tbody","thead","tfoot","tr","td","th",
                        "form","fieldset","legend","label","input","button","select","datalist","optgroup","option","textarea",
                        "keygen","output","progress","meter","details","summary","menuitem","menu",
                        "content","decorator","element","shadow","template"]
    OldTag:             ["acromym","address","basefont","bgsound","big","blink","center","dir","frame","frameset","hgroup",
                         "isindex","listing","marquee","nobr","noframes","plaintext","spacer","strike","tt","xmp"]

  @Specs = [ 'References', 'Dimensions', 'Perspectives', 'Planes', 'Columns', 'Rows',
             'Practices',  'Studys',     'Conveys',      'Flows',  'Links',   'Conduits',
             'NavbSpecs',  'NavbItems' ]

  @isType:( prop ) -> Type.isType(prop)
  @isPrim:( prop ) -> S.Prims.indexOf(prop) isnt -1
  @isEnum:( prop ) -> S.Enums.indexOf(prop) isnt -1
  @isSpec:( prop ) -> S.Specs.indexOf(prop) isnt -1

  @toRdfType:(    dir, decl, cardinality='1' ) -> S.toTypeLD( S.rdf,    dir,    decl, cardinality ) # Schema.org
  @toSchemaType:( dir, decl, cardinality='1' ) -> S.toTypeLD( S.SchemaOrg,    dir,    decl, cardinality ) # Schema.org
  @toFoafType:(   dir, decl, cardinality='1' ) -> S.toTypeLD( S.Foaf,         dir,    decl, cardinality ) # FOAF
  @toXSDType:(    dir, decl, cardinality='1' ) -> S.toTypeLD( S.XMLSchema,    dir,    decl, cardinality ) # XML Schema

  @toTypeType:(        decl, cardinality='1' ) -> S.toTypeLD( S.AxiomSchema, 'type/', decl, cardinality )
  @toPrimType:(        decl, cardinality='1' ) -> S.toTypeLD( S.AxiomSchema, 'prim/', decl, cardinality )
  @toEnumType:(        decl, cardinality='1' ) -> S.toTypeLD( S.AxiomSchema, 'enum/', decl, cardinality )
  @toSpecType:(        prop, cardinality='1' ) -> S.toTypeLD( S.AxiomSchema, 'spec/', prop, cardinality )

  @toIdLD:(   uri, dir, prop      ) -> "#{uri}#{dir}#{prop}"
  @toTypeLD:( uri, dir, decl      ) -> "#{uri}#{dir}#{decl}"  # , cardinality='1'
  @toPropLD:( prop, toId, toType  ) -> { "@id":"#{toId}", "@type":"#{toType}" }

  @rdf:      ( prop, dir='', decl='string', cardinality='1' ) -> S.toPropLD( prop, S.toIdLD( S.rdf,          dir,    prop ), S.toRdfType(  dir, decl,cardinality) )
  @schemaOrg:( prop, dir='', decl='string', cardinality='1' ) -> S.toPropLD( prop, S.toIdLD( S.SchemaOrg,    dir,    prop ), S.toSchemaType(  dir, decl,cardinality) )
  @foafOrg:(   prop, dir='', decl='string', cardinality='1' ) -> S.toPropLD( prop, S.toIdLD( S.Foaf,         dir,    prop ), S.toFoafType(    dir, decl,cardinality) )
  @xmlSchema:( prop, dir='', decl='string', cardinality='1' ) -> S.toPropLD( prop, S.toIdLD( S.XMLSchema,    dir,    prop ), S.toXSDType(     dir, decl,cardinality) )

  @axiomType:( prop, cardinality='1', decl='string' ) -> S.toPropLD( prop, S.toIdLD( S.AxiomSchema, 'type/', prop ), S.toTypeType(         decl,cardinality) )
  @axiomPrim:( prop, cardinality='1', decl='string' ) -> S.toPropLD( prop, S.toIdLD( S.AxiomSchema, 'prim/', prop ), S.toPrimType(         decl,cardinality) )
  @axiomEnum:( prop, cardinality='1', decl='string' ) -> S.toPropLD( prop, S.toIdLD( S.AxiomSchema, 'enum/', prop ), S.toEnumType(         decl,cardinality) )
  @axiomSpec:( prop, cardinality='1'                ) -> S.toPropLD( prop, S.toIdLD( S.AxiomSchema, 'kind/', prop ), S.toSpecType(         prop,cardinality) )

  # ------ App.Spec Schemas ------

  @QuadRdf =
    "subject":    S.rdf('subject')
    "predicate":  S.rdf('predicate')
    "object":     S.rdf('object')
    "graphLabel": S.rdf('graphLabel','','','?')

  @Quad =
    "subject":    S.axiomPrim('Subject',    '1' )
    "predicate":  S.axiomPrim('Predicate',  '1' )
    "object":     S.axiomPrim('Object',     '1' )
    "graphLabel": S.axiomPrim('GraphLabel', '?' )

  @Elem =
    "level": S.axiomType('Level', '1', 'Int'    )
    "tag":   S.axiomEnum('Tag',   '1', 'string' )
    "atts":  S.axiomType('Atts',  '?', 'object' )
    "text":  S.axiomType('Text',  '?', 'string' )
    "quad":  S.axiomSpec('Quad',  '?' )

  @References =
    "name":  S.axiomPrim('Reference')
    "title": S.axiomPrim('Title')
    "url":   S.schemaOrg('url')

  @Dimensions =
    "inquisitive": S.axiomEnum('Inquisitive')
    "zachman":     S.axiomEnum('ZachmanDimension')
    "column":      S.axiomSpec('Columns')

  @Perspectives =
    "zachman": S.axiomEnum('ZachmanPerspecive')
    "row":     S.axiomSpec('Rows')

  @Planes =
    "icon":    S.axiomPrim('FontAwesomeIcon')
    "matter":  S.axiomEnum('MatterPhase')
    "water":   S.axiomEnum('WaterPhase')
    "cynefin": S.axiomEnum('CynefinDomain')

  @Columns =
    "icon":       S.axiomPrim('FontAwesomeIcon')
    "css":        S.axiomPrim('Muse.Less')
    "cells":      S.axiomPrim('UI.Cells')
    "fill":       S.axiomPrim('Pallete.Group.Code')
    "fab":        S.axiomEnum('FAB')
    "goal":       S.axiomEnum('Goal')
    "dimensions": S.axiomEnum('ZachmanDimension','+')

  @Rows =
    "icon":         S.axiomPrim('FontAwesomeIcon')
    "css":          S.axiomPrim('Muse.Less')
    "cells":        S.axiomPrim('UI.Cells')
    "fill":         S.axiomPrim('Pallete.Group.Code')
    "perspectives": S.axiomEnum('ZachmanPerspective','+' )

  @Practices =
    "column":       S.axiomSpec('Columns')
    "row":          S.axiomSpec('Rows')
    "plane":        S.axiomSpec('Plane')
    "icon":         S.axiomPrim('FontAwesomeIcon')
    "css":          S.axiomEnum('Muse.Less')
    "cells":        S.axiomPrim('UI.Cells')
    "fill":         S.axiomPrim('Pallete.Group.Code')
    "pos":          S.axiomEnum('Pos')

  @Studys =
    "practice":     S.axiomSpec('Practices')
    "dimension":    S.axiomEnum('ZachmanDimension')
    "icon":         S.axiomPrim('FontAwesomeIcon')
    "css":          S.axiomEnum('Muse.Less')
    "uc":           S.axiomPrim('FontAwesomeUnicode')
    "fill":         S.axiomPrim('Pallete.Group.Code')
    "reference":    S.axiomSpec('References')
    "bmg":          S.axiomEnum('BMG','?')
    "rm":           S.axiomEnum('FEAReferenceModel','?')

  @Conveys =
    "name":   S.axiomPrim('ConveyName')
    "source": S.axiomSpec('Practices')
    "target": S.axiomSpec('Practices')
    "links":  S.axiomSpec('Links','+')

  @Flows =
    "name":   S.axiomPrim('FlowName')
    "source": S.axiomSpec('Practices')
    "target": S.axiomSpec('Practices')
    "links":  S.axiomSpec('Links','+')

  @Conduits =
    "pos":         S.axiomEnum('Pos')
    "information": S.axiomSpec('Practices')
    "knowledge":   S.axiomSpec('Practices')
    "wisdom":      S.axiomSpec('Practices')

  @Links =
    "name":   S.axiomPrim('LinkName')
    "source": S.axiomSpec('Studys')
    "target": S.axiomSpec('Studys')

  @NavbSpecs =
    "type":    S.axiomEnum('NavbType')
    "name":    S.schemaOrg('name','?')
    "icon":    S.axiomPrim('FontAwesomeIcon','?')
    "topic":   S.schemaOrg('name','?')
    "subject": S.schemaOrg('name','?')
    "size":    S.xmlSchema('positiveInteger','?')
    "items":   S.axiomSpec('NavbItems','*')

  @NavbItems =
    "type":    S.axiomEnum('NavbType')
    "name":    S.schemaOrg('name')
    "topic":   S.schemaOrg('name')
    "subject": S.schemaOrg('name')






