

Pouch = require( 'pouchdb'        )
Store = require( 'js/store/Store' )

class PouchTID extends Store

  module.exports = Util.Export( PouchTID, 'store/PouchTID' )

  @CouchDBHost    = 'http://127.0.0.1:5984/'
  @CouchDBLocal   = 'http://localhost:5984/'
  @CouchDBLocalUI = 'http://127.0.0.1:5984/_utils/database.html'
  @pouchTIDOptions = { adapter:'http', ajax:{ headers:{ 'Access-Control-Allow-Origin':''}}}

  constructor:( stream, uri=PouchTID.CouchDBHost  ) ->
    super( stream, uri, 'PouchTID' )
    @key       = '_id' # CouchDB Id - important
    @pouch = new Pouch( @uri )

  tid:( t, id, object=null ) ->
    tblId = if Util.isStr(id) and id isnt 'none' then t+'_'+id else t
    object['_id'] = tblId if object?
    tblId

  add:( t, id, object ) ->
    @tid(t,id,object)
    @pouch.post( object  )
    .then(  (obj) => @publish( t, id, 'add', obj,        ) )
    .catch( (err) => @onerror( t, id, 'add', object, err ) )
    return

  get:( t, id ) ->
    @pouch.get( @tid(t,id) )
    .then(  (obj) => @publish( t, id, 'get', obj     ) )
    .catch( (err) => @onerror( t, id, 'get', {}, err ) )
    return

  put:(   t, id, object ) ->
    @tid( t, id, object )
    @pouch.put( object )
    .then(  (obj) => @publish( t, id, 'put', obj         ) )
    .catch( (err) => @onerror( t, id, 'put', object, err ) )
    return

  del:( t, id ) ->
    @pouch.get( @tid(t,id) )
    .then( (obj) =>
      obj['_deleted'] = true
      console.log( 'PouchTID.del get obj', obj )
      @pouch.put( obj )
      .then(  (obj) => @publish( t, id, 'del', obj      ) )
      .catch( (err) => @onerror( t, id, 'del', obj, err ) ) )
    .catch( (err) => @onerror( t, id, 'del', {msg:'Unable to get doc'},  err,    ) )
    return

# Right now same as update, objects without _rev will be inserted
  insert:( t, objects ) ->
    docs = @toArray( t, objects, Store.where )
    @pouch.bulkDocs( docs )
    .then(  (res) => @publish( t, 'none', 'insert', objects, res ) )
    .catch( (err) => @onerror( t, 'none', 'insert', objects, err ) )
    return

  select:( t, where=Store.where ) ->
    @pouch.allDocs( { include_docs:true } )
    .then(  (res) =>
      objects = @toObjects( t, res.rows, where )
      @publish( t, 'none', 'select', objects  ) )
    .catch( (err)  =>
      @onerror( t, 'none', 'select', {}, err  ) )
    return

# Right now same as insert except objects with  _rev will be updated
  update:( t, objects ) ->
    docs = @toArray( t, objects, Store.where )
    @pouch.bulkDocs( docs )
    .then(  (res) => @publish( t, 'none', 'update', objects, {   res:res } ) )
    .catch( (err) => @onerror( t, 'none', 'update', objects, err ) )
    return

# Modified remove API with additional objects arg
  remove:( t, objects, where=Store.where ) ->
    docs = @toArray( t, objects, where, true )
    @pouch.bulkDocs( docs )
    .then(  (res) => @publish( t, 'none', 'remove', objects, { where:where.toString(),   res:res } ) )
    .catch( (err) => @onerror( t, 'none', 'remove', objects, err ) )
    return

  open:( t, schema ) ->
# @pouch
    @publish( t, 'none', 'open', {}, { schema:schema } )
    return

  show:( t ) ->
    @pouch.allDocs( { include_docs:true } )
    .then(  (rows) =>
      array = @toArray( rows )
      @publish( t, 'none', 'show', array, { rows:rows } ) )
    .catch( (err)  =>
      @onerror( t, 'none', 'show', {}, err ) )
    return

  make:( t, alters ) ->
# @pouch
    @publish( t, 'none', 'open', {}, { alters:alters } )
    return

  drop:( t ) ->
    @pouch.destroy( t )
    .then(  (info)  => @publish( t, 'none', 'open', {}, { info:info   } ) )
    .catch( (error) => @onerror( t, 'none', 'open', {}, error ) )
    return

# Subscribe to  a table. Note: PouchTID can not subscript to objecst with id
  onChange:( t,  id=''   ) ->
    @pouch.changes( { include_docs:true } )
    .on( 'change', (changes) => @publish( t, 'none', 'onChange', {}, changes     ) )
    .on( 'error',  (error)   => @onerror( t, 'none', 'onChange', {}, error:error ) )
    return

  toArray:( t, objects, whereIn=null, del=false ) ->
    where = if whereIn? then whereIn else () -> true
    array = []
    if Util.isArray(objects)
      for object in array  when where(object)
        @tid( t, object.id, object )
        doc['_deleted'] = true if del
        array.push( object )
    else
      for own key, object of objects when where(object)
        @tid( t, key, object )
        array.push(object)
    array

  toObjects:( t, rows, whereIn, del=false ) ->
    where = if whereIn? then whereIn else () -> true
    objects = {}
    if Util.isArray(rows)
      for row in rows when where(row)
        @tid( t, row.id, row )
        row['_deleted'] = true if del
        objects[t] = row
    else
      for key, row of rows when where(row)
        @tid( t, key, row )
        row['_deleted'] = true if del
        objects[t]  = row
    objects

