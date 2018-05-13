
Visual = require( 'js/visual/Visual' )
d3     = require( 'd3' )

class D3V

  module.exports = D3V # Util.Export( D3V, 'visual/D3V' )

  constructor:( @stream ) ->

  # D3 "version": "4.0.0-alpha.40"

  # array": "0.7.1",
  # axis": "0.3.1",
  # collection": "0.1.2",
  # color": "0.4.2",
  # dispatch": "0.4.3",
  # drag": "0.1.2",
  # dsv": "0.3.2",
  # ease": "0.7.0",
  # force": "0.6.2",
  # format": "0.5.1",
  # hierarchy": "0.2.2",
  # interpolate": "0.7.0",
  # path": "0.1.5",
  # polygon": "0.2.1",
  # quadtree": "0.7.2",
  # queue": "2.0.3",
  # random": "0.2.1",
  # request": "0.4.6",
  # scale": "0.7.0",
  # selection": "0.7.2",
  # shape": "0.6.0",
  # time": "0.2.5",
  # time-format": "0.3.2",
  # timer": "0.4.3",
  # transition": "0.2.8",
  # voronoi": "0.3.2"

  # NPM Plugins - Installed
  # chord
  # hexbin
  # sankey

  # d3-selection-multi
  # zoom
  # brush
  # geo
  # geo-projection

#
# Array manipulation, ordering, searching, summarizing, etc.

# -- Statistics Methods for computing basic summary statistics.
#
#    d3.min - compute the minimum value in an array.
#    d3.max - compute the maximum value in an array.
#    d3.extent - compute the minimum and maximum value in an array.
#    d3.sum - compute the sum of an array of numbers.
#    d3.mean - compute the arithmetic mean of an array of numbers.
#    d3.median - compute the median of an array of numbers (the 0.5-quantile).
#    d3.quantile - compute a quantile for a sorted array of numbers.
#    d3.variance - compute the variance of an array of numbers.
#    d3.deviation - compute the standard deviation of an array of numbers.
#
# -- Histograms Bin discrete samples into continuous, non-overlapping intervals.
#
#    d3.histogram - create a new histogram generator.
#       histogram - compute the histogram for the given array of samples.
#       histogram.value - specify a value accessor for each sample.
#       histogram.domain - specify the interval of observable values.
#       histogram.thresholds - specify how values are divided into bins.
#    d3.thresholdFreedmanDiaconis - the Freedman–Diaconis binning rule.
#    d3.thresholdScott - Scott’s normal reference binning rule.
#    d3.thresholdSturges - Sturges’ binning formula.
#
# -- Search Methods for searching arrays for a specific element.
#
#   d3.scan - linear search for an element using a comparator.
#   d3.bisect - binary search for a value in a sorted array.
#   d3.bisectRight - binary search for a value in a sorted array.
#   d3.bisectLeft - binary search for a value in a sorted array.
#   d3.bisector - bisect using an accessor or comparator.
#      bisector.left - bisectLeft, with the given comparator.
#      bisector.right - bisectRight, with the given comparator.
#   d3.ascending - compute the natural order of two values.
#   d3.descending - compute the natural order of two values.
#
# -- Transformations Methods for transforming arrays and for generating new arrays.
#
#    d3.merge - merge multiple arrays into one array.
#    d3.pairs - create an array of adjacent pairs of elements.
#    d3.permute - reorder an array of elements according to an array of indexes.
#    d3.shuffle - randomize the order of an array.
#    d3.ticks - generate representative values from a numeric interval.
#    d3.tickStep - generate representative values from a numeric interval.
#    d3.range - generate a range of numeric values.
#    d3.transpose - transpose an array of arrays.
#    d3.zip - transpose a variable number of arrays.
#
# -- Axes Human-readable reference marks for scales.
#
#    d3.axisTop - create a new top-oriented axis generator.
#    d3.axisRight - create a new right-oriented axis generator.
#    d3.axisBottom - create a new bottom-oriented axis generator.
#    d3.axisLeft - create a new left-oriented axis generator.
#    axis - generate an axis for the given selection.
#    axis.scale - set the scale.
#    axis.ticks - customize how ticks are generated and formatted.
#    axis.tickArguments - customize how ticks are generated and formatted.
#    axis.tickValues - set the tick values explicitly.
#    axis.tickFormat - set the tick format explicitly.
#    axis.tickSize - set the size of the ticks.
#    axis.tickSizeInner - set the size of inner ticks.
#    axis.tickSizeOuter - set the size of outer (extent) ticks.
#    axis.tickPadding - set the padding between ticks and labels.
#
# -- Collections Handy data structures for elements keyed by string.
#
#   -- Methods for converting associative arrays (objects) to arrays.
#
#      d3.keys - list the keys of an associative array.
#      d3.values - list the values of an associated array.
#      d3.entries - list the key-value entries of an associative array.
#
#   -- Maps Like ES6 Map, but with string keys and a few other differences.
#
#  d3.map - create a new, empty map.
#     map.has - returns true if the map contains the given key.
#     map.get - get the value for the given key.
#     map.set - set the value for the given key.
#     map.remove - remove the entry for given key.
#     map.clear - remove all entries.
#     map.keys - get the array of keys.
#     map.values - get the array of values.
#     map.entries - get the array of entries (key-values objects).
#     map.each - call a function for each entry.
#     map.empty - returns false if the map has at least one entry.
#     map.size - compute the number of entries.
#
#   -- Sets Like ES6 Set, but with string keys and a few other differences.
#
#  d3.set - create a new, empty set.
#     set.has - returns true if the set contains the given value.
#     set.add - add the given value.
#     set.remove - remove the given value.
#     set.clear - remove all values.
#     set.values - get the array of values.
#     set.each - call a function for each value.
#     set.empty - returns true if the set has at least one value.
#     set.size - compute the number of values.
#
#     Nests Group data into arbitrary hierarchies.
#
# d3.nest - create a new nest generator.
#    nest.key - add a level to the nest hierarchy.
#    nest.sortKeys - sort the current nest level by key.
#    nest.sortValues - sort the leaf nest level by value.
#    nest.rollup - specify a rollup function for leaf values.
#    nest.map - generate the nest, returning a map.
#    nest.object - generate the nest, returning an associative array.
#    nest.entries - generate the nest, returning an array of key-values tuples.
#
# Colors Color manipulation and color space conversion.
#
# d3.color - parse the given CSS color specifier.
#    color.rgb - compute the RGB equivalent of this color.
#    color.brighter - create a brighter copy of this color.
#               color.darker - create a darker copy of this color.
#                   color.displayable - returns true if the color is displayable on standard hardware.
#   color.toString - format the color as an RGB hexadecimal string.
#     d3.rgb - create a new RGB color.
#       d3.hsl - create a new HSL color.
#         d3.lab - create a new Lab color.
#           d3.hcl - create a new HCL color.
#             d3.cubehelix - create a new Cubehelix color.
# #
#               Delimiter-Separated Values
# #
# Parse and format delimiter-separated values, most commonly CSV and TSV.
# #
#     d3.dsvFormat - create a new parser and formatter for the given delimiter.
#   dsv.parse - parse the given string, returning an array of objects.
#     dsv.parseRows - parse the given string, returning an array of rows.
#       dsv.format - format the given array of objects.
#         dsv.formatRows - format the given array of rows.
#           d3.csvParse - parse the given CSV string, returning an array of objects.
#             d3.csvParseRows - parse the given CSV string, returning an array of rows.
#               d3.csvFormat - format the given array of objects as CSV.
#                   d3.csvFormatRows - format the given array of rows as CSV.
#                       d3.tsvParse - parse the given TSV string, returning an array of objects.
#                         d3.tsvParseRows - parse the given TSV string, returning an array of rows.
#                           d3.tsvFormat - format the given array of objects as TSV.
#                               d3.tsvFormatRows - format the given array of rows as TSV.
# #
#                                 Dispatches
# #
# Separate concerns using named callbacks.
# #
#   d3.dispatch - create a custom event dispatcher.
#     dispatch.on - register or unregister an event listener.
#       dispatch.copy - create a copy of a dispatcher.
#           dispatch.call - dispatch an event to registered listeners.
#             dispatch.apply - dispatch an event to registered listeners.
# #
#             Dragging
# #
# Drag and drop SVG, HTML or Canvas using mouse or touch input.
# #
#       d3.drag - create a drag behavior.
#         drag - apply the drag behavior to a selection.
#           drag.container - set the coordinate system.
#             drag.filter - ignore some initiating input events.
#               drag.subject - set the thing being dragged.
#                 drag.x - set the x-coordinate of the subject.
#                     drag.y - set the y-coordinate of the subject.
#                         drag.on - listen for drag events.
# event.on - listen for drag events on the current gesture.
# #
# Easings
# #
# Easing functions for smooth animation.
# #
# ease - ease the given normalized time.
#   d3.easeLinear - linear easing; the identity function.
#   d3.easePolyIn - polynomial easing; raises time to the given power.
#   d3.easePolyOut - reverse polynomial easing.
#     d3.easePolyInOut - symmetric polynomial easing.
#       poly.exponent - specify the polynomial exponent.
#         d3.easeQuad - an alias for easeQuadInOut.
#           d3.easeQuadIn - quadratic easing; squares time.
#   d3.easeQuadOut - reverse quadratic easing.
#     d3.easeQuadInOut - symmetric quadratic easing.
#       d3.easeCubic - an alias for easeCubicInOut.
#         d3.easeCubicIn - cubic easing; cubes time.
#   d3.easeCubicOut - reverse cubic easing.
#     d3.easeCubicInOut - symmetric cubic easing.
#       d3.easeSin - an alias for easeSinInOut.
#         d3.easeSinIn - sinusoidal easing.
#           d3.easeSinOut - reverse sinusoidal easing.
#             d3.easeSinInOut - symmetric sinusoidal easing.
#               d3.easeExp - an alias for easeExpInOut.
#                 d3.easeExpIn - exponential easing.
#                   d3.easeExpOut - reverse exponential easing.
#                     d3.easeExpInOut - symmetric exponential easing.
#                       d3.easeCircle - an alias for easeCircleInOut.
#                         d3.easeCircleIn - circular easing.
#                           d3.easeCircleOut - reverse circular easing.
#                             d3.easeCircleInOut - symmetric circular easing.
#                               d3.easeElastic - an alias for easeElasticOut.
#                                 d3.easeElasticIn - elastic easing, like a rubber band.
#                                   d3.easeElasticOut - reverse elastic easing.
#                                     d3.easeElasticInOut - symmetric elastic easing.
#                                       elastic.amplitude - specify the elastic amplitude.
#                                         elastic.period - specify the elastic period.
#                                           d3.easeBack - an alias for easeBackInOut.
#                                             d3.easeBackIn - anticipatory easing, like a dancer bending his knees before jumping.
#                                               d3.easeBackOut - reverse anticipatory easing.
#                                                 d3.easeBackInOut - symmetric anticipatory easing.
#                                                   back.overshoot - specify the amount of overshoot.
#                                                     d3.easeBounce - an alias for easeBounceOut.
#                                                       d3.easeBounceIn - bounce easing, like a rubber ball.
#                                                         d3.easeBounceOut - reverse bounce easing.
#                                                           d3.easeBounceInOut - symmetric bounce easing.
# #
#                                                           Forces
# #
# Force-directed graph layout using velocity Verlet integration.
# #
#   d3.forceSimulation - create a new force simulation.
#     simulation.restart - reheat and restart the simulation’s timer.
#   simulation.stop - stop the simulation’s timer.
#   simulation.tick - advance the simulation one step.
#     simulation.nodes - set the simulation’s nodes.
#   simulation.alpha - set the current alpha.
#     simulation.alphaMin - set the minimum alpha threshold.
#       simulation.alphaDecay - set the alpha exponential decay rate.
#         simulation.alphaTarget - set the target alpha.
#           simulation.drag - set the drag coefficient.
#             simulation.force - add or remove a force.
#               simulation.fix - fix a node in a given position.
#                   simulation.unfix - release a fixed node.
#                     simulation.find - find the closest node to the given position.
#                       simulation.on - add or remove an event listener.
#                         force - apply the force.
#                           force.initialize - initialize the force with the given nodes.
#                             d3.forceCenter - create a centering force.
#                               center.x - set the center x-coordinate.
#                                 center.y - set the center y-coordinate.
#                                   d3.forceCollide - create a circle collision force.
#                                     collide.radius - set the circle radius.
#                                       collide.strength - set the collision resolution strength.
#                                         collide.iterations - set the number of iterations.
#                                           d3.forceLink - create a link force.
#                                             link.links - set the array of links.
#                                               link.id - link nodes by numeric index or string identifier.
#     link.distance - set the link distance.
#       link.strength - set the link strength.
#         link.iterations - set the number of iterations.
#           d3.forceManyBody - create a many-body force.
#               manyBody.strength - set the force strength.
#                 manyBody.theta - set the Barnes–Hut approximation accuracy.
#   manyBody.distanceMin - limit the force when nodes are close.
#   manyBody.distanceMax - limit the force when nodes are far.
#   d3.forceX - create an x-positioning force.
#       x.strength - set the force strength.
#         x.x - set the target x-coordinate.
#           d3.forceY - create an y-positioning force.
#               y.strength - set the force strength.
#                 y.y - set the target y-coordinate.
# #
#                   Hierarchies
# #
# Layout algorithms for visualizing hierarchical data.
# #
#   d3.hierarchy - constructs a root node from hierarchical data.
#     node.ancestors - generate an array of ancestors.
#       node.descendants - generate an array of descendants.
#         node.leaves - generate an array of leaves.
#           node.path - generate the shortest path to another node.
#             node.sum - evaluate and aggregate quantitative values.
#               node.sort - sort all descendant siblings.
#                 node.each - breadth-first traversal.
#                   node.eachAfter - post-order traversal.
#                     node.eachBefore - pre-order traversal.
#                       node.copy - copy a hierarchy.
#                         d3.stratify - create a new stratify operator.
#                           stratify - construct a root node from tabular data.
#                             stratify.id - set the node id accessor.
#                               stratify.parentId - set the parent node id accessor.
#                                 d3.cluster - create a new cluster (dendrogram) layout.
#                                   cluster - layout the specified hierarchy in a dendrogram.
#                                       cluster.size - set the layout size.
#                                         cluster.nodeSize - set the node size.
#                                           cluster.separation - set the separation between leaves.
#                                             d3.tree - create a new tidy tree layout.
#                                               tree - layout the specified hierarchy in a tidy tree.
#                                                   tree.size - set the layout size.
#                                                     tree.nodeSize - set the node size.
#                                                       tree.separation - set the separation between nodes.
#                                                         d3.treemap - create a new treemap layout.
#                                                           treemap - layout the specified hierarchy as a treemap.
#                                                             treemap.tile - set the tiling method.
#                                                               treemap.size - set the layout size.
#                                                                 treemap.round - set whether the output coordinates are rounded.
#                                                                   treemap.padding - set the padding.
#                                                                     treemap.paddingInner - set the padding between siblings.
#                                                                       treemap.paddingOuter - set the padding between parent and children.
#                                                                         treemap.paddingTop - set the padding between the parent’s top edge and children.
#   treemap.paddingRight - set the padding between the parent’s right edge and children.
#   treemap.paddingBottom - set the padding between the parent’s bottom edge and children.
#   treemap.paddingLeft - set the padding between the parent’s left edge and children.
#   d3.treemapBinary - tile using a balanced binary tree.
#     d3.treemapDice - tile into a horizontal row.
#       d3.treemapSlice - tile into a vertical column.
#         d3.treemapSliceDice - alternate between slicing and dicing.
#           d3.treemapSquarify - tile using squarified rows per Bruls et. al.
#             squarify.ratio - set the desired rectangle aspect ratio.
#               d3.partition - create a new partition (icicle or sunburst) layout.
#                 partition - layout the specified hierarchy as a partition diagram.
#                   partition.size - set the layout size.
#                     partition.round - set whether the output coordinates are rounded.
#                       partition.padding - set the padding.
#                         d3.pack - create a new circle-packing layout.
#                             pack - layout the specified hierarchy using circle-packing.
#                               pack.radius - set the radius accessor.
#                                 pack.size - set the layout size.
#                                   pack.padding - set the padding.
#                                     d3.packSiblings - pack the specified array of circles.
#                                       d3.packEnclose - enclose the specified array of circles.
# #
#                                         Interpolators
# #
# Interpolate numbers, colors, strings, arrays, objects, whatever!
# #
# d3.interpolate - interpolate arbitrary values.
#   d3.interpolateArray - interpolate arrays of arbitrary values.
#       d3.interpolateNumber - interpolate numbers.
#         d3.interpolateObject - interpolate arbitrary objects.
#           d3.interpolateRound - interpolate integers.
#             d3.interpolateString - interpolate strings with embedded numbers.
#               d3.interpolateTransformCss - interpolate 2D CSS transforms.
#   d3.interpolateTransformSvg - interpolate 2D SVG transforms.
#   d3.interpolateZoom - zoom and pan between two views.
#     d3.interpolateRgb - interpolate RGB colors.
#       d3.interpolateHsl - interpolate HSL colors.
#         d3.interpolateHslLong - interpolate HSL colors, the long way.
#           d3.interpolateLab - interpolate Lab colors.
#             d3.interpolateHcl - interpolate HCL colors.
#               d3.interpolateHclLong - interpolate HCL colors, the long way.
#                 d3.interpolateCubehelix - interpolate Cubehelix colors.
#                   d3.interpolateCubehelixLong - interpolate Cubehelix colors, the long way.
#                     interpolate.gamma - apply gamma correction during interpolation.
# #
#                     Number Formats
# #
# Format numbers for human consumption.
# #
# d3.format - alias for enUs.format.
# d3.formatPrefix - alias for enUs.formatPrefix.
# d3.formatSpecifier - parse a number format specifier.
#   d3.formatLocale - define a custom locale.
#     locale.format - create a number format.
#       locale.formatPrefix - create a SI-prefix number format.
#           d3.formatCaEs - the Catalan (Spain) locale.
#             d3.formatCsCz - the Czech (Czech Republic) locale.
#               d3.formatDeCh - the German (Switzerland) locale.
#                 d3.formatDeDe - the German (Germany) locale.
#                   d3.formatEnCa - the English (Canada) locale.
#                     d3.formatEnGb - the English (United Kingdom) locale.
#                       d3.formatEnUs - the English (United States) locale.
#                         d3.formatEsEs - the Spanish (Spain) locale.
#                           d3.formatFiFi - the Finnish (Finland) locale.
#                             d3.formatFrCa - the French (Canada) locale.
#                               d3.formatFrFr - the French (France) locale.
#                                 d3.formatHeIl - the Hebrew (Israel) locale.
#                                   d3.formatHuHu - the Hungarian (Hungary) locale.
#                                     d3.formatItIt - the Italian (Italy) locale.
#                                       d3.formatJaJp - the Japanese (Japan) locale.
#                                         d3.formatKoKr - the Korean (South Korea) locale.
#                                           d3.formatMkMk - the Macedonian (Macedonia) locale.
#                                             d3.formatNlNl - the Dutch (Netherlands) locale.
#                                               d3.formatPlPl - the Polish (Poland) locale.
#                                                 d3.formatPtBr - the Portuguese (Brazil) locale.
#                                                   d3.formatRuRu - the Russian (Russia) locale.
#                                                     d3.formatSvSe - the Swedish (Sweden) locale.
#                                                       d3.formatZhCn - the Chinese (China) locale.
#                                                         d3.precisionFixed - compute decimal precision for fixed-point notation.
#                                                             d3.precisionPrefix - compute decimal precision for SI-prefix notation.
#                                                                 d3.precisionRound - compute significant digits for rounded notation.
# #
# Paths
# #
# Serialize Canvas path commands to SVG.
# #
#   d3.path - create a new path serializer.
#     path.moveTo - move to the given point.
#       path.closePath - close the current subpath.
#         path.lineTo - draw a straight line segment.
#           path.quadraticCurveTo - draw a quadratic Bézier segment.
#             path.bezierCurveTo - draw a cubic Bézier segment.
#               path.arcTo - draw a circular arc segment.
#                 path.arc - draw a circular arc segment.
#                   path.rect - draw a rectangle.
#                     path.toString - serialize to an SVG path data string.
# #
#                     Polygons
# #
# Geometric operations for two-dimensional polygons.
# #
#     d3.polygonArea - compute the area of the given polygon.
#         d3.polygonCentroid - compute the centroid of the given polygon.
#             d3.polygonHull - compute the convex hull of the given points.
#                 d3.polygonContains - test whether a point is inside a polygon.
#                     d3.polygonLength - compute the length of the given polygon’s perimeter.
# #
# Quadtrees
# #
# Two-dimensional recursive spatial subdivision.
# #
#   d3.quadtree - create a new, empty quadtree.
#     quadtree.x - set the x accessor.
#       quadtree.y - set the y accessor.
#         quadtree.add - add a datum to a quadtree.
#           quadtree.remove - remove a datum from a quadtree.
#             quadtree.copy - create a copy of a quadtree.
#                 quadtree.root - get the quadtree’s root node.
#   quadtree.data - retrieve all data from the quadtree.
#     quadtree.size - count the number of data in the quadtree.
#         quadtree.find - quickly find the closest datum in a quadtree.
#             quadtree.visit - selectively visit nodes in a quadtree.
#                 quadtree.visitAfter - visit all nodes in a quadtree.
#                     quadtree.cover - extend the quadtree to cover a point.
#                       quadtree.extent - extend the quadtree to cover an extent.
# #
#                       Queues
# #
# Evaluate asynchronous tasks with configurable concurrency.
# #
#   d3.queue - manage the concurrent evaluation of asynchronous tasks.
#       queue.defer - register a task for evaluation.
#         queue.abort - abort any active tasks and cancel any pending ones.
#             queue.await - register a callback for when tasks complete.
#   queue.awaitAll - register a callback for when tasks complete.
# #
# Random Numbers
# #
# Generate random numbers from various distributions.
# #
#   d3.randomUniform - from a uniform distribution.
#     d3.randomNormal - from a normal distribution.
#       d3.randomLogNormal - from a log-normal distribution.
#           d3.randomBates - from a Bates distribution.
#             d3.randomIrwinHall - from an Irwin–Hall distribution.
#   d3.randomExponential - from an exponential distribution.
# #
#   Requests
# #
# A convenient alternative to asynchronous XMLHttpRequest.
# #
#   d3.request - make an asynchronous request.
#     request.header - set a request header.
#       request.user - set the user for authentication.
#         request.password - set the password for authentication.
#           request.mimeType - set the MIME type.
#             request.timeout - set the timeout in milliseconds.
#               request.responseType - set the response type.
#                 request.response - set the response function.
#                   request.get - send a GET request.
#                     request.post - send a POST request.
#                       request.send - set the request.
#                         request.abort - abort the request.
#                           request.on - listen for a request event.
#   d3.csv - get a comma-separated values (CSV) file.
#       d3.html - get an HTML file.
#         d3.json - get a JSON file.
#           d3.text - get a plain text file.
#             d3.tsv - get a tab-separated values (TSV) file.
#                 d3.xml - get an XML file.
# #
#                 Scales
# #
# Encodings that map abstract data to visual representation.
# Continuous Scales
# #
# Map a continuous, quantitative domain to a continuous range.
# #
#   continuous - compute the range value corresponding to a given domain value.
#     continuous.invert - compute the domain value corresponding to a given range value.
#       continuous.domain - set the input domain.
#         continuous.range - set the output range.
#           continuous.rangeRound - set the output range and enable rounding.
#               continuous.clamp - enable clamping to the domain or range.
#                 continuous.interpolate - set the output interpolator.
#                   continuous.ticks - compute representative values from the domain.
#                     continuous.tickFormat - format ticks for human consumption.
# continuous.nice - extend the domain to nice round numbers.
#   continuous.copy - create a copy of this scale.
#       d3.scaleLinear - create a quantitative linear scale.
#         d3.scalePow - create a quantitative power scale.
#           pow - compute the range value corresponding to a given domain value.
#             pow.invert - compute the domain value corresponding to a given range value.
#               pow.exponent - set the power exponent.
#                 pow.domain - set the input domain.
#                   pow.range - set the output range.
#                     pow.rangeRound - set the output range and enable rounding.
#                         pow.clamp - enable clamping to the domain or range.
#                           pow.interpolate - set the output interpolator.
#                             pow.ticks - compute representative values from the domain.
#                               pow.tickFormat - format ticks for human consumption.
# pow.nice - extend the domain to nice round numbers.
#   pow.copy - create a copy of this scale.
#       d3.scaleSqrt - create a quantitative power scale with exponent 0.5.
#         d3.scaleLog - create a quantitative logarithmic scale.
#           log - compute the range value corresponding to a given domain value.
#             log.invert - compute the domain value corresponding to a given range value.
#               log.base - set the logarithm base.
#                 log.domain - set the input domain.
#                   log.range - set the output range.
#                     log.rangeRound - set the output range and enable rounding.
#                         log.clamp - enable clamping to the domain or range.
#                           log.interpolate - set the output interpolator.
#                             log.ticks - compute representative values from the domain.
#                               log.tickFormat - format ticks for human consumption.
# log.nice - extend the domain to nice round numbers.
#   log.copy - create a copy of this scale.
#       d3.scaleIdentity - create a quantitative identity scale.
#         d3.scaleTime - create a linear scale for time.
#           time - compute the range value corresponding to a given domain value.
#             time.invert - compute the domain value corresponding to a given range value.
#               time.domain - set the input domain.
#                 time.range - set the output range.
#                   time.rangeRound - set the output range and enable rounding.
#                       time.clamp - enable clamping to the domain or range.
#                         time.interpolate - set the output interpolator.
#                           time.ticks - compute representative values from the domain.
#                             time.tickFormat - format ticks for human consumption.
# time.nice - extend the domain to nice round times.
#   time.copy - create a copy of this scale.
#       d3.scaleUtc - create a linear scale for UTC.
# #
#       Sequential Color Scales
# #
# Map a continuous, quantitative domain to a continuous, fixed color ramp.
# #
#   d3.scaleViridis - a dark-to-light color scheme.
#       d3.scaleInferno - a dark-to-light color scheme.
#           d3.scaleMagma - a dark-to-light color scheme.
#               d3.scalePlasma - a dark-to-light color scheme.
#                   d3.scaleWarm - a rotating-hue color scheme.
#                       d3.scaleCool - a rotating-hue color scheme.
#                           d3.scaleRainbow - a cyclical rotating-hue color scheme.
#                               d3.scaleCubehelix - a dark-to-light, rotating-hue color scheme.
# #
#                                 Quantize Scales
# #
# Map a continuous, quantitative domain to a discrete range.
# #
#   d3.scaleQuantize - create a uniform quantizing linear scale.
#     quantize - compute the range value corresponding to a given domain value.
#       quantize.invertExtent - compute the domain values corresponding to a given range value.
#         quantize.domain - set the input domain.
#           quantize.range - set the output range.
#             quantize.nice - extend the domain to nice round numbers.
#               quantize.ticks - compute representative values from the domain.
#                 quantize.tickFormat - format ticks for human consumption.
# quantize.copy - create a copy of this scale.
#     d3.scaleQuantile - create a quantile quantizing linear scale.
#       quantile - compute the range value corresponding to a given domain value.
#         quantile.invertExtent - compute the domain values corresponding to a given range value.
#           quantile.domain - set the input domain.
#             quantile.range - set the output range.
#               quantile.quantiles - get the quantile thresholds.
#                 quantile.copy - create a copy of this scale.
#                     d3.scaleThreshold - create an arbitrary quantizing linear scale.
#                       threshold - compute the range value corresponding to a given domain value.
#                         threshold.invertExtent - compute the domain values corresponding to a given range value.
#                           threshold.domain - set the input domain.
#                             threshold.range - set the output range.
#                               threshold.copy - create a copy of this scale.
# #
#                                 Ordinal Scales
# #
# Map a discrete domain to a discrete range.
# #
#   d3.scaleOrdinal - create an ordinal scale.
#     ordinal - compute the range value corresponding to a given domain value.
#       ordinal.domain - set the input domain.
#         ordinal.range - set the output range.
#           ordinal.unknown - set the output value for unknown inputs.
# ordinal.copy - create a copy of this scale.
#     d3.scaleImplicit - a special unknown value for implicit domains.
# d3.scaleBand - create an ordinal band scale.
#   band - compute the band start corresponding to a given domain value.
#     band.domain - set the input domain.
#       band.range - set the output range.
#         band.rangeRound - set the output range and enable rounding.
#             band.round - enable rounding.
#               band.paddingInner - set padding between bands.
#                 band.paddingOuter - set padding outside the first and last bands.
#                     band.padding - set padding outside and between bands.
#                         band.align - set band alignment, if there is extra space.
#   band.bandwidth - get the width of each band.
#       band.step - get the distance between the starts of adjacent bands.
#           band.copy - create a copy of this scale.
#               d3.scalePoint - create an ordinal point scale.
#                 point - compute the point corresponding to a given domain value.
#                   point.domain - set the input domain.
#                     point.range - set the output range.
#                       point.rangeRound - set the output range and enable rounding.
#                           point.round - enable rounding.
#                             point.padding - set padding outside the first and last point.
#                                 point.align - set point alignment, if there is extra space.
#   point.bandwidth - returns zero.
#     point.step - get the distance between the starts of adjacent points.
#         point.copy - create a copy of this scale.
# #
#           Categorical Color Scales
# #
# Map a discrete domain to a discrete, fixed categorical color range.
# #
#   d3.scaleCategory10 - a categorical scheme with 10 colors.
# d3.scaleCategory20 - a categorical scheme with 20 colors.
# d3.scaleCategory20b - a categorical scheme with 20 colors.
# d3.scaleCategory20c - a categorical scheme with 20 colors.
# #
# Selections
# #
# Transform the DOM by selecting elements and joining to data.
#   Selecting Elements
# #
#     d3.selection - select the root document element.
#       d3.select - select an element from the document.
#         d3.selectAll - select multiple elements from the document.
#           selection.select - select a descendant element for each selected element.
#   selection.selectAll - select multiple descendants for each selected element.
#   selection.filter - filter elements based on data.
# selection.merge - merge this selection with another.
#   d3.matcher - test whether an element matches a selector.
#     d3.selector - select an element.
#       d3.selectorAll - select elements.
#         d3.window - get a node’s owner window.
# #
# Modifying Elements
# #
#   selection.attr - get or set an attribute.
#     selection.classed - get, add or remove CSS classes.
#       selection.style - get or set a style property.
#         selection.property - get or set a (raw) property.
#           selection.text - get or set the text content.
#             selection.html - get or set the inner HTML.
#               selection.append - create, append and select new elements.
#                 selection.remove - remove elements from the document.
#                   selection.sort - sort elements in the document based on data.
# selection.order - reorders elements in the document to match the selection.
#     selection.raise - reorders each element as the last child of its parent.
#         selection.lower - reorders each element as the first child of its parent.
#             d3.creator - create an element by name.
# #
# Joining Data
# #
#   selection.data - join elements to data.
#     selection.enter - get the enter selection (data missing elements).
#       selection.exit - get the exit selection (elements missing data).
#         selection.datum - get or set element data (without joining).
# #
#         Handling Events
# #
#           selection.on - add or remove event listeners.
#             selection.dispatch - dispatch a custom event.
#               d3.event - the current user event, during interaction.
#                 d3.customEvent - temporarily define a custom event.
#                   d3.mouse - get the mouse position relative to a given container.
#                     d3.touch - get a touch position relative to a given container.
#                       d3.touches - get the touch positions relative to a given container.
# #
#                       Control Flow
# #
#                         selection.each - call a function for each element.
# selection.call - call a function with this selection.
#   selection.empty - returns true if this selection is empty.
#   selection.nodes - returns an array of all selected elements.
#       selection.node - returns the first (non-null) element.
#         selection.size - returns the count of elements.
# #
#           Namespaces
# #
# d3.namespace - qualify a prefixed XML name, such as “xlink:href”.
# d3.namespaces - the built-in XML namespaces.
# #
#   Shapes
# #
# Graphical primitives for visualization.
# Arcs
# #
# Circular or annular sectors, as in a pie or donut chart.
# #
#       d3.arc - create a new arc generator.
#         arc - generate an arc for the given datum.
#         arc.centroid - compute an arc’s midpoint.
#   arc.innerRadius - set the inner radius.
#     arc.outerRadius - set the outer radius.
#       arc.cornerRadius - set the corner radius, for rounded corners.
# arc.startAngle - set the start angle.
#   arc.endAngle - set the end angle.
#     arc.padAngle - set the angle between adjacent arcs, for padded arcs.
# arc.padRadius - set the radius at which to linearize padding.
#   arc.context - set the rendering context.
# #
#   Pies
# #
# Compute the necessary angles to represent a tabular dataset as a pie or donut chart.
# #
#     d3.pie - create a new pie generator.
#       pie - compute the arc angles for the given dataset.
#       pie.value - set the value accessor.
#         pie.sort - set the sort order comparator.
#           pie.sortValues - set the sort order comparator.
#             pie.startAngle - set the overall start angle.
#               pie.endAngle - set the overall end angle.
#                 pie.padAngle - set the pad angle between adjacent arcs.
# #
#                 Lines
# #
# A spline or polyline, as in a line chart.
# #
#     d3.line - create a new line generator.
#       line - generate a line for the given dataset.
#       line.x - set the x accessor.
#         line.y - set the y accessor.
#           line.defined - set the defined accessor.
#             line.curve - set the curve interpolator.
#               line.context - set the rendering context.
#                 d3.radialLine - create a new radial line generator.
#                   radialLine - generate a line for the given dataset.
#                   radialLine.angle - set the angle accessor.
#                     radialLine.radius - set the radius accessor.
#                       radialLine.defined - set the defined accessor.
#                         radialLine.curve - set the curve interpolator.
#                           radialLine.context - set the rendering context.
# #
#                           Areas
# #
# An area, defined by a bounding topline and baseline, as in an area chart.
# #
#     d3.area - create a new area generator.
#       area - generate an area for the given dataset.
#       area.x - set the x0 and x1 accessors.
#           area.x0 - set the baseline x accessor.
#             area.x1 - set the topline x accessor.
#               area.y - set the y0 and y1 accessors.
#                   area.y0 - set the baseline y accessor.
#                     area.y1 - set the topline y accessor.
#                       area.defined - set the defined accessor.
#                         area.curve - set the curve interpolator.
#                           area.context - set the rendering context.
#                             d3.radialArea - create a new radial area generator.
#                               radialArea - generate an area for the given dataset.
#                               radialArea.angle - set the start and end angle accessors.
#                                   radialArea.startAngle - set the start angle accessor.
#                                     radialArea.endAngle - set the end angle accessor.
#                                       radialArea.radius - set the inner and outer radius accessors.
#                                           radialArea.innerRadius - set the inner radius accessor.
#                                             radialArea.outerRadius - set the outer radius accessor.
#                                               radialArea.defined - set the defined accessor.
#                                                 radialArea.curve - set the curve interpolator.
#                                                   radialArea.context - set the rendering context.
# #
#                                                   Curves
# #
# Interpolate between points to produce a continuous shape.
# #
#   d3.curveBasis - a cubic basis spline, repeating the end points.
#     d3.curveBasisClosed - a closed cubic basis spline.
#       d3.curveBasisOpen - a cubic basis spline.
#         d3.curveBundle - a straightened cubic basis spline.
#           d3.curveCardinal - a cubic cardinal spline, with one-sided difference at each end.
#               d3.curveCardinalClosed - a closed cubic cardinal spline.
#                 d3.curveCardinalOpen - a cubic cardinal spline.
#                   d3.curveCatmullRom - a cubic Catmull–Rom spline, with one-sided difference at each end.
#     d3.curveCatmullRomClosed - a closed cubic Catmull–Rom spline.
#   d3.curveCatmullRomOpen - a cubic Catmull–Rom spline.
#   d3.curveLinear - a polyline.
#     d3.curveLinearClosed - a closed polyline.
#       d3.curveMonotoneX - a cubic spline that, given monotonicity in x, preserves it in y.
#         d3.curveMonotoneY - a cubic spline that, given monotonicity in y, preserves it in x.
#           d3.curveNatural - a natural cubic spline.
#             d3.curveStep - a piecewise constant function.
#               d3.curveStepAfter - a piecewise constant function.
#                 d3.curveStepBefore - a piecewise constant function.
#                   curve.areaStart - start a new area segment.
#                     curve.areaEnd - end the current area segment.
#                       curve.lineStart - start a new line segment.
#                         curve.lineEnd - end the current line segment.
#                           curve.point - add a point to the current line segment.
# #
#                           Symbols
# #
# A categorical shape encoding, as in a scatterplot.
# #
#     d3.symbol - create a new symbol generator.
#       symbol - generate a symbol for the given datum.
#       symbol.type - set the symbol type.
#         symbol.size - set the size of the symbol in square pixels.
#               symbol.context - set the rendering context.
#                 d3.symbols - the array of built-in symbol types.
#                     d3.symbolCircle - a circle.
#                       d3.symbolCross - a Greek cross with arms of equal length.
#                           d3.symbolDiamond - a rhombus.
#                             d3.symbolSquare - a square.
#                               d3.symbolStar - a pentagonal star (pentagram).
#                                 d3.symbolTriangle - an up-pointing triangle.
#                                     d3.symbolWye - an up-pointing triangle.
#                                         symbolType.draw - draw this symbol to the given context.
# #
#                                         Stacks
# #
# Stack shapes, placing one adjacent to another, as in a stacked bar chart.
# #
#     d3.stack - create a new stack generator.
#       stack - generate a stack for the given dataset.
#       stack.keys - set the keys accessor.
#         stack.value - set the value accessor.
#           stack.order - set the order accessor.
#             stack.offset - set the offset accessor.
#               d3.stackOrderAscending - put the smallest series on bottom.
# d3.stackOrderDescending - put the largest series on bottom.
# d3.stackOrderInsideOut - put larger series in the middle.
#     d3.stackOrderNone - use the given series order.
#       d3.stackOrderReverse - use the reverse of the given series order.
#           d3.stackOffsetExpand - normalize the baseline to zero and topline to one.
#               d3.stackOffsetNone - apply a zero baseline.
#                 d3.stackOffsetSilhouette - center the streamgraph around zero.
#                   d3.stackOffsetWiggle - minimize streamgraph wiggling.
# #
#                   Time Formats
# #
# Parse and format times, inspired by strptime and strftime.
# #
# d3.timeFormat - alias for enUs.format.
# d3.timeParse - alias for enUs.parse.
# d3.utcFormat - alias for enUs.utcFormat.
# d3.utcFormat - alias for enUs.utcParse.
# d3.isoFormat - an ISO 8601 UTC formatter.
#   d3.isoParse - an ISO 8601 UTC parser.
#   d3.timeFormatLocale - define a custom locale.
#     locale.format - create a time formatter.
#       locale.parse - create a time parser.
#         locale.utcFormat - create a UTC formatter.
#           locale.utcParse - create a UTC parser.
#             d3.timeFormatCaEs - the Catalan (Spain) locale.
#               d3.timeFormatDeCh - the German (Switzerland) locale.
#                 d3.timeFormatDeDe - the German (Germany) locale.
#                   d3.timeFormatEnCa - the English (Canada) locale.
#                     d3.timeFormatEnGb - the English (United Kingdom) locale.
#                       d3.timeFormatEnUs - the English (United States) locale.
#                         d3.timeFormatEsEs - the Spanish (Spain) locale.
#                           d3.timeFormatFiFi - the Finnish (Finland) locale.
#                             d3.timeFormatFrCa - the French (Canada) locale.
#                               d3.timeFormatFrFr - the French (France) locale.
#                                 d3.timeFormatHeIl - the Hebrew (Israel) locale.
#                                   d3.timeFormatHuHu - the Hungarian (Hungary) locale.
#                                     d3.timeFormatItIt - the Italian (Italy) locale.
#                                       d3.timeFormatJaJp - the Japanese (Japan) locale.
#                                         d3.timeFormatKoKr - the Korean (South Korea) locale.
#                                           d3.timeFormatMkMk - the Macedonian (Macedonia) locale.
#                                             d3.timeFormatNlNl - the Dutch (Netherlands) locale.
#                                               d3.timeFormatPlPl - the Polish (Poland) locale.
#                                                 d3.timeFormatPtBr - the Portuguese (Brazil) locale.
#                                                   d3.timeFormatRuRu - the Russian (Russia) locale.
#                                                     d3.timeFormatSvSe - the Swedish (Sweden) locale.
#                                                       d3.timeFormatZhCn - the Chinese (China) locale.
# #
#                                                       Time Intervals
# #
# A calculator for humanity’s peculiar conventions of time.
# #
#   d3.timeInterval - implement a new custom time interval.
#     interval - alias for interval.floor.
#     interval.floor - round down to the nearest boundary.
#       interval.round - round to the nearest boundary.
#         interval.ceil - round up to the nearest boundary.
#           interval.offset - offset a date by some number of intervals.
#   interval.range - generate a range of dates at interval boundaries.
#       interval.filter - create a filtered subset of this interval.
#           interval.every - create a filtered subset of this interval.
#               interval.count - count interval boundaries between two dates.
#               d3.timeMillisecond, d3.utcMillisecond - the millisecond interval.
#                 d3.timeMilliseconds, d3.utcMilliseconds - aliases for millisecond.range.
#                   d3.timeSecond, d3.utcSecond - the second interval.
#                   d3.timeSeconds, d3.utcSeconds - aliases for second.range.
#                     d3.timeMinute, d3.utcMinute - the minute interval.
#                     d3.timeMinutes, d3.utcMinutes - aliases for minute.range.
#                       d3.timeHour, d3.utcHour - the hour interval.
#                       d3.timeHours, d3.utcHours - aliases for hour.range.
#                         d3.timeDay, d3.utcDay - the day interval.
#                         d3.timeDays, d3.utcDays - aliases for day.range.
#                           d3.timeWeek, d3.utcWeek - aliases for sunday.
#                           d3.timeWeeks, d3.utcWeeks - aliases for week.range.
#                           d3.timeSunday, d3.utcSunday - the week interval, starting on Sunday.
# d3.timeSundays, d3.utcSundays - aliases for sunday.range.
# d3.timeMonday, d3.utcMonday - the week interval, starting on Monday.
# d3.timeMondays, d3.utcMondays - aliases for monday.range.
# d3.timeTuesday, d3.utcTuesday - the week interval, starting on Tuesday.
# d3.timeTuesdays, d3.utcTuesdays - aliases for tuesday.range.
# d3.timeWednesday, d3.utcWednesday - the week interval, starting on Wednesday.
# d3.timeWednesdays, d3.utcWednesdays - aliases for wednesday.range.
# d3.timeThursday, d3.utcThursday - the week interval, starting on Thursday.
# d3.timeThursdays, d3.utcThursdays - aliases for thursday.range.
# d3.timeFriday, d3.utcFriday - the week interval, starting on Friday.
# d3.timeFridays, d3.utcFridays - aliases for friday.range.
# d3.timeSaturday, d3.utcSaturday - the week interval, starting on Saturday.
# d3.timeSaturdays, d3.utcSaturdays - aliases for saturday.range.
# d3.timeMonth, d3.utcMonth - the month interval.
# d3.timeMonths, d3.utcMonths - aliases for month.range.
#   d3.timeYear, d3.utcYear - the year interval.
#   d3.timeYears, d3.utcYears - aliases for year.range.
# #
#     Timers
# #
# An efficient queue for managing thousands of concurrent animations.
# #
#   d3.now - get the current high-resolution time.
#       d3.timer - schedule a new timer.
#         timer.restart - reset the timer’s start time and callback.
#   timer.stop - stop the timer.
#     d3.timerFlush - immediately execute any eligible timers.
#       d3.timeout - schedule a timer that stops on its first callback.
#   d3.interval - schedule a timer that is called with a configurable period.
# #
#     Transitions
# #
# Animated transitions for selections.
# #
#   selection.transition - schedule a transition for the selected elements.
#   selection.interrupt - interrupt and cancel transitions on the selected elements.
#   d3.transition - schedule a transition on the root document element.
#   transition.select - schedule a transition on the selected elements.
#   transition.selectAll - schedule a transition on the selected elements.
#   transition.filter - filter elements based on data.
# transition.merge - merge this transition with another.
#   transition.selection - returns a selection for this transition.
# transition.transition - schedule a new transition following this one.
#   transition.call - call a function with this transition.
#     transition.nodes - returns an array of all selected elements.
#         transition.node - returns the first (non-null) element.
#           transition.size - returns the count of elements.
#             transition.empty - returns true if this transition is empty.
#   transition.each - call a function for each element.
# transition.on - add or remove transition event listeners.
#   transition.attr - tween the given attribute using the default interpolator.
#     transition.attrTween - tween the given attribute using a custom interpolator.
#       transition.style - tween the given style property using the default interpolator.
#         transition.styleTween - tween the given style property using a custom interpolator.
#           transition.text - set the text content when the transition starts.
#   transition.remove - remove the selected elements when the transition ends.
#   transition.tween - run custom code during the transition.
#     transition.delay - specify per-element delay in milliseconds.
#         transition.duration - specify per-element duration in milliseconds.
#             transition.ease - specify the easing function.
#               d3.active - select the active transition for a given node.
# #
# Voronoi Diagrams
# #
# Compute the Voronoi diagram of a given set of points.
# #
#     d3.voronoi - create a new Voronoi generator.
#       voronoi - generate a new Voronoi diagram for the given points.
#         voronoi.polygons - compute the Voronoi polygons for the given points.
#       voronoi.triangles - compute the Delaunay triangles for the given points.
#   voronoi.links - compute the Delaunay links for the given points.
#   voronoi.x - set the x accessor.
#     voronoi.y - set the y accessor.
#       voronoi.extent - set the observed extent of points.
#         voronoi.size - set the observed extent of points.




