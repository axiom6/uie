// Generated by CoffeeScript 1.10.0
(function() {
  var Schema;

  Schema = (function() {
    module.exports = Schema;

    Schema.cssUOM = ['px', 'in', 'cm', 'mm', 'pc', 'pt', 'px', 'em', 'ex', 'ch', 'vb', 'vw', 'vmax', 'vmin'];

    Schema.siUOM = ['m', 'kg', 's', 'A', 'K', 'mol', 'cd'];

    Schema.sciUOM = ['deg', 'rad'];

    Schema.UOMs = Schema.cssUOM.concat(Schema.siUOM, Schema.sciUOM);

    Schema.Opts = ['?', '1', '*', '+'];

    Schema.Props = {
      'type': 'type',
      'schema': 'schema',
      'qschemas': 'qschemas',
      'prim': 'prim',
      'ref': 'ref',
      'Enum': 'Enum',
      'opt': 'opt',
      'minmax': 'minmax',
      'format': 'format',
      'validator': 'validator',
      'default': 'default',
      'uom': 'uom',
      'abstract': 'abstract',
      '_ext': '_ext'
    };

    Schema.Propa = {
      't': 't',
      's': 's',
      'q': 'q',
      'p': 'p',
      'r': 'r',
      'E': 'E',
      'o': 'o',
      'm': 'm',
      'f': 'f',
      'v': 'v',
      'd': 'd',
      'u': 'u',
      'a': 'a',
      '_': '_'
    };

    Schema.toProp = function(chr) {
      var index;
      index = Schema.Propa.indexOf(chr);
      if (index >= 0) {
        return Schema.Props[index];
      } else {
        return 'undefined';
      }
    };

    Schema.isProp = function(key) {
      return Schema.Props.indexOf(key) !== -1 || Schema.Propa.indexOf(key) !== -1;
    };

    Schema.isUOM = function(uom) {
      return Schema.UOMs.indexOf(uom) !== -1;
    };

    Schema.isOpt = function(opt) {
      return Schema.Opts.indexOf(opt) !== -1;
    };


    /*
    @checkModel:( model, schema ) ->
      check = ''
      if Util.isArray( model )
        for obj in model
          check += Type.checkObj( key, schema[key] )
      else
        for key, obj of model
          check += Type.checkObj( key, schema[key] )
      check
     */

    Schema.checkProps = function(key, spec) {
      var check, k, v;
      check = '';
      for (k in spec) {
        v = spec[k];
        if (!Schema.isProp(k)) {
          check += Schema.checkProp(k, v, spec);
        }
        if (Schema.isKey(k, 'type')) {
          check += Schema.checkType(k, v, spec);
        }
        if (Schema.isKey(k, 'prim')) {
          check += Schema.checkPrim(k, v, spec);
        }
        if (Schema.isKey(k, 'spec')) {
          check += Schema.checkProp(k, v, spec);
        }
        if (Schema.isKey(k, 'ref')) {
          check += Schema.checkRef(k, v, spec);
        }
        if (Schema.isKey(k, 'opt')) {
          check += Schema.checkOpt(k, v, spec);
        }
        if (Schema.isKey(k, 'minmax')) {
          check += Schema.checkMinMax(k, v, spec);
        }
        if (Schema.isKey(k, 'format')) {
          check += Schema.checkFormat(k, v, spec);
        }
        if (Schema.isKey(k, 'validator')) {
          check += Schema.checkValid(k, v, spec);
        }
        if (Schema.isKey(k, 'default')) {
          check += Schema.checkDefault(k, v, spec);
        }
        if (Schema.isKey(k, 'uom')) {
          check += Schema.checkUom(k, v, spec);
        }
        if (Schema.isKey(k, 'abstract')) {
          check += Schema.checkAbstract(k, v, spec);
        }
        if (Schema.isKey(k, '_ext')) {
          check += Schema.checkExt(k, v, spec);
        }
      }
      return check;
    };

    Schema.checkProp = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkType = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkPrim = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkProp = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkRef = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkOpt = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkMinMax = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkFormat = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkValid = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkDefault = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkUom = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkAbstract = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.checkExt = function(k, v, spec) {
      return k + " " + v + " " + (Util.toStr(spec));
    };

    Schema.validObj = function(obj, model) {
      var key, valid, value;
      valid = '';
      for (key in obj) {
        value = obj[key];
        valid += Schema.validValue(key, value, model[key]);
      }
      return valid;
    };

    Schema.validValue = function(key, ov, spec) {
      var k, sv, valid;
      valid = '';
      if (spec == null) {
        return valid;
      }
      for (k in spec) {
        sv = spec[k];
        if (Schema.isKey(k, 'type')) {
          valid += Schema.validType(key, ov, sv);
        }
        if (Schema.isKey(k, 'spec')) {
          valid += Schema.validProp(key, ov, sv);
        }
        if (Schema.isKey(k, 'ref')) {
          valid += Schema.validRef(key, ov, sv);
        }
        if (Schema.isKey(k, 'enum')) {
          valid += Schema.validEnum(key, ov, sv);
        }
        if (Schema.isKey(k, 'opt')) {
          valid += Schema.validOpt(key, ov, sv);
        }
        if (Schema.isKey(k, 'minmax')) {
          valid += Schema.validMinMax(key, ov, sv);
        }
        if (Schema.isKey(k, 'format')) {
          valid += Schema.validFormat(key, ov, sv);
        }
        if (Schema.isKey(k, 'validator')) {
          valid += Schema.validValue(key, ov, sv);
        }
      }
      return valid;
    };

    Schema.validType = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validProp = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validRef = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validEnum = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validOpt = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validMinMax = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validFormat = function(key, ov, sv) {
      return key + " " + ov + " " + sv;
    };

    Schema.validValue = function(key, ov, sv) {
      var isValid;
      isValid = sv(ov);
      if (isValid) {
        return 'true';
      } else {
        return 'false';
      }
    };

    Schema.isKey = function(k, key) {
      return k === key || k === key.charAt(0);
    };

    function Schema() {}

    return Schema;

  })();

}).call(this);
