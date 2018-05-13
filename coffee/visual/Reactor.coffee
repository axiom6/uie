

Visual = require( 'js/visual/Visual' )

class Reactor

  module.exports = Reactor # Util.Export( Reactor, 'visual/Reactor' )
  Visual.Reactor = Reactor

  constructor:( @stream ) ->