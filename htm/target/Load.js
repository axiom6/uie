// Generated by CoffeeScript 1.10.0
(function() {
  var Load;

  Load = (function() {
    function Load() {}

    Load.root = "../../";

    Load.libsNode = {
      "paths": {
        "node": "node_modules/"
      },
      "node": ["jQuery:jquery/dist/jquery", "d3:d3/d3", "c3:c3/c3", "Rx:rx/dist/rx.all", "rxjs-jquery/rx.jquery", "_:lodash/lodash", "chroma:chroma-js/chroma"]
    };

    Load.libsCommonJS = {
      "paths": {
        "bower": "lib/bower_components/"
      },
      "bower": ["pivottable/dist/pivot", "pivottable/dist/c3_renderers", "pivottable/dist/export_renderers", "d3-plugins/sankey/sankey"]
    };

    Load.libsYepNope = {
      "paths": {
        "bower": "lib/bower_components/",
        "js": "js/",
        "muse": "htm/target/"
      },
      "bower": Load.libsCommonJS.bower,
      "js": ["util/Stream", "visual/Palettes", "util/Vis", "util/Type", "util/GeoJson", "build/Build", "ui/UI", "prac/Prac", "store/Store", "visual/Visual", "visual/Pres", "table/Table", "table/Pivot", "store/Database"],
      "muse": ["Action", "Persist"]
    };

    Load.libsMuse = Util.isCommonJS ? Load.libsCommonJS : Load.libsYepNope;

    Load.load = function(init) {
      Util.debug = false;
      Util.init(Load.root);
      Util.loadLibModules(Load.libsNode, false, Util.resetModuleExports);
      return Util.loadLibModules(Load.libsMuse, true, init);
    };

    Util.Load = Load;

    Load.verifyLoadModules = function(lib, modules, global) {
      var has, i, len, module, ok;
      if (global == null) {
        global = void 0;
      }
      ok = true;
      for (i = 0, len = modules.length; i < len; i++) {
        module = modules[i];
        has = global != null ? Util.hasGlobal(global, false) || Util.hasPlugin(global) : Util.hasModule(lib + module, false) != null;
        if (!has) {
          Util.error('Util.verifyLoadModules() Missing Module', lib + module + '.js', {
            global: global
          });
        }
        ok &= has;
      }
      return ok;
    };

    Load.loadInitLibs = function(root, paths, libs, callback, dbg) {
      var deps, dir, i, len, mod, path, ref, ref1;
      if (dbg == null) {
        dbg = false;
      }
      Util.root = root;
      Util.paths = paths;
      Util.libs = libs;
      if (!Util.hasGlobal('yepnope')) {
        return;
      }
      deps = [];
      ref = libs.paths;
      for (path in ref) {
        dir = ref[path];
        ref1 = libs[path];
        for (i = 0, len = ref1.length; i < len; i++) {
          mod = ref1[i];
          deps.push(root + dir + mod + '.js');
          if (dbg) {
            Util.log(root + dir + mod + '.js');
          }
        }
      }
      yepnope([
        {
          load: deps,
          complete: callback
        }
      ]);
    };

    Load.loadModules = function(path, dir, modules, callback) {
      var deps, i, len, module, modulesCallback;
      if (callback == null) {
        callback = null;
      }
      if (!Util.hasGlobal('yepnope')) {
        return;
      }
      modulesCallback = callback != null ? callback : (function(_this) {
        return function() {
          return Util.verifyLoadModules(dir, modules);
        };
      })(this);
      deps = [];
      for (i = 0, len = modules.length; i < len; i++) {
        module = modules[i];
        if (!Util.hasModule(dir + module, false)) {
          deps.push(Util.root + path + dir + module + '.js');
        } else {
          Util.warn('Util.loadModules() already loaded module', Util.root + dir + module);
        }
      }
      yepnope([
        {
          load: deps,
          complete: modulesCallback
        }
      ]);
    };

    Load.loadModule = function(path, dir, module, global) {
      var modulesCallback;
      if (global == null) {
        global = void 0;
      }
      if (!Util.hasGlobal('yepnope')) {
        return;
      }
      modulesCallback = typeof callback !== "undefined" && callback !== null ? callback : (function(_this) {
        return function() {
          return Util.verifyLoadModules(dir, [module], global);
        };
      })(this);
      if (((global != null) && !Util.hasGlobal(global, false)) || !Util.hasModule(dir + module, false)) {
        yepnope([
          {
            load: Util.root + path + dir + module + '.js',
            complete: modulesCallback
          }
        ]);
      } else {
        Util.warn('Util.loadModule() already loaded module', dir + module);
      }
    };

    return Load;

  })();

}).call(this);
