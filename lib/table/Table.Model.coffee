
class Model

  module.exports = Util.Export( Model,       'table/Table.Model')
  Table       = require('js/table/Table')
  Table.Model = Model

  constructor:( @table ) ->

  ready:() ->
    # Set order index and bind sort method to  columns
    for  col in @table.cols when not col.firstCol
       col.order  = 'sort'
       col.$icon = col.$col.find('i')
       @bindSort( col )
    return

  # bindSort is needed to bind each otherwise it just binds to the last column
  bindSort:( col ) ->
    col.$icon.on( 'click', () => @sort(col) )

  filterOn:( col ) ->
    col.$filter = $('#'+col.filterId)
    col.$filter.on( 'change', () => @filterCall( col ) )
    return

  filterCall:( col ) ->
    @filter( col, col.$filter.val() )
    return

  # Sort the <tbody> rows for <th> onclick
  sort:( col ) ->
    for row in  @table.array         # Load the chosen sort column into sort array
      row.sortVal = @table.cell( row, col )
    @sortOnCol( col ) 
    @resetSortIcons( col ) # Resent the sort symbols in the columns
    @table.hasGroups = col.prop == @table.groupProps[0]
    #@groupsToRows( @table.groupProps )
    @table.view.order()  # Reset row stripping and append rows in sort order
    return

  # Sort with array.val using the internal JavaScript array sort
  sortOnCol:( col ) ->
    if(      col.typeJS()=='string' && @isAcsend(col) ) then @table.array.sort( @stringDecend )
    else if( col.typeJS()=='string' && @isDecend(col) ) then @table.array.sort( @stringAscend )
    else if( col.typeJS()=='number' && @isAcsend(col) ) then @table.array.sort( @numberDecend )
    else if( col.typeJS()=='number' && @isDecend(col) ) then @table.array.sort( @numberAscend )
    return

  isAcsend:(col) -> col.order=='sort-asc'
  isDecend:(col) -> col.order=='sort-desc' || col.order=='sort'

  stringAscend:( a, b ) ->  if a.sortVal == b.sortVal then 0 else if a.sortVal<b.sortVal then -1 else  1
  stringDecend:( a, b ) ->  if a.sortVal == b.sortVal then 0 else if a.sortVal<b.sortVal then  1 else -1
  numberAscend:( a, b ) ->     a.sortVal -  b.sortVal
  numberDecend:( a, b ) ->     b.sortVal -  a.sortVal

  resetSortIcons:( col ) ->
    for colq in @table.cols
      colq.$icon.toggleClass("fa-#{colq.order}", false ).toggleClass("fa-sort", true )
    col.order = if @isAcsend(col) then 'sort-desc' else 'sort-asc'
    col.$icon.toggleClass("fa-#{col.order}", true )
    return   

  filter:( col, str ) ->
    @table.page.nin = 0
    for row in @table.array
      row.sortVal  = @table.cell( row, col )
      row.filtered = if @isMatch( row.sortVal, str ) then false else true
      @table.page.nin++ if not row.filtered
    @table.view.order()  # Reset row stripping and append rows in sort order
    return

  isMatch:( sortVal, str ) ->
    sortVal.toString().startsWith( str )

  groups:( props ) ->
    return unless props.length > 0
    #@table.cross.groupReduce( props )
    @sort( @table.col(props[0]) )
    return

  groupsToRows:( props ) ->
    key = props[0]
    for i in [0...@table.array.length]
      row  = @table.array[i]
      last = row.id is @table.array[@table.array.length-1].id
      next = if not  last then @table.array[i+1] else null
      row.$groupOn = @table.hasGroups and ( last or ( next? and ( row[key] isnt next[key] ) ) )
      #Util.log('groupOn', )
      if row.$groupOn and not Util.isJQuery(row.$group)
        #group = @table.cross.group( key, row[key] )
        row.$group = $( @table.html.tgroup(group,props) )
    return