
class Persist

  module.exports = Persist # Util.Export( Persist, 'Muse.Persist' )

  constructor:( @stream ) ->
    @Database = require( 'js/store/Database' )
    #@persistIDX( 'select' )

    @subscribe()

  subscribe:() ->
    @stream.subscribe( 'Test', (topic) => @onTest(topic) )

  onTest:( topic ) ->
    switch topic
      when 'Rest'      then @rest()
      when 'Memory'    then @memFromLocal('muse')
      when 'IndexedDb' then @persistIDX( 'select', 'muse' )
    return

  rest:() ->
    for own key, database of @Database.Databases
      @persistRest( database )

  persistRest:( database ) ->
    Rest     = Util.Import( 'store/Store.Rest' )
    rest     = new Rest( @stream, database.uriLoc )
    rest.key = database.key if database.key?
    tables   = database.tables
    rest.remember()
    onRestComplete = (objects) ->
      Util.noop( objects )
      Util.log( 'Persist.onRestComplete()', rest.dbName )
      memory = rest.getMemory()
      memory.exportLocalStorage()
      memory.exportIndexedDb()
      return
    rest.uponTablesComplete( tables, 'select', 'complete', (objects) => onRestComplete(objects) )
    for table in tables
      rest.select( table+'.json' )
    return

  memFromLocal:( database ) ->
    Memory  = Util.Import( 'store/Store.Memory' )
    @memory = new Memory(  @stream, database.uriLoc )
    @memory.importLocalStorage( database.tables )
    return

  persistIDX:( op, database ) ->
    IndexedDB  = Util.Import( 'store/Store.IndexedDB' )
    @indexedDB = new IndexedDB(  @stream, database.id, 1, database.tables )
    switch op
      when 'insert'
        @indexedDB.deleteDatabase( database.id )
        @indexedDB.subscribe( 'none', 'none', 'open', (object) => @insertIDB(object) )
      when 'select'
        @indexedDB.subscribe( 'none', 'none', 'open', (object) => @selectIDB(object) )
    @indexedDB.openDatabase()
    return

  insertIDB:( tables ) ->
    @indexedDB.remember()
    @indexedDB.uponTablesComplete( tables, 'insert', 'complete', (objects) => @onCompleteIDBInsert(objects) )
    Util.log( 'insertIDB', tables )
    for name in tables
      @indexedDB.insert( name, 'Muse' ) # build.name
    return

  selectIDB:( tables ) ->
    @indexedDB.remember()
    @indexedDB.uponTablesComplete( tables, 'select', 'complete', (objects) => @onCompleteIDBSelect(objects) )
    for table in tables
      @indexedDB.select( table )
    return

  onCompleteIDBInsert:( objects ) ->
    Util.noop( objects )
    Util.log( 'Persist.onCompleteIDBInsert' )

  onCompleteIDBSelect:( objects ) ->
    Util.noop( objects )
    Util.log( 'Persist.onCompleteIDBSelect' )
