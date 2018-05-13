
class View

  module.exports = Util.Export( View,       'table/Table.View')
  Table      = require('js/table/Table')
  Table.View = View

  constructor:(  @table ) ->
    @$table = $(); @$parent = $(); @$thead = $(); @$tcols = $(); @$tbody = $(); @$rows  = $();
    @$tfoot = $(); @$pagup  = $() ;@$pagdn = $(); @$tbegp = $(); @$tendp = $(); @$ttotp = $();

  ready:() ->
    @$table  = $('#'+@table.htmlId)
    @$parent = $('#'+@table.parentId) # @$table.parent()
    @$thead  = @$table.find('thead' )
    @$tcols  = @$thead.children().eq(0).children()
    for col in @table.cols
      col.$col = @$tcols.eq(col.index)
    @$tbody  = @$table.find('tbody')
    @table.model.$tbody = @$tbody
    @table.page .$tbody = @$tbody
    @$rows  = @$tbody.children()
    @table.model.$rows = @$rows
    @$tfoot  = @$table.find('tfoot')
    @$tfoot.hide()
    @$pagup  = $('#PAGEUP' ) #'[class~="table-th-page-up"]' )
    @$pagdn  = $('#PAGEDN' ) #'[class~="table-th-page-dn"]' )
    @$tbegp  = $('#PAGEBEG') #@$thead.children('.table-th-page-beg' )
    @$tendp  = $('#PAGEEND') #@$thead.children('.table-th-page-end' )
    @$ttotp  = $('#PAGETOT') #@$thead.children('.table-th-page-end' )
    #Util.dbg( 'Page', @$pagup.attr('class'), @$pagdn.attr('class'), @$tbegp.attr('class'), @$tendp.attr('class') )
    @$pagup.on( 'click', (e) => @table.page.pageUp(e) )
    @$pagdn.on( 'click', (e) => @table.page.pageDn(e) )
    i = 0
    for row in @table.array # Create sor array with sort column and <tr> row
      row.$row = @$rows.eq(i)
      row.$row.data( 'row', row )
      i++
    return

  updateRange:( bin, ein, nin ) ->
    @$tbegp.text( bin+1 )
    @$tendp.text( ein+1 )
    @$ttotp.text( nin   )
    # Util.log( 'updateRange', bin+1, ein+1, nin, @$tbegp.attr('id') )
    return

  maxBodyHeight:() ->
    @$parent.outerHeight() - @$thead.outerHeight() - @$tfoot.outerHeight() - 26 # 26 margin

  resize:() =>
    @table.page.reset( false )
    return

  order:() ->
    @$tbody.children().detach()
    isEven = true
    prev   = null
    for row in @table.array
      row.$row.attr('class',@table.stripe(isEven) ) #  Reset Stripping
      @$tbody.append( row.$row   )
      @$tbody.append( row.$load  ) if row.$loadOn
      @$tbody.append( row.$group ) if row.$groupOn
      isEven = not isEven
      prev   = row
    @table.page.reset( true )
    return