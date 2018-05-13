
Build = require( "js/build/Build" )

class Spark

  Build.Spark    = Spark
  module.exports = Util.Export( Spark, "build/Spark" )

  @ir:( icon, rotate ) -> "fa-#{icon} fa-rotate-#{rotate}"

  # cells[j,m,i,n] and telss[j,m,i,n] reference a 6x10 grid
  @ncol              = 36
  @nrow              = 36
  @Margin            = { width:1, height:1, west:5, north:5, east:2, south:2 }
  @MarginDataScience = { width:1, height:1, west:5, north:5, east:2, south:2 }

  @Planes = {
    DataScience: { prev:'', next:'' } }

  @Rows = {
    Learn:     { id:"Learn", north:"",      south:"Do",    icon:"fa-book",        css:"ikw-row", quels:[1,36, 1,12], fill:"LDT", perspectives:[ "Context",    "Concept" ]               }
    Reveal:    { id:"Do",    north:"Learn", south:"Share", icon:"fa-bar-chart-o", css:"ikw-row", quels:[1,36,13,24], fill:"PWG", perspectives:[ "Architect",  "Engineer", "Construct" ] }
    Share:     { id:"Share", north:"Do",    south:"",      icon:"fa-share-alt",   css:"ikw-row", quels:[1,36,25,36], fill:"PWG", perspectives:[ "Transition", "Adminstrate" ]           } }

  @Columns = {
    Embrace:   { id:"Embrace",   west:"",         east:"Innovate",  icon:"fa-link",  css:"ikw-col", quels:[ 1,12,1,36], fill:"PWG", fab:"Feature",   plan:"Tactics",  dimensions:["Behavior"] }
    Innovate:  { id:"Innovate",  west:"Embrace",  east:"Encourage", icon:"fa-bolt",  css:"ikw-col", quels:[13,24,1,36], fill:"PWG", fab:"Advantage", plan:"Execute",  dimensions:["People","Service","Data","Network"] }
    Encourage: { id:"Encourage", west:"Innovate", east:"",          icon:"fa-music", css:"ikw-col", quels:[25,36,1,36], fill:"PWG", fab:"Benefit",   plan:"Strategy", dimensions:["Motivation"] } }

  @Groups = {
    Acquire:     { column:"Embrace",   row:"Learn",  plane:"DataScience", icon:"fa-flask",            pc:0.90, css:"ikw-group", quels:[ 1,12, 1,12], fill:"LDR", pos:"N"  }
    Explore:     { column:"Innovate",  row:"Learn",  plane:"DataScience", icon:"fa-compass",          pc:0.90, css:"ikw-group", quels:[13,24, 1,12], fill:"LDM", pos:"N"  }
    Classify:    { column:"Encourage", row:"Learn",  plane:"DataScience", icon:"fa-diamond",          pc:0.90, css:"ikw-group", quels:[25,36, 1,12], fill:"LDB", pos:"N"  }

    Process:     { column:"Embrace",   row:"Reveal", plane:"DataScience", icon:"fa-spinner",          pc:0.90, css:"ikw-group", quels:[ 1,12,13,24], fill:"MWR", pos:"W"  }
    Spark:       { column:"Innovate",  row:"Reveal", plane:"DataScience", icon:"fa-bell",             pc:0.90, css:"ikw-group", quels:[13,24,13,24], fill:"MWM", pos:"E"  }
    Quantify:    { column:"Encourage", row:"Reveal", plane:"DataScience", icon:"fa-bar-chart-o",      pc:0.90, css:"ikw-group", quels:[25,36,13,24], fill:"MWB", pos:"C"  }

    Upgrade:     { column:"Embrace",   row:"Reveal", plane:"DataScience", icon:"fa-refresh",          pc:0.90, css:"ikw-group", quels:[ 1,12,25,36], fill:"DDR", pos:"C"  }
    Cluster:     { column:"Innovate",  row:"Reveal", plane:"DataScience", icon:"fa-cloud",            pc:0.90, css:"ikw-group", quels:[13,24,25,36], fill:"DDM", pos:"W"  }
    Decision:    { column:"Encourage", row:"Reveal", plane:"DataScience", icon:"fa-code-fork",        pc:0.90, css:"ikw-group", quels:[25,36,25,36], fill:"DDB", pos:"E"  } }

  @Practices = {
    Acquire:     { id:"Acquire",  column:"Embrace",   row:"Learn",  plane:"DataScience", icon:"fa-flask",            pc:0.90, css:"ikw-pane", quels:[ 5, 8, 5, 8], fill:"PWY", pos:"N" }
    Explore:     { id:"Explore",  column:"Innovate",  row:"Learn",  plane:"DataScience", icon:"fa-compass",          pc:0.90, css:"ikw-pane", quels:[17,20, 5, 8], fill:"PWY", pos:"N" }
    Classify:    { id:"Classify", column:"Encourage", row:"Learn",  plane:"DataScience", icon:"fa-diamond",          pc:0.90, css:"ikw-pane", quels:[29,32, 5, 8], fill:"PWY", pos:"N" }
    Process:     { id:"Process",  column:"Embrace",   row:"Reveal", plane:"DataScience", icon:"fa-spinner",          pc:0.90, css:"ikw-pane", quels:[ 5, 8,17,20], fill:"LDT", pos:"W" }
    Spark:       { id:"Spark",    column:"Innovate",  row:"Reveal", plane:"DataScience", icon:"fa-star-o",           pc:0.90, css:"ikw-pane", quels:[17,20,17,20], fill:"MWM", pos:"E" }
    Quantify:    { id:"Quantify", column:"Encourage", row:"Reveal", plane:"DataScience", icon:"fa-trophy",           pc:0.90, css:"ikw-pane", quels:[29,32,17,20], fill:"PWY", pos:"C" }
    Upgrade:     { id:"Upgrade",  column:"Embrace",   row:"Share",  plane:"DataScience", icon:"fa-refresh",          pc:0.90, css:"ikw-pane", quels:[ 5, 8,29,32], fill:"PWY", pos:"C" }
    Cluster:     { id:"Cluster",  column:"Innovate",  row:"Share",  plane:"DataScience", icon:"fa-cloud",            pc:0.90, css:"ikw-pane", quels:[17,20,29,32], fill:"LDT", pos:"W" }
    Decision:    { id:"Decision", column:"Encourage", row:"Share",  plane:"DataScience", icon:"fa-code-fork",        pc:0.90, css:"ikw-pane", quels:[29,32,29,32], fill:"MWM", pos:"E" } }

  @Studies = {

    Data_Mining: { practice:"Acquire",   icon:"fa-user-secret",     uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 1, 4, 5, 8], fill:"PWY", pos:"N"  }
    Refine:      { practice:"Acquire",   icon:"fa-forward",         uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8, 1, 4], fill:"PWY", pos:"N"  }
    Schema:      { practice:"Acquire",   icon:"fa-sitemap",         uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8, 9,12], fill:"LDT", pos:"NW" }
    Store:       { practice:"Acquire",   icon:"fa-archive",         uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 9,12, 5, 8], fill:"PWY", pos:"N"  }

    Visualize:   { practice:"Explore",   icon:"fa-bar-chart",       uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[13,16, 5, 8], fill:"LDT", pos:"NW" }
    Search:      { practice:"Explore",   icon:"fa-search",          uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20, 1, 4], fill:"PWY", pos:"N"  }
    BI:          { practice:"Explore",   icon:"fa-dropbox",         uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[21,24, 5, 8], fill:"PWY", pos:"N"  }
    Solutions:   { practice:"Explore",   icon:"fa-globe",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20, 9,12], fill:"PWY", pos:"N"  }

    Identify:    { practice:"Classify",  icon:@ir('sitemap',270),   uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[25,28, 5, 8], fill:"LDT", pos:"NW" }
    Sample:      { practice:"Classify",  icon:"fa-filter",          uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32, 1, 4], fill:"PWY", pos:"N"  }
    Metadata:    { practice:"Classify",  icon:"fa-list-ol",         uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[33,36, 5, 8], fill:"PWY", pos:"N"  }
    Hypothesize: { practice:"Classify",  icon:"fa-graduation-cap",  uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32, 9,12], fill:"PWY", pos:"N"  }

    Plan:        { practice:"Process",    icon:"fa-users",          uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8,13,16], fill:"LDT", pos:"W" }
    Messaging:   { practice:"Process",    icon:@ir('share-alt',180),uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W" }
    Tasks:       { practice:"Process",    icon:"fa-tasks",          uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 9,12,17,20], fill:"LDT", pos:"W" }
    Grid_Gain:   { practice:"Process",    icon:"fa-cube",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8,21,24], fill:"LDT", pos:"W" }

    Notebook:    { practice:"Spark",   icon:"fa-leanpub",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[13,16,17,20], fill:"MWM", pos:"E" }
    Streams:     { practice:"Spark",   icon:"fa-sliders",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20,13,16], fill:"MWM", pos:"E" }
    RDD:         { practice:"Spark",   icon:@ir('database',90),     uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[21,24,17,20], fill:"MWM", pos:"E" }
    Akka:        { practice:"Spark",   icon:"fa-area-chart",        uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20,21,24], fill:"MWM", pos:"E" }

    Pattern:     { practice:"Quantify",  icon:"fa-signal",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[25,28,17,20], fill:"PWY", pos:"C" }
    Confirm:     { practice:"Quantify",  icon:"fa-thumbs-up",        uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32,13,16], fill:"PWY", pos:"C" }
    Publish:     { practice:"Quantify",  icon:"fa-newspaper-o",      uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32,21,24], fill:"PWY", pos:"C" }
    Review:      { practice:"Quantify",  icon:"fa-eye",              uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[33,36,17,20], fill:"PWY", pos:"C" }

    Test:        { practice:"Upgrade",   icon:"fa-stethoscope",      uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 1, 4,29,32], fill:"PWY", pos:"C" }
    Config:      { practice:"Upgrade",   icon:"fa-cogs",             uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8,25,28], fill:"PWY", pos:"C" }
    Transition:  { practice:"Upgrade",   icon:"fa-random",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 9,12,29,32], fill:"PWY", pos:"C" }
    Anticipate:  { practice:"Upgrade",   icon:"fa-soundcloud",       uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[ 5, 8,33,36], fill:"PWY", pos:"C" }

    Support:     { practice:"Cluster",  icon:"fa-life-ring",          uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[13,16,29,32], fill:"LDT", pos:"W" }
    Servers:     { practice:"Cluster",  icon:"fa-server",             uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20,25,28], fill:"LDT", pos:"W" }
    Warehouse:   { practice:"Cluster",  icon:"fa-cubes",              uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[21,24,29,32], fill:"LDT", pos:"W" }
    Security:    { practice:"Cluster",  icon:"fa-lock",               uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[17,20,33,36], fill:"LDT", pos:"W" }

    Query:       { practice:"Decision", icon:"fa-question-circle",  uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[25,28,29,32], fill:"MWM", pos:"E" }
    Resource:    { practice:"Decision", icon:"fa-money",            uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32,25,28], fill:"MWM", pos:"E" }
    Comply:      { practice:"Decision", icon:"fa-legal",            uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[33,36,29,32], fill:"MWM", pos:"E" }
    Maturity:    { practice:"Decision", icon:"fa-anchor",           uc:"\uf0c1",  pc:0.75, css:"ikw-pane", quels:[29,32,33,36], fill:"MWM", pos:"E" } }


  @Topics  = {

    Weka:           { study:"Data_Mining",    icon:"fa-circle",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }

    Elastic_Search: { study:"Search",         icon:"fa-search",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }
    Lucene:         { study:"Search",         icon:"fa-search",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }
    Solr:           { study:"Search",         icon:"fa-search",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }

    D3:         { study:"Visualize",             icon:"D3",  uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }
    Pentaho:    { study:"BI", icon:"fa-circle",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }
    Constraint: { study:"Solutions",        icon:"fa-square-o",  uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }

    Mondarian: { study:"Classify",            icon:"fa-cube",      uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }

    Kafka:     { study:"Messaging",           icon:"fa-circle", uc:"\uf0c1",  pc:0.33, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W"  }
    Storm:     { study:"Messaging",           icon:"fa-circle", uc:"\uf0c1",  pc:0.33, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W"  }

    Dependency:{ study:"Tasks",            icon:@ir('share-alt',90), uc:"\uf0c1",  pc:0.33, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W"  }
    Console:   { study:"Tasks",               icon:"fa-desktop",     uc:"\uf0c1",  pc:0.33, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W"  }
    Monitor:   { study:"Tasks",               icon:"fa-heartbeat",   uc:"\uf0c1",  pc:0.33, css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT", pos:"W"  }

    Machine_Learning: { study:"Streams", icon:"fa-connectdevelop",    uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[17,20,13,16], fill:"PWY", pos:"N"  }
    Numerical:        { study:"Streams", icon:"fa-calculator",        uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[13,16,13,16], fill:"PWY", pos:"N"  }

    GraphX:       { study:"RDD",       icon:"fa-joomla",           uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[21,24,13,16], fill:"MWM", pos:"E"  }
    IndexedRDD:   { study:"RDD",       icon:"fa-toggle-right",     uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[21,24,21,24], fill:"MWM", pos:"E"  }
    DataFrames:   { study:"RDD",       icon:"fa-th",               uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[21,24,21,24], fill:"MWM", pos:"E"  }
    Tachyon:      { study:"RDD",       icon:@ir('cubes',180),      uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E" }
    #Databases:   { study:"RDD",       icon:"fa-database",         uc:"\uf0c1",  pc:0.33, css:"ikw-study", quels:[21,24,25,28], fill:"MWM", pos:"E"  }

    Zeppelin:     { study:"Notebook",   icon:"fa-circle",       uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,17,20], fill:"MWM", pos:"E"  }
    SparkR:       { study:"Notebook",   icon:"R",              uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,17,20], fill:"MWM", pos:"E"  }
    IPython:      { study:"Notebook",   icon :"IP[y]",             uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }

    Rest:         { study:"Akka",        icon:"fa-circle",      uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    Play:         { study:"Akka",        icon:"fa-chevron-right",  uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    Cluster:      { study:"Akka",        icon:"fa-server",         uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    #Actors:      { study:"Akka",        icon:"fa-users",          uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    #Slick:       { study:"Akka",        icon:"fa-bars",           uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }

    Descriptive:  { study:"Pattern",  icon:"fa-table",            uc:"\uf0c1",  pc:0.66, css:"ikw-study", quels:[25,28,13,16], fill:"PWY", pos:"C"  }
    Diagnostic:   { study:"Pattern",  icon:"fa-user-md",          uc:"\uf0c1",  pc:0.66, css:"ikw-study", quels:[25,28,17,20], fill:"PWY", pos:"C"  }
    Predictive:   { study:"Pattern",  icon:"fa-line-chart",       uc:"\uf0c1",  pc:0.66, css:"ikw-study", quels:[25,28,25,28], fill:"PWY", pos:"C"  }
    Prescriptive: { study:"Pattern",  icon:"fa-paint-brush",      uc:"\uf0c1",  pc:0.66, css:"ikw-study", quels:[29,32,21,24], fill:"PWY", pos:"C"  }

    Mesos:        { study:"Cluster",        icon:"fa-server",     uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    Myriad:       { study:"Cluster",        icon:"fa-server",     uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
    Yarn:         { study:"Cluster",        icon:"fa-server",     uc:"\uf0c1",   pc:0.33, css:"ikw-study", quels:[13,16,21,24], fill:"MWM", pos:"E"  }
  }

  @Talks = {
    Muse:           { url:"htn/ikw/Muse.html"                  }
    Info:           { url:"htn/ikw/Info.html"                  }
    Know:           { url:"htn/ikw/Know.html"                  }
    Wise:           { url:"htn/ikw/Wise.html"                  }
    Spark:          { url:"htn/spark/"                         }
    SparkStreaming: { url:"htm/spark/SparkStreaming.html"      }
    ScalaMathDSL:   { url:"htm/scala/ScalaMathDSL.html"        }
    RxJS:           { url:"htm/rxjs/ScalaMathDSL.html"         }
    HtmlCoffee:     { url:"htm/rxjs/HtmlCoffee.html"           }
    leaflet:        { url:"htm/leaflet/leaflet.html"           }
    RxDataScience:  { url:"htm/datascience/RxDataScience.html" }
    RxGridGain:     { url:"htm/datascience/RxGridGain.html"    }
    RxManifesto:    { url:"htm/datascience/RxManifesto.html"   }
    RxQuan:         { url:"htm/datascience/RxQuan.html"        } }

  @Algorithms = [
    { name:"Machine Learning", children:[
      { name:"Regression" }
      { name:"Logit" }
      { name:"CART" }
      { name:"Ensenble", children:[
        { name:"Random Forest" } ] }
      { name:"Clustering" }
      { name:"KNN" }
      { name:"Genetic Algorithms"  }
      { name:"Simulated Annealing" } ] }
    {  name:"Cute Math", children:[
      { name:"Colaborative Filtering" }
      { name:"SVM", children:[
        { name:"Kernels" } ] }
      { name:"SVD" } ] }
    { name:"Artificial Intelligence", children:[
      { name:"MNet" }
      { name:"Boltzman Machine" }
      { name:"Feature Learning" } ] }
    { name:"Other", children:[
      { name:"Monte Carlo Methods" }
      { name:"Principal Component" }
      { name:"Kalman Filter" }
      { name:"Fuzzy Logic", children:[
        { name:"Evolutionary" } ] } ] } ]

  @Classifiers = [
    { name:'Statistical', children:[
      { name:"Regression" }
      { name:"Logistic Regression" }
      { name:"Boosting" }
      { name:"SVM" }
      { name:"Naive Bayes" }
      { name:"Bayesian Networks" } ] }
    { name:'Structural', children: [
      { name:"RuleBased", children: [
        { name:"Production Rules" }
        { name:"Decision Tree" } ] }
      { name:"Distance Based", children:[
        { name:"Functional", children:[
          { name:"Linear" }
          { name:"Spectral Wavelet" } ] }
        { name:"Nearest Neighbor", children:[
          { name:"kNN" }
          { name:"Learn Vector Sparktication" } ] } ] }
      { name:"Ensemble", children:[
        { name:"Random Forests" } ] }
      { name:"Neural Networks", children:[
        { name:"Multi Layer Perception" } ] } ] } ]

  @Conveys = []


