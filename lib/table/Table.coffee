
class Table

  #Util.dependsOn('js/util/Type')
  module.exports = Util.Export( Table, 'table/Table'  )
  Table.modules = ['Table.Col','Table.Html','Table.Model','Table.Page','Table.View']
  Util.loadModules( 'js/', 'table/', Table.modules )

  @css = {     # fa fa-sort
    table:'table-table', form:'table-form', thScroll:'table-th-scroll',
    thead:'table-thead', th:'table-th', faUnsort:'fa fa-sort',
    trLoad:'table-tr-load',     thLoad:'table-th-load', tdLoad:'table-td-load', dataLoadId:'data-loadId',
    filterTR:'table-tr-filter', filterTH:'table-th-filter', filterDIV:'table-div-filter', filterINPUT:'table-input-filter'
    tbody:'table-tbody', tr:'table-tr',  trOBJ:'table-tr-obj', even:'table-even', odds:'table-odds',
    td:'table-td', tdOBJ:'table-td-obj',
    pageUp:'fa fa-chevron-circle-left  table-th-page-up',
    pageDn:'fa fa-chevron-circle-right table-th-page-dn',
    pageNum:'table-th-page-num', pageBeg:'table-th-page-beg',   pageTo:'table-th-page-to'
    pageEnd:'table-th-page-end', pageOver:'table-th-page-over', pageTot:'table-th-page-tot',
    trGroup:'table-tr-group', tdGroup:'table-td-group',
    tfoot:'table-tfoot' }

  Table.options = { rowIsObject:true, borders:true, filters:true } # Default table options

  constructor:( @name, @parentId, cols, @options=Table.options ) ->
    [@cols,@propId,@indexId] = @createCols(  cols )
    @htmlId = Util.htmlId('Table','Table')

  doData:( objs ) ->
    @check      = Table.Col.Type.checkStart( objs, @toSchema(), @name )
    #Util.log( 'Table.doData.check', @check )
    @array      = @createArray( objs )
    @hasGroup   = false
    @css        = Table.css
    @html       = new Table.Html(  @ )
    @model      = new Table.Model( @ )
    @page       = new Table.Page(  @ )
    @view       = new Table.View(  @ )
    @groupProps = [] # ['grade','angle']
    window.onresize = @view.resize
    $('#'+@parentId).append( @thtml() )
    @ready()

  toSchema:() ->
    schemaRow = {}
    schemaTbl = { type:'Array', range:'+', schema:schemaRow }
    for col in @cols
      schemaCol           = {}
      schemaCol.type      = col.type # scheme.width = col.size scheme.key   = col.prop # scheme.name  = col.title
      schemaRow[col.prop] = schemaCol
    # Util.log( 'Table.toSchema()', schemaTbl )
    schemaTbl

  createArray:( objs ) ->
    array = []
    index = 0
    if Util.isArray(objs)
      for obj in objs
        row  = @createRow( obj, @objId(obj), index )
        array.push( row )
        index++
    else
      for own key, obj of objs
        row  = @createRow( obj, key, index )
        array.push( row )
        index++
    array

  createRow:( obj, id, index ) ->
    for col in @cols
      obj[col.prop] = col.calc(obj) if Util.isFunc(col.calc)
    row = {}
    row.obj      = obj;   row.id      = id;     row.index    = index;
    row.$row     = $();   row.$load   = $();    row.$group   = $();
    row.sortVal  = '';    row.$loadOn = false;  row.$groupOn = false;
    row.filtered = false; row.visible = true;
    row

  resize:( pane ) ->
    Util.noop( pane )
    @view.resize() if @view?
    return

  thtml:() ->
    @html.thtml()

  objId:( row ) ->
    if  @options.rowIsObject then row.obj[@propId] else row.obj[@indexId]

  createCols:( columns ) ->
    cols  = []
    for column in columns
      column.c = if column.c? then column.c else ''
      cols.push( new Table.Col( column.n, column.w, column.t, column.c ) )
      #Util.log( 'column', column )
    indexId = Table.Col.indicies( cols )
    propId  = cols[indexId].prop
    [cols,propId,indexId]

  col:( nc ) =>
    return nc if Table.Col.isCol(nc)
    for col in @cols
      #Util.log('Table.col', col.prop, nc )
      return col if col.prop == nc
    Util.error( 'Table.col() name not found', nc )
    null

  cell:( row, col ) =>
    if @options.rowIsObject then row.obj[col.prop] else row.obj[col.index]

  stripe:( isEven ) =>
    if isEven then @css.even else @css.odds

  ready:() ->
    for  col in @cols
       @model.filterOn(col) if col.type isnt 'Load'
    @view.ready()
    @model.ready()
    @model.groups( @groupProps )
    return
