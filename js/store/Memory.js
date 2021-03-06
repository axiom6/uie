// Generated by CoffeeScript 1.10.0
(function() {
  var Memory, Store,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Store = require('js/store/Store');

  Memory = (function(superClass) {
    extend(Memory, superClass);

    module.exports = Memory;

    function Memory(stream, uri) {
      Memory.__super__.constructor.call(this, stream, uri, 'Memory');
      Store.databases[this.dbName] = this.tables;
      Util.databases[this.dbName] = this.tables;
    }

    Memory.prototype.add = function(t, id, object) {
      this.table(t)[id] = object;
      this.publish(t, id, 'add', object);
    };

    Memory.prototype.get = function(t, id) {
      var object;
      object = this.table(t)[id];
      if (object != null) {
        this.publish(t, id, 'get', object);
      } else {
        this.onerror(t, id, 'get', object, {
          msg: "Id " + id + " not found"
        });
      }
    };

    Memory.prototype.put = function(t, id, object) {
      this.table(t)[id] = object;
      this.publish(t, id, 'put', object);
    };

    Memory.prototype.del = function(t, id) {
      var object;
      object = this.table(t)[id];
      if (object != null) {
        delete this.table(t)[id];
        this.publish(t, id, 'del', object);
      } else {
        this.onerror(t, id, 'del', object, {
          msg: "Id " + id + " not found"
        });
      }
    };

    Memory.prototype.insert = function(t, objects) {
      var key, object, table;
      table = this.table(t);
      for (key in objects) {
        if (!hasProp.call(objects, key)) continue;
        object = objects[key];
        table[key] = object;
      }
      this.publish(t, 'none', 'insert', objects);
    };

    Memory.prototype.select = function(t, where) {
      var key, object, objects, table;
      objects = {};
      table = this.table(t);
      for (key in table) {
        if (!hasProp.call(table, key)) continue;
        object = table[key];
        if (where(object)) {
          objects[key] = object;
        }
      }
      this.publish(t, 'none', 'select', objects, {
        where: where.toString()
      });
    };

    Memory.prototype.update = function(t, objects) {
      var key, object, table;
      table = this.table(t);
      for (key in objects) {
        if (!hasProp.call(objects, key)) continue;
        object = objects[key];
        table[key] = object;
      }
      this.publish(t, id, 'update', objects);
    };

    Memory.prototype.remove = function(t, where) {
      var key, object, objects, table;
      if (where == null) {
        where = Store.where;
      }
      table = this.table(t);
      objects = {};
      for (key in table) {
        if (!hasProp.call(table, key)) continue;
        object = table[key];
        if (!(where(object))) {
          continue;
        }
        objects[key] = object;
        delete object[key];
      }
      this.publish(t, 'none', 'remove', objects, {
        where: where.toString()
      });
    };

    Memory.prototype.open = function(t, schema) {
      this.createTable(t);
      this.publish(t, 'none', 'open', {}, {
        schema: schema
      });
    };

    Memory.prototype.show = function(t) {
      var key, keys, ref, ref1, tables, val;
      if (Util.isStr(t)) {
        keys = [];
        ref = this.tables[t];
        for (key in ref) {
          if (!hasProp.call(ref, key)) continue;
          val = ref[key];
          keys.push(key);
        }
        this.publish(t, 'none', 'show', keys, {
          showing: 'keys'
        });
      } else {
        tables = [];
        ref1 = this.tables;
        for (key in ref1) {
          if (!hasProp.call(ref1, key)) continue;
          val = ref1[key];
          tables.push(key);
        }
        this.publish(t, 'none', 'show', tables, {
          showing: 'tables'
        });
      }
    };

    Memory.prototype.make = function(t, alters) {
      this.publish(t, 'none', 'make', {}, {
        alters: alters,
        msg: 'alter is a noop'
      });
    };

    Memory.prototype.drop = function(t) {
      var hasTable;
      hasTable = this.tables[t] != null;
      if (hasTable) {
        delete this.tables[t];
        this.publish(t, 'none', 'drop', {});
      } else {
        this.onerror(t, 'none', 'drop', {}, {
          msg: "Table " + t + " not found"
        });
      }
    };

    Memory.prototype.onChange = function(t, id) {
      if (id == null) {
        id = 'none';
      }
      this.onerror(t, id, 'onChange', {}, {
        msg: "onChange() not implemeted by Store.Memory"
      });
    };

    Memory.prototype.dbTableName = function(tableName) {
      return this.dbName + '/' + tableName;
    };

    Memory.prototype.importLocalStorage = function(tableNames) {
      var i, len, tableName;
      for (i = 0, len = tableNames.length; i < len; i++) {
        tableName = tableNames[i];
        this.tables[tableName] = JSON.parse(localStorage.getItem(this.dbTableName(tableName)));
      }
    };

    Memory.prototype.exportLocalStorage = function() {
      var dbTableName, ref, table, tableName;
      ref = this.tables;
      for (tableName in ref) {
        if (!hasProp.call(ref, tableName)) continue;
        table = ref[tableName];
        dbTableName = this.dbTableName(tableName);
        localStorage.removeItem(dbTableName);
        localStorage.setItem(dbTableName, JSON.stringify(table));
      }
    };

    Memory.prototype.importIndexDb = function(op) {
      var IDB, i, idb, len, onNext, ref, tableName;
      IDB = require('js/store/IndexedDB');
      idb = new IDB(this.stream, this.dbName);
      ref = idb.dbs.objectStoreNames;
      for (i = 0, len = ref.length; i < len; i++) {
        tableName = ref[i];
        onNext = (function(_this) {
          return function(result) {
            if (op === 'select') {
              return _this.tables[tableName] = result;
            }
          };
        })(this);
        this.subscribe(tableName, onNext);
        idb.traverse('select', tableName, {}, Store.where(), false);
      }
    };

    Memory.prototype.exportIndexedDb = function() {
      var IDB, dbVersion, idb, onIdxOpen;
      dbVersion = 1;
      IDB = require('js/store/IndexedDB');
      idb = new IDB(this.stream, this.dbName, dbVersion, this.tables);
      onIdxOpen = (function(_this) {
        return function(dbName) {
          var name, onNext, ref, results, table;
          idb.deleteDatabase(dbName);
          ref = _this.tables;
          results = [];
          for (name in ref) {
            if (!hasProp.call(ref, name)) continue;
            table = ref[name];
            onNext = function(result) {
              return Util.noop(dbName, result);
            };
            _this.subscribe(name, 'none', 'insert', onNext);
            results.push(idb.insert(name, table));
          }
          return results;
        };
      })(this);
      this.subscribe('IndexedDB', dbVersion.toString(), 'open', (function(_this) {
        return function(dbName) {
          return onIdxOpen(dbName);
        };
      })(this));
      idb.openDatabase();
    };

    Memory.prototype.tableNames = function() {
      var key, names, ref, table;
      names = [];
      ref = this.tables;
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        table = ref[key];
        names.push(key);
      }
      return names;
    };

    Memory.prototype.logRows = function(name, table) {
      var key, results, row;
      Util.log(name);
      results = [];
      for (key in table) {
        if (!hasProp.call(table, key)) continue;
        row = table[key];
        Util.log('  ', key);
        Util.log('  ', row);
        results.push(Util.log('  ', JSON.stringify(row)));
      }
      return results;
    };

    return Memory;

  })(Store);

}).call(this);
