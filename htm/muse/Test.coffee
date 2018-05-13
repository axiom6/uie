

Stream      = require( 'js/util/Stream' )
Build       = require( 'js/prac/Build' )

beforeAll () ->
  buildArgs = { name:'Muse', plane:'Information', op:''        }
  stream = new Stream()
  build  = new Build( buildArgs, stream )
  Util.noop( build )

# Modules
describe("exit/Muse.coffee", () ->
  it("root        ", () -> expect(true).toBe(true)  )
  it("paths       ", () -> expect(true).toBe(true)  )
  it("libs        ", () -> expect(true).toBe(true)  )
  it("init        ", () -> expect(true).toBe(true)  )
  it("Util.loadInitLibs( root, paths, libs, init )",  () -> expect(true).toBe(true)  )
)

# Muse
describe("exit/Muse.coffee", () ->
  it("constructor:() ->         ", () -> expect(true).toBe(true)  )
)

describe("exit/Action.coffee", () ->
  it("constructor:( @app ) ->                        ", () -> expect(true).toBe(true)  )
  it("plane:( topic ) ->                             ", () -> expect(true).toBe(true)  )
  it("navigate:( topic ) ->                          ", () -> expect(true).toBe(true)  )
  it("about:( topic ) ->                             ", () -> expect(true).toBe(true)  )
  it("settings:( topic ) ->                          ", () -> expect(true).toBe(true)  )
  it("submit:(  inVal ) ->                           ", () -> expect(true).toBe(true)  )
  it("search:( value ) ->                            ", () -> expect(true).toBe(true)  )
  it("signon:( value ) ->                            ", () -> expect(true).toBe(true)  )
)