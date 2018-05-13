

class Exit

  @init = () ->
    Util.ready ->
      Util.app   = new Exit( 'Local' ) # @dataSource = 'Rest', 'RestThenLocal', 'Local', 'LocalForecasts'

  constructor:( @dataSource='RestThenLocal' ) ->
    @subjectNames = ['Icons','Location','Screen','Source','Destination','Trip','Forecasts']

    # Import Class for CommonJS  Util.resetModuleExports() has to be called beforehand
    Stream        = require( 'js/util/Stream'             )
    Rest          = require( 'js/exit/app/Rest'           )
    Data          = require( 'js/exit/app/Data'           )
    Model         = require( 'js/exit/app/Model'          )
    Simulate      = require( 'js/exit/app/Simulate'       )

    DestinationUI = require( 'js/exit/page/DestinationUI' )
    GoUI          = require( 'js/exit/page/GoUI'          )
    TripUI        = require( 'js/exit/page/TripUI'        )
    DealsUI       = require( 'js/exit/page/DealsUI'       )
    NavigateUI    = require( 'js/exit/page/NavigateUI'    )
    Page          = require( 'js/exit/page/Page'          )

    # Instantiate main App classes
    @stream        = new Stream( @subjectNames  )
    @rest          = new Rest(   @stream        )
    @model         = new Model(  @stream, @rest, @dataSource )

    @destinationUI = new DestinationUI(  @stream, @thresholdUC )
    @goUI          = new GoUI(           @stream )
    @tripUI        = new TripUI(         @stream )
    @dealsUI       = new DealsUI(        @stream )
    @navigateUI    = new NavigateUI(     @stream )
    @page          = new Page(           @stream, @destinationUI, @goUI, @tripUI, @dealsUI, @navigateUI )

    @ready()
    @position( @page.toScreen('Portrait' ) )

    # Run simulations and test if test modules presents
    @simulate = new Simulate( @, @stream )

    if Util.hasModule( 'exit/App.Test',false )
      $ = require( 'jquery' )
      $('body').css( { "background-image":"none" } )
      $('#App').hide()
      @appTest = new App.Test( @, @stream, @simulate, @rest, @model )

    if Util.hasModule( 'page/Page.Test',false )
      @pageTest = new Page.Test( @ui, @trip, @destinationUI, @goUI, @tripUI, @navigateUI )

    # Jumpstart App
    #@stream.publish( 'Source',      'Denver' )
    #@stream.publish( 'Destination', 'Vail'   )

  ready:() ->
    @model.ready()
    @page.ready()

  position:( screen ) ->
    @page.position( screen )

Exit.init()
