'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(function () {
  var Muse;

  Muse = function () {
    var Muse = function () {
      function Muse() {
        _classCallCheck(this, Muse);
      }

      _createClass(Muse, null, [{
        key: 'init',
        value: function init() {
          Util.ready(function () {
            var Action, Build, Navb, Stream, UI, action, args, build, navb, stream, subjects;
            Stream = require('js/util/Stream'); // require( 'coffee/util/Stream.coffee'    )
            Build = require('js/prac/Build');
            Action = require('target/Action');
            UI = require('js/ui/UI');
            Navb = require('js/ui/Navb');
            args = Muse.buildArgs();
            subjects = ['Select', 'Content', 'Connect', 'Test', 'Plane', 'About', 'Slide', 'Image', 'Cursor', 'Navigate', 'Settings', 'Submit', 'Toggle'];
            stream = new Stream(subjects);
            build = new Build(args); // Build App by processing the specs in the Build module based on 'buildName'
            action = new Action(stream);
            navb = new Navb(stream, build.NavbSpecs);
            action.ready();
            navb.ready();
            UI.createUI(args.plane, build, stream);
          });
          //build.ready()
          Muse.initCalled = true;
        }
      }, {
        key: 'buildArgs',
        value: function buildArgs() {
          var name, parse;
          parse = Util.parseURI(window.location); //Util.log( 'Muse.parse', parse )
          name = Util.isStr(parse.fragment) ? parse.fragment.substring(1) : '';
          switch (name) {
            case 'Info':
              return {
                name: 'Muse',
                plane: 'Information',
                op: ''
              };
            case 'Augm':
              return {
                name: 'Muse',
                plane: 'Augment',
                op: ''
              };
            case 'Data':
              return {
                name: 'Muse',
                plane: 'DataScience',
                op: ''
              };
            case 'Know':
              return {
                name: 'Muse',
                plane: 'Knowledge',
                op: ''
              };
            case 'Wise':
              return {
                name: 'Muse',
                plane: 'Wisdom',
                op: ''
              };
            case 'Hues':
              return {
                name: 'Muse',
                plane: 'Hues',
                op: ''
              };
            default:
              return {
                name: 'Muse',
                plane: 'Information',
                op: ''
              };
          }
        }
      }]);

      return Muse;
    }();

    ;

    module.exports = Muse;

    return Muse;
  }.call(this);

  //Palettes = require( 'js/d3d/Palettes' )
  //Palettes.hsvOut()
  Muse.init();

  // Load modules
  // Util.Load.load( Muse.init ) if Util.Load?
  /*
  @doElectron:( electron ) ->
    electron.ipcRenderer.on( 'init', ( event, message ) ->
      Util.log( 'Muse.init()', message ) )
    return
  
  @doScs:( stream ) ->
    Scs = Util.Import( 'Scs' )
    scs = new Scs( stream )
    scs.selectMaster()
    return
  
  @doF6s:( build, stream ) ->
    F6s      = Util.Import( 'F6s' )
    local    = new F6s( build, stream, F6s.Local    )
    innov    = new F6s( build, stream, F6s.Innov    )
    wellness = new F6s( build, stream, F6s.Wellness )
    local.doSelectsAll()
    innov.doSelectsAll()
    wellness.doSelectsAll()
    return
  */
}).call(undefined);
