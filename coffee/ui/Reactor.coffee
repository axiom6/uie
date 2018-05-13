
UI = require( 'js/ui/UI' )

class Reactor

  module.exports = Reactor # Util.Export( Reactor, 'ui/Reactor' )
  UI.Reactor     = Reactor

  constructor:( @stream ) ->