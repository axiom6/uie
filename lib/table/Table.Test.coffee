
class Test

  #Util.dependsOn('jasmine','table/Table')
  module.exports = Util.Export( Test,       'table/Table.Test')
  Table      = require('js/table/Table')
  Table.Test = Test
  Setup      = require('js/jasmine/Setup')

  constructor:( @testId, @tableId ) ->
    @setup = new Setup( @testId )
    @table = new Table( @tableId, @columns(), @techs(), @loads() )
    $('#'+@tableId).append( @table.thtml() )
    @table.ready()


  columns:() -> [
      { n:'',      s:0, t:'Load'   }, { n:'Name',   s:15, t:'Id'     },
      { n:'Grade', s:5, t:'Float'  }, { n:'G',      s:1,  t:'string', c:'?' }, # c:calcs.letter
      { n:'Angle', s:5, t:'Float'  }, { n:'Sector', s:5,  t:'string', c:'?' }, # c:calcs.sector
      { n:'Title', s:0, t:'string' } ]

  techs:() -> []

  loads:() -> []