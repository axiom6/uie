// Generated by CoffeeScript 1.12.2
(function() {
  var $, Group, UI, Vis,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  $ = require('jquery');

  Vis = require('js/util/Vis');

  UI = require('js/ui/UI');

  Group = (function(superClass) {
    extend(Group, superClass);

    module.exports = Group;

    UI.Group = Group;

    function Group(ui, stream, view, spec1) {
      this.ui = ui;
      this.stream = stream;
      this.view = view;
      this.spec = spec1;
      Group.__super__.constructor.call(this, this.ui, this.stream, this.view, this.spec);
      this.panes = this.collectPanes();
      this.margin = this.view.margin;
      this.icon = this.spec.icon;
      this.css = Util.isStr(this.spec.css) ? this.spec.css : 'ikw-group';
      this.$ = UI.$empty;
    }

    Group.prototype.id = function(name, ext) {
      return this.ui.htmlId(name + 'Group', ext);
    };

    Group.prototype.ready = function() {
      var select;
      this.htmlId = this.id(this.name, 'Group');
      this.$icon = this.createIcon();
      this.view.$view.append(this.$icon);
      select = UI.Build.select(this.name, 'Group', this.spec.intent);
      return this.stream.publish('Select', select, this.$icon, 'click');
    };

    Group.show = function() {
      var i, len, pane, ref, results;
      Group.__super__.constructor.show.apply(this, arguments).show();
      ref = this.panes;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        pane = ref[i];
        results.push(pane.show());
      }
      return results;
    };

    Group.hide = function() {
      var i, len, pane, ref, results;
      Group.__super__.constructor.hide.apply(this, arguments).hide();
      ref = this.panes;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        pane = ref[i];
        results.push(pane.hide());
      }
      return results;
    };

    Group.prototype.createIcon = function() {
      var $icon, height, htm, left, ref, top, width;
      htm = this.htmIconName(this.spec);
      $icon = $(htm);
      ref = this.positionIcon(this.spec), left = ref[0], top = ref[1], width = ref[2], height = ref[3];
      $icon.css({
        left: this.xs(left),
        top: this.ys(top),
        width: this.pc(width),
        height: this.pc(height)
      });
      return $icon;
    };

    Group.prototype.htmIconName = function(spec) {
      var htm;
      htm = "<div  id=\"" + (this.id(spec.name, 'Icon')) + "\" class=\"" + this.css + "-icon\" style=\"display:table; font-size:1.2em;\">";
      if (spec.icon) {
        htm += "<i class=\"fa " + spec.icon + " fa-lg\"></i>";
      }
      htm += spec.css === 'ikw-col' ? this.htmColName(spec) : this.htmRowName(spec);
      return htm += "</div>";
    };

    Group.prototype.htmColName = function(spec) {
      return "<span style=\"display:table-cell; vertical-align:middle; padding-left:12px;\">" + (Util.toName(spec.name)) + "</span>";
    };

    Group.prototype.htmRowName = function(spec) {
      return "<div style=\"display:table-cell; vertical-align:middle; padding-left:12px;\">" + (Util.toName(spec.name)) + "</div>";
    };


    /*
    render:( spec ) ->
      h("""div##{@id(spec.name,'Icon')}.#{@css+'-icon'}""", [
        h("""i."fa #{spec.icon} fa-lg" """)
        h("""span""", { style: { 'display':'table-cell', 'vertical-align':'middle', 'padding-left':'12px' } } ) ] )
     */

    Group.prototype.positionIcon = function(spec) {
      var ub, w;
      w = spec.w != null ? spec.w * this.wscale * 0.5 : 100 * this.wscale * 0.5;
      ub = UI.Build;
      switch (spec.intent) {
        case ub.SelectRow:
          return [-10, this.ycenter(this.top, this.height, this.margin.west), 12, this.margin.west];
        case ub.SelectCol:
          return [this.xcenter(this.left, this.width, w), 0, this.margin.north, this.margin.north];
        case ub.SelectGroup:
          return [this.xcenter(this.left, this.width, w), 0, this.margin.north, this.margin.north];
        default:
          return this.positionGroupIcon();
      }
    };

    Group.prototype.positionGroup = function() {
      var height, left, ref, top, width;
      ref = this.view.positionGroup(this.cells, this.spec), left = ref[0], top = ref[1], width = ref[2], height = ref[3];
      return this.$.css({
        left: this.xs(left),
        top: this.ys(top),
        width: this.xs(width),
        height: this.ys(height)
      });
    };

    Group.prototype.positionGroupIcon = function() {
      var height, left, ref, top, width;
      ref = this.view.positionGroup(this.cells, this.spec), left = ref[0], top = ref[1], width = ref[2], height = ref[3];
      return [left + 20, top + 20, 20, 20];
    };

    Group.prototype.animateIcon = function($icon) {
      var height, left, ref, top, width;
      ref = this.positionIcon(), left = ref[0], top = ref[1], width = ref[2], height = ref[3];
      return $icon.animate({
        left: this.xs(left),
        top: this.ys(top),
        width: this.pc(width),
        height: this.pc(height)
      });
    };

    Group.prototype.collectPanes = function() {
      var gpanes, i, ig, ip, j, jg, jp, len, len1, mg, mp, ng, np, pane, ref, ref1, ref2, ref3;
      gpanes = [];
      if (this.cells != null) {
        ref = UI.jmin(this.cells), jg = ref[0], mg = ref[1], ig = ref[2], ng = ref[3];
        ref1 = this.view.panes;
        for (i = 0, len = ref1.length; i < len; i++) {
          pane = ref1[i];
          ref2 = UI.jmin(pane.cells), jp = ref2[0], mp = ref2[1], ip = ref2[2], np = ref2[3];
          if (jg <= jp && jp + mp <= jg + mg && ig <= ip && ip + np <= ig + ng) {
            gpanes.push(pane);
          }
        }
      } else {
        ref3 = this.view.panes;
        for (j = 0, len1 = ref3.length; j < len1; j++) {
          pane = ref3[j];
          if (Util.inArray(pane.spec.groups, this.name)) {
            gpanes.push(pane);
          }
        }
      }
      return gpanes;
    };

    Group.prototype.fillPanes = function() {
      var fill, i, len, pane, ref;
      fill = this.spec.hsv != null ? Vis.toRgbHsvStr(this.spec.hsv) : "#888888";
      ref = this.panes;
      for (i = 0, len = ref.length; i < len; i++) {
        pane = ref[i];
        pane.$.css({
          'background-color': fill
        });
      }
    };

    Group.prototype.animate = function(left, top, width, height, parent, callback) {
      if (parent == null) {
        parent = null;
      }
      if (callback == null) {
        callback = null;
      }
      this.$.animate({
        left: this.pc(left),
        top: this.pc(top),
        width: this.pc(width),
        height: this.pc(height)
      }, this.speed, (function(_this) {
        return function() {
          if (callback != null) {
            return callback(_this);
          }
        };
      })(this));
    };

    return Group;

  })(UI.Pane);

}).call(this);