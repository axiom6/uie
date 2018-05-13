

window.xUtil.fixTestGlobals()
Stream = require( 'js/util/Stream' )
UI     = require( 'js/ui/UI')

beforeAll () ->
  stream = new Stream()
  Util.noop( stream )

class Test


describe("ui/UI.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Btn.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Group.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)
describe("ui/Navb.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Pane.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Part.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Stream.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/Tocs.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)

describe("ui/View.coffee", () ->
  it("constructor",              () -> expect(true).toBe(true)  )
)
