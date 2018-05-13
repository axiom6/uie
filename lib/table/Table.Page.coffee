
class Page

  module.exports = Util.Export( Page,       'table/Table.Page')
  Table      = require('js/table/Table')
  Table.Page = Page

  constructor:(  @table ) ->
    n = @table.array.length
    [@beg,@bin] = [0,0]
    [@end,@ein] = [n,n]
    @nin = n
    @stripe    = @table.stripe

  endRow:() ->
    @hideAllRows()  # Important to hide all rows so table does not push out maxBodyHeight()
    maxBodyHeight = @table.view.maxBodyHeight()
    isEven = true
    ein = @bin
    for end in [@beg...@table.array.length]
      row =  @table.array[end]
      continue if row.filtered
      isEven = @showRow( row, isEven )
      if @$tbody.outerHeight(true) > maxBodyHeight
        @hideRow( row )
        return [end-1,ein-1]
      ein++
    [@table.array.length-1,ein]

  begRow:() ->
    @hideAllRows() # Important to hide all rows so table does not push out maxBodyHeight()
    maxBodyHeight = @table.view.maxBodyHeight()
    isEven = true
    bin = @ein
    for beg in [@end..0]
      row =  @table.array[beg]
      continue if row.filtered
      isEven = @showRow( row, isEven )
      if @$tbody.outerHeight() > maxBodyHeight
        @hideRow( row )
        return [beg+1,bin+1]
      bin--
    [@beg,@bin] = [0,bin]
    [@end,@ein] = @endRow()
    [0,0]

  reset:( atBeg=true ) ->
    [@beg,@bin] = [0,0]  if atBeg
    [@end,@ein] = @endRow()
    @range()

  norows:() ->
    @hideAllRows()
    [@beg,@bin] = [0,0]
    [@end,@ein] = [0,0]
    @range()

  range:() ->
    @table.view.updateRange( @bin, @ein, @nin )
    return

  hideAllRows:() ->
    @hideRow( row ) for row in @table.array

  showRow:( row, isEven ) ->
    row.$row.attr('class', @stripe(isEven) )
    return isEven if row.visible
    display = 'display:table-row;'
    row.$row  .attr('style', display )
    row.$load .attr('style', display ) if row.$loadOn
    row.$group.attr('style', display ) if row.$groupOn
    row.visible = true
    not isEven

  hideRow:( row ) ->
    row.$row  .hide()
    row.$load .hide()
    row.$group.hide()
    row.visible = false
    return

  pageDn:( e ) ->
    Util.noop(e)
    return if @end is @table.array.length-1 or @ein is @nin-1
    [@beg,@bin] = [@end+1,@ein+1]
    [@end,@ein] = @endRow()
    @range()
    return

  pageUp:( e ) ->
    Util.noop(e)
    return if @beg is 0 or @bin is 0
    [@end,@ein] = [@beg-1,@bin-1]
    [@beg,@bin] = @begRow()
    @range()
    return
