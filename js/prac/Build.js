// Generated by CoffeeScript 1.6.3
(function() {
  var Build,
    __hasProp = {}.hasOwnProperty;

  Build = (function() {
    module.exports = Build;

    Build.Muse = require('data/muse/Muse.json');

    Build.Info = require('data/muse/Info.json');

    Build.Augm = require('data/muse/Augm.json');

    Build.Data = require('data/muse/Data.json');

    Build.Know = require('data/muse/Know.json');

    Build.Wise = require('data/muse/Wise.json');

    Build.Hues = require('data/muse/Hues.json');

    function Build(args) {
      this.name = args.name;
      this.op = args.op;
      this.Core = this.core(this.name);
      this.None = this.Core.None;
      this.NoneStudy = this.Core.NoneStudy;
      this.Rows = this.toRows(this.Core.Rows);
      this.Columns = this.toColumns(this.Core.Columns);
      this.Planes = this.createPlanes(this.Core.Planes);
      this.Routes = this.createRoutes();
      this.NavbSpecs = Build.NavbSpecs;
      this.margin = this.Core.Margin;
      this.maxLevel = 5;
      this.fullUI = true;
      this.topicFontFactor = this.Core.topicFontFactor;
      Util.noop(this.op);
      Util.build = this;
      this.subscribe();
    }

    Build.prototype.isChild = function(key) {
      var a;
      a = key.charAt(0);
      return a === a.toUpperCase();
    };

    Build.prototype.combine = function() {
      var arg, key, obj, val, _i, _len;
      obj = {};
      for (_i = 0, _len = arguments.length; _i < _len; _i++) {
        arg = arguments[_i];
        for (key in arg) {
          if (!__hasProp.call(arg, key)) continue;
          val = arg[key];
          obj[key] = val;
        }
      }
      return obj;
    };

    Build.prototype.subscribe = function() {
      return window.onresize = this.resize;
    };

    Build.prototype.core = function(name) {
      switch (name) {
        case 'Muse':
          return Build.Muse;
        default:
          Util.error('Build.core() unknown app name', name);
          return Build.Muse;
      }
    };

    Build.prototype.logCore = function() {
      Util.log('------ Beg Core ------');
      Util.log("Planes: ", this.Core.Planes);
      Util.log("None", this.Core.None);
      Util.log("Practices: ", this.practices);
      Util.log("Studies: ", this.studies);
      return Util.log('------ End Core ------');
    };

    Build.prototype.adjacentPractice = function(practice, dir) {
      var col, key, plane, pln, prac, practices, row, _ref, _ref1;
      if ((practice == null) || (practice.name == null) || practice.name === 'None' || (practice.column == null)) {
        return this.None;
      }
      _ref = (function() {
        switch (dir) {
          case 'west':
            return [this.Columns[practice.column].west, practice.row, practice.plane];
          case 'east':
            return [this.Columns[practice.column].east, practice.row, practice.plane];
          case 'north':
            return [practice.column, this.Rows[practice.row].north, practice.plane];
          case 'south':
            return [practice.column, this.Rows[practice.row].south, practice.plane];
          case 'prev':
            return [practice.column, practice.row, this.Core.Planes[practice.plane].prev];
          case 'next':
            return [practice.column, practice.row, this.Core.Planes[practice.plane].next];
          default:
            return ["", "", ""];
        }
      }).call(this), col = _ref[0], row = _ref[1], pln = _ref[2];
      if ([col, row, pln] === ["", "", ""]) {
        return this.None;
      }
      _ref1 = this.Planes;
      for (key in _ref1) {
        plane = _ref1[key];
        practices = this.getPractices(key);
        for (key in practices) {
          if (!__hasProp.call(practices, key)) continue;
          prac = practices[key];
          if (prac.column === col && prac.row === row && prac.plane === pln) {
            return prac;
          }
        }
      }
      return this.None;
    };

    Build.prototype.adjacentStudies = function(practice, dir) {
      var adjPrac;
      adjPrac = this.adjacentPractice(practice, dir);
      if (adjPrac.name !== 'None' && (adjPrac.studies != null)) {
        return adjPrac.studies;
      } else {
        return {};
      }
    };

    Build.prototype.logAdjacentPractices = function() {
      var key, p, plane, practices, _ref;
      this.setAdjacents(this.None);
      _ref = this.Planes;
      for (key in _ref) {
        plane = _ref[key];
        practices = this.getPractices(key);
        for (key in practices) {
          if (!__hasProp.call(practices, key)) continue;
          p = practices[key];
          this.setAdjacents(p);
          Util.log({
            p: key,
            column: p.column,
            west: p.west.name,
            east: p.east.name,
            north: p.north.name,
            south: p.south.name,
            prev: p.prev.name,
            next: p.next.name
          });
        }
      }
    };

    Build.prototype.connectName = function(practice, dir) {
      var adjacent;
      adjacent = this.adjacentPractice(practice, dir);
      if (adjacent.name !== 'None') {
        return [practice.name, adjacent.name];
      } else {
        return ['None', 'None'];
      }
    };

    Build.prototype.setAdjacents = function(practice) {
      practice.west = this.adjacentPractice(practice, 'west');
      practice.east = this.adjacentPractice(practice, 'east');
      practice.north = this.adjacentPractice(practice, 'north');
      practice.south = this.adjacentPractice(practice, 'south');
      practice.prev = this.adjacentPractice(practice, 'prev');
      practice.next = this.adjacentPractice(practice, 'next');
    };

    Build.prototype.toRows = function(rows) {
      var key, row;
      for (key in rows) {
        row = rows[key];
        row['key'] = key;
        row['name'] = row.name != null ? row.name : key;
        if (row['quels'] != null) {
          row['cells'] = this.toCells(row['quels']);
        }
      }
      return rows;
    };

    Build.prototype.toColumns = function(cols) {
      var col, key;
      for (key in cols) {
        col = cols[key];
        col['key'] = key;
        col['name'] = col.name != null ? col.name : key;
        if (col['quels'] != null) {
          col['cells'] = this.toCells(col['quels']);
        }
      }
      return cols;
    };

    Build.prototype.toGroups = function(groups) {
      var group, key;
      for (key in groups) {
        group = groups[key];
        group['key'] = key;
        group['name'] = group.name != null ? group.name : key;
        if (group['quels'] != null) {
          group['cells'] = this.toCells(group['quels']);
        }
        group['border'] = group['border'] != null ? group['border'] : '0';
      }
      return groups;
    };

    Build.prototype.planeGroups = function(plane, practice) {
      var group, _i, _len, _ref;
      if (practice.groups == null) {
        return;
      }
      _ref = practice.groups;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        group = _ref[_i];
        if (plane.groups[group] == null) {
          plane.groups[group] = {};
        }
      }
    };

    Build.prototype.toCells = function(quels) {
      return [quels[0], quels[1] - quels[0] + 1, quels[2], quels[3] - quels[2] + 1];
    };

    Build.prototype.notContext = function(key) {
      return key !== '@context';
    };

    Build.prototype.createFilteredPractices = function(plane) {
      var filtered, ikey, item, pkey, practice, practices, skey, study, tkey, topic;
      practices = Build[plane.spec];
      filtered = {};
      for (pkey in practices) {
        practice = practices[pkey];
        if (!(this.isChild(pkey))) {
          continue;
        }
        practice['name'] = pkey;
        practice.studies = {};
        practice.children = [];
        filtered[pkey] = practice;
        for (skey in practice) {
          study = practice[skey];
          if (!(this.isChild(skey))) {
            continue;
          }
          study['name'] = skey;
          study.topics = {};
          study.children = [];
          practice.studies[skey] = study;
          practice.children.push(study);
          for (tkey in study) {
            topic = study[tkey];
            if (!(this.isChild(tkey))) {
              continue;
            }
            topic['name'] = tkey;
            topic.items = {};
            topic.children = [];
            study.topics[tkey] = topic;
            study.children.push(topic);
            for (ikey in topic) {
              item = topic[ikey];
              if (!(this.isChild(ikey))) {
                continue;
              }
              item['name'] = ikey;
              topic.items[ikey] = item;
            }
          }
        }
      }
      return filtered;
    };

    Build.prototype.createOverview = function(plane) {
      var overview, pkey, practice, practices;
      practices = Build[plane.id];
      overview = {};
      overview.name = plane.id;
      overview.cells = [1, plane.spec.nrow, 1, plane.spec.ncol];
      overview.hsv = [60, 90, 90];
      overview.icon = "fa-group";
      overview.children = [];
      for (pkey in practices) {
        practice = practices[pkey];
        if (this.isChild(pkey)) {
          overview.children.push(practice);
        }
      }
      return overview;
    };

    Build.prototype.createAsciiDoc = function(practices) {
      var adoc, ikey, item, name, pkey, practice, skey, study, tkey, topic;
      adoc = "";
      for (pkey in practices) {
        practice = practices[pkey];
        if (!(this.isChild(pkey))) {
          continue;
        }
        name = Util.toName1(pkey);
        adoc += "\n= [black]#" + name + "#\n";
        for (skey in practice) {
          study = practice[skey];
          if (!(this.isChild(skey))) {
            continue;
          }
          name = Util.toName1(skey);
          adoc += "\n== [black]#" + name + "#\n";
          for (tkey in study) {
            topic = study[tkey];
            if (!(this.isChild(tkey))) {
              continue;
            }
            name = Util.toName1(tkey);
            adoc += "  " + name + "\n";
            for (ikey in topic) {
              item = topic[ikey];
              if (!(this.isChild(ikey))) {
                continue;
              }
              name = Util.toName1(ikey);
              adoc += "    " + name + "\n";
            }
          }
        }
      }
      return Util.saveFile(adoc, 'Data.adoc', 'adoc');
    };

    Build.prototype.createJsonDoc = function(practices) {
      var doc, ikey, item, pkey, pracs, practice, skey, study, tkey, toProp, topic;
      doc = {};
      toProp = function(prop, name) {
        if ((prop != null) && prop !== 'None') {
          return prop;
        } else {
          return Util.toName(name);
        }
      };
      pracs = ['Describe', 'Distill', 'Predict', 'Advise'];
      for (pkey in practices) {
        practice = practices[pkey];
        if (!(this.isChild(pkey) && Util.inArray(pracs, pkey))) {
          continue;
        }
        doc[pkey] = {};
        for (skey in practice) {
          study = practice[skey];
          if (!(this.isChild(skey) && study.dir === 'ned' || study.dir === 'nwd')) {
            continue;
          }
          doc[pkey][skey] = {};
          for (tkey in study) {
            topic = study[tkey];
            if (!(this.isChild(tkey))) {
              continue;
            }
            doc[pkey][skey][tkey] = {
              title: toProp(topic.title, tkey),
              abstract: [""],
              purpose: [toProp(topic.purpose, "")]
            };
            for (ikey in topic) {
              item = topic[ikey];
              if (this.isChild(ikey)) {
                doc[pkey][skey][tkey][ikey] = {
                  title: toProp(item.title, ikey),
                  abstract: [""],
                  purpose: [toProp(topic.purpose, "")],
                  advantages: [""],
                  disadvantages: [""],
                  tools: {
                    spark: "",
                    scikit: "",
                    r: ""
                  },
                  links: {
                    adoc: "",
                    book: "",
                    sklearn: ""
                  }
                };
              }
            }
          }
        }
      }
      return Util.saveFile(JSON.stringify(doc), 'Desc.json', 'json');
    };

    Build.prototype.orphanItems = function(practice) {
      var study, topic, _i, _j, _len, _len1, _ref, _ref1;
      _ref = practice.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        study = _ref[_i];
        _ref1 = study.children;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          topic = _ref1[_j];
          topic.orphans = topic.children;
          delete topic.children;
        }
      }
      return practice;
    };

    Build.prototype.adoptItems = function(practice) {
      var study, topic, _i, _j, _len, _len1, _ref, _ref1;
      _ref = practice.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        study = _ref[_i];
        _ref1 = study.children;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          topic = _ref1[_j];
          if (topic.orphans != null) {
            topic.children = topic.orphans;
          }
        }
      }
      return practice;
    };

    Build.prototype.createPlanes = function(planes) {
      var key, plane;
      for (key in planes) {
        plane = planes[key];
        plane['name'] = key;
        plane['practices'] = this.createFilteredPractices(plane);
      }
      return planes;
    };

    Build.prototype.toArray = function(objects) {
      var array, key, obj;
      array = [];
      for (key in objects) {
        if (!__hasProp.call(objects, key)) continue;
        obj = objects[key];
        obj['id'] = key;
        array.push(obj);
      }
      return array;
    };

    Build.prototype.getPractices = function(plane) {
      if (this.Planes[plane] != null) {
        return this.Planes[plane].practices;
      } else {
        Util.error('Build.getPractices(plane) unknown plane', plane, 'returning Information practices');
        return this.Planes['Information'].practices;
      }
    };

    Build.prototype.isPractice = function(key) {
      return this.practices()[key] != null;
    };

    Build.prototype.getStudies = function(ikw, practice) {
      var practices;
      practices = this.getPractices(ikw);
      if (practices[practice] != null) {
        return practices[practice].studies;
      } else {
        Util.error('Build.getStudies(ikw,practice) unknown practice', practice, 'returning Collaborate studies');
        return practices['Collaborate'].studies;
      }
    };

    Build.prototype.getTopics = function(ikw, practice, study) {
      var studies;
      studies = this.getStudies(ikw, practice);
      if (studies[study] != null) {
        return studies[study].topics;
      } else {
        Util.error('Build.getTopics(ikw,practice,study) unknown study', study, 'returning Team studies');
        return studies['Team'].topics;
      }
    };

    Build.prototype.createRoutes = function() {
      var Routes, keyPractice, objPlane, objPractice, plane, _ref, _ref1;
      Routes = {};
      _ref = this.Planes;
      for (plane in _ref) {
        if (!__hasProp.call(_ref, plane)) continue;
        objPlane = _ref[plane];
        _ref1 = objPlane.practices;
        for (keyPractice in _ref1) {
          if (!__hasProp.call(_ref1, keyPractice)) continue;
          objPractice = _ref1[keyPractice];
          Routes['/' + keyPractice] = Util.noop('Route:', keyPractice);
        }
      }
      return Routes;
    };

    Build.prototype.queryPractices = function(filter) {
      var key, p, practice, _ref;
      p = {};
      _ref = this.practices;
      for (key in _ref) {
        if (!__hasProp.call(_ref, key)) continue;
        practice = _ref[key];
        if (this.notContext(key) && filter) {
          p[key] = practice;
        }
      }
      return p;
    };

    Build.prototype.getPractice = function(plane, row, column) {
      var key, practice, practices;
      practices = this.getPractices(plane);
      for (key in practices) {
        if (!__hasProp.call(practices, key)) continue;
        practice = practices[key];
        if (practice.column === column && practice.row === row) {
          return practice;
        }
      }
      Util.error('Build.getPractice() practice not found for', {
        plane: plane,
        column: column,
        row: row
      });
      return this.None;
    };

    Build.prototype.queryStudies = function(filter) {
      var key, s, study, _ref;
      s = {};
      _ref = this.studies;
      for (key in _ref) {
        if (!__hasProp.call(_ref, key)) continue;
        study = _ref[key];
        if (this.notContext(key) && filter) {
          s[key] = study;
        }
      }
      return s;
    };

    Build.prototype.logPlanes = function(Planes) {
      var keyPractice, keyStudy, objPlane, objPractice, objStudy, plane, _ref, _ref1;
      Util.log('----- Beg Build ------');
      for (plane in Planes) {
        if (!__hasProp.call(Planes, plane)) continue;
        objPlane = Planes[plane];
        Util.log("Plane: ", plane);
        _ref = objPlane.practices;
        for (keyPractice in _ref) {
          if (!__hasProp.call(_ref, keyPractice)) continue;
          objPractice = _ref[keyPractice];
          Util.log("  Practice: ", keyPractice);
          _ref1 = objPractice.studies;
          for (keyStudy in _ref1) {
            if (!__hasProp.call(_ref1, keyStudy)) continue;
            objStudy = _ref1[keyStudy];
            Util.log("    Study: ", keyStudy);
          }
        }
      }
      Util.log('----- End Build ------');
    };

    Build.SelectPlane = 'SelectPlane';

    Build.SelectAllPanes = 'SelectAllPanes';

    Build.SelectOverview = 'SelectOverview';

    Build.SelectGroup = 'SelectGroup';

    Build.SelectRow = 'SelectRow';

    Build.SelectCol = 'SelectCol';

    Build.SelectPractice = 'SelectPractice';

    Build.SelectStudy = 'SelectStudy';

    Build.SelectTopic = 'SelectTopic';

    Build.SelectItems = 'SelectItems';

    Build.content = function(content, source, intent, name) {
      if (intent == null) {
        intent = 'None';
      }
      if (name == null) {
        name = 'None';
      }
      if (intent === 'None') {
        intent = (function() {
          switch (content) {
            case 'Study':
              return Build.SelectStudy;
            case 'Topic':
              return Build.SelectTopic;
            case 'Items':
              return Build.SelectItems;
            default:
              return Build.SelectAllPanes;
          }
        })();
      }
      return {
        content: content,
        source: source,
        intent: intent,
        name: name
      };
    };

    Build.select = function(name, source, intent) {
      if (intent == null) {
        intent = Build.SelectAllPanes;
      }
      return {
        name: name,
        source: source,
        intent: intent
      };
    };

    Build.NavbSpecs = [
      {
        type: "NavBarLeft"
      }, {
        type: "Item",
        name: "Home",
        icon: "fa-home",
        topic: "muse.html",
        subject: "Navigate"
      }, {
        type: "Dropdown",
        name: "Planes",
        icon: "fa-sitemap",
        items: [
          {
            type: "Item",
            name: "Information",
            topic: "Information",
            subject: "Plane"
          }, {
            type: "Item",
            name: "Augment",
            topic: "Augment",
            subject: "Plane"
          }, {
            type: "Item",
            name: "DataScience",
            topic: "DataScience",
            subject: "Plane"
          }, {
            type: "Item",
            name: "Knowledge",
            topic: "Knowledge",
            subject: "Plane"
          }, {
            type: "Item",
            name: "Wisdom",
            topic: "Wisdom",
            subject: "Plane"
          }, {
            type: "Item",
            name: "Hues",
            topic: "Hues",
            subject: "Plane"
          }
        ]
      }, {
        type: "Dropdown",
        name: "Content",
        icon: "fa-leanpub",
        items: [
          {
            type: "Item",
            name: "Overview",
            topic: Build.select("Overview", 'Navb', Build.SelectOverview),
            subject: "Select"
          }, {
            type: "Item",
            name: "Center",
            topic: Build.content("Center", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Graphs",
            topic: Build.content("Svg", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Studies",
            topic: Build.content("Studies", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Tree",
            topic: Build.content("Tree", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Radial",
            topic: Build.content("Radial", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Inventory",
            topic: Build.content("Inven", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Connects",
            topic: Build.content("Connect", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Pivot",
            topic: Build.content("Pivot", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Plot",
            topic: Build.content("Plot", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "MathBox",
            topic: Build.content("MathBox", 'Navb'),
            subject: "Content"
          }, {
            type: "Item",
            name: "Slide",
            topic: Build.content("Slide", 'Navb'),
            subject: "Content"
          }
        ]
      }, {
        type: "Dropdown",
        name: "Tests",
        icon: "fa-stethoscope",
        items: [
          {
            type: "Item",
            name: "Populate",
            topic: "Populate",
            subject: "Test"
          }, {
            type: "Item",
            name: "Migrate",
            topic: "Migrate",
            subject: "Test"
          }, {
            type: "Item",
            name: "Persist",
            topic: "Persist",
            subject: "Test"
          }, {
            type: "Item",
            name: "Rest",
            topic: "Rest",
            subject: "Test"
          }, {
            type: "Item",
            name: "Memory",
            topic: "Memory",
            subject: "Test"
          }, {
            type: "Item",
            name: "IndexedDB",
            topic: "IndexedDB",
            subject: "Test"
          }
        ]
      }, {
        type: "Image",
        name: "Image",
        icon: "fa-picture-o",
        topic: 'Image',
        subject: "Image"
      }, {
        type: "NavBarEnd"
      }, {
        type: "NavBarRight"
      }, {
        type: "Search",
        name: "Search",
        icon: "fa-search",
        size: "10",
        topic: 'Search',
        subject: "Submit"
      }, {
        type: "Contact",
        name: "Contact",
        icon: "fa-twitter",
        topic: "http://twitter.com/TheTomFlaherty",
        subject: "Navigate"
      }, {
        type: "Dropdown",
        name: "Settings",
        icon: "fa-cog",
        items: [
          {
            type: "Item",
            name: "Preferences",
            topic: "Preferences",
            subject: "Settings"
          }, {
            type: "Item",
            name: "Connection",
            topic: "Connection",
            subject: "Settings"
          }, {
            type: "Item",
            name: "Privacy",
            topic: "Privacy",
            subject: "Settings"
          }
        ]
      }, {
        type: "SignOn",
        name: "SignOn",
        icon: "fa-sign-in",
        size: "10",
        topic: 'SignOn',
        subject: "Submit"
      }, {
        type: "NavBarEnd"
      }
    ];

    /*
    { type:"FileInput", name:"FileInput", icon:"fa-file-text-o", size:"10", topic:'FileInput', subject:"Submit" }
    { type:"Dropdown",  name:"About", icon:"fa-book", items: [
      { type:"Item",    name:"DataScience", topic:"DataScience", subject:"About" }
      { type:"Item",    name:"Machine",     topic:"Machine",     subject:"About" }
      { type:"Item",    name:"Information", topic:"Information", subject:"About" }
      { type:"Item",    name:"Knowledge",   topic:"Knowledge",   subject:"About" }
      { type:"Item",    name:"Wisdom",      topic:"Wisdom",      subject:"About" } ] }
    */


    return Build;

  })();

}).call(this);
