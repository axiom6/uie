
$ = require('jquery')

class Action

  module.exports = Action # Util.Export( Action, 'htm/target/Action' )

  constructor:( @stream ) ->
    @first  = true
    @fullUI = true
    @stream.subscribe( 'Navigate', (object) => @navigate( object ) )
    @stream.subscribe( 'Settings', (object) => @settings( object ) )
    @stream.subscribe( 'Submit',   (object) => @submit(   object ) )
    @stream.subscribe( 'Test',     (topic)  => @onTest(   topic ) )
    #@router = @createRouter()

  ready:() ->
    $('#'+Util.htmlId('App')).html( @html() )
    @$togg = $('#'+Util.getHtmlId('Togg','App'))
    @stream.publish(   'Toggle', 'Toggle', @$togg, 'click'  )
    @stream.subscribe( 'Toggle', (toggle) => @onToggle(toggle) )
    return

  onTest:( topic ) ->
    switch topic
      when 'Persist'
        Persist  = Util.Import( 'Muse.Persist'  )
        persist  = new Persist( @stream )
        Util.noop( persist )
    return

  htmlId:(    name ) -> Util.htmlId(    name, 'App' )
  getHtmlId:( name ) -> Util.getHtmlId( name, 'App' )

  html:() ->
    """
      <div   class="ikw-logo" id="#{@htmlId('Logo')}"></div>
      <div   class="ikw-corp" id="#{@htmlId('Corp')}">
        <div id="#{@htmlId('Navb')}"></div>
      </div>
      <div   class="ikw-find" id="#{@htmlId('Find')}"></div>
      <div   class="ikw-tocs tocs" id="#{@htmlId('Tocs')}"></div>
      <div   class="ikw-view" id="#{@htmlId('View')}">
        <i id="#{@htmlId('Togg')}" class="fa fa-compress ikw-togg"></i>
      </div>
      <div class="ikw-side" id="#{@htmlId('Side')}"></div>
      <div class="ikw-pref" id="#{@htmlId('Pref')}"><a id="#{@htmlId('ImageLink')}"></a></div>
      <div class="ikw-foot" id="#{@htmlId('Foot')}"></div>
      <div class="ikw-trak" id="#{@htmlId('Trak')}"></div>
    """

  createRouter:( Routes ) ->
    router  = new Router( Routes )
    #router.contigure( { container:@ } )
    router.init()
    router

  navigate:( topic ) ->
    Util.log( 'App.Action.navigate()', topic )
    window.location.assign( topic )
    return

  settings:( topic ) ->
    Util.log( 'App.Action.settings()', topic )
    return

  submit:(  object ) ->
    switch( object.topic )
      when 'Search' then @search( object.value )
      when 'SignOn' then @signon( object.value )
      else Util.error( 'App.Action.submit() unknown input value', object )

  search:( value ) ->
    Util.log( 'App.Action.search()', value )

  signon:( value ) ->
    Util.log( 'App.Action.signon()', value )

  onToggle:( toggle ) ->
    if @first
      @$logo = $('#'+@getHtmlId('Logo'))
      @$tocs = $('#'+@getHtmlId('Tocs'))
      @$corp = $('#'+@getHtmlId('Corp'))
      @$view = $('#'+@getHtmlId('View'))
      @west    = @$tocs.width()
      @north   = @$corp.height()
      @first   = false
    if @fullUI  # Shrink
      shrink = 0
      @$tocs.css('width',  shrink )
      @$corp.css('height', shrink )
      @$view.css( { left:shrink, top:shrink } )
      @$tocs.hide()
      @$corp.hide()
      @$view.hide().show(600)
      @$togg.attr('class','fa fa-expand ikw-togg')
    else  # Expand
      @$tocs.css('width',  @west  )
      @$corp.css('height', @north )
      @$view.css( { left:@west, top:@north } )
      @$tocs.show()
      @$corp.show()
      @$view.hide().show(600)
      @$togg.attr('class','fa fa-compress ikw-togg')
    #@$tocs.children().toggle(600)
    #@$corp.children().toggle(600)
    @fullUI = not @fullUI
    Util.noop( toggle )
    #Util.log('toggleToc()', @fullUI, toggle )
    return


