
window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )
D3D    = require( 'js/d3d/D3D' )

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

# Modules
describe "d3d/Axes.coffee", () ->
  it("root        ", () -> expect(true).toBe(true)  )
  it("paths       ", () -> expect(true).toBe(true)  )
  it("libs        ", () -> expect(true).toBe(true)  )