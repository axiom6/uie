// Generated by CoffeeScript 1.10.0
(function() {
  var Persist,
    hasProp = {}.hasOwnProperty;

  Persist = (function() {
    module.exports = Persist;

    function Persist(stream) {
      this.stream = stream;
      this.Database = require('js/store/Database');
      this.subscribe();
    }

    Persist.prototype.subscribe = function() {
      return this.stream.subscribe('Test', (function(_this) {
        return function(topic) {
          return _this.onTest(topic);
        };
      })(this));
    };

    Persist.prototype.onTest = function(topic) {
      switch (topic) {
        case 'Rest':
          this.rest();
          break;
        case 'Memory':
          this.memFromLocal('muse');
          break;
        case 'IndexedDb':
          this.persistIDX('select', 'muse');
      }
    };

    Persist.prototype.rest = function() {
      var database, key, ref, results;
      ref = this.Database.Databases;
      results = [];
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        database = ref[key];
        results.push(this.persistRest(database));
      }
      return results;
    };

    Persist.prototype.persistRest = function(database) {
      var Rest, i, len, onRestComplete, rest, table, tables;
      Rest = Util.Import('store/Store.Rest');
      rest = new Rest(this.stream, database.uriLoc);
      if (database.key != null) {
        rest.key = database.key;
      }
      tables = database.tables;
      rest.remember();
      onRestComplete = function(objects) {
        var memory;
        Util.noop(objects);
        Util.log('Persist.onRestComplete()', rest.dbName);
        memory = rest.getMemory();
        memory.exportLocalStorage();
        memory.exportIndexedDb();
      };
      rest.uponTablesComplete(tables, 'select', 'complete', (function(_this) {
        return function(objects) {
          return onRestComplete(objects);
        };
      })(this));
      for (i = 0, len = tables.length; i < len; i++) {
        table = tables[i];
        rest.select(table + '.json');
      }
    };

    Persist.prototype.memFromLocal = function(database) {
      var Memory;
      Memory = Util.Import('store/Store.Memory');
      this.memory = new Memory(this.stream, database.uriLoc);
      this.memory.importLocalStorage(database.tables);
    };

    Persist.prototype.persistIDX = function(op, database) {
      var IndexedDB;
      IndexedDB = Util.Import('store/Store.IndexedDB');
      this.indexedDB = new IndexedDB(this.stream, database.id, 1, database.tables);
      switch (op) {
        case 'insert':
          this.indexedDB.deleteDatabase(database.id);
          this.indexedDB.subscribe('none', 'none', 'open', (function(_this) {
            return function(object) {
              return _this.insertIDB(object);
            };
          })(this));
          break;
        case 'select':
          this.indexedDB.subscribe('none', 'none', 'open', (function(_this) {
            return function(object) {
              return _this.selectIDB(object);
            };
          })(this));
      }
      this.indexedDB.openDatabase();
    };

    Persist.prototype.insertIDB = function(tables) {
      var i, len, name;
      this.indexedDB.remember();
      this.indexedDB.uponTablesComplete(tables, 'insert', 'complete', (function(_this) {
        return function(objects) {
          return _this.onCompleteIDBInsert(objects);
        };
      })(this));
      Util.log('insertIDB', tables);
      for (i = 0, len = tables.length; i < len; i++) {
        name = tables[i];
        this.indexedDB.insert(name, 'Muse');
      }
    };

    Persist.prototype.selectIDB = function(tables) {
      var i, len, table;
      this.indexedDB.remember();
      this.indexedDB.uponTablesComplete(tables, 'select', 'complete', (function(_this) {
        return function(objects) {
          return _this.onCompleteIDBSelect(objects);
        };
      })(this));
      for (i = 0, len = tables.length; i < len; i++) {
        table = tables[i];
        this.indexedDB.select(table);
      }
    };

    Persist.prototype.onCompleteIDBInsert = function(objects) {
      Util.noop(objects);
      return Util.log('Persist.onCompleteIDBInsert');
    };

    Persist.prototype.onCompleteIDBSelect = function(objects) {
      Util.noop(objects);
      return Util.log('Persist.onCompleteIDBSelect');
    };

    return Persist;

  })();

}).call(this);
