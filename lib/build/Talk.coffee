Build = require( "js/build/Build" )

class Talk

  Build.Talk =  Talk
  module.exports = Util.Export(  Talk,  "build/Talk"   )
  B = Build

  @Talks = {
    Information: { index:0, abstract:"The Muse Information Plane", slides: [
      { subject:"Plane",   topic:"Information",  content:"Svg"   }
      { subject:"Content", topic:"AllPanes",     content:"Topic" }
      { subject:"Select",  topic:"Collaborate",  content:"Svg"   }
      { subject:"Select",  topic:"Concept",      content:"Svg"   }
      { subject:"Select",  topic:"Discover",     content:"Svg"   }
      { subject:"Select",  topic:"Adapt",        content:"Svg"   }
      { subject:"Select",  topic:"Technology",   content:"Svg"   }
      { subject:"Select",  topic:"Benefit",      content:"Svg"   }
      { subject:"Select",  topic:"Change",       content:"Svg"   }
      { subject:"Select",  topic:"Deliver",      content:"Svg"   }
      { subject:"Select",  topic:"Govern",       content:"Svg"   }
    ] }
    DataScience: { index:0, abstract:"What Is Data Science", slides: [
      { subject:"Plane",   topic:"DataScience",    content:"Topic" }
      { subject:"Select",  topic:"GroupPractices", content:"Topic" }
      { subject:"Plane",   topic:"DataScience",    content:"Topic" }
      { subject:"Select",  topic:"Acquire",        content:"Topic" }
      { subject:"Select",  topic:"Theorize",        content:"Topic" }
      { subject:"Select",  topic:"Distill",      content:"Topic" }
      { subject:"Select",  topic:"Conduct",      content:"Topic" }
      { subject:"Select",  topic:"Machine",          content:"Topic" }
      { subject:"Select",  topic:"Model",          content:"Topic" }
      { subject:"Select",  topic:"Prove",        content:"Topic" }
      { subject:"Select",  topic:"Explain",        content:"Topic" }
      { subject:"Select",  topic:"Decision",       content:"Topic" }
    ] }
    Machine: { index:0, abstract:"What Is Machine Learning", slides: [
      { subject:"Plane",   topic:"DataScience",    content:"Topic" }
      { subject:"Select",  topic:"GroupPractices", content:"Topic" }
      { subject:"Plane",   topic:"DataScience",    content:"Topic" }
      { subject:"Select",  topic:"Machine",        content:"Topic" }
      { subject:"Select",  topic:"Train",          content:"Topic" }
      { subject:"Select",  topic:"Numerical",      content:"Topic" }
      { subject:"Select",  topic:"Store",          content:"Topic" }
      { subject:"Select",  topic:"Search",         content:"Topic" }
    ] }
  }

  @Slides = {
    SymLink:        { url:"../../lib/talks/"                   }
    Muse:           { url:"htn/ikw/"                           }
    Info:           { url:"htn/ikw/"                           }
    Know:           { url:"htn/ikw/"                           }
    Wise:           { url:"htn/ikw/"                           }
    Spark:          { url:"htm/spark/Spark.html"               }
    SparkStreaming: { url:"htm/spark/SparkStreaming.html"      }
    ScalaMathDSL:   { url:"htm/scala/ScalaMathDSL.html"        }
    RxJS:           { url:"htm/rxjs/ScalaMathDSL.html"         }
    HtmlCoffee:     { url:"htm/rxjs/HtmlCoffee.html"           }
    leaflet:        { url:"htm/leaflet/leaflet.html"           }
    RxDataScience:  { url:"htm/datascience/RxDataScience.html" }
    RxGridGain:     { url:"htm/datascience/RxGridGain.html"    }
    RxManifesto:    { url:"htm/datascience/RxManifesto.html"   }
    RxQuan:         { url:"htm/datascience/RxQuan.html"        } }

  @References = {
    MUSE:  { name:"Muse",    title:"Muse",                     url:'http://axiom6.com/muse/' } # AxiomMuse in Schema
    BMG:   { name:"BMG",     title:"Business Model Generator", url:'http://www.businessmodelgeneration.com' }
    ZACH:  { name:"Zachman", title:"Zachman Framework",        url:'http://www.zachman.com' } }

  Concerts = {
    Internal:   { hsv:[210,70,70], dir:"north", dimension:"Behavior",   zachman:"Time",       muse:"Embrace"   }
    Activity:   { hsv:[210,90,90], dir:"west",  dimension:"Behavior",   zachman:"Time",       muse:"Embrace"   }
    External:   { hsv:[210,80,80], dir:"south", dimension:"Behavior",   zachman:"Time",       muse:"Embrace"   }
    Refine:     { hsv:[220,90,70], dir:"east",  dimension:"Behavior",   zachman:"Time",       muse:"Embrace"   }
    People:     { hsv:[180,60,90], dir:"west",  dimension:"People",     zachman:"People",     muse:"Innovate"  }
    Service:    { hsv:[ 90,60,90], dir:"north", dimension:"Service",    zachman:"Function",   muse:"Innovate"  }
    Data:       { hsv:[ 45,60,90], dir:"east",  dimension:"Data",       zachman:"Data",       muse:"Innovate"  }
    Network:    { hsv:[ 60,60,90], dir:"south", dimension:"Network",    zachman:"Network",    muse:"Innovate"  }
    Vision:     { hsv:[255,70,70], dir:"north", dimension:"Motivation", zachman:"Motivation", muse:"Encourage" }
    Method:     { hsv:[255,70,90], dir:"east",  dimension:"Motivation", zachman:"Motivation", muse:"Encourage" }
    Mission:    { hsv:[255,70,80], dir:"south", dimension:"Motivation", zachman:"Motivation", muse:"Encourage" }
    Result:     { hsv:[265,70,90], dir:"west",  dimension:"Motivation", zachman:"Motivation", muse:"Encourage" } }

  @Dimensions = {
    Behavior:   { inquisitive:"When",  zachman:"Time",       muse:"Embrace"   }
    People:     { inquisitive:"Who",   zachman:"People",     muse:"Innovate"  }
    Service:    { inquisitive:"How",   zachman:"Function",   muse:"Innovate"  }
    Data:       { inquisitive:"What",  zachman:"Data",       muse:"Innovate"  }
    Network:    { inquisitive:"Where", zachman:"Network",    muse:"Innovate"  }
    Motivation: { inquisitive:"Why",   zachman:"Motivation", muse:"Encourage" } }

  @Perspectivess = {
    Context:     { zachman:"Planner",    muse:"Learn" }
    Concept:     { zachman:"Owner",      muse:"Learn" }
    Architect:   { zachman:"System",     muse:"Do"    }
    Engineer:    { zachman:"Designer",   muse:"Do"    }
    Construct:   { zachman:"Contractor", muse:"Do"    }
    Transition:  { zachman:"none",       muse:"Share" }
    Adminstrate: { zachman:"Function",   muse:"Share" } }

  @PlanesExpanded  = {
    Information: { icon:"fa-link",  matter:"Solid",   water:"Ice",       cynefin:"Simple"      }
    Knowledge:   { icon:"fa-link",  matter:"Liquid",  water:"Water",     cynefin:"Complicated" }
    Wisdom:      { icon:"fa-link",  matter:"Crystal", water:"Snowflake", cynefin:"Complex"     }
    Chaos:       { icon:"fa-link",  matter:"Gas",     water:"Vapor",     cynefin:"Chaotic"     } }

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
          { name:"Learn Vector Sparkty" } ] } ] }
      { name:"Ensemble", children:[
        { name:"Random Forests" } ] }
      { name:"Neural Networks", children:[
        { name:"Multi Layer Perception" } ] } ] } ]
