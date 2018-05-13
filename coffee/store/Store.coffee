
class Store

  module.exports  = Store
  #Store.Memory    = require( 'js/store/Memory'    )
  #Store.IndexedDB = require( 'js/store/IndexedDB' )
  #Store.Rest      = require( 'js/store/Rest'      )
  #Store.Firebase  = require( 'js/store/Firebase'  )
  #Store.PouchDB   = require( 'js/store/PouchDB'   )

  @memories  = {} # Store.Memory instances create by getMemory() for in memory dbName
  @databases = {} # Set by Store.Memory as Store.databases[dbName].tables for 

  # CRUD        Create    Retrieve  Update    Delete
  @restOps  = [ 'add',    'get',    'put',    'del'    ]
  @sqlOps   = [ 'insert', 'select', 'update', 'remove' ]
  @tableOps = [ 'open',   'show',   'make',   'drop'   ]

  @isRestOp:(  op ) -> Store. restOps.indexOf(op) isnt -1
  @isSqlOp:(   op ) -> Store.  sqlOps.indexOf(op) isnt -1
  @isTableOp:( op ) -> Store.tableOps.indexOf(op) isnt -1

  @methods = Store.restOps.concat( Store.sqlOps ).concat( Store.tableOps ).concat(['onChange'])

  # Dafaults for empty arguments
  @where  = () -> true # Default where clause filter that returns true to access all records
  @schema = {}         # Default schema      for open()
  @format = {}         # Default format      for show()
  @alters = {}         # Default alterations for make()
  @resets = {}         # Default resets      for drop()
  W       = Store.where
  S       = Store.schema
  F       = Store.format
  A       = Store.alters
  R       = Store.resets

  # @uri = REST URI where the file part is the database
  # @key = The key id property = default is ['id']
  constructor:( @stream, @uri, @module ) ->
    @key       = 'id'
    @dbName    = Store.nameDb( @uri )
    @tables    = {}
    @hasMemory = false

  # REST Api  CRUD + Subscribe for objectect records
  add:( table, id, object )  -> Util.noop(  table, id, object )  # Post    Create   an object into table with id
  get:( table, id )          -> Util.noop(  table, id         )  # Get     Retrieve an object from table with id
  put:( table, id, object )  -> Util.noop(  table, id, object )  # Put     Update   an object into table with id
  del:( table, id )          -> Util.noop(  table, id         )  # Delete  Delete   an object from table with id

  # SQL Table DML (Data Manipulation Language) with multiple objects (rows)
  insert:( table, objects ) -> Util.noop( table, objects )  # Insert objects into table with unique id
  select:( table, where=W ) -> Util.noop( table, where   )  # Select objects from table with where clause
  update:( table, objects ) -> Util.noop( table, objects )  # Update objects into table mapped by id
  remove:( table, where=W ) -> Util.noop( table, where   )  # Delete objects from table with where clause

  # Table DDL (Data Definition Language)
  open:( table, schema=S ) -> Util.noop( table, schema ) # Create a table with an optional schema
  show:( table, format=F ) -> Util.noop( table, format ) # Show a list tables if table name blank or columns
  make:( table, alters=A ) -> Util.noop( table, alters ) # Alter a table's schema - especially columns
  drop:( table, resets=R ) -> Util.noop( table, resets ) # Drop the entire @table - good for testing

  # Subscribe to CRUD changes on a table or an object with id
  onChange:( table, id='' ) ->
    Util.noop( table, id )
    return

  createTable:( t  ) ->
    @tables[t] = {}
    @tables[t]

  table:( t ) ->
    if @tables[t]? then @tables[t] else @createTable( t )

  tableName:( t ) ->
     name  = Util.firstTok(t,'.') # Strips off  .json .js .csv file extensions
     table = @table( name )
     Util.noop( table )
     name

  memory:( table, id , op ) ->
    # Util.log( 'Store.memory()', @toSubject(table,op,id) )
    onNext = (data) => @toMemory(  op, table, id, data )
    @stream.subscribe( @toSubject(table,op,id), onNext, @onError, @onComplete )
    return

  subscribe:( table, id ,op, onNext  ) ->
    # Util.log( 'Store.subscribe()', @toSubject(table,op,id) )
    @stream.subscribe( @toSubject(table,op,id), onNext, @onError, @onComplete )
    return

  publish:( table, id, op, data, extras={} ) ->
    params = @toParams(table,id,op,extras)
    @toMemory( op, table, id, data, params ) if @hasMemory
    @stream.publish( @toSubject(table,op,id), data )
    return

  onerror:( table, id, op, result={}, error={} ) ->
    console.log( 'Stream.onerror', { db:@dbName, table:table, id:id, op:op, result:result, error:error } )
    #@stream.onerror( @toSubject(table,op,id), @toStoreObject( @toParams(table,id,op,extras),result ) )
    return

  # params=Store provides empty defaults
  toMemory:( op, table, id, data, params=Store ) ->
    memory = @getMemory( @dbName )
    switch op
      when 'add'    then memory.add(    table, id, data )
      when 'get'    then memory.add(    table, id, data )
      when 'put'    then memory.put(    table, id, data )
      when 'del'    then memory.del(    table, id )
      when 'insert' then memory.insert( table, data )
      when 'select' then memory.insert( table, data )
      when 'update' then memory.update( table, data )
      when 'remove' then memory.remove( table, params.where  )
      when 'open'   then memory.open(   table, params.schema )
      when 'show'   then memory.show(   table, params.format )
      when 'make'   then memory.make(   table, params.alters )
      when 'drop'   then memory.drop(   table, params.resets )
      else Util.error( 'Store.toMemory() unknown op', op )
    return

  getMemory:() ->
    @hasMemory = true
    Store.memories[@dbName] = new Store.Memory( @stream, @dbName ) if Store.Memory? and not Store.memories[@dbName]?
    Store.memories[@dbName]

  getMemoryTables:() ->
    @getMemory().tables
    
  remember:() ->
    Util.noop( @getMemory(@dbName) )
    return

  toSubject:( table='none', op='none', id='none' ) ->
    subject  = "#{@dbName}"
    subject += "/#{table}"     if table isnt 'none'
    subject += "/#{id}"        if id    isnt 'none'
    subject += "?module=#{@module}"
    subject += "&op=#{op}"     if op    isnt 'none'
    # Util.log( 'Store.toSubject', subject )
    subject

  toSubjectFromParams:( params ) ->
    @toSubject( params.table, params.op, params.id )

  toParams:( table, id, op, extras ) ->
    params = { db:@dbName, table:table, id:id, op:op, module:@module }
    Util.copyProperties( params, extras )

  # Combine params and result
  toStoreObject:( params, result ) ->
    { params:params, result:result }

  fromStoreObject:( object ) ->
    [object.params,object.result]

  # ops can be single value. ids can be an array for single record ops
  toSubjects:( tables, ops, ids ) ->
    array = []
    for i in [0...tables.length]
      elem = {}
      elem.table = tables[i]
      elem.op    = if Util.isArray(ops) then ops[i] else ops
      elem.id    = if Util.isArray(ids) then ids[i] else 'none'
      array.push( elem )
    array

  completeSubjects:( array, completeOp, onComplete ) ->
    subjects = []
    for elem in array
      op  = if elem.op? then elem.op else 'none'
      id  = if elem.id? then elem.id else 'none'
      sub = @toSubject( elem.table, op, id )
      subjects.push( sub )
    completeSubject = "#{@dbName}?module=#{@module}&op=#{completeOp}"
    callback = if typeof onComplete is 'function' then () => onComplete() else true  
    @stream.complete( completeSubject, subjects, callback )

  # ops can be single value.  
  uponTablesComplete:( tables, ops, completeOp, onComplete ) ->
    subjects = @toSubjects( tables, ops, 'none' )
    @completeSubjects( subjects, completeOp, onComplete )
    return

  toKeys:( object ) ->
    keys = []
    for own key, obj of object
      keys.push(key)
    keys

  toJSON:(     obj  ) -> if obj? then JSON.stringify(obj) else ''

  toObject:(   json ) -> if json then JSON.parse(json) else {}

  toKeysJson:( json ) -> @toKeys( JSON.parse(json) )

  toObjectsJson:( json, where ) -> Util.toObjects( JSON.parse(json), where, @key )

  onError2:( error ) -> Util.error( 'Store.onError()', error.params, error.result )

  onComplete:()      -> Util.log(   'Store.onComplete()', 'Completed' )

  toExtras:( status, url, datatype, readyState=null, error=null ) ->
    extras = { status:status, url:url, datatype:datatype, readyState:readyState, error:error }
    extras['readyState'] = readyState if readyState?
    extras['error']      = error      if error?
    extras

  dataType:() ->
    parse = Util.parseURI( @uri )
    if parse.hostname is 'localhost' then 'json' else 'jsonp'

  # ---- Class Methods ------

  @nameDb:( uri ) -> Util.parseURI( uri ).dbName

  @requireStore:( module ) ->
    Store = null
    try
      Store = require( 'js/store/'+module )
    catch e
      Util.error( 'Store.requireStore( stream, uri, module) can not find Store module for', module )
    Store

  @createStore:( stream, uri, module ) ->
    store = null
    Klazz = Store.requireStore( module )
    store = new Klass( stream, uri, module ) if Klazz?
    store
