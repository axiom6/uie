
UI       = require('js/ui/UI')
Btn      = require('js/ui/Btn')
Viewer   = require('js/prac/Viewer')
#Connect = require('js/prac/Connect')

class Page

  module.exports = Page

  constructor: ( @ui, @stream, @view, @pane, @prac ) ->
    @spec        = @pane.spec
    @name        = @spec.name
    @icon        = @spec.icon
    @viewer      = new Viewer( @pane, @, @prac )
    @contents    = @viewer.contents # contents maintains that state of all page contents
    @choice      = 'Studies' # 'Studies'
    #@connect    = new Connect( @ui, @stream, @view, @, @spec   )
    @saveHtml    = false
    @saveSvg     = false
    @showBtn     = false
    @btn         = new Btn( @ui, @stream, @pane, @pane.spec, @contents ) if @showBtn

  ready:() ->
    return if @ui.plane.name is 'Hues'
    @viewer.ready()
    @subscribe()
    #@connect.ready()
    @btn.ready() if @showBtn
    return

  subscribe:() ->
    @stream.subscribe( 'Content', (content) => @onContent( content ) )
    return

  publish:( $on ) ->
    if UI.isElem($on)
      select = UI.Build.select( Util.toSelect(@pane.name), 'Page', UI.Build.SelectPractice )
      @stream.publish( 'Select', select, $on, 'click' )
    return

  publishJQueryObjects:( objects, intent ) ->
    return
    for name, $object of objects when UI.isElem($object)
      select = UI.Build.select( Util.toSelect(name),  'Page', intent )
      Util.log( 'Page.publishJQueryObjects()', )
      @stream.publish( 'Select', select, $object, 'click' )
    return

  # Called by pane.paneContent
  paneContent:( select ) ->
    choice  = switch select.intent
      when UI.Build.SelectStudy    then 'Study'
      when UI.Build.SelectTopic    then 'Topic'
      when UI.Build.SelectItems    then 'Items'
      else @choice
    content = UI.Build.content( choice, select.source, select.intent, select.name )
    @onContent( content )
    return

  # Called by layout and Btn
  onContent:( content ) =>
    return if @ui.notInPlane() or @ui.plane.name is 'Hues'
    @choice = content.content
    Util.msg( 'Page.onContent()', content, @choice, @name )
    geom    = @pane.geom()
    @btn   .layout( geom ) if @showBtn
    return if @name is @ui.plane.id and @choice isnt 'Overview' # Skip planes without content
    @viewer.layout( geom, content )
    if @choice is 'Svg' and @saveSvg
      @prac.saveSvg( @pane.page.contents.svg.htmlId, @name + '.svg' )
      @saveSvg = false
    if @choice is 'Studies' and @saveHtml
      @prac.saveHtml( @pane.page.contents.studies.htmlId, @name + '.html' )
      @saveHtml = false
    return

  getStudy:( name ) ->
    for own key, study of @spec.studies when name isnt 'None'
      return study if key is name
    @ui.build.NoneStudy

