
Visual   = require( 'js/visual/Visual' )
#mathbox = require( 'mathbox' )

class MathBoxV

  module.exports = MathBoxV # Util.Export( MathBoxV, 'visual/MathBoxV' )

  constructor:( @stream ) ->

  # High level input / display / demo
  inputData:(          obj ) -> Util.noop( obj )
  outputData:(         obj ) -> Util.noop( obj )
  displayCartesian:(   obj ) -> Util.noop( obj )
  displayCylindrical:( obj ) -> Util.noop( obj )
  displaySpherical:(   obj ) -> Util.noop( obj )
  displayScatter:(     obj ) -> Util.noop( obj )
  displayCurves:(      obj ) -> Util.noop( obj )
  displayCurveFits:(   obj ) -> Util.noop( obj )
  displaySurfaces:(    obj ) -> Util.noop( obj )
  displaySurfaceFits:( obj ) -> Util.noop( obj )
  displayShapes:(      obj ) -> Util.noop( obj )
  displayVectors:(     obj ) -> Util.noop( obj )
  displayQuanterions:( obj ) -> Util.noop( obj )
  displaySolar:(       obj ) -> Util.noop( obj )

  # MBox module
  mboxMBox:(     obj ) -> Util.noop( obj )
  coordMBox:(    obj ) -> Util.noop( obj )
  colorMBox:(    obj ) -> Util.noop( obj )
  museMBox:(     obj ) -> Util.noop( obj )
  namesMBox:(    obj ) -> Util.noop( obj )
  ncsMBox:(      obj ) -> Util.noop( obj )
  regressMBox:(  obj ) -> Util.noop( obj )

  # New MBox Modules
  cameraMBox:(   obj ) -> Util.noop( obj )
  platMBox:(     obj ) -> Util.noop( obj )
  
  # MathBox primitives
  axis:(    obj ) -> Util.noop( obj )   # ['draw', 'Draw an axis', {}, {end: "true", zBias: "-1"}]
  face:(    obj ) -> Util.noop( obj )   # ['draw', 'Draw polygon faces']
  grid:(    obj ) -> Util.noop( obj )   # ['draw', 'Draw a 2D line grid', {}, {width: "1", zBias: "-2"}]
  line:(    obj ) -> Util.noop( obj )   # ['draw', 'Draw lines']
  point:(   obj ) -> Util.noop( obj )   # ['draw', 'Draw points']
  strip:(   obj ) -> Util.noop( obj )   # ['draw', 'Draw triangle strips']
  surface:( obj ) -> Util.noop( obj )   # ['draw', 'Draw surfaces', {}, {lineX: "false", lineY: "false"}]
  ticks:(   obj ) -> Util.noop( obj )   # ['draw', 'Draw ticks']
  vector:(  obj ) -> Util.noop( obj )   # ['draw', 'Draw vectors']

  view:(           obj ) -> Util.noop( obj )   # ['view', 'Adjust view range']
  cartesian:(      obj ) -> Util.noop( obj )   # ['view', 'Apply cartesian view']
  cartesian4:(     obj ) -> Util.noop( obj )   # ['view', 'Apply 4D cartesian view']
  polar:(          obj ) -> Util.noop( obj )   # ['view', 'Apply polar view']
  spherical:(      obj ) -> Util.noop( obj )   # ['view', 'Apply spherical view']
  stereographic:(  obj ) -> Util.noop( obj )   # ['view', 'Apply stereographic projection']
  stereographic4:( obj ) -> Util.noop( obj )   # ['view', 'Apply 4D stereographic projection']

  transform:(  obj ) -> Util.noop( obj )  # ['transform','Transform geometry in 3D']
  transform4:( obj ) -> Util.noop( obj )  # ['transform','Transform geometry in 4D']
  vertex:(     obj ) -> Util.noop( obj )  # ['transform','Apply custom vertex shader pass']
  fragment:(   obj ) -> Util.noop( obj )  # ['transform','Apply custom fragment shader pass']
  layer:(      obj ) -> Util.noop( obj )  # ['transform','Independent 2D layer/overlay']
  mask:(       obj ) -> Util.noop( obj )  # ['transform','Apply custom mask pass']

  array:(    obj ) -> Util.noop( obj )  # ['data','1D array', {expr: "function (emit, i, time, delta) { ... }"}]
  interval:( obj ) -> Util.noop( obj )  # ['data','1D sampled array', {expr: "function (emit, x, i, time, delta) { ... }"}]
  matrix:(   obj ) -> Util.noop( obj )  # ['data','2D matrix', {expr: "function (emit, i, j, time, delta) { ... }"}]
  area:(     obj ) -> Util.noop( obj )  # ['data','2D sampled matrix', {expr: "function (emit, x, y, i, j, time, delta) { ... }"}]
  voxel:(    obj ) -> Util.noop( obj )  # ['data','3D voxels', {expr: "function (emit, i, j, k, time, delta) { ... }"}]
  volume:(   obj ) -> Util.noop( obj )  # ['data','3D sampled voxels', {expr: "function (emit, x, y, z, i, j, k, time, delta) { ... }"}]
  scale:(    obj ) -> Util.noop( obj )  # ['data','Human-friendly divisions on an axis, subdivided as needed']

  html:( obj ) -> Util.noop( obj )   # ['overlay','HTML element source']
  dom:(  obj ) -> Util.noop( obj )   # ['overlay','HTML DOM injector']

  text:(   obj ) -> Util.noop( obj ) # ['text','GL text source', {}, {minFilter: '"linear"', magFilter: '"linear"'}]
  format:( obj ) -> Util.noop( obj ) # ['text','Text formatter', {expr: "function (x, y, z, w, i, j, k, l, time, delta) { ... }"}, {minFilter: '"linear"', magFilter: '"linear"'}]
  retext:( obj ) -> Util.noop( obj ) # ['text','Text atlas resampler']
  label:(  obj ) -> Util.noop( obj ) # ['text','Draw GL labels']

  clamp:(     obj ) -> Util.noop( obj )  # ['operator','Clamp out-of-bounds samples to the nearest data point']
  grow:(      obj ) -> Util.noop( obj )  # ['operator','Scale data relative to reference data point']
  join:(      obj ) -> Util.noop( obj )  # ['operator','Join two array dimensions into one by concatenating rows/columns/stacks']
  lerp:(      obj ) -> Util.noop( obj )  # ['operator','Linear interpolation of data']
  memo:(      obj ) -> Util.noop( obj )  # ['operator','Memoize data to an array/texture']
  readback:(  obj ) -> Util.noop( obj )  # ['operator','Read data back to a binary JavaScript array', {expr: "function (x, y, z, w, i, j, k, l) { ... }"}]
  resample:(  obj ) -> Util.noop( obj )  # ['operator','Resample data to new dimensions with a shader']
  repeat:(    obj ) -> Util.noop( obj )  # ['operator','Repeat data in one or more dimensions']
  swizzle:(   obj ) -> Util.noop( obj )  # ['operator','Swizzle data values']
  spread:(    obj ) -> Util.noop( obj )  # ['operator','Spread data values according to array indices']
  split:(     obj ) -> Util.noop( obj )  # ['operator','Split one array dimension into two by splitting rows/columns/etc']
  slice:(     obj ) -> Util.noop( obj )  # ['operator','Select one or more rows/columns/stacks']
  subdivide:( obj ) -> Util.noop( obj )  # ['operator','Subdivide data points evenly or with a bevel']
  transpose:( obj ) -> Util.noop( obj )  # ['operator','Transpose array dimensions']

  group:(   obj ) -> Util.noop( obj )  # ['base','Group elements for visibility and activity']
  inherit:( obj ) -> Util.noop( obj )  # ['base','Inherit and inject a trait from another element']
  root:(    obj ) -> Util.noop( obj )  # ['base','Tree root']
  unit:(    obj ) -> Util.noop( obj )  # ['base','Change unit sizing for drawing ops']

  shader:(  obj ) -> Util.noop( obj )  # ['shader','Custom shader snippet']
  camera:(  obj ) -> Util.noop( obj )  # ['camera','Camera instance or proxy']
  rtt:(     obj ) -> Util.noop( obj )  # ['rtt','Render objects to a texture', {}, {minFilter: '"linear"', magFilter: '"linear"', type: '"unsignedByte"'}]
  compose:( obj ) -> Util.noop( obj )  # ['rtt','Full-screen render pass', {}, {zWrite: "false", zTest: "false", color: '"white"'}]

  clock:( obj ) -> Util.noop( obj )  # ['time','Relative clock that starts from zero.']
  now:(   obj ) -> Util.noop( obj )  # ['time','Absolute UNIX time in seconds since 01/01/1970']

  move:(    obj ) -> Util.noop( obj )  # ['present','Move elements in/out on transition']
  play:(    obj ) -> Util.noop( obj )  # ['present','Play a sequenced animation']
  present:( obj ) -> Util.noop( obj )  # ['present','Present a tree of slides']
  reveal:(  obj ) -> Util.noop( obj )  # ['present','Reveal/hide elements on transition']
  slide:(   obj ) -> Util.noop( obj )  # ['present','Presentation slide']
  step:(    obj ) -> Util.noop( obj )  # ['present','Step through a sequenced animation']
