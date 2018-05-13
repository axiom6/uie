// Generated by CoffeeScript 1.6.3
(function() {
  var Vis;

  Vis = (function() {
    function Vis() {}

    module.exports = Vis;

    Vis.Palettes = require('js/d3d/Palettes');

    Vis.chroma = require('chroma-js');

    Vis.rad = function(deg) {
      return deg * Math.PI / 180;
    };

    Vis.deg = function(rad) {
      return rad * 180 / Math.PI;
    };

    Vis.sin = function(deg) {
      return Math.sin(Vis.rad(deg));
    };

    Vis.cos = function(deg) {
      return Math.cos(Vis.rad(deg));
    };

    Vis.rot = function(deg, ang) {
      var a;
      a = deg + ang;
      if (a < 0) {
        a = a + 360;
      }
      return a;
    };

    Vis.toRadian = function(h, hueIsRygb) {
      var hue, radian;
      if (hueIsRygb == null) {
        hueIsRygb = false;
      }
      hue = hueIsRygb ? Vis.toHueRygb(h) : h;
      radian = 2 * π * (90 - hue) / 360;
      if (radian < 0) {
        radian = 2 * π + radian;
      }
      return radian;
    };

    Vis.svgDeg = function(deg) {
      return 360 - deg;
    };

    Vis.svgRad = function(rad) {
      return 2 * Math.PI - rad;
    };

    Vis.radSvg = function(deg) {
      return Vis.rad(360 - deg);
    };

    Vis.degSvg = function(rad) {
      return Vis.deg(2 * Math.PI - rad);
    };

    Vis.sinSvg = function(deg) {
      return Math.sin(Vis.radSvg(deg));
    };

    Vis.cosSvg = function(deg) {
      return Math.cos(Vis.radSvg(deg));
    };

    Vis.chRgbHsl = function(h, s, l) {
      return Vis.chroma.hsl(h, s, l).rgb();
    };

    Vis.chRgbHsv = function(h, s, v) {
      return Vis.chroma.hsv(h, s, v).rgb();
    };

    Vis.chRgbLab = function(L, a, b) {
      return Vis.chroma.lab(L, a, b).rgb();
    };

    Vis.chRgbLch = function(L, c, h) {
      return Vis.chroma.lch(l, c, h).rgb();
    };

    Vis.chRgbHcl = function(h, c, l) {
      return Vis.chroma.hsl(h, s, l).rgb();
    };

    Vis.chRgbCmyk = function(c, m, y, k) {
      return Vis.chroma.hsl(c, m, y, k).rgb();
    };

    Vis.chRgbGl = function(R, G, B) {
      return Vis.chroma.gl(R, G, B).rgb();
    };

    Vis.toRgbRygb = function(r, y, g, b) {
      return [Math.max(r, y, 0), Math.max(g, y, 0), Math.max(b, 0)];
    };

    Vis.toRygbRgb = function(r, g, b) {
      return [r, Math.max(r, g), g, b];
    };

    Vis.toRgbHsvSigmoidal = function(H, C, V, toRygb) {
      var b, c, d, f, g, h, i, r, v, x, y, z, _ref;
      if (toRygb == null) {
        toRygb = true;
      }
      h = toRygb ? Vis.toHueRgb(H) : H;
      d = C * 0.01;
      c = Vis.sigmoidal(d, 2, 0.25);
      v = V * 0.01;
      i = Math.floor(h / 60);
      f = h / 60 - i;
      x = 1 - c;
      y = 1 - f * c;
      z = 1 - (1 - f) * c;
      _ref = (function() {
        switch (i % 6) {
          case 0:
            return [1, z, x, 1];
          case 1:
            return [y, 1, x, 1];
          case 2:
            return [x, 1, z, 1];
          case 3:
            return [x, y, 1, 1];
          case 4:
            return [z, x, 1, 1];
          case 5:
            return [1, x, y, 1];
        }
      })(), r = _ref[0], g = _ref[1], b = _ref[2];
      return [r * v, g * v, b * v, 1];
    };

    Vis.toRgbHsv = function(H, C, V, toRygb) {
      var b, c, f, g, h, i, r, v, x, y, z, _ref;
      if (toRygb == null) {
        toRygb = true;
      }
      h = toRygb ? Vis.toHueRgb(H) : H;
      c = C * 0.01;
      v = V * 0.01;
      i = Math.floor(h / 60);
      f = h / 60 - i;
      x = 1 - c;
      y = 1 - f * c;
      z = 1 - (1 - f) * c;
      _ref = (function() {
        switch (i % 6) {
          case 0:
            return [1, z, x, 1];
          case 1:
            return [y, 1, x, 1];
          case 2:
            return [x, 1, z, 1];
          case 3:
            return [x, y, 1, 1];
          case 4:
            return [z, x, 1, 1];
          case 5:
            return [1, x, y, 1];
        }
      })(), r = _ref[0], g = _ref[1], b = _ref[2];
      return [r * v, g * v, b * v, 1];
    };

    Vis.toHcsRgb = function(R, G, B, toRygb) {
      var H, a, b, c, g, h, r, s, sum;
      if (toRygb == null) {
        toRygb = true;
      }
      sum = R + G + B;
      r = R / sum;
      g = G / sum;
      b = B / sum;
      s = sum / 3;
      c = R === G && G === B ? 0 : 1 - 3 * Math.min(r, g, b);
      a = Vis.deg(Math.acos((r - 0.5 * (g + b)) / Math.sqrt((r - g) * (r - g) + (r - b) * (g - b))));
      h = b <= g ? a : 360 - a;
      if (c === 0) {
        h = 0;
      }
      H = toRygb ? Vis.toHueRgb(h) : h;
      return [H, c * 100, s / 2.55];
    };

    Vis.toRgbCode = function(code) {
      var hex, rgb, s, str;
      str = Vis.Palettes.hex(code).replace("#", "0x");
      hex = Number.parseInt(str, 16);
      rgb = Vis.hexRgb(hex);
      s = 1 / 256;
      return [rgb.r * s, rgb.g * s, rgb.b * s, 1];
    };

    Vis.toRgba = function(studyPrac) {
      var h, s, v, _ref;
      if ((studyPrac.hsv != null) && studyPrac.hsv.length === 3) {
        _ref = studyPrac.hsv, h = _ref[0], s = _ref[1], v = _ref[2];
        return Vis.toRgbHsvSigmoidal(h, s, v);
      } else if (studyPrac.fill.length <= 5) {
        return Vis.toRgbCode(studyPrac.fill);
      } else {
        Util.error('Vis.toRgba() unknown fill code', studyPrac.name, studyPrac.fill);
        return '#888888';
      }
    };

    Vis.toHsvHex = function(hexStr) {
      var hex, hsv, rgb, str;
      str = hexStr.replace("#", "0x");
      hex = Number.parseInt(str, 16);
      rgb = Vis.hexRgb(hex);
      hsv = Vis.toHcsRgb(rgb.r, rgb.g, rgb.b);
      return hsv;
    };

    Vis.toHexRgb = function(rgb) {
      return rgb[0] * 4026 + rgb[1] * 256 + rgb[2];
    };

    Vis.toCssHex = function(hex) {
      return "#" + (hex.toString(16));
    };

    Vis.toCssHsv1 = function(hsv) {
      var css, hex, rgb;
      rgb = Vis.toRgbHsv(hsv[0], hsv[1], hsv[2]);
      hex = Vis.toHexRgbSigmoidal(rgb);
      css = "#" + (hex.toString());
      return css;
    };

    Vis.toCssHsv2 = function(hsv) {
      var css, rgb;
      rgb = Vis.toRgbHsvSigmoidal(hsv[0], hsv[1], hsv[2]);
      css = Vis.chroma.gl(rgb[0], rgb[1], rgb[2]).hex();
      return css;
    };

    Vis.toHsvCode = function(code) {
      var hsv, i, rgb, _i;
      rgb = Vis.toRgbCode(code);
      hsv = Vis.toHcsRgb(rgb[0], rgb[1], rgb[2], true);
      for (i = _i = 0; _i < 3; i = ++_i) {
        hsv[i] = Math.round(hsv[i]);
      }
      return hsv;
    };

    Vis.chRgbHsvStr = function(hsv) {
      var h, i, rgb, _i;
      h = Vis.toHueRgb(hsv[0]);
      rgb = Vis.chRgbHsv(h, hsv[1] * 0.01, hsv[2] * 0.01);
      for (i = _i = 0; _i < 3; i = ++_i) {
        rgb[i] = Math.round(rgb[i]);
      }
      return "rgba(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + ",1)";
    };

    Vis.toRgbHsvStr = function(hsv) {
      var a, b, g, i, r, rgba, str, _i;
      rgba = Vis.toRgbHsvSigmoidal(hsv[0], hsv[1], hsv[2] * 255, true);
      for (i = _i = 0; _i < 3; i = ++_i) {
        rgba[i] = Math.round(rgba[i]);
      }
      r = rgba[0], g = rgba[1], b = rgba[2], a = rgba[3];
      str = "rgba(" + r + "," + g + "," + b + "," + a + ")";
      return str;
    };

    Vis.sigmoidal = function(x, k, x0, L) {
      if (x0 == null) {
        x0 = 0.5;
      }
      if (L == null) {
        L = 1;
      }
      return L / (1 + Math.exp(-k * (x - x0)));
    };

    Vis.prototype.rgbaStr = function() {
      var a, b, g, n, r, _ref;
      n = function(f) {
        return Math.round(f);
      };
      _ref = this.rgba, r = _ref[0], g = _ref[1], b = _ref[2], a = _ref[3];
      return "rgba(" + (n(r)) + "," + (n(g)) + "," + (n(b)) + "," + (n(a)) + ")";
    };

    Vis.toRgbHcs = function(H, C, S, toRygb) {
      var b, c, g, h, max, r, s, v, x, y, z, _ref, _ref1, _ref2, _ref3;
      if (toRygb == null) {
        toRygb = true;
      }
      h = toRygb ? Vis.toHueRgb(H) : H;
      c = C * 0.01;
      s = S * 0.01;
      x = 1 - c;
      y = function(a) {
        return 1 + c * Vis.cos(h - a) / Vis.cos(a + 60 - h);
      };
      z = function(a) {
        return 3 - x - y(a);
      };
      _ref = [0, 0, 0], r = _ref[0], g = _ref[1], b = _ref[2];
      if (0 <= h && h < 120) {
        _ref1 = [y(0), z(0), x], r = _ref1[0], g = _ref1[1], b = _ref1[2];
      }
      if (120 <= h && h < 240) {
        _ref2 = [x, y(120), z(120)], r = _ref2[0], g = _ref2[1], b = _ref2[2];
      }
      if (240 <= h && h < 360) {
        _ref3 = [z(240), x, y(240)], r = _ref3[0], g = _ref3[1], b = _ref3[2];
      }
      max = Math.max(r, g, b) * s;
      v = max > 255 ? s * 255 / max : s;
      return [r * v, g * v, b * v, 1];
    };

    Vis.toRgbSphere = function(hue, phi, rad) {
      return Vis.toRgbHsv(Vis.rot(hue, 90), 100 * Vis.sin(phi), 100 * rad);
    };

    Vis.toHclRygb = function(r, y, g, b) {
      var C, H, L;
      L = (r + y + g + b) / 4;
      C = (Math.abs(r - y) + Math.abs(y - g) + Math.abs(g - b) + Math.abs(b - r)) / 4;
      H = Vis.angle(r - g, y - b, 0);
      return [H, C, L];
    };

    Vis.sScale = function(hue, c, s) {
      var ch, m120, m60, s60, ss;
      ss = 1.0;
      m60 = hue % 60;
      m120 = hue % 120;
      s60 = m60 / 60;
      ch = c / 100;
      ss = m120 < 60 ? 3.0 - 1.5 * s60 : 1.5 + 1.5 * s60;
      return s * (1 - ch) + s * ch * ss;
    };

    Vis.sScaleCf = function(hue, c, s) {
      var cf, cosd, cosu, m120, m60, ss;
      ss = sScale(hue, c, s);
      m60 = hue % 60;
      m120 = hue % 120;
      cosu = (1 - Vis.cos(m60)) * 100.00;
      cosd = (1 - Vis.cos(60 - m60)) * 100.00;
      cf = m120 < 60 ? cosu : cosd;
      return ss - cf;
    };

    Vis.toHueRygb = function(hue) {
      var hRygb;
      hRygb = 0;
      if (0 <= hue && hue < 120) {
        hRygb = hue * 180 / 120;
      } else if (120 <= hue && hue < 240) {
        hRygb = 180 + (hue - 120) * 90 / 120;
      } else if (240 <= hue && hue < 360) {
        hRygb = 270 + (hue - 240) * 90 / 120;
      }
      return hRygb;
    };

    Vis.toHueRgb = function(hue) {
      var hRgb;
      hRgb = 0;
      if (0 <= hue && hue < 90) {
        hRgb = hue * 60 / 90;
      } else if (90 <= hue && hue < 180) {
        hRgb = 60 + (hue - 90) * 60 / 90;
      } else if (180 <= hue && hue < 270) {
        hRgb = 120 + (hue - 180) * 120 / 90;
      } else if (270 <= hue && hue < 360) {
        hRgb = 240 + (hue - 270) * 120 / 90;
      }
      return hRgb;
    };

    Vis.pad2 = function(n) {
      var s;
      s = n.toString();
      if (0 <= n && n <= 9) {
        s = '&nbsp;' + s;
      }
      return s;
    };

    Vis.pad3 = function(n) {
      var s;
      s = n.toString();
      if (0 <= n && n <= 9) {
        s = '&nbsp;&nbsp;' + s;
      }
      if (10 <= n && n <= 99) {
        s = '&nbsp;' + s;
      }
      return s;
    };

    Vis.dec = function(f) {
      return Math.round(f * 100) / 100;
    };

    Vis.quotes = function(str) {
      return '"' + str + '"';
    };

    Vis.within = function(beg, deg, end) {
      return beg <= deg && deg <= end;
    };

    Vis.isZero = function(v) {
      return -0.01 < v && v < 0.01;
    };

    Vis.floor = function(x, dx) {
      var dr;
      dr = Math.round(dx);
      return Math.floor(x / dr) * dr;
    };

    Vis.ceil = function(x, dx) {
      var dr;
      dr = Math.round(dx);
      return Math.ceil(x / dr) * dr;
    };

    Vis.to = function(a, a1, a2, b1, b2) {
      return (a - a1) / (a2 - a1) * (b2 - b1) + b1;
    };

    Vis.angle = function(x, y) {
      var ang;
      if (!this.isZero(x) && !this.isZero(y)) {
        ang = Vis.deg(Math.atan2(y, x));
      }
      if (this.isZero(x) && this.isZero(y)) {
        ang = 0;
      }
      if (x > 0 && this.isZero(y)) {
        ang = 0;
      }
      if (this.isZero(x) && y > 0) {
        ang = 90;
      }
      if (x < 0 && this.isZero(y)) {
        ang = 180;
      }
      if (this.isZero(x) && y < 0) {
        ang = 270;
      }
      ang = Vis.deg(Math.atan2(y, x));
      return ang = ang < 0 ? 360 + ang : ang;
    };

    Vis.angleSvg = function(x, y) {
      return Vis.angle(x, -y);
    };

    Vis.minRgb = function(rgb) {
      return Math.min(rgb.r, rgb.g, rgb.b);
    };

    Vis.maxRgb = function(rgb) {
      return Math.max(rgb.r, rgb.g, rgb.b);
    };

    Vis.sumRgb = function(rgb) {
      return rgb.r + rgb.g + rgb.b;
    };

    Vis.hexCss = function(hex) {
      return "#" + (hex.toString(16));
    };

    Vis.rgbCss = function(rgb) {
      return "rgb(" + rgb.r + "," + rgb.g + "," + rgb.b + ")";
    };

    Vis.hslCss = function(hsl) {
      return "hsl(" + hsl.h + "," + (hsl.s * 100) + "%," + (hsl.l * 100) + "%)";
    };

    Vis.hsiCss = function(hsi) {
      return Vis.hslCss(Vis.rgbToHsl(Vis.hsiToRgb(hsi)));
    };

    Vis.hsvCss = function(hsv) {
      return Vis.hslCss(Vis.rgbToHsl(Vis.hsvToRgb(hsv)));
    };

    Vis.roundRgb = function(rgb, f) {
      if (f == null) {
        f = 1.0;
      }
      return {
        r: Math.round(rgb.r * f),
        g: Math.round(rgb.g * f),
        b: Math.round(rgb.b * f)
      };
    };

    Vis.roundHsl = function(hsl) {
      return {
        h: Math.round(hsl.h),
        s: Vis.dec(hsl.s),
        l: Vis.dec(hsl.l)
      };
    };

    Vis.roundHsi = function(hsi) {
      return {
        h: Math.round(hsi.h),
        s: Vis.dec(hsi.s),
        i: Math.round(hsi.i)
      };
    };

    Vis.roundHsv = function(hsv) {
      return {
        h: Math.round(hsv.h),
        s: Vis.dec(hsv.s),
        v: Vis.dec(hsv.v)
      };
    };

    Vis.fixedDec = function(rgb) {
      return {
        r: Vis.dec(rgb.r),
        g: Vis.dec(rgb.g),
        b: Vis.dec(rgb.b)
      };
    };

    Vis.hexRgb = function(hex) {
      return Vis.roundRgb({
        r: (hex & 0xFF0000) >> 16,
        g: (hex & 0x00FF00) >> 8,
        b: hex & 0x0000FF
      });
    };

    Vis.rgbHex = function(rgb) {
      return rgb.r * 4096 + rgb.g * 256 + rgb.b;
    };

    Vis.cssRgb = function(str) {
      var hex, hsl, rgb, toks;
      rgb = {
        r: 0,
        g: 0,
        b: 0
      };
      if (str[0] === '#') {
        hex = parseInt(str.substr(1), 16);
        rgb = Vis.hexRgb(hex);
      } else if (str.slice(0, 3) === 'rgb') {
        toks = str.split(/[\s,\(\)]+/);
        rgb = Vis.roundRgb({
          r: parseInt(toks[1]),
          g: parseInt(toks[2]),
          b: parseInt(toks[3])
        });
      } else if (str.slice(0, 3) === 'hsl') {
        toks = str.split(/[\s,\(\)]+/);
        hsl = {
          h: parseInt(toks[1]),
          s: parseInt(toks[2]),
          l: parseInt(toks[3])
        };
        rgb = Vis.hslToRgb(hsl);
      } else {
        Util.error('Vis.cssRgb() unknown CSS color', str);
      }
      return rgb;
    };

    Vis.rgbToHsi = function(rgb) {
      var a, b, g, h, i, r, s, sum;
      sum = Vis.sumRgb(rgb);
      r = rgb.r / sum;
      g = rgb.g / sum;
      b = rgb.b / sum;
      i = sum / 3;
      s = 1 - 3 * Math.min(r, g, b);
      a = Vis.deg(Math.acos((r - 0.5 * (g + b)) / Math.sqrt((r - g) * (r - g) + (r - b) * (g - b))));
      h = b <= g ? a : 360 - a;
      return Vis.roundHsi({
        h: h,
        s: s,
        i: i
      });
    };

    Vis.hsiToRgb = function(hsi) {
      var fac, h, i, max, rgb, s, x, y, z;
      h = hsi.h;
      s = hsi.s;
      i = hsi.i;
      x = 1 - s;
      y = function(a) {
        return 1 + s * Vis.cos(h - a) / Vis.cos(a + 60 - h);
      };
      z = function(a) {
        return 3 - x - y(a);
      };
      rgb = {
        r: 0,
        g: 0,
        b: 0
      };
      if (0 <= h && h < 120) {
        rgb = {
          r: y(0),
          g: z(0),
          b: x
        };
      }
      if (120 <= h && h < 240) {
        rgb = {
          r: x,
          g: y(120),
          b: z(120)
        };
      }
      if (240 <= h && h < 360) {
        rgb = {
          r: z(240),
          g: x,
          b: y(240)
        };
      }
      max = Vis.maxRgb(rgb) * i;
      fac = max > 255 ? i * 255 / max : i;
      return Vis.roundRgb(rgb, fac);
    };

    Vis.hsvToRgb = function(hsv) {
      var f, i, p, q, rgb, t, v;
      i = Math.floor(hsv.h / 60);
      f = hsv.h / 60 - i;
      p = hsv.v * (1 - hsv.s);
      q = hsv.v * (1 - f * hsv.s);
      t = hsv.v * (1 - (1 - f) * hsv.s);
      v = hsv.v;
      rgb = (function() {
        switch (i % 6) {
          case 0:
            return {
              r: v,
              g: t,
              b: p
            };
          case 1:
            return {
              r: q,
              g: v,
              b: p
            };
          case 2:
            return {
              r: p,
              g: v,
              b: t
            };
          case 3:
            return {
              r: p,
              g: q,
              b: v
            };
          case 4:
            return {
              r: t,
              g: p,
              b: v
            };
          case 5:
            return {
              r: v,
              g: p,
              b: q
            };
          default:
            Util.error('Vis.hsvToRgb()');
            return {
              r: v,
              g: t,
              b: p
            };
        }
      })();
      return Vis.roundRgb(rgb, 255);
    };

    Vis.rgbToHsv = function(rgb) {
      var d, h, max, min, s, v;
      rgb = Vis.rgbRound(rgb, 1 / 255);
      max = Vis.maxRgb(rgb);
      min = Vis.maxRgb(rgb);
      v = max;
      d = max - min;
      s = max === 0 ? 0 : d / max;
      h = 0;
      if (max !== min) {
        h = (function() {
          switch (max) {
            case r:
              return (rgb.g - rgb.b) / d + (g < b ? 6 : 0);
            case g:
              return (rgb.b - rgb.r) / d + 2;
            case b:
              return (rgb.r - rgb.g) / d + 4;
            default:
              return Util.error('Vis.rgbToHsv');
          }
        })();
      }
      return {
        h: Math.round(h * 60),
        s: Vis.dec(s),
        v: Vis.dec(v)
      };
    };

    Vis.hslToRgb = function(hsl) {
      var b, g, h, l, p, q, r, s;
      h = hsl.h;
      s = hsl.s;
      l = hsl.l;
      r = 1;
      g = 1;
      b = 1;
      if (s !== 0) {
        q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        p = 2 * l - q;
        r = Vis.hue2rgb(p, q, h + 1 / 3);
        g = Vis.hue2rgb(p, q, h);
        b = Vis.hue2rgb(p, q, h - 1 / 3);
      }
      return {
        r: Math.round(r * 255),
        g: Math.round(g * 255),
        b: Math.round(b * 255)
      };
    };

    Vis.hue2rgb = function(p, q, t) {
      if (t < 0) {
        t += 1;
      }
      if (t > 1) {
        t -= 1;
      }
      if (t < 1 / 6) {
        return p + (q - p) * 6 * t;
      }
      if (t < 1 / 2) {
        return q;
      }
      if (t < 2 / 3) {
        return p + (q - p) * (2 / 3 - t) * 6;
      }
      return p;
    };

    Vis.rgbsToHsl = function(red, green, blue) {
      return this.rgbToHsl({
        r: red,
        g: green,
        b: blue
      });
    };

    Vis.rgbToHsl = function(rgb) {
      var b, d, g, h, l, max, min, r, s;
      r = rgb.r / 255;
      g = rgb.g / 255;
      b = rgb.b / 255;
      max = Math.max(r, g, b);
      min = Math.min(r, g, b);
      h = 0;
      l = (max + min) / 2;
      s = 0;
      if (max !== min) {
        d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        h = (function() {
          switch (max) {
            case r:
              return (g - b) / d + (g < b ? 6 : 0);
            case g:
              return (b - r) / d + 2;
            case b:
              return (r - g) / d + 4;
            default:
              Util.error('Vis.@rgbToHsl()');
              return 0;
          }
        })();
      }
      return {
        h: Math.round(h * 60),
        s: Vis.dec(s),
        l: Vis.dec(l)
      };
    };

    Vis.FontAwesomeUnicodes = {
      "fa-calendar-o": "\uf133",
      "fa-book": "\uf02d",
      "fa-steam": "\uf1b6",
      "fa-circle": "\uf111",
      "fa-signal": "\uf012",
      "fa-external-link-square": "\uf14c",
      "fa-group": "\uf0c0",
      "fa-empire": "\uf1d1",
      "fa-diamond": "\uf219",
      "fa-spinner": "\uf110",
      "fa-wrench": "\uf0ad",
      "fa-bar-chart-o": "\uf080",
      "fa-refresh": "\uf021",
      "fa-medkit": "\uf0fa",
      "fa-compass": "\uf14e",
      "fa-flask": "\uf0c3",
      "fa-connectdevelop": "\uf20e",
      "fa-joomla": "\uf1aa",
      "fa-bar-chart": "\uf080",
      "fa-star-o": "\uf006",
      "fa-area-chart": "\uf1fe",
      "fa-cloud": "\uf0c2",
      "fa-code-fork": "\uf126",
      "fa-question-circle": "\uf059",
      "fa-tripadvisor": "\uf262",
      "fa-magic": "\uf0d0",
      "fa-object-group": "\uf247",
      "fa-language": "\uf1ab",
      "fa-graduation-cap": "\uf19d",
      "fa-user-plus": "\uf234",
      "fa-github-square": "\uf092",
      "fa-paint-brush": "\uf1fc",
      "fa-lightbulb-o": "\uf0eb",
      "fa-address-card": "\uf2bb",
      "fa-history": "\uf1da",
      "fa-eye": "\uf06e",
      "fa-fire": "\uf06d",
      "fa-codepen": "\uf0c1",
      "fa-link": "\uf0c1",
      "fa-tasks": "\uf0ae",
      "fa-child": "\uf1ae",
      "fa-briefcase": "\uf0b1",
      "fa-dropbox": "\uf16b",
      "fa-user": "\uf007",
      "fa-heart": "\uf004",
      "fa-truck": "\uf0d1",
      "fa-star": "\uf005",
      "fa-sitemap": "\uf0e8",
      "fa-cube": "\uf0eb",
      "fa-desktop": "\uf108",
      "fa-bars": "\uf0c9",
      "fa-database": "\uf1c0",
      "fa-binoculars": "\uf164",
      "fa-thumbs-up": "\uf0a2",
      "fa-bell": "\uf0f1",
      "fa-stethoscope": "\uf0f1",
      "fa-random": "\uf074",
      "fa-cogs": "\uf085",
      "fa-life-ring": "\uf1cd",
      "fa-globe": "\uf0ac",
      "fa-lock": "\uf023",
      "fa-cubes": "\uf1b3",
      "fa-money": "\uf0d6",
      "fa-anchor": "\uf13d",
      "fa-legal": "\uf0e3",
      "fa-university": "\uf19c",
      "fa-shield": "\uf132",
      "fa-align-left": "\uf036",
      "fa-arrow-circle-right": "\uf0a9",
      "fa-retweet": "\uf079",
      "fa-check-square": "\uf14a",
      "fa-modx": "\uf285",
      "fa-ioxhost": "\uf208",
      "fa-calculator": "\uf1ec",
      "fa-wordpress": "\uf19a",
      "fa-filter": "\uf0b0",
      "fa-html5": "\uf13b",
      "fa-search": "\uf002",
      "fa-leanpub": "\uf212",
      "fa-sliders": "\uf1de",
      "fa-database": "\uf1c0",
      "fa-table": "\uf0ce",
      "fa-user-md": "\uf0f0",
      "fa-line-chart": "\uf201",
      "fa-certificate": "\uf0a3",
      "fa-clone": "\uf24d",
      "fa-thumbs-down": "\uf165",
      "fa-hand-peace-o": "\uf25b",
      "fa-users": "\uf0c0",
      "fa-balance-scale": "\uf24e",
      "fa-newspaper-o": "\uf1ea",
      "fa-wechat": "\uf1d7 ",
      "fa-leaf": "\uf06c",
      "fa-dropbox": "\uf16b",
      "fa-external-link-square": "\uf14c",
      "fa-university": "\uf19c",
      "fa-life-ring": "\uf1cd",
      "fa-cubes": "\uf1b3",
      "fa-anchor": "\uf13d",
      "fa-compass": "\uf066",
      "fa-question": "\uf128",
      "fa-asl-interpreting": "\uf2a3",
      "fa-road": "\uf018",
      "fa-pied-piper-alt": "\uf1a8",
      "fa-gift": "\uf06b",
      "fa-universal-access": "\uf29a",
      "fa-cloud-download": "\uf0ed",
      "fa-blind": "\uf29d",
      "fa-sun-o": "\uf185",
      "fa-gears": "\uf085",
      "fa-gamepad": "\uf11b",
      "fa-slideshare": "\uf1e7",
      "fa-envelope-square": "\uf199",
      "fa-recycle": "\uf1b8",
      "fa-list-alt": "\uf022",
      "fa-wheelchair-alt": "\uf29b",
      "fa-trophy": "\uf091",
      "fa-headphones": "\uf025",
      "fa-codiepie": "\uf284",
      "fa-building-o": "\uf0f7",
      "fa-plus-circle": "\uf055",
      "fa-server": "\uf233",
      "fa-square-o": "\uf096",
      "fa-share-alt": "\uf1e0",
      "fa-handshake-o": "\uf2b5",
      "fa-snowflake-o": "\uf2dc",
      "fa-shower": "\uf2cc"
    };

    Vis.unicode = function(icon) {
      var uc;
      uc = Vis.FontAwesomeUnicodes[icon];
      if (uc == null) {
        Util.error('Vis.unicode() missing icon in Vis.FontAwesomeUnicodes for', icon);
        uc = "\uf111";
      }
      return uc;
    };

    Vis.unichar = function(icon) {
      var uc, un, us;
      uc = Vis.FontAwesomeUnicodes[icon];
      uc = uc == null ? "\uf111" : uc;
      un = Number.parseInt('0xf0ad', 16);
      us = String.fromCharCode(un);
      Util.log('Vis.unichar', {
        icon: icon,
        uc: uc,
        un: un,
        us: us
      });
      return "\uF000";
    };

    Vis.uniawe = function(icon) {
      var temp, uni;
      temp = document.createElement("i");
      temp.className = icon;
      document.body.appendChild(temp);
      uni = window.getComputedStyle(document.querySelector('.' + icon), ':before').getPropertyValue('content');
      Util.log('uniawe', icon, uni);
      temp.remove();
      return uni;
    };

    /*
    var setCursor = function (icon) {
        var tempElement = document.createElement("i");
        tempElement.className = icon;
        document.body.appendChild(tempElement);
        var character = window.getComputedStyle(
            document.querySelector('.' + icon), ':before'
        ).getPropertyValue('content');
        tempElement.remove();
    */


    return Vis;

  }).call(this);

}).call(this);
