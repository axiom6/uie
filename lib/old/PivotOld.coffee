
class Pivot

  @init:() ->

    Util.ready ->
      window.jQuery  = require('jquery')
      Pivot.$        = window.jQuery
      $UI            = require('jquery-ui')
      d3             = require('d3')
      pivottable     = require('pivottable')
      Pivot.Store    = require('js/store/Store'   )
      Pivot.Database = require('js/store/Database')
      Util.noop(  $UI, d3, pivottable )

      #ivot.doPractices()
      #Pivot.doMps()
      document.getElementById('pivotfiles').addEventListener('change', Pivot.handleFileSelect, false )

  @handleFileSelect:( event ) ->
    event.stopPropagation()
    event.preventDefault()
    files = event.target.files
    Pivot.Store.readJson( files[0], ( array ) ->
      switch files[0].name
        when 'practices.json' then Pivot.showPractices( array )
        when 'mps.json'       then Pivot.showMps(       array )
        else                       Pivot.showArray(     array )
      return )
    return

  @doPractices:() ->
    url = Pivot.Database.fileURI+"/muse/Practices2.json"
    Pivot.Store.readJson( url  ( practices ) ->
      Pivot.showPractices( practices )
      return )
    return

  @doPractices2:() ->
    url = Pivot.Database.dataURI()+"/muse/Practices2.json"
    Pivot.$.getJSON( url, ( practices ) ->
      Pivot.showPractices(  practices )
      return )
    return

  @showPractices:( practices, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( practices, sorters: (attr) ->
      switch attr
        when 'plane'  then Pivot.$.pivotUtilities.sortAs( [ "Information", "DataScience", "Knowledge", "Wisdow" ] )
        when 'row'    then Pivot.$.pivotUtilities.sortAs( [ "Learn",   "Do",       "Share"     ] )
        when 'column' then Pivot.$.pivotUtilities.sortAs( [ "Embrace", "Innovate", "Encourage" ] )
        else null )
    return

  @showMps:( mps, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( mps.array, Pivot.mpsAtts() )
    return

  @showArray:( array, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( array )
    return

  @doPivotFiles:( htmlId="output" ) ->
    url = Pivot.Database.fileURI+"/pivot/mps.json"
    Pivot.Store.readJson( url, (mps) ->
      Pivot.$( '#'+htmlId ).pivotUI( mps.array, Pivot.mpsAtts() )
      return )
    return

  @doMps:( htmlId="output" ) ->
    url = Pivot.Database.fileURI+"/pivot/mps.json"
    Pivot.Store.readJson( url, (mps) ->
      Pivot.$( '#'+htmlId ).pivotUI( mps.array, Pivot.mpsAtts() )
      return )
    return

  @doMps2:( htmlId="output" ) ->
    url = Pivot.Database.dataURI()+"/pivot/mps.json"
    Pivot.$.getJSON( url, (mps) ->
      Pivot.$( '#'+htmlId ).pivotUI( mps.array, Pivot.mpsAtts() )
      return )
    return

  @mpsAtts:() ->
    derivers = Pivot.$.pivotUtilities.derivers
    { derivedAttributes: {
      "Age Bin":  derivers.bin("Age", 10)
      "Gender Imbalance": (mp) -> mp["Gender"] == "Male" ? 1 : -1 } }

###
@doImports:() ->
  args   = { name:'Pivot', plane:'Information', op:'' }
  Stream = require('js/util/Stream')
  Build  = require('js/prac/Build')
  Memory = require('js/store/Store.Memory')
  stream = new Stream( [] )
  build  = new Build( args, stream)
  memory = new Memory(  stream, 'muse'  )
  Util.noop( memory, build )
###

Pivot.init()

