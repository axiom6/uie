
Store = require( 'js/store/Store' )

class IndexedDB extends Store

  module.exports = IndexedDB # Util.Export( IndexedDB, 'store/IndexedDB' )

  constructor:( stream, uri, @dbVersion=1, @tableNames=[] ) ->
    super( stream, uri, 'IndexedDB' )
    @indexedDB = window.indexedDB # or window.mozIndexedDB or window.webkitIndexedDB or window.msIndexedDB
    Util.error( 'Store.IndexedDB.constructor indexedDB not found' ) if not @indexedDB
    @dbs       = null

  add:( t, id, object ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( tableName, "readwrite" )
    req = txo.add( obj, id )
    req.onsuccess = () => @publish( tableName, id, 'add', object )
    req.onerror   = () => @onerror( tableName, id, 'add', object, { error:req.error } )
    return

  get:( t, id ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( tableName, "readonly" )
    req = txo.get(id) # Check to be sre that indexDB understands id
    req.onsuccess = () => @publish( tableName, id, 'get', req.result )
    req.onerror   = () => @onerror( tableName, id, 'get', req.result, { error:req.error } )
    return

  put:( t, id, object ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( tableName, "readwrite" )
    req = txo.put(object) # Check to be sre that indexDB understands id
    req.onsuccess = () => @publish( tableName, id, 'put', object )
    req.onerror   = () => @onerror( tableName, id, 'put', object, { error:req.error } )
    return

  del:( t, id ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( tableName, "readwrite" )
    req = txo['delete'](id) # Check to be sre that indexDB understands id
    req.onsuccess = () => @publish( tableName, id, 'del', req.result )
    req.onerror   = () => @onerror( tableName, id, 'del', req.result, { error:req.error } )
    return

  insert:( t, objects ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( t, "readwrite" )
    for own key, object of objects
      object = @idProp( key, object, @key )
      txo.put(object)
    @publish( tableName, 'none', 'insert', objects )
    return

  select:( t, where=Store.where ) ->
    tableName = @tableName(t)
    @traverse( 'select', tableName, where )
    return

  update:( t, objects ) ->
    tableName = @tableName(t)
    txo = @txnObjectStore( t, "readwrite" )
    for own key, object of objects
      object = @idProp( key, object, @key )
      txo.put(object)
    @publish( tableName, 'none', 'update', objects )
    return

  remove:( t, where=Store.where ) ->
    tableName = @tableName(t)
    @traverse( 'remove', tableName, where )
    return

  open:( t, schema ) ->
    tableName = @tableName(t)
    # No real create table in IndexedDB so publish success
    @publish( tableName, 'none', 'open', {}, { schema:schema } )
    return

  show:( t ) ->
    tableName = @tableName(t)
    @traverse( 'show', tableName, objects, where, false )
    return

  make:( t, alters ) ->
    tableName = @tableName(t)
    @publish( tableName, 'none', 'make', {}, { alters:alters } )
    return

  drop:( t ) ->
    tableName = @tableName(t)
    @dbs.deleteObjectStore(t)
    @publish( tableName, 'none', 'drop' )
    return

  # Subscribe to  a table or object with id
  onChange:(  t, id='none'   ) ->
    tableName = @tableName(t)
    @onerror( tableName, id, 'onChange', {}, { msg:"onChange() not implemeted by Store.IndexedDb" } )
    return

  # IndexedDB Specifics

  idProp:( id, object, key ) ->
    object[key] = id if not object[key]?
    object

  txnObjectStore:( t, mode, key=@key ) ->
    txo = null
    if not @dbs?
      Util.trace( 'Store.IndexedDb.txnObjectStore() @dbs null' )
    else if @dbs.objectStoreNames.contains(t)
      txn = @dbs.transaction( t, mode )
      txo = txn.objectStore(  t, { keyPath:key } )
    else
      Util.error( 'Store.IndexedDb.txnObjectStore() missing objectStore for', t )
    txo

  traverse:( op, t, where ) ->
    mode = if op is 'select' then 'readonly' else 'readwrite'
    txo  = @txnObjectStore( t, mode )
    req  = txo.openCursor()
    req.onsuccess = ( event ) =>
      objects = {}
      cursor = event.target.result
      if cursor?
        objects[cursor.key] = cursor.value if op is 'select' and where(cursor.value)
        cursor.delete()                    if op is 'remove' and where(cursor.value)
        cursor.continue()
      @publish( t, 'none', op, objects,   { where:'all' } )
    req.onerror   = () =>
      @onerror( t, 'none', op, {}, { where:'all', error:req.error } )
    return

  createObjectStores:() ->
    if @tableNames?
      for t in @tableNames when not @dbs.objectStoreNames.contains(t)
        @dbs.createObjectStore( t, { keyPath:@key } )
    else
      Util.error( 'Store.IndexedDB.createTables() missing @tableNames' )
    return

  openDatabase:() ->
    request = @indexedDB.open( @dbName, @dbVersion ) # request = @indexedDB.IDBFactory.open( database, @dbVersion )
    request.onupgradeneeded = ( event ) =>
      @dbs = event.target.result
      @createObjectStores()
      Util.log( 'Store.IndexedDB', 'upgrade', @dbName, @dbs.objectStoreNames )
    request.onsuccess = ( event ) =>
      @dbs = event.target.result
      Util.log( 'Store.IndexedDB', 'open',    @dbName, @dbs.objectStoreNames )
      @publish( 'none', 'none', 'open', @dbs.objectStoreNames )
    request.onerror   = () =>
      Util.error( 'Store.IndexedDB.openDatabase() unable to open', { database:@dbName, error:request.error } )
      @onerror( 'none', 'none', 'open', @dbName, { error:request.error } )

  deleteDatabase:( dbName ) ->
    request = @indexedDB.deleteDatabase(dbName)
    request.onsuccess = () =>
      Util.log(   'Store.IndexedDB.deleteDatabase() deleted',          { database:dbName } )
    request.onerror   = () =>
      Util.error( 'Store.IndexedDB.deleteDatabase() unable to delete', { database:dbName, error:request.error } )
    request.onblocked = () =>
      Util.error( 'Store.IndexedDB.deleteDatabase() database blocked', { database:dbName, error:request.error } )

  close:() ->
    @dbs.close() if @dbs?