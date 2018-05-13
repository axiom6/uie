System.config
  baseURL: "../../"
  defaultJSExtensions: true
  transpiler: "typescript"
  typescriptOptions: {
    "tsconfig": "lib/jspm_packages/tsconfig.json" }

  paths:
    "node:*":   "node_modules/*"
    "bower:*":  "lib/bower_components/*"
    "github:*": "lib/jspm_packages/github/*"
    "npm:*":    "lib/jspm_packages/npm/*"
    "app/*":    "js/*"

  packages:
    "app":
      "main": "htm/target/Muse"
      "format": "amd"
      "defaultExtension": "js"

  map:
    "jquery":        "node:jquery/dist/jquery"
    "jQuery":        "node:jquery/dist/jquery"
    "jquery-ui":     "node:jquery-ui/jquery-ui"
    "d3":            "node:d3/d3"
    "c3":            "node:c3/c3"
    "rx":            "node:rx/dist/rx.all"
    "rxjs-jquery":   "node:rxjs-jquery/rx.jquery"
    "mathbox":       "node:mathbox/build/mathbox-bundle"
    "lodash":        "node:lodash/lodash"
    "chroma-js":     "node:chroma-js/chroma"
    "pouchdb":       "node:pouchdb/dist/pouchdb"
    "pivottable":    "bower:pivottable/dist/pivot"
    "c3Renderers":   "bower:pivottable/dist/c3_renderers"
    "exRenderers":   "bower:pivottable/dist/export_renderers"
    "d3Sankey":      "bower:d3-plugins/sankey/sankey"
    "ts":            "github:frankwallis/plugin-typescript@4.0.16"
    "typescript":    "npm:typescript@1.8.10"
    "bespoke":       "node:bespoke/dist/bespoke"
    "bespoke-keys":  "node:bespoke-keys/dist/bespoke-keys"
    "github:frankwallis/plugin-typescript@4.0.16": { "typescript": "npm:typescript@1.8.10" }
    "github:jspm/nodelibs-os@0.1.0":               { "os-browserify": "npm:os-browserify@0.1.2" }
    "npm:os-browserify@0.1.2": { "os": "github:jspm/nodelibs-os@0.1.0" }
    "npm:typescript@1.8.10":   { "os": "github:jspm/nodelibs-os@0.1.0" }
    "npm:core-js@1.2.7":
      "fs": "github:jspm/nodelibs-fs@0.1.2",
      "path": "github:jspm/nodelibs-path@0.1.0",
      "process": "github:jspm/nodelibs-process@0.1.2",
      "systemjs-json": "github:systemjs/plugin-json@0.1.2"

