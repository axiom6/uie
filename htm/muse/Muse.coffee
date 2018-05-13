


class Muse

  module.exports = Muse

  @init = () ->

    Util.ready ->

      Stream   = require( 'js/util/Stream'    ) # require( 'coffee/util/Stream.coffee'    )
      Build    = require( 'js/prac/Build'     )
      Action   = require( 'target/Action'     )
      UI       = require( 'js/ui/UI'          )
      Navb     = require( 'js/ui/Navb'        )

      args     = Muse.buildArgs()
      subjects = ['Select','Content','Connect','Test','Plane','About','Slide','Image',
                  'Cursor','Navigate','Settings','Submit','Toggle']
      stream   = new Stream( subjects )
      build    = new Build(  args )  # Build App by processing the specs in the Build module based on 'buildName'
      action   = new Action( stream )
      navb     = new Navb(   stream, build.NavbSpecs )
      action.ready()
      navb  .ready()
      UI.createUI( args.plane, build, stream )
      #build.ready()
      return

    Muse.initCalled = true
    return

  @buildArgs:() ->
    parse = Util.parseURI( window.location ) #Util.log( 'Muse.parse', parse )
    name  = if Util.isStr(parse.fragment) then parse.fragment.substring(1) else ''
    switch name
      when 'Info'    then { name:'Muse', plane:'Information', op:''        }
      when 'Augm'    then { name:'Muse', plane:'Augment',     op:''        }
      when 'Data'    then { name:'Muse', plane:'DataScience', op:''        }
      when 'Know'    then { name:'Muse', plane:'Knowledge',   op:''        }
      when 'Wise'    then { name:'Muse', plane:'Wisdom',      op:''        }
      when 'Hues'    then { name:'Muse', plane:'Hues',        op:''        }
      else                { name:'Muse', plane:'Information', op:''        }

  #Palettes = require( 'js/d3d/Palettes' )
  #Palettes.hsvOut()

Muse.init()

# Load modules
# Util.Load.load( Muse.init ) if Util.Load?

###
@doElectron:( electron ) ->
  electron.ipcRenderer.on( 'init', ( event, message ) ->
    Util.log( 'Muse.init()', message ) )
  return


@doScs:( stream ) ->
  Scs = Util.Import( 'Scs' )
  scs = new Scs( stream )
  scs.selectMaster()
  return

@doF6s:( build, stream ) ->
  F6s      = Util.Import( 'F6s' )
  local    = new F6s( build, stream, F6s.Local    )
  innov    = new F6s( build, stream, F6s.Innov    )
  wellness = new F6s( build, stream, F6s.Wellness )
  local.doSelectsAll()
  innov.doSelectsAll()
  wellness.doSelectsAll()
  return
###



