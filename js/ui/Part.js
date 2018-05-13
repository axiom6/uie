// Generated by CoffeeScript 1.11.0
(function() {
  var $, Part, UI;

  $ = require('jquery');

  UI = require('js/ui/UI');

  Part = (function() {
    module.exports = Part;

    function Part(ui, stream, pane, ext, rgba, left1, top1, width1, height1, title) {
      this.ui = ui;
      this.stream = stream;
      this.pane = pane;
      this.ext = ext;
      this.rgba = rgba;
      this.left = left1;
      this.top = top1;
      this.width = width1;
      this.height = height1;
      this.title = title != null ? title : "";
      this.htmlId = this.ui.htmlId(this.pane.name, this.ext);
      this.$ = UI.$empty;
      this.css = 'ikw-hues';
      this.addClass = '';
    }

    Part.prototype.ready = function() {
      this.$ = $(this.createHtml());
      this.reset();
      this.pane.$.append(this.$);
      return this.show();
    };

    Part.prototype.show = function() {
      return this.$.show();
    };

    Part.prototype.hide = function() {
      return this.$.hide();
    };

    Part.prototype.pc = function(v) {
      return this.pane.pc(v);
    };

    Part.prototype.rgbaStr = function() {
      var a, b, g, n, r, ref;
      n = function(f) {
        return Math.round(f);
      };
      ref = this.rgba, r = ref[0], g = ref[1], b = ref[2], a = ref[3];
      return "rgba(" + (n(r)) + "," + (n(g)) + "," + (n(b)) + "," + (n(a)) + ")";
    };

    Part.prototype.createHtml = function() {
      return "<div id=\"" + this.htmlId + "\" class=\"" + this.css + "\" style=\"background-color:" + (this.rgbaStr()) + ";\" title=\"" + this.title + "\"></div>";
    };

    Part.prototype.resize = function() {
      if (Util.isStr(this.addClass)) {
        this.adjustAddClass(this.addClass);
      }
      this.show;
    };

    Part.prototype.adjustAddClass = function(addClass) {
      var h1, h2, height, ref, ref1, w1, w2, width;
      this.addClass = addClass;
      this.$.removeClass(addClass);
      ref = this.whOuter(), w1 = ref[0], h1 = ref[1];
      this.$.addClass(addClass);
      ref1 = this.whOuter(), w2 = ref1[0], h2 = ref1[1];
      width = this.width * w1 / w2;
      height = this.height * h1 / h2;
      this.resetCss(this.left, this.top, width, height);
    };

    Part.prototype.whOuter = function() {
      return [this.$.outerWidth(), this.$.outerHeight()];
    };

    Part.prototype.cssProps = function() {
      return {
        backgroundColor: this.rgbaStr(),
        left: this.pc(this.left),
        top: this.pc(this.top),
        width: this.pc(this.width),
        height: this.pc(this.height),
        position: 'absolute'
      };
    };

    Part.prototype.reset = function() {
      this.$.css(this.cssProps());
    };

    Part.prototype.resetCss = function(left, top, width, height) {
      this.left = left;
      this.top = top;
      this.width = width;
      this.height = height;
      this.$.css(this.cssProps());
    };

    Part.prototype.animate = function(left, top, width, height, aniLinks, callback) {
      if (aniLinks == null) {
        aniLinks = false;
      }
      if (callback == null) {
        callback = null;
      }
      this.$.show().animate(this.cssProps(), this.pane.speed, (function(_this) {
        return function() {
          if (callback != null) {
            return callback(_this);
          }
        };
      })(this));
    };

    Part.prototype.log = function(msg) {
      return Util.log(msg, {
        "background-color": this.rgbaStr(),
        left: Util.toFixed(this.left),
        top: Util.toFixed(this.top),
        width: Util.toFixed(this.width),
        height: Util.toFixed(this.height)
      });
    };

    Part.prototype.geom = function() {
      var h, r, w, x0, y0;
      w = this.$.innerWidth();
      h = this.$.innerHeight();
      r = Math.min(w, h) * 0.2;
      x0 = w * 0.5;
      y0 = h * 0.5;
      return {
        w: w,
        h: h,
        r: r,
        x0: x0,
        y0: y0
      };
    };

    return Part;

  })();

}).call(this);
