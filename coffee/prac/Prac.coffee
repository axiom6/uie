
$   = require('jquery')
Vis = require('js/util/Vis')

class Prac

  module.exports = Prac

  Prac.Shapes    = require( 'js/prac/Shapes'    )
  Prac.Embrace   = require( 'js/prac/Embrace'   )
  Prac.Innovate  = require( 'js/prac/Innovate'  )
  Prac.Encourage = require( 'js/prac/Encourage' )
  Prac.Connect   = require( 'js/prac/Connect'   )
  Prac.Tree      = require( 'js/d3d/Tree'       )
  Prac.Radial    = require( 'js/d3d/Radial'     )
  Prac.Cluster   = require( 'js/d3d/Cluster'    )

  @cos30        = 0.86602540378
  @cos15        = Vis.cos(15)
  @cos:( deg ) -> Vis.cosSvg(deg)
  @sin:( deg ) -> Vis.sinSvg(deg)

  constructor:( @ui, @stream, @view ) ->
    @practices = @ui.build.getPractices( @ui.plane.name ) # For current plane
    @shapes    = new Prac.Shapes( @stream, @ )

  arrange:( studies0 ) ->
    studies1 = {}
    for dir in ['north','west','east','south']
      studies1[@key(studies0,dir)] = @obj(studies0,dir)
    studies1

  key:( studies, dir ) ->
    for key, study of studies when study.dir is dir
      return key
    '???'

  obj:( studies, dir ) ->
    for key, study of studies when study.dir is dir
      return study
    {}

  createDraw:( pane, content, g, w, h ) ->
    spec = pane.spec
    if content.name is 'Svg' and @ui.plane.id isnt 'Data'
      switch spec.column
        when 'Embrace'   then new Prac.Embrace(   @ui, spec, @ )
        when 'Innovate'  then new Prac.Innovate(  @ui, spec, @ )
        when 'Encourage' then new Prac.Encourage( @ui, spec, @ )
        else                  new Prac.Embrace(   @ui, spec, @ )
    else if content.name is 'Svg' and @ui.plane.id is 'Data'
      new Prac.Innovate(  @ui, spec, @ )
    else if content.name is 'Tree'
      new Prac.Tree(    @ui, spec, g, w, h )
    else if content.name is 'Radial' or content.name is 'Overview'
      new Prac.Radial(  @ui, spec, g, w, h )
    else
      Util.error( 'Prac.createDraw unknown content', content.draw )
      null

  htmlId:( pracName, contentName ) ->
    Util.getHtmlId( pracName, @ui.plane.id, contentName )

  toFill:( studyPrac ) ->
    if      studyPrac.hsv?  and studyPrac.hsv.length is 3
      Vis.toRgbHsvStr( studyPrac.hsv )
    else if studyPrac.fill? and studyPrac.fill.length <= 5
      Vis.Palettes.hex( studyPrac.fill )
    else
      Util.error( 'Prac.toFill() unknown fill code', studyPrac.name, studyPrac.fill )
      '#888888'

  size:( obj ) ->
    if obj? then Object.keys(obj).length else 0

  saveSvg:( htmlId, fileName ) ->
    svgData = $('#'+htmlId)[0].outerHTML
    svgBlob = new Blob( [svgData], { type:"image/svg+xml;charset=utf-8" } )
    svgUrl  = URL.createObjectURL(svgBlob)
    downloadLink      = document.createElement("a")
    downloadLink.href = svgUrl;
    downloadLink.download = fileName
    document.body.appendChild(downloadLink)
    downloadLink.click()
    document.body.removeChild(downloadLink)
    return

  saveHtml:( htmlId, fileName ) ->
    htmlData = $('#'+htmlId)[0].outerHTML
    htmlBlob = new Blob( [htmlData], { type:"text/html;charset=utf-8" } )
    htmlUrl  = URL.createObjectURL(htmlBlob)
    downloadLink      = document.createElement("a")
    downloadLink.href = htmlUrl;
    downloadLink.download = fileName
    document.body.appendChild(downloadLink)
    downloadLink.click()
    document.body.removeChild(downloadLink)
    return




