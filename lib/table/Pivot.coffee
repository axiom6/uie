
class Pivot

  #Util.dependsOn('js/util/Type')
  module.exports = Util.Export( Pivot, 'table/Pivot'  )

  constructor:( @build, @stream ) ->

  doMps:(  mps,  htmlId ) ->
    derivers = $.pivotUtilities.derivers
    $( '#'+htmlId ).pivotUI( mps.array,
      derivedAttributes:
        "Age Bin"          : derivers.bin("Age", 10),
        "Gender Imbalance" : (mp) -> mp["Gender"] == if "Male" then 1 else -1
      renderers: $.extend(
        $.pivotUtilities.renderers,
        $.pivotUtilities.c3_renderers,
        $.pivotUtilities.export_renderers ) )

  doPractices:( practices, htmlId ) ->
    array = Util.toArray( practices )
    $( '#'+htmlId ).pivotUI( array,
      sorters: (attr) ->
        switch attr
          when 'row'    then $.pivotUtilities.sortAs( [ "Learn",   "Do",       "Share"     ] )
          when 'column' then $.pivotUtilities.sortAs( [ "Embrace", "Innovate", "Encourage" ] )
          else null
    )