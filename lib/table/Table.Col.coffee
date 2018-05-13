
class Col

  module.exports = Util.Export( Col, 'table/Table.Col' )
  Table     = require("js/table/Table")
  Table.Col = Col
  Col.Type  = require( 'js/util/Type' )
  Col.empty = new Col( 'Empty' ) #, 1, 'string', 'empty' )

  constructor:( @title, @size=1, @type='string', @calc=null, @prop=@title.toLowerCase() ) ->
    #Util.error( 'Table.Col invalid type', @type ) if not Col.Type.isType(@type)
    @filterId = @title + 'Filter'
    @width    =  0 # Max of th and td outerWidth()
    @index    = -1 # Assigned latter by Table
    @$icon    = $() # Set by initSort()
    @order    = 'sort'
    @dimen    = null
    @group    = null
    @groups   = {}
    @firstCol = @title  is '1st'

  html:( value ) ->
    align = Col.Type.align(@type)
    css   = if @firstCol then Table.css.tdLoad else Table.css.td
    """<td class="#{css}" align="#{align}">#{@cell(value)}</td>"""

  cell:( value ) ->
    htm  = if @firstCol then """<i class="icon-expand"></i>""" else ""
    htm += Col.Type.cell( value, @type )
    htm

  format:( value ) ->
    Col.Type.cell( value, @type )

  typeJS:() ->
    Col.Type.typeJS( @type )

  @isCol:( nc ) ->
    not Util.isStr(nc)

  @indicies:( cols ) ->
    indexId = -1
    for j in [0...cols.length]
      cols[j].index = j  #columns[j].index used by tbody() and Sort
      indexId = j if cols[j].type == 'Id'
    indexId

