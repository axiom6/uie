
$  = require( 'jquery'   )
UI = require( 'js/ui/UI' )
#h = require('virtual-dom/h')

class Btn

  module.exports = Btn

  constructor:( @ui, @stream, @pane, @spec, @contents ) ->
    @css = @pane.css

  ready:() ->
    return if not  @pane.page?
    @$ = $( @html( @contents  ) )
    @pane.$.append( @$ )
    @publish( @contents )
    return

  layout:( geom ) ->
    if geom.w < 200 then @$.hide() else @$.show()
    return

  html:( contents ) ->
    htmlId = @ui.htmlId( @pane.name, 'Btn' )
    html   = """<ul id="#{htmlId}" class="#{@css+'-ul-content'}">"""
    for own key, content of contents when @hasButton( content )
      content.btnId = @ui.htmlId( @pane.name, content.name+'Btn')
      html += """<li id="#{content.btnId}" class="btn-page">#{content.name}</li>"""
    html += """</ul>"""
    html

  ###
  render:( contents ) ->
    htmlId = @ui.htmlId( @pane.name, 'Btn' )
    lis    = []
    for own key, content of contents when @hasButton( content )
      content.btnId = @ui.htmlId( @pane.name, content.name+'Btn')
      lis.push( h( "li##{content.btnId}.btn-page", content.name ) )
    h("ul##{htmlId}.#{@css+'-ul-content'}", lis )
  ###

  publish:( contents ) ->
    for own key, content of contents when @hasButton( content )
      content.$btn = $( '#'+content.btnId )
      msg = UI.Build.content( content.name, 'Btn', UI.Build.SelectPractice, @pane.name )
      @stream.publish( 'Content', msg, content.$btn, 'click' )
    return

  hasButton:( content ) ->
    content.has and content.name isnt 'Study'
