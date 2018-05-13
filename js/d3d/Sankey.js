'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function () {
  var Sankey, d3, d3Sankey;

  d3 = require('d3');

  window.d3 = d3;

  d3Sankey = require('d3-sankey');

  Sankey = function () {
    var Sankey = function () {
      _createClass(Sankey, null, [{
        key: 'sankeyLink',

        // Patch for d3.sankey.link(d) plugin
        value: function sankeyLink(d) {
          var curvature, x0, x1, x2, x3, xi, y0, y1;
          curvature = .5;
          x0 = d.source.x + d.source.dx;
          x1 = d.target.x;
          xi = d3.interpolateNumber(x0, x1);
          x2 = xi(curvature);
          x3 = xi(1 - curvature);
          y0 = d.source.y + d.sy + d.dy / 2;
          y1 = d.target.y + d.ty + d.dy / 2 + 0.1; // 0.1 prevents a pure horizontal line that did not respond to color gradients
          return 'M' + x0 + ',' + y0 + 'C' + x2 + ',' + y0 + ' ' + x3 + ',' + y1 + ' ' + x1 + ',' + y1;
        }

        // Patch for d3.sankey.link2() pluging - added for initializing

      }, {
        key: 'sankeyLink2',
        value: function sankeyLink2() {
          var curvature, link;
          curvature = .5;
          link = function link(d) {
            var x0, x1, x2, x3, xi, y0, y1;
            x0 = d.source.x + d.source.dx;
            x1 = d.target.x;
            xi = d3.interpolateNumber(x0, x1);
            x2 = xi(curvature);
            x3 = xi(1 - curvature);
            y0 = d.source.y + d.sy + d.dy / 2;
            y1 = d.target.y + d.ty + d.dy / 2;
            return 'M' + x0 + ',' + y0 + 'C' + x2 + ',' + y0 + ' ' + x3 + ',' + y1 + ' ' + x1 + ',' + y1;
          };
          link.curvature = function (_) {
            if (!arguments.length) {
              return curvature;
            }
            curvature = +_;
            return link;
          };
          return link;
        }
      }]);

      function Sankey(defs1, g, x4, y, w, h, nodeWidth, nodePadding, label) {
        _classCallCheck(this, Sankey);

        this.doData = this.doData.bind(this);
        this.defs = defs1;
        this.g = g;
        this.x = x4;
        this.y = y;
        this.w = w;
        this.h = h;
        this.nodeWidth = nodeWidth;
        this.nodePadding = nodePadding;
        this.label = label;
        this.uom = '';
        this.gradientX(this.defs, 'WhiteBlack', 'white', 'black');
        this.gSankey = this.g.append("g").attr('transform', 'translate(' + this.x + ',' + this.y + ')');
      }

      _createClass(Sankey, [{
        key: 'doData',
        value: function doData(data) {
          var _createSankey = this.createSankey();

          var _createSankey2 = _slicedToArray(_createSankey, 2);

          this.sankey = _createSankey2[0];
          this.path = _createSankey2[1];

          this.graph = this.createGraph(data);

          var _doSankey = this.doSankey(this.sankey, this.graph);

          var _doSankey2 = _slicedToArray(_doSankey, 2);

          this.linkSvg = _doSankey2[0];
          this.nodeSvg = _doSankey2[1];
        }
      }, {
        key: 'createSankey',
        value: function createSankey() {
          var path, sankey;
          sankey = d3Sankey.sankey().nodeWidth(this.nodeWidth).nodePadding(this.nodePadding).size([this.w, this.h]);
          sankey.link = Sankey.sankeyLink;
          sankey.link2 = Sankey.sankeyLink2;
          path = sankey.link2();
          return [sankey, path];
        }
      }, {
        key: 'createGraph',
        value: function createGraph(data) {
          var _this2 = this;

          var graph, nodeMap;
          graph = data; // JSON.parse( json )
          nodeMap = {};
          graph.nodes.forEach(function (x) {
            return nodeMap[x.name] = x;
          });
          graph.links = graph.links.map(function (x) {
            return _this2.toLink(x, nodeMap);
          });
          return graph;
        }
      }, {
        key: 'toLink',
        value: function toLink(x, nodeMap) {
          return {
            source: nodeMap[x.source],
            target: nodeMap[x.target],
            value: x.value
          };
        }
      }, {
        key: 'doSankey',
        value: function doSankey(sankey, graph) {
          var linkSvg, nodeSvg;
          sankey.nodes(graph.nodes).links(graph.links); //.layout( 32 )
          linkSvg = this.doLinks();
          nodeSvg = this.doNodes(linkSvg);
          return [linkSvg, nodeSvg];
        }

        // .attr( "stroke", "url(#WhiteBlack)" ).attr( "fill","none")#

      }, {
        key: 'doLinks',
        value: function doLinks() {
          var d, gLink, gLinks, i, id, len, path, ref;
          gLinks = this.gSankey.append("svg:g");
          ref = this.graph.links;
          for (i = 0, len = ref.length; i < len; i++) {
            d = ref[i];
            id = d.source.name + d.target.name;
            this.gradientX(this.defs, id, d.source.color, d.target.color);
            gLink = gLinks.append("svg:g").attr("stroke", 'url(#' + id + ')').attr("fill", "none");
            path = gLink.append("svg:path").attr("d", this.sankey.link(d)).style("stroke-width", Math.max(1, d.dy - 1)).sort(function (a, b) {
              //.attr("class", "link")
              return b.dy - a.dy;
            }).append("title").text(d.source.name + " → " + d.target.name); //  + "\n" + d.value
          }
          //rect  = gLink.append("svg:rect").attr("x",-1).attr("y",-1).attr("width",1000).attr("height",200).attr('fill','none').attr('stroke','none')
          return gLinks;
        }
      }, {
        key: 'doNodes',
        value: function doNodes(linkSvg) {
          var _this3 = this;

          var _this, node;
          node = this.gSankey.append("g").selectAll(".node").data(this.graph.nodes).enter().append("g").attr("class", "node").attr("transform", function (d) {
            return "translate(" + d.x + "," + d.y + ")";
          });
          node.append("rect").attr("height", function (d) {
            return d.dy;
          }).attr("width", this.sankey.nodeWidth()).attr("fill", function (d) {
            return d.color; //#.attr("stroke", (d) -> d3.rgb(d.color).darker(2) )
          }).append("title").text(function (d) {
            return d.name; //  + "\n" + d.value
          });
          if (this.label) {
            node.append("text").attr("x", -6).attr("y", function (d) {
              return d.dy / 2;
            }).attr("dy", ".35em").attr("text-anchor", "end").attr("transform", null).text(function (d) {
              return d.name;
            }).filter(function (d) {
              return d.x < _this3.w / 2;
            }).attr("x", 6 + this.sankey.nodeWidth()).attr("text-anchor", "start");
          }
          _this = this; // Same as CoffeeScript put here for lint checking
          //.origin( (d) -> d )
          node.call(d3.drag().container(this.parentNode).on("start", function () {
            return this.parentNode.appendChild(this);
          }).on("drag", function (d) {
            return _this.dragMove(d, this, linkSvg);
          }));
          return node;
        }
      }, {
        key: 'dragMove',
        value: function dragMove(d, caller, linkSvg) {
          d.y = Math.max(0, Math.min(this.h - d.dy, d3.event.y));
          d3.select(caller).attr("transform", 'translate(' + d.x + ',' + d.y + ')');
          this.sankey.relayout();
          linkSvg.attr("d", this.path);
        }
      }, {
        key: 'number',
        value: function number(d) {
          return d3.format(d, ",.0f");
        }
      }, {
        key: 'format',
        value: function format(d) {
          return this.number(d) + this.uom;
        }
      }, {
        key: 'gradientX',
        value: function gradientX(defs, id, color1, color2) {
          var grad;
          grad = defs.append("svg:linearGradient");
          grad.attr("id", id).attr("y1", "0%").attr("y2", "0%").attr("x1", "0%").attr("x2", "100%");
          grad.append("svg:stop").attr("offset", "10%").attr("stop-color", color1);
          grad.append("svg:stop").attr("offset", "90%").attr("stop-color", color2);
        }
      }]);

      return Sankey;
    }();

    ;

    module.exports = Sankey;

    return Sankey;
  }.call(this);
}).call(undefined);
