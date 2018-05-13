// Generated by CoffeeScript 1.12.2
(function() {
  var Chord, d3,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  d3 = require('d3');

  Chord = (function() {
    module.exports = Chord;

    Chord.matrix = [[0, 20, 20, 20], [20, 0, 20, 80], [20, 20, 0, 20], [20, 80, 20, 0]];

    Chord.range = ["#FF0000", "#00FF00", "#0000FF", "#888888"];

    Chord.matrix2 = [[11975, 5871, 8916, 2868], [1951, 10048, 2060, 6171], [8010, 16145, 8090, 8045], [1013, 990, 940, 6907]];

    Chord.range2 = ["#000000", "#FFDD89", "#957244", "#F26223"];

    function Chord(g, width, height, matrix1, range1) {
      this.g = g;
      this.width = width != null ? width : 600;
      this.height = height != null ? height : 600;
      this.matrix = matrix1 != null ? matrix1 : Chord.matrix;
      this.range = range1 != null ? range1 : Chord.range;
      this.fade = bind(this.fade, this);
      this.chord = this.createChord(this.matrix);
      this.fill = this.createFill(this.range);
      this.innerRadius = Math.min(this.width, this.height) * .41;
      this.outerRadius = this.innerRadius * 1.1;
      this.groups = this.createGroups();
      this.chords = this.createChords();
    }

    Chord.prototype.createChord = function(matrix) {
      return d3.layout.chord().padding(.05).matrix(matrix);
    };

    Chord.prototype.createFill = function(range) {
      return d3.scale.ordinal().domain(d3.range(4)).range(range);
    };

    Chord.prototype.createGroups = function() {
      var groups;
      groups = this.g.append("g").selectAll("path").data(this.chord.groups).enter().append("path").style("fill", (function(_this) {
        return function(d) {
          return _this.fill(d.index);
        };
      })(this)).style("stroke", (function(_this) {
        return function(d) {
          return _this.fill(d.index);
        };
      })(this));
      groups.attr("d", d3.arc().innerRadius(this.innerRadius).outerRadius(this.outerRadius));
      groups.on("mouseover", this.fade(.1)).on("mouseout", this.fade(1));
      return groups;
    };

    Chord.prototype.createChords = function() {
      var chords;
      chords = this.g.append("g").attr("class", "chord").selectAll("path").data(this.chord.chords).enter().append("path").attr("d", d3.chord().radius(this.innerRadius)).style("fill", (function(_this) {
        return function(d) {
          return _this.fill(d.target.index);
        };
      })(this)).style("opacity", 1);
      return chords;
    };

    Chord.prototype.createTicks = function() {
      var ticks;
      ticks = this.g.append("g").selectAll("g").data(this.chord.groups);
      ticks.enter().append("g").selectAll("g").data(this.groupTicks);
      ticks.append("line").attr("x1", 1).attr("y1", 0).attr("x2", 5).attr("y2", 0).style("stroke", "#000");
      ticks.append("text").attr("x", 8).attr("dy", ".35em").attr("transform", function(d) {
        if (d.angle > Math.PI) {
          return "rotate(180)translate(-16)";
        } else {
          return null;
        }
      });
      ticks.style("text-anchor", function(d) {
        if (d.angle > Math.PI) {
          return "end";
        } else {
          return null;
        }
      });
      ticks.text(function(d) {
        return d.label;
      });
      return ticks;
    };

    Chord.prototype.groupTicks = function(d) {
      var k, range;
      k = (d.endAngle - d.startAngle) / d.value;
      range = d3.range(0, d.value, 1000).map(function(v, i) {
        return {
          angle: v * k + d.startAngle,
          label: (i % 5 ? null : v / 1000 + "k")
        };
      });
      Util.log('groupTicks', d, k);
      return range;
    };

    Chord.prototype.fade = function(opacity) {
      return (function(_this) {
        return function(i) {
          return _this.g.selectAll(".chord path").filter(function(d) {
            return d.source.index !== i && d.target.index !== i;
          }).transition().style("opacity", opacity);
        };
      })(this);
    };

    return Chord;

  })();

}).call(this);