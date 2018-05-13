
class Html

  module.exports = Util.Export( Html,       'table/Table.Html')
  Table      = require('js/table/Table')
  Table.Html = Html

  constructor:( @table ) ->

  thtml:() ->
    #htm = """<form  class="#{@table.css.form}"  id="#{@table.htmlId}Form"></form> """
    htm  = """<table class="#{@table.css.table}" id="#{@table.htmlId}" border="1">#{ @thead()+@tbody()+@tfoot() }</table>"""
    htm

  thead:() ->
    htm = """<colgroup>"""
    for col in @table.cols
      htm += """<col>"""
    htm += """</colgroup>"""
    htm += """  <thead class="#{@table.css.thead}">    <tr>"""
    for col in @table.cols
      if col.firstCol
        htm += """<th id="#{Util.htmlId('PAGER')}">
                   <i id="#{Util.htmlId('PAGEUP')}" class="#{@table.css.pageUp}"></i>
                   <i id="#{Util.htmlId('PAGEDN')}" class="#{@table.css.pageDn}"></i></th>"""
      else
        htm += """<th class="#{@table.css.th}">
                   <span>#{col.title}</span>
                   <i class="#{@table.css.faUnsort}"></i>
                   </th>"""
    htm += '</tr>'
    htm += @tfilter()
    htm += '</thead>'
    htm

  tfilter:() =>
    return "" if not @table.options.filters
    htm = """<tr class="#{@table.css.filterTR}">"""
    for col in @table.cols
      if col.firstCol
        htm += """<th class="#{@table.css.pageNum}">"""
        htm += """    <span id="#{Util.htmlId('PAGEBEG')}" class="#{@table.css.pageBeg}">1</span>"""
        htm += """    <span              class="#{@table.css.pageTo}">-</span>"""
        htm += """    <span id="#{Util.htmlId('PAGEEND')}" class="#{@table.css.pageEnd}">20</span>"""
        htm += """    <span              class="#{@table.css.pageOver}">/</span>"""
        htm += """    <span id="#{Util.htmlId('PAGETOT')}" class="#{@table.css.pageTot}">100</span></th>"""
      else
        htm += """<th class="#{@table.css.filterTH}">
               <div class="#{@table.css.filterDIV}">
               <input id="#{Util.htmlId(col.filterId)}" type="text" #{@inputSize(col)} form="#{@table.htmlId}Form" class="#{@table.css.filterINPUT}" } /></div></th>"""
    htm += '</tr>'
    htm

  inputSize:( col ) ->
    if col.length > 0 then """ size="#{col.length}" """ else " "

  tbody:() ->
    htm  = """  <tbody class="#{@table.css.tbody}">"""
    isEven = true                # i is used for even / odds row  stripping
    prev = null
    for row in @table.array
      htm += @trow(   row, isEven )
      isEven = not isEven
      prev = row
    htm += '  </tbody>'
    htm

  trow:( row, isEven ) ->
    htm  = ""
    htm += """<tr class="#{ @table.stripe(isEven) }">"""
    for col in @table.cols
      htm += col.html( @table.cell(row,col) )
    htm += """</tr>"""
    htm

  tfoot:() ->
    htm = """  <tfoot class="#{@table.css.tfoot}">    <tr>"""
    for col in @table.cols
      Util.noop( col )
      htm += """<th></th>"""
    htm += """</tr>  </tfoot>"""
    htm

  tgroup:( group, props ) ->
    htm = """<tr class="#{@table.css.trGroup}">"""
    for col in @table.cols
      cell  = if Util.inArray(props,col.prop) then group[col.prop] else ''
      htm  += if col.firstCol then col.html(cell) else """<td></td>"""
    htm += """</tr>"""
    htm
