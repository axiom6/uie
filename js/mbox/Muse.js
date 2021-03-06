// Generated by CoffeeScript 1.10.0
(function() {
  var IKW, Prac, Vis,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Vis = require('js/util/Vis');

  Prac = require('js/prac/Prac');

  IKW = (function() {
    var MBox;

    module.exports = IKW;

    MBox = require('js/mbox/MBox');

    MBox.IKW = IKW;

    function IKW(mbox, coord, color, width, height, depth) {
      this.mbox = mbox;
      this.coord = coord;
      this.color = color;
      this.width = width;
      this.height = height;
      this.depth = depth;
      this.viewXyzsRgbs = bind(this.viewXyzsRgbs, this);
      this.flotExpr = bind(this.flotExpr, this);
      this.mathbox = this.mbox.mathbox;
      this.build = this.createBuild();
      this.peop = ['Activity', 'People', 'Result'];
      this.serv = ['Internal', 'Service', 'Vision'];
      this.netw = ['External', 'Network', 'Mission'];
      this.data = ['Refine', 'Data', 'Method'];
    }

    IKW.prototype.createBuild = function() {
      var Build, Stream, args, build, stream, subjects;
      Stream = require('js/util/Stream');
      Build = require('js/prac/Build');
      args = {
        name: 'Muse',
        plane: 'Information',
        op: ''
      };
      subjects = ['Select'];
      stream = new Stream(subjects);
      build = new Build(args, stream);
      return build;
    };

    IKW.prototype.fontFace = function(name, uri) {
      var fontFace;
      fontFace = new FontFace(name, uri);
      return fontFace.load();
    };


    /*
    docFonts:( fontSpec='36px FontAwesome' ) ->
      document.fonts.load( fontSpec )
        .then( Util.log( 'MBox.IKW().docFonts loaded', fontSpec), Util.error('MBox.IKW.docFonts()' ) )
      return
     */

    IKW.prototype.canvasContext = function() {
      var canvas, ctx;
      canvas = document.querySelector('canvas');
      ctx = canvas.getContext('2d');
      if (ctx == null) {
        ctx = canvas.getContext('webgl');
      }
      if (ctx == null) {
        Util.log('MBox.IKW.canvasContext() null');
      }
      return ctx;
    };

    IKW.prototype.canvasText = function(icon, x, y) {
      var ctx, uc;
      uc = Prac.unicode(icon);
      ctx = this.canvasContext();
      ctx.font = 'bold 24px FontAwesome';
      ctx.fillText(uc, x, y);
    };

    IKW.prototype.contextFont = function(fontSpec) {
      var ctx;
      if (fontSpec == null) {
        fontSpec = '36px FontAwesome';
      }
      ctx = this.canvasContext();
      ctx.font = fontSpec;
      Util.log('MBox.IKW.contextFont()', fontSpec);
    };

    IKW.prototype.logContextFont = function(msg) {
      var ctx;
      ctx = this.canvasContext();
      Util.log('MBox.IKW().logContextFont', msg, ctx.font);
    };

    IKW.prototype.museCartesian = function(range, scale, divide) {
      var view;
      if (range == null) {
        range = [[0, 120], [0, 120], [0, 120]];
      }
      if (scale == null) {
        scale = [2, 2, 2];
      }
      if (divide == null) {
        divide = [12, 12];
      }
      this.mathbox.camera({
        position: [3, 3, 3],
        proxy: true
      });
      view = this.mathbox.cartesian({
        range: range,
        scale: scale
      });
      this.coord.axesXYZ(view, 8, 0xFFFFFF);
      this.coord.gridXYZ(view, 4, 0xFFFFFF, divide[1], 0.7, '10');
      this.coord.tickXYZ(view, 64, 0xFFFFFF, divide[2], 2);
      return view;
    };

    IKW.prototype.createArrays = function() {
      var aa, ab, ac, ad, ae, c, col, con, conc, conp, cont, conv, cubc, cubp, flo, flob, floc, floe, flop, flow, h, hexc, hexi, hexp, hexq, hext, i, key, l, len1, len2, len3, len4, len5, len6, len7, len8, len9, m, o, p, pipb, pipc, pipe, pipp, pipv, pla, plane, practice, prci, prcp, prct, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, row, sprac, studies, study, v, w, x, xyzs, y, z;
      xyzs = [];
      cubp = [];
      cubc = [];
      hexp = [];
      hexc = [];
      hexq = [];
      hext = [];
      hexi = [];
      prcp = [];
      prct = [];
      prci = [];
      conv = [];
      conc = [];
      cont = [];
      conp = [];
      flow = [];
      floc = [];
      flob = [];
      floe = [];
      flop = [];
      pipv = [];
      pipc = [];
      pipb = [];
      pipe = [];
      pipp = [];
      sprac = 10;
      ref = [
        {
          name: 'Information',
          z: 105
        }, {
          name: 'DataScience',
          z: 75
        }, {
          name: 'Knowledge',
          z: 45
        }, {
          name: 'Wisdom',
          z: 15
        }
      ];
      for (l = 0, len1 = ref.length; l < len1; l++) {
        plane = ref[l];
        ref1 = [
          {
            name: 'Learn',
            y: 100
          }, {
            name: 'Do',
            y: 60
          }, {
            name: 'Share',
            y: 20
          }
        ];
        for (m = 0, len2 = ref1.length; m < len2; m++) {
          row = ref1[m];
          ref2 = [
            {
              name: 'Embrace',
              x: 20
            }, {
              name: 'Innovate',
              x: 60
            }, {
              name: 'Encourage',
              x: 100
            }
          ];
          for (o = 0, len3 = ref2.length; o < len3; o++) {
            col = ref2[o];
            x = col.x;
            y = row.y;
            z = plane.z;
            xyzs.push([x, y, z, 1]);
            this.cubeFaces(x, y, z, sprac, cubp);
            practice = this.build.getPractice(plane.name, row.name, col.name);
            studies = this.build.studies(plane.name, practice.key);
            for (key in studies) {
              study = studies[key];
              this.fourTier(x, y, z, 4, study, hexp, hexc, hexq, hext, hexi);
            }
            ref3 = practice.hsv, h = ref3[0], c = ref3[1], v = ref3[2];
            for (i = p = 0; p < 6; i = ++p) {
              cubc.push(Vis.toRgbHsv(h, c, v, true));
            }
            prcp.push([x, y - sprac + 2, z, 1]);
            prct.push(practice.key);
            prci.push("" + (Prac.unicode(practice.icon)));
          }
          ref4 = [
            {
              name: 'west',
              x: 40,
              hsv: {
                h: 90,
                s: 60,
                v: 90
              },
              colName: 'Embrace'
            }, {
              name: 'east',
              x: 80,
              hsv: {
                h: 0,
                s: 60,
                v: 90
              },
              colName: 'Innovate'
            }
          ];
          for (w = 0, len4 = ref4.length; w < len4; w++) {
            con = ref4[w];
            practice = this.build.getPractice(plane.name, row.name, con.colName);
            this.convey(practice, 'east', con.x, row.y, plane.z, sprac, con.hsv, conv, conc, cont, conp);
          }
        }
        ref5 = [
          {
            name: 'north',
            y: 80,
            rowName: 'Learn'
          }, {
            name: 'south',
            y: 40,
            rowName: 'Do'
          }
        ];
        for (aa = 0, len5 = ref5.length; aa < len5; aa++) {
          flo = ref5[aa];
          ref6 = [
            {
              name: 'Embrace',
              x: 20,
              hsv: {
                h: 210,
                s: 60,
                v: 90
              }
            }, {
              name: 'Innovate',
              x: 60,
              hsv: {
                h: 60,
                s: 60,
                v: 90
              }
            }, {
              name: 'Encourage',
              x: 100,
              hsv: {
                h: 255,
                s: 60,
                v: 90
              }
            }
          ];
          for (ab = 0, len6 = ref6.length; ab < len6; ab++) {
            col = ref6[ab];
            practice = this.build.getPractice(plane.name, flo.rowName, col.name);
            this.flow(practice, 'south', col.x, flo.y, plane.z, sprac, col.hsv, flow, floc, flob, floe, flop);
          }
        }
      }
      ref7 = [
        {
          name: 'Information',
          z: 90
        }, {
          name: 'DataScience',
          z: 60
        }, {
          name: 'Knowledge',
          z: 30
        }
      ];
      for (ac = 0, len7 = ref7.length; ac < len7; ac++) {
        pla = ref7[ac];
        ref8 = [
          {
            name: 'Learn',
            y: 100
          }, {
            name: 'Do',
            y: 60
          }, {
            name: 'Share',
            y: 20
          }
        ];
        for (ad = 0, len8 = ref8.length; ad < len8; ad++) {
          row = ref8[ad];
          ref9 = [
            {
              name: 'Embrace',
              x: 20
            }, {
              name: 'Innovate',
              x: 60
            }, {
              name: 'Encourage',
              x: 100
            }
          ];
          for (ae = 0, len9 = ref9.length; ae < len9; ae++) {
            col = ref9[ae];
            practice = this.build.getPractice(pla.name, row.name, col.name);
            this.conduit(practice, 'next', col.x, row.y, pla.z, sprac, practice.hsv, pipv, pipc, pipb, pipe, pipp);
          }
        }
      }
      return [xyzs, cubp, cubc, hexp, hexc, hexq, hext, hexi, prcp, prct, prci, conv, conc, cont, conp, flow, floc, flob, floe, flop, pipv, pipc, pipb, pipe, pipp];
    };

    IKW.prototype.cubeFaces = function(x, y, z, s, cubp) {
      cubp.push([[x - s, y - s, z - s], [x - s, y + s, z - s], [x - s, y + s, z + s], [x - s, y - s, z + s]]);
      cubp.push([[x + s, y - s, z - s], [x + s, y + s, z - s], [x + s, y + s, z + s], [x + s, y - s, z + s]]);
      cubp.push([[x - s, y - s, z - s], [x + s, y - s, z - s], [x + s, y - s, z + s], [x - s, y - s, z + s]]);
      cubp.push([[x - s, y + s, z - s], [x + s, y + s, z - s], [x + s, y + s, z + s], [x - s, y + s, z + s]]);
      cubp.push([[x - s, y - s, z - s], [x + s, y - s, z - s], [x + s, y + s, z - s], [x - s, y + s, z - s]]);
      cubp.push([[x - s, y - s, z + s], [x + s, y - s, z + s], [x + s, y + s, z + s], [x - s, y + s, z + s]]);
    };

    IKW.prototype.convey = function(practice, dir, x, y, z, s, hsv, conv, conc, cont, conp) {
      var beg, end, q, ref;
      q = s / 2;
      ref = this.build.connectName(practice, dir), beg = ref[0], end = ref[1];
      conv.push([[x - s, y - q, z], [x - s, y + q, z], [x + s, y + q, z], [x + s, y - q, z]]);
      conc.push(Vis.toRgbHsv(hsv.h, hsv.s, hsv.v, true));
      cont.push(beg + ' ' + end);
      conp.push([x, y, z]);
    };

    IKW.prototype.flow = function(practice, dir, x, y, z, s, hsv, flow, floc, flob, floe, flop) {
      var beg, end, q, ref;
      q = s / 2;
      ref = this.build.connectName(practice, dir), beg = ref[0], end = ref[1];
      flow.push([[x - q, y - s, z], [x - q, y + s, z], [x + q, y + s, z], [x + q, y - s, z]]);
      floc.push(Vis.toRgbHsv(hsv.h, hsv.s, hsv.v, true));
      flob.push(beg);
      floe.push(end);
      flop.push([x, y, z]);
    };

    IKW.prototype.conduit = function(practice, dir, x, y, z, s, hsv, pipv, pipc, pipb, pipe, pipp) {
      var beg, end, q, ref;
      q = s / 2;
      ref = this.build.connectName(practice, dir), beg = ref[0], end = ref[1];
      pipv.push([[x - q, y, z - q], [x + q, y, z - q], [x + q, y, z + q], [x - q, y, z + q]]);
      pipc.push(Vis.toRgbHsv(hsv[0], hsv[1], hsv[2], true));
      pipb.push(beg);
      pipe.push(end);
      pipp.push([x, y, z]);
    };

    IKW.prototype.fourTier = function(x, y, z, s, study, hexp, hexc, hexq, hext, hexi) {
      var c, cos30s, h, ref, v;
      cos30s = Vis.cos(30) * s;
      if (Util.contains(this.serv, study.concern)) {
        hexp.push(this.hex(x, y + cos30s, z, s, hexq));
      }
      if (Util.contains(this.peop, study.concern)) {
        hexp.push(this.hex(x - 1.5 * s, y, z, s, hexq));
      }
      if (Util.contains(this.data, study.concern)) {
        hexp.push(this.hex(x + 1.5 * s, y, z, s, hexq));
      }
      if (Util.contains(this.netw, study.concern)) {
        hexp.push(this.hex(x, y - cos30s, z, s, hexq));
      }
      ref = this.build.studyHsv(study), h = ref[0], c = ref[1], v = ref[2];
      hexc.push(Vis.toRgbHsv(h, c, v, true));
      hext.push(study.key);
      hexi.push(Prac.unicode(study.icon));
    };

    IKW.prototype.hex = function(x, y, z, s, hexq) {
      var ang, l, len1, pts, ref;
      hexq.push([x, y, z]);
      pts = [];
      ref = [0, 60, 120, 180, 240, 300];
      for (l = 0, len1 = ref.length; l < len1; l++) {
        ang = ref[l];
        pts.push([x + s * Vis.cos(ang), y + s * Vis.sin(ang), z]);
      }
      return pts;
    };

    IKW.prototype.studySlots = function(x, y, z, sprac, subs) {
      var l, len1, len2, m, ref, ref1, s, t, u;
      s = sprac / 3;
      ref = [s, s * 3, s * 5];
      for (l = 0, len1 = ref.length; l < len1; l++) {
        t = ref[l];
        ref1 = [s, s * 3, s * 5];
        for (m = 0, len2 = ref1.length; m < len2; m++) {
          u = ref1[m];
          this.cubeFaces(x + t - sprac, y + u - sprac, z - s * 2, s, subs);
        }
      }
    };

    IKW.prototype.flotExpr = function(emit, el) {
      return emit(el('div', {}, 'Practice'));
    };

    IKW.prototype.viewXyzsRgbs = function(view) {
      var conc, conp, cont, conv, cubc, cubp, flob, floc, floe, flop, flow, hexc, hexi, hexp, hexq, hext, pipb, pipc, pipe, pipp, pipv, prci, prcp, prct, ref, xyzs;
      ref = this.createArrays(), xyzs = ref[0], cubp = ref[1], cubc = ref[2], hexp = ref[3], hexc = ref[4], hexq = ref[5], hext = ref[6], hexi = ref[7], prcp = ref[8], prct = ref[9], prci = ref[10], conv = ref[11], conc = ref[12], cont = ref[13], conp = ref[14], flow = ref[15], floc = ref[16], flob = ref[17], floe = ref[18], flop = ref[19], pipv = ref[20], pipc = ref[21], pipb = ref[22], pipe = ref[23], pipp = ref[24];
      view.array({
        data: xyzs,
        id: "xyzs",
        items: 1,
        channels: 4,
        live: false,
        width: xyzs.length
      });
      view.array({
        data: cubp,
        id: "cubp",
        items: 4,
        channels: 3,
        live: false,
        width: cubp.length
      });
      view.array({
        data: cubc,
        id: "cubc",
        items: 1,
        channels: 4,
        live: false,
        width: cubc.length
      });
      view.array({
        data: hexp,
        id: "hexp",
        items: 6,
        channels: 3,
        live: false,
        width: hexp.length
      });
      view.array({
        data: hexc,
        id: "hexc",
        items: 1,
        channels: 4,
        live: false,
        width: hexc.length
      });
      view.array({
        data: hexq,
        id: "hexq",
        items: 1,
        channels: 3,
        live: false,
        width: hexq.length
      });
      view.array({
        data: prcp,
        id: "prcp",
        items: 1,
        channels: 4,
        live: false,
        width: prcp.length
      });
      view.array({
        data: conv,
        id: "conv",
        items: 4,
        channels: 3,
        live: false,
        width: conv.length
      });
      view.array({
        data: conc,
        id: "conc",
        items: 1,
        channels: 4,
        live: false,
        width: conc.length
      });
      view.array({
        data: conp,
        id: "conp",
        items: 1,
        channels: 3,
        live: false,
        width: conp.length
      });
      view.array({
        data: flow,
        id: "flow",
        items: 4,
        channels: 3,
        live: false,
        width: flow.length
      });
      view.array({
        data: floc,
        id: "floc",
        items: 1,
        channels: 4,
        live: false,
        width: floc.length
      });
      view.array({
        data: flop,
        id: "flop",
        items: 1,
        channels: 3,
        live: false,
        width: flop.length
      });
      view.array({
        data: pipv,
        id: "pipv",
        items: 4,
        channels: 3,
        live: false,
        width: pipv.length
      });
      view.array({
        data: pipc,
        id: "pipc",
        items: 1,
        channels: 4,
        live: false,
        width: pipc.length
      });
      view.array({
        data: pipp,
        id: "pipp",
        items: 1,
        channels: 3,
        live: false,
        width: pipp.length
      });
      view.face({
        points: "#cubp",
        colors: "#cubc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 1,
        opacity: 0.3
      });
      view.face({
        points: "#hexp",
        colors: "#hexc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 2,
        opacity: 1.0
      });
      view.face({
        points: "#hexp",
        colors: "#hexc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 2,
        opacity: 1.0
      });
      view.face({
        points: "#conv",
        colors: "#conc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 3,
        opacity: 0.5
      });
      view.face({
        points: "#flow",
        colors: "#floc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 3,
        opacity: 0.5
      });
      view.face({
        points: "#pipv",
        colors: "#pipc",
        color: 0xffffff,
        shaded: true,
        fill: true,
        line: true,
        closed: true,
        zIndex: 3,
        opacity: 0.5
      });
      view.text({
        data: prct,
        font: 'Font Awesome',
        width: prct.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#prcp",
        color: '#ffffff',
        snap: false,
        size: 24,
        offset: [0, -72],
        depth: 0.5,
        zIndex: 3,
        outline: 0
      });
      view.text({
        data: prci,
        font: 'FontAwesome',
        width: prci.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#prcp",
        color: '#ffffff',
        snap: false,
        size: 72,
        offset: [0, -6],
        depth: 0.5,
        zIndex: 3,
        outline: 0
      });
      view.text({
        data: hext,
        font: 'Font Awesome',
        width: hext.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#hexq",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, -15],
        depth: 0.5,
        zIndex: 3,
        outline: 0
      });
      view.text({
        data: hexi,
        font: 'FontAwesome',
        width: hexi.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#hexq",
        color: '#000000',
        snap: false,
        size: 36,
        offset: [0, 15],
        depth: 0.5,
        zIndex: 3,
        outline: 0
      });
      view.text({
        data: cont,
        font: 'FontAwesome',
        width: cont.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#conp",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, 15],
        depth: 0.5,
        zIndex: 4,
        outline: 0
      });
      view.text({
        data: flob,
        font: 'FontAwesome',
        width: flob.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#flop",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, 15],
        depth: 0.5,
        zIndex: 4,
        outline: 0
      });
      view.text({
        data: floe,
        font: 'FontAwesome',
        width: floe.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#flop",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, -15],
        depth: 0.5,
        zIndex: 4,
        outline: 0
      });
      view.text({
        data: pipb,
        font: 'FontAwesome',
        width: pipb.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#pipp",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, -15],
        depth: 0.5,
        zIndex: 4,
        outline: 0
      });
      view.text({
        data: pipe,
        font: 'FontAwesome',
        width: pipe.length,
        height: 1,
        depth: 1
      });
      view.label({
        points: "#pipp",
        color: '#000000',
        snap: false,
        size: 16,
        offset: [0, 15],
        depth: 0.5,
        zIndex: 4,
        outline: 0
      });
    };

    IKW.prototype.toRgbHexxFaces = function(len) {
      var l, len1, m, prac, ref, ref1, rgba, rgbh;
      rgbh = [];
      for (prac = l = 0, ref = len; 0 <= ref ? l < ref : l > ref; prac = 0 <= ref ? ++l : --l) {
        ref1 = [[180, 50, 90], [60, 50, 90], [90, 50, 90], [30, 50, 90]];
        for (m = 0, len1 = ref1.length; m < len1; m++) {
          rgba = ref1[m];
          rgbh.push(Vis.toRgbHsv(rgba[0], rgba[1], rgba[2], true));
        }
      }
      return rgbh;
    };

    IKW.prototype.musePoints = function() {
      var obj;
      obj = {
        id: 'musePoints',
        width: this.width,
        height: this.height,
        depth: this.depth,
        items: 1,
        channels: 4
      };
      obj.expr = (function(_this) {
        return function(emit, x, y, z) {
          return emit(_this.center(x), _this.center(y), _this.center(z), 1);
        };
      })(this);
      return obj;
    };

    IKW.prototype.center = function(u) {
      var v;
      v = u;
      if (0 <= u && u < 40) {
        v = 20;
      }
      if (80 <= u && u < 80) {
        v = 60;
      }
      if (80 <= u && u <= 120) {
        v = 100;
      }
      return v;
    };

    IKW.prototype.museColors = function() {
      var obj;
      obj = {
        id: 'museColors',
        width: this.width,
        height: this.height,
        depth: this.depth,
        channels: 4
      };
      obj.expr = (function(_this) {
        return function(emit, x, y, z) {
          var a, b, g, r, ref;
          ref = _this.practiceColor(x, y, z, i, j, k), r = ref[0], g = ref[1], b = ref[2], a = ref[3];
          return emit(r, g, b, a);
        };
      })(this);
      return obj;
    };

    IKW.prototype.musePoint = function() {
      var obj;
      obj = {
        id: "musePoint",
        points: "#musePoints",
        colors: "#museColors",
        shape: "square",
        color: 0xffffff,
        size: 600
      };
      return obj;
    };

    IKW.prototype.museText = function() {
      var obj, str;
      str = function(n) {
        return Util.toStr(n);
      };
      obj = {
        font: 'Helvetica',
        style: 'bold',
        width: 16,
        height: 5,
        depth: 2
      };
      obj.expr = (function(_this) {
        return function(emit, i, j, k, time) {
          Util.noop(time);
          if (_this.ni < _this.nt) {
            _this.ni = _this.ni + 1;
          }
          return emit("Hi " + (str(i)) + " " + (str(j)) + " " + (str(k)));
        };
      })(this);
      return obj;
    };

    IKW.prototype.museLabel = function() {
      return {
        points: "#musePoints",
        color: '#000000',
        snap: false,
        outline: 2,
        size: 24,
        depth: .5,
        zIndex: 5
      };
    };

    IKW.prototype.museCube = function(view) {
      view.volume(this.musePoints());
      view.volume(this.museColors());
      return view.point(this.musePoint()).text(this.museText()).label(this.museLabel());
    };

    IKW.prototype.practiceColor = function(x, y, z) {
      var c, hue, v;
      if (0 <= x && x < 40) {
        hue = 210;
      } else if (40 <= x && x < 80) {
        hue = 60;
      } else if (80 <= x && x <= 120) {
        hue = 300;
      }
      if (0 <= y && y < 40) {
        c = 40;
      } else if (40 <= y && y < 80) {
        c = 60;
      } else if (80 <= y && y <= 120) {
        c = 80;
      }
      if (0 <= z && z < 40) {
        v = 40;
      } else if (40 <= z && z < 80) {
        v = 60;
      } else if (80 <= z && z <= 120) {
        v = 80;
      }
      return Vis.toRgbHsv(hue, c, v, true);
    };

    return IKW;

  })();

}).call(this);
