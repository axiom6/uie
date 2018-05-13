

window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )
Prac   = require( 'js/prac/Prac' )

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

Stream = require( 'js/util/Stream' )
Build  = require( 'js/prac/Build' )

beforeAll () ->
  buildArgs = { name:'Muse', plane:'Information', op:'' }
  stream = new Stream()
  build  = new Build( buildArgs, stream )
  Util.noop( build )

describe("Build/Build.coffee", () ->
  it("constructor:() ->                                           ", () -> expect(true).toBe(true)  )
  it("core:( name ) ->                                            ", () -> expect(true).toBe(true)  )
  it("@logCore:( Core ) ->                                        ", () -> expect(true).toBe(true)  )
  it("toRows:( rows ) ->                                          ", () -> expect(true).toBe(true)  )
  it("toColumns:( cols ) ->                                       ", () -> expect(true).toBe(true)  )
  it("toGroups:( groups ) ->                                      ", () -> expect(true).toBe(true)  )
  it("toCells:( quels ) ->                                        ", () -> expect(true).toBe(true)  )
  it("notContext:( key ) ->                                       ", () -> expect(true).toBe(true)  )
  it("createPlanes:( SpecPractices, SpecStudies ) ->              ", () -> expect(true).toBe(true)  )
  it("createPractices:( keyPlane, SpecPractices, SpecStudies ) -> ", () -> expect(true).toBe(true)  )
  it("createStudies:( keyPractice, SpecStudies ) ->               ", () -> expect(true).toBe(true)  )
  it("createTopics:( keyStudy ) ->                                ", () -> expect(true).toBe(true)  )
  it("createRoutes:() ->                                          ", () -> expect(true).toBe(true)  )
  it("queryPractiices:( filter ) ->                               ", () -> expect(true).toBe(true)  )
  it("queryStudies:( filter ) ->                                  ", () -> expect(true).toBe(true)  )
  it("practices:( ikw ) -> @Planes[ikw].practices                 ", () -> expect(true).toBe(true)  )
  it("studies:( ikw ) ->                                          ", () -> expect(true).toBe(true)  )
  it("practicesSwitch:( ikw ) ->                                  ", () -> expect(true).toBe(true)  )
  it("conveyTarget:( source ) ->                                  ", () -> expect(true).toBe(true)  )
  it("conduit:( practice ) ->                                     ", () -> expect(true).toBe(true)  )
  it("innovateStudies:( practice ) ->                             ", () -> expect(true).toBe(true)  )
  it("talkUrl:( talk ) ->                                         ", () -> expect(true).toBe(true)  )
  it("logPlanes:( Planes ) ->                                     ", () -> expect(true).toBe(true)  )
)


describe("prac/Prac.coffee", () ->
  it("constructor",                                   () -> expect(true).toBe(true)  )
  it("createDoc:( pane ) -> ",                        () -> expect(true).toBe(true)  )
  it("createMuse:( pane ) -> ",                       () -> expect(true).toBe(true)  )
)

describe("prac/Doc.coffee", () ->
  it("constructor",                                    () -> expect(true).toBe(true)  )
  it("ready:() -> ",                                   () -> expect(true).toBe(true)  )
  it("subscribe:() -> ",                               () -> expect(true).toBe(true)  )
  it("selectContent:( object ) -> ",                   () -> expect(true).toBe(true)  )
  it("chooseContent:( geom ) -> ",                     () -> expect(true).toBe(true)  )
  it("chooseByName:( geom, name ) -> ",                () -> expect(true).toBe(true)  )
  it("chooseBySize:( geom ) -> ",                      () -> expect(true).toBe(true)  )
  it("layout:( geom ) -> ",                            () -> expect(true).toBe(true)  )
  it("loadSlide:( geom ) -> ",                         () -> expect(true).toBe(true)  )
  it("contains:( str, tok ) -> ",                      () -> expect(true).toBe(true)  )
  it("specHasTopic:() -> ",                            () -> expect(true).toBe(true)  )
  it("getStudiesOrTopics:() -> ",                      () -> expect(true).toBe(true)  )
  it("id:( name, ext ) -> ",                           () -> expect(true).toBe(true)  )
  it("create$Center:( pane ) -> ",                     () -> expect(true).toBe(true)  )
  it("createSvg:( pane ) -> ",                         () -> expect(true).toBe(true)  )
  it("createCenter:() -> ",                            () -> expect(true).toBe(true)  )
  it("createTopic:() -> ",                             () -> expect(true).toBe(true)  )
  it("createSlide:() -> ",                             () -> expect(true).toBe(true)  )
  it("htmlPracticeIcon:( css, icon ) -> ",             () -> expect(true).toBe(true)  )
  it("htmlTopicIcon:( css, icon ) -> ",                () -> expect(true).toBe(true)  )
)

describe("prac/Embrace.coffee", () ->
  it("constructor",                                   () -> expect(true).toBe(true)  )
  it("drawSvg:() -> ",                                () -> expect(true).toBe(true)  )
  it("innovateStudies:() -> ",                        () -> expect(true).toBe(true)  )
)

describe("prac/Encourage.coffee", () ->
  it("constructor",                                   () -> expect(true).toBe(true)  )
  it("drawSvg:() -> ",                                () -> expect(true).toBe(true)  )
  it("innovateStudies:() -> ",                        () -> expect(true).toBe(true)  )
)

describe("prac/Innovate.coffee", () ->
  it("constructor() ->                                 ", () -> expect(true).toBe(true)  )
  it("drawSvg:() ->                                    ", () -> expect(true).toBe(true)  )
  it("concept:( ) ->                                   ", () -> expect(true).toBe(true)  )
  it("technology:() ->                                 ", () -> expect(true).toBe(true)  )
  it("facilitate:() ->                                 ", () -> expect(true).toBe(true)  )
  it("westInovate:() ->                                ", () -> expect(true).toBe(true)  )
  it("eastInovate:() ->                                ", () -> expect(true).toBe(true)  )
  it("northInovate:( filter ) ->                       ", () -> expect(true).toBe(true)  )
  it("southInovate:( filter ) ->                       ", () -> expect(true).toBe(true)  )
  it("hexStudy:( study, hexId ) ->                     ", () -> expect(true).toBe(true)  )
  it("hexPos:( dimension ) ->                          ", () -> expect(true).toBe(true)  )
  it("hexPath:( fill, g, x0, y0, pathId ) ->           ", () -> expect(true).toBe(true)  )
  it("hexText:( text, g, x0, y0, textId ) ->           ", () -> expect(true).toBe(true)  )
  it("hexIcon:( icon, g, x0, y0, iconId ) ->           ", () -> expect(true).toBe(true)  )
  it("hexClick:( path, text, svgId ) ->                ", () -> expect(true).toBe(true)  )
  it("hexLoc:( id, j,i, r, fill, text=, icon= ) ->     ", () -> expect(true).toBe(true)  )
  it("x0y0:( j, i, r, x0, y0 ) ->                      ", () -> expect(true).toBe(true)  )
)

describe("prac/Shapes.coffee", () ->
  it("constructor",                                                              () -> expect(true).toBe(true)  )
  it("constructor: ( @app, @prac ) -> ",                                         () -> expect(true).toBe(true)  )
  it("ready:() -> ",                                                             () -> expect(true).toBe(true)  )
  it("isWest:(pos) -> ",                                                         () -> expect(true).toBe(true)  )
  it("layout:( geom, pos, ns, ni ) -> ",                                         () -> expect(true).toBe(true)  )
  it("wedge:( g, r1, r2, a1, a2, x0, y0, fill, text, wedgeId ) -> ",             () -> expect(true).toBe(true)  )
  it("wedgeText:( g, r1, r2, a1, a2, x0, y0, fill, text, wedgeId ) -> ",         () -> expect(true).toBe(true)  )
  it("wedgeClick:( path, wedgeId ) -> ",                                         () -> expect(true).toBe(true)  )
  it("link:( g, a, ra, rb, xc, yc, xd, yd, xe, ye, stroke, thick ) -> ",         () -> expect(true).toBe(true)  )
  it("curve:( g, data, stroke, thick ) -> ",                                     () -> expect(true).toBe(true)  )
  it("keyHole:( g, xc, yc, xs, ys, ro, ri, fill, stroke='none', thick=0 ) -> ",  () -> expect(true).toBe(true)  )
  it("poly:( g, data, fill ) -> ",                                               () -> expect(true).toBe(true)  )
  it("rect:( g, x0, y0, w, h, fill, stroke, text='' ) -> ",                      () -> expect(true).toBe(true)  )
  it("round:( g, x0, y0, w, h, rx, ry, fill, stroke ) -> ",                      () -> expect(true).toBe(true)  )
  it("elipse:( g, cx, cy, rx, ry, fill, stroke ) -> ",                           () -> expect(true).toBe(true)  )
  it("circle:( g, cx, cy, r, fill, stroke ) -> ",                                () -> expect(true).toBe(true)  )
  it("pathPlot:( g, stroke, thick, d )-> ",                                      () -> expect(true).toBe(true)  )
  it("rad:( deg ) -> ",                                                          () -> expect(true).toBe(true)  )
  it("degSVG:( deg ) -> ",                                                       () -> expect(true).toBe(true)  )
  it("radD3:( deg ) -> ",                                                        () -> expect(true).toBe(true)  )
  it("degD3:( rad ) -> ",                                                        () -> expect(true).toBe(true)  )
  it("cos:( deg ) -> ",                                                          () -> expect(true).toBe(true)  )
  it("sin:( deg ) -> ",                                                          () -> expect(true).toBe(true)  )
  it("textFill:( fill, dark='#000000', light='#FFFFFF') -> ",                    () -> expect(true).toBe(true)  )
)