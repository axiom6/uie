
class Pivot

  module.exports = Pivot

  @init:() ->

    Util.ready ->
      window.jQuery  = require('jquery')
      Pivot.$        = window.jQuery
      $UI            = require('lib/custom/jquery-ui')
      d3             = require('d3')
      pivottable     = require('pivottable')
      Pivot.Database = require('js/util/Database')
      Util.noop(  $UI, d3, pivottable )
      console.log( 'Pivot.init() ready' )
      document.getElementById('pivotfiles').addEventListener('change', Pivot.handleFileSelect, false )

  @handleFileSelect:( event ) ->
    event.stopPropagation()
    event.preventDefault()
    files = event.target.files
    console.log( 'handleFileSelect' )
    Pivot.Database.read( files[0], ( array ) ->
      console.log( 'File', { name:files[0].name, lenght:files.length, array:array } )
      switch files[0].name
        when 'practices.json' then Pivot.showPractices( array )
        when 'mps.json'       then Pivot.showMps(       array )
        when 'bar.json'       then Pivot.showBar(       array )
        when 'tensor.json'    then Pivot.showTensor(    array )
        else                       Pivot.showArray(     array )
      return )
    return

  @showPractices:( practices, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( practices, { sorters:Pivot.practiceSort, rows:['plane','row'],cols:['column'] } )
    return

  @practiceSort:( attr ) ->
    switch attr
      when 'plane'  then Pivot.$.pivotUtilities.sortAs( [ "Information", "DataScience", "Knowledge", "Wisdow" ] )
      when 'row'    then Pivot.$.pivotUtilities.sortAs( [ "Learn",   "Do",       "Share"     ] )
      when 'column' then Pivot.$.pivotUtilities.sortAs( [ "Embrace", "Innovate", "Encourage" ] )
      else null

  @showMps:( mps, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( mps.array, { derivedAttributes:Pivot.mpsAtts(), rows:['Province'], cols:['Party'] } )
    return

  @showBar:( array, htmlId="output" ) ->
    layout = {fileopt : "extend", filename : "nodenodenode"}
    Plotly.plot( htmlId, array, layout )

  @showTensor:( tensor, htmlId="output" ) ->
    #layout = require('data/pivot/tensor.layout.json')
    Plotly.plot( htmlId, tensor.data, tensor.layout )

  @mpsAtts:() ->
    derivers = Pivot.$.pivotUtilities.derivers
    {  "Age Bin":derivers.bin("Age", 10), "Gender Imbalance": (mp) -> mp["Gender"] == "Male" ? 1 : -1 }

  @showArray:( array, htmlId="output" ) ->
    Pivot.$( '#'+htmlId ).pivotUI( array )
    return

  @doPivotFiles:( htmlId="output" ) ->
    url = Pivot.Database.fileURI+"/pivot/mps.json"
    Pivot.Database.read( url, (mps) ->
      Pivot.$( '#'+htmlId ).pivotUI( mps.array, Pivot.mpsAtts() )
      return )
    return

  @readFile:( fileObj, doJson ) ->
    fileReader = new FileReader()
    fileReader.onerror = (e) -> Util.error( 'Store.readFile', fileObj.name, e.target.error )
    fileReader.onload  = (e) -> doJson( JSON.parse(e.target.result) )
    fileReader.readAsText( fileObj )
    return

  @readRequire:( url, doJson ) ->
    path = url.substring(5)
    json = Util.require( path ) # Util.require prevents dynamic resolve in webpack
    if json?
      doJson( json )
    else
      Util.error( 'Store.req require(json)  failed for url', url )
    return

  @readAjax:( url, doJson ) ->                   #jsonp
    settings  = { url:url, type:'get', dataType:'json', processData:false, contentType:'application/json', accepts:'application/json' }
    settings.success = ( data,  status, jqXHR ) =>
      Util.noop( status, jqXHR )
      json   = JSON.parse( data )
      doJson( json )
    settings.error   = ( jqXHR, status, error ) =>
      Util.error( 'Store.ajaxGet', { url:url, status:status, error:error } )
    $.ajax( settings )
    return

  # A quick in and out method to select JSON data
  @selectJson:( stream, uri, table, doData ) ->
    rest = new Store.Rest( stream, uri )
    rest.remember()
    rest.select( table )
    rest.subscribe( table, 'none', 'select', doData )

 Pivot.init()