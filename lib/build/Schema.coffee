
Build = require( "js/build/Build" )
#T    = require('js/util/Type')

class Schema

  Build.Schema = Schema
  module.exports = Util.Export(   Schema,      "build/Schema" )
  S = Schema

  # ------ GeoJSON ------

  @Point              : { type:'Array', schema:'Float', range:[2,3] }  # long lat atttitues
  @Polygon            : { type:'Array', schema:Schema.Point      }
  @LineString         : { type:'Array', schema:Schema.Point      }
  @Polygon            : { type:'Array', schema:Schema.Point      }
  @MultiPoint         : { type:'Array', schema:Schema.Point      }
  @MultiLineString    : { type:'Array', schema:Schema.LineString }
  @MultiPolygon       : { type:'Array', schema:Schema.Polygon    }
  @GeometryCollection : { geometries : { type:'Array', schema:Schema.Geometry } } # Forward reference

  @CrsName :
    name: { type:'string' }

  @CrsLink :
    href: { type:'string' }
    type: { type:'string' } # Enum coordinate system

  @Crs :
    type:        { type:'string', Enum:['name',  'link'] }
    properties : { type:'object', schema:[Schema.CrsName,Schema.CrsLink ] }

  @properties :
     ID:   { name:'ID',   type:'Id'     }
     Name: { name:'Name', type:'string' }

  @Geometry :
    type :       { type:'string', Enum:['Point','LineString','Polygon','MultiPoint','MultiLineString','MultiPolygon','GeometryCollection'] }
    coordinates: { type:'Array',  schema:Schema.Polygon }
    #schema: [ Schema.Point, Schema.LineString,   Schema.Polygon,  Schema.MultiPoint,  Schema.MultiLineString,  Schema.MultiPolygon,  Schema.GeometryCollection ]

  @Features :
    type       : { type:'string', Enum:['Feature'] }
    crs        : { type:'object', schema:Schema.Crs, range:'?' }
    bbox       : { type:'Array',  schema:'Float',    range:'?', minmax:[4,4] }
    properties : { type:'object', schema:Schema.properties }  # Properties are user defined
    geometry   : { type:'object', schema:Schema.Geometry   }

  @GeoJSON:
    type       : { type:'string', Enum:['FeatureCollection'] }
    features   : { type:'Array',  schema:Schema.Features }

  Util.GeoJSON  = Schema.GeoJSON

  # ------ GraphJSON ------

  ###

  @GraphJSONs :

    Vertex :
      _id    : { type:'Id' }
      _type  : { type:'Enum', Enum:['vertex'] }
      props  : { type:'object', schema:{} }

    Edge :
      _id    : { type:'Id' }
      _type  : { type:'string', Enum:['edge'] }
      _outV  : { type:'Id' }
      _inV   : { type:'Id' }
      _label : { type:'string' }
      props  : { type:'object', schema:{} }

  @GraphJSON :
    aaa      : { name:'GraphJSON' }
    mode     : { type:'string', Enum:['NORMAL','EMBEDDED','EXTENDED','COMPACT'] }
    vertices : { type:'Array',  schema:@GraphJSONs.Vertex }
    edges    : { type:'Array',  schema:@GraphJSONs.Edge   }

  # ------ Topo D3 ------

  @TopoD3s =

    Node :
      name     : { type:'Id'     }
      #spec    : { type:'string', opt:'?', schema:Schema.Spec }
      type     : { type:'string', opt:'?' }
      size     : { type:'number', opt:'?' }
      depth    : { type:'Int',    opt:'?' }
      parent   : { type:'object', opt:'?', schema:@TopoD3s.Node }
      children : { type:'Array',  opt:'?', schema:@TopoD3s.Node }
      props    : { type:'object', opt:'?', schema:{} }

    Node2 :
      id       : { type:'Id'     }
      name     : { type:'string' }
      type     : { type:'string' }
      depth    : { type:'Int',    opt:'?' }
      value    : { type:'number', opt:'?' }
      size     : { type:'number', opt:'?' } # Check
      x        : { type:'Float',  opt:'?' }
      y        : { type:'Float',  opt:'?' }
      dx       : { type:'Float',  opt:'?' }
      dy       : { type:'Float',  opt:'?' }
      r        : { type:'Float',  opt:'?' }
      parent   : { type:'object', opt:'?', schema:@TopoD3s.Node  }
      children : { type:'Array',  opt:'?', schema:@TopoD3s.Node  }
      props    : { type:'object', opt:'?', schema:{} }

    Link :
      source : { type:'Id'     }
      target : { type:'Id'     }
      name   : { type:'string' }
      type   : { type:'string', opt:'?' }
      value  : { type:'number', opt:'?' }
      props  : { type:'object', opt:'?', schema:{} }

    Force :
      index  : { type:'Id',      abstract:'the zero-based index of the node within the nodes array' }
      x      : { type:'Float',   abstract:'the x-coordinate of the current node position' }
      y      : { type:'Float',   abstract:'the y-coordinate of the current node position' }
      px     : { type:'Float',   abstract:'the x-coordinate of the previous node position' }
      py     : { type:'Float',   abstract:'the y-coordinate of the previous node position' }
      fixed  : { type:'boolean', abstract:'a boolean indicating whether node position is locked' }
      weight : { type:'Int',     abstract:'the node weight; the number of associated links' }

  @TopoD3 :
    aaa      : { name:'TopoD3' }
    nodes    : { type:'Array', schema:@TopoD3s.Node }
    links    : { type:'Array', schema:@TopoD3s.Link }

  # ------ Old Muse Spec ------

  @Muses :

    Spec :
      level  : { type:'Int'    }
      name   : { type:'string' }
      icon   : { type:'string' }
      css    : { type:'string' }
      uc     : { type:'string', opt:'?' } # Unicode
      fill   : { type:'string', opt:'?' }
      code   : { type:'string', opt:'?' }
      j      : { type:'Int',    opt:'?' }
      i      : { type:'Int',    opt:'?' }
      cells  : { type:'Array',  opt:'?', schema:'Int',  minmax:[4,4] }
      pos    : { type:'string', opt:'?', Enum:['NW','N','NE','W','C','E','SW','S','SE']}

  @Muse :
    aaa    : { name:'Muse' }
    type   : 'Array'
    schema :  @Muses.Spec

  ###

