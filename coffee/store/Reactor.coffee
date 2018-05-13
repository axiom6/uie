
Store = require( 'js/store/Store' )

class Reactor

  module.exports = Reactor # Util.Export( Reactor, 'store/Reactor' )
  Store.Reactor  = Reactor

  constructor:( @stream ) ->