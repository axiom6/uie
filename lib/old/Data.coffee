
Build = require(  "js/prac/Build" )

class Data

  Build.Data     =  Data
  module.exports = Data

  @Groups = {
    Acquire:      { column:"Embrace",   row:"Learn", plane:"DataScience", icon:"fa-flask",          css:"ikw-group", quels:[ 1,12, 1,12], fill:"LDR"  }
    Model:        { column:"Innovate",  row:"Learn", plane:"DataScience", icon:"fa-calculator",         css:"ikw-group", quels:[13,24, 1,12], fill:"LDM" }
    Distill:      { column:"Encourage", row:"Learn", plane:"DataScience", icon:"fa-filter",         css:"ikw-group", quels:[25,36, 1,12], fill:"MWR"  }

    Conduct:      { column:"Embrace",   row:"Do",    plane:"DataScience", icon:"fa-magic",          css:"ikw-group", quels:[ 1,12,13,24], fill:"LDB"  }
    Spark:        { column:"Innovate",  row:"Do",    plane:"DataScience", icon:"fa-star-o",         css:"ikw-group", quels:[13,24,13,24], fill:"MWM"  }
    Interpret:    { column:"Encourage", row:"Do",    plane:"DataScience", icon:"fa-bar-chart-o",    css:"ikw-group", quels:[25,36,13,24], fill:"MWB"  }

    Prove:        { column:"Embrace",   row:"Share", plane:"DataScience", icon:"fa-thumbs-up",      css:"ikw-group", quels:[ 1,12,25,36], fill:"DDR"  }
    Explain:      { column:"Innovate",  row:"Share", plane:"DataScience", icon:"fa-users",          css:"ikw-group", quels:[13,24,25,36], fill:"DDM"  }
    Decision:     { column:"Encourage", row:"Share", plane:"DataScience", icon:"fa-code-fork",      css:"ikw-group", quels:[25,36,25,36], fill:"DDB"  }
  }

  @Practices = {
    Acquire:      { hsv:[210,60,90], column:"Embrace",   row:"Learn", plane:"DataScience", icon:"fa-flask",          css:"ikw-pane", quels:[ 5, 8, 5, 8], fill:"PWY" }
    Model:        { hsv:[ 60,60,90], column:"Innovate",  row:"Learn", plane:"DataScience", icon:"fa-modx",           css:"ikw-pane", quels:[17,20, 5, 8], fill:"PWY" }
    Distill:      { hsv:[255,60,90], column:"Encourage", row:"Learn", plane:"DataScience", icon:"fa-filter",         css:"ikw-pane", quels:[29,32, 5, 8], fill:"LDT" }
    Conduct:      { hsv:[210,60,90], column:"Embrace",   row:"Do",    plane:"DataScience", icon:"fa-magic",          css:"ikw-pane", quels:[ 5, 8,17,20], fill:"PWY" }
    Spark:        { hsv:[ 60,60,90], column:"Innovate",  row:"Do",    plane:"DataScience", icon:"fa-star-o",         css:"ikw-pane", quels:[17,20,17,20], fill:"MWM" }
    Interpret:    { hsv:[255,60,90], column:"Encourage", row:"Do",    plane:"DataScience", icon:"fa-bar-chart-o",    css:"ikw-pane", quels:[29,32,17,20], fill:"PWY" }
    Prove:        { hsv:[210,60,90], column:"Embrace",   row:"Share", plane:"DataScience", icon:"fa-thumbs-up",      css:"ikw-pane", quels:[ 5, 8,29,32], fill:"PWY" }
    Explain:      { hsv:[ 60,60,90], column:"Innovate",  row:"Share", plane:"DataScience", icon:"fa-users",          css:"ikw-pane", quels:[17,20,29,32], fill:"LDT" }
    Decision:     { hsv:[255,60,90], column:"Encourage", row:"Share", plane:"DataScience", icon:"fa-code-fork",      css:"ikw-pane", quels:[29,32,29,32], fill:"MWM" }
  }

  @Studies = {
    Collect:      { practice:"Acquire",  concern:"Activity", icon:"fa-arrow-circle-right",         css:"ikw-pane", quels:[ 1, 4, 5, 8], fill:"PWY" }
    Refine:       { practice:"Acquire",  concern:"Internal", icon:"fa-retweet",       css:"ikw-pane", quels:[ 5, 8, 1, 4], fill:"PWY" }
    Schema:       { practice:"Acquire",  concern:"Refine",   icon:"fa-sitemap",       css:"ikw-pane", quels:[ 9,12, 5, 8], fill:"LDT" }
    Quality:      { practice:"Acquire",  concern:"External", icon:"fa-check-square",  css:"ikw-pane", quels:[ 5, 8, 9,12], fill:"PWY" }

    Learning:     { practice:"Model",    concern:"People",   icon:"fa-question-circle",        css:"ikw-pane", quels:[13,16, 5, 8], fill:"PWY" }
    Regression:   { practice:"Model",    concern:"Service",  icon:"fa-object-group",  css:"ikw-pane", quels:[17,20, 1, 4], fill:"LDT" }
    Classify:     { practice:"Model",    concern:"Data",     icon:"fa-sitemap",       css:"ikw-pane", quels:[21,24, 5, 8], fill:"PWY" }
    Clustering:   { practice:"Model",    concern:"Network",  icon:"fa-cube",          css:"ikw-pane", quels:[17,20, 9,12], fill:"LDT" }

    Determine:    { practice:"Distill", concern:"Result",    icon:"fa-ioxhost",       css:"ikw-pane", quels:[25,28, 5, 8], fill:"PWY" }
    Algorithms:   { practice:"Distill", concern:"Vision",    icon:"fa-calculator",    css:"ikw-pane", quels:[29,32, 1, 4], fill:"PWY" }
    Ontology:     { practice:"Distill", concern:"Mission",   icon:"fa-wordpress",     css:"ikw-pane", quels:[33,36, 5, 8], fill:"LDT" }
    Dimensional:  { practice:"Distill", concern:"Method",    icon:"fa-cube",          css:"ikw-pane", quels:[29,32, 9,12], fill:"LDT" }

    Visual:       { practice:"Conduct", concern:"Activity",  icon:"fa-html5",         css:"ikw-pane", quels:[ 1, 4,17,20], fill:"LDT" }
    Prepare:      { practice:"Conduct", concern:"Internal",  icon:"fa-search",        css:"ikw-pane", quels:[ 5, 8,13,16], fill:"LDT" }
    Languages:    { practice:"Conduct", concern:"External",  icon:"fa-codepen",       css:"ikw-pane", quels:[ 5, 8,21,24], fill:"LDT" }
    Notebook:     { practice:"Conduct", concern:"Refine",    icon:"fa-leanpub",       css:"ikw-pane", quels:[ 9,12,17,20], fill:"MWM" }

    Kafka:        { practice:"Spark",   concern:"People",    icon:"fa-circle",          css:"ikw-pane", quels:[13,16,17,20], fill:"PWY" }
    Streams:      { practice:"Spark",   concern:"Service",   icon:"fa-sliders",         css:"ikw-pane", quels:[17,20,13,16], fill:"LDT" }
    Store:        { practice:"Spark",   concern:"Data",      icon:"fa-database",        css:"ikw-pane", quels:[21,24,17,20], fill:"PWY" }
    Akka:         { practice:"Spark",   concern:"Network",   icon:"fa-area-chart",      css:"ikw-pane", quels:[17,20,21,24], fill:"LDT" }

    Pattern:      { practice:"Interpret", concern:"Result",    icon:"fa-signal",      css:"ikw-pane", quels:[25,28,17,20], fill:"PWY" }
    Descriptive:  { practice:"Interpret", concern:"Vision",    icon:"fa-table",       css:"ikw-pane", quels:[29,32,13,16], fill:"PWY" }
    Diagnostic:   { practice:"Interpret", concern:"Mission",   icon:"fa-user-md",     css:"ikw-pane", quels:[33,36,17,20], fill:"PWY" }
    Predictive:   { practice:"Interpret", concern:"Method",    icon:"fa-line-chart",  css:"ikw-pane", quels:[29,32,21,24], fill:"PWY" }

    Validate:     { practice:"Prove",   concern:"Activity",  icon:"fa-certificate",     css:"ikw-pane", quels:[ 1, 4,29,32], fill:"PWY" }
    Trial:        { practice:"Prove",   concern:"Internal",  icon:"fa-stethoscope",     css:"ikw-pane", quels:[ 5, 8,25,28], fill:"PWY" }
    Reproduce:    { practice:"Prove",   concern:"Refine",    icon:"fa-clone",           css:"ikw-pane", quels:[ 9,12,29,32], fill:"PWY" }
    Pitfalls:     { practice:"Prove",   concern:"External",  icon:"fa-thumbs-down",     css:"ikw-pane", quels:[ 5, 8,33,36], fill:"PWY" }

    Teach_:       { practice:"Explain", concern:"People",    icon:"fa-university",      css:"ikw-pane", quels:[13,16,29,32], fill:"LDT" }
    Enable:       { practice:"Explain", concern:"Service",   icon:"fa-hand-peace-o",    css:"ikw-pane", quels:[17,20,25,28], fill:"LDT" }
    Warehouse1:   { practice:"Explain", concern:"Data",      icon:"fa-cubes",           css:"ikw-pane", quels:[21,24,29,32], fill:"LDT", name:"Warehouse" }
    Protect:      { practice:"Explain", concern:"Network",   icon:"fa-lock",            css:"ikw-pane", quels:[17,20,33,36], fill:"LDT" }

    Query:        { practice:"Decision", concern:"Result",   icon:"fa-question-circle", css:"ikw-pane", quels:[25,28,29,32], fill:"MWM" }
    Prescriptive: { practice:"Decision", concern:"Vision",   icon:"fa-thumbs-up",       css:"ikw-pane", quels:[29,32,25,28], fill:"PWY" }
    Legal:        { practice:"Decision", concern:"Mission",  icon:"fa-balance-scale",   css:"ikw-pane", quels:[33,36,29,32], fill:"MWM" }
    Publish:      { practice:"Decision", concern:"Method",   icon:"fa-newspaper-o",     css:"ikw-pane", quels:[29,32,33,36], fill:"PWY" }
  }

  @Topics = {

    #Acquire
    PlanAcquire:         { study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    OriginalDataCapture: { study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    GeneratedData:       { study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    TransformedData:     { study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    UseTheData:          { study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    CleanUpAtSource:     { study:"Refine",      icon:"fa-retweet", css:"ikw-topic", fill:"PWY" }
    DefectTracking:      { study:"Refine",      icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    QualityIndicator:    { study:"Refine",      icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    CrowdSource:         { study:"Refine",      icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    FullAutomation:      { study:"Refine",      icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    Dictionary:          { study:"Schema",      icon:"fa-list",    css:"ikw-topic", fill:"PWY" }
    Catalog:             { study:"Schema",      icon:"fa-book",    css:"ikw-topic", fill:"PWY" }
    EntityRelation:      { study:"Schema",      icon:"fa-sitemap", css:"ikw-topic", fill:"LDT" }
    ExperimentalDesign:  { study:"Schema",      icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    SourceMetadata:      { study:"Schema",      icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    Assurance:           { study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    Control:             { study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    Profile:             { study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    Usage:               { study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }
    Audit:               { study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }

    # Model
    PlanModel:           { study:"Learning",    icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    SelectModel:         { study:"Learning",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    ModelParameters:     { study:"Learning",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    Unsupervised:        { study:"Learning",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    Supervised:          { study:"Learning",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    KMeans:              { study:"Clustering",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY", measure:"Centroid"     }
    GaussianMixture:     { study:"Clustering",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY", measure:"Distribution" }
    PowerIteration:      { study:"Clustering",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY", measure:"Spectral"     }
    LatentDirichlet:     { study:"Clustering",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY", measure:"Connectivity" }
    Density:             { study:"Clustering",  icon:"fa-circle",  css:"ikw-topic", fill:"PWY", measure:"Density"      }
    Linear:              { study:"Regression",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY", name:"LinearLeastSquare" }
    Logistic:            { study:"Regression",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    NonLinear:           { study:"Regression",  icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    MiscRegressions:     { study:"Regression",  icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    ANOVA:               { study:"Regression",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    SupportVector:       { study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    DecisionTree:        { study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    RandomForests:       { study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    NaiveBayes:          { study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    #Ontology:           { study:"Classify",    icon:"fa-th-list", css:"ikw-topic", fill:"PWY" }
    BoostedTrees:        { study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }

    # Distill
    Dependency:          { study:"Determine",   icon:"fa-line-chart",   css:"ikw-topic", fill:"PWY"  }
    Correlation:         { study:"Determine",   icon:"fa-line-chart",   css:"ikw-topic", fill:"PWY"  }
    Causality:           { study:"Determine",   icon:"fa-hand-o-right", css:"ikw-topic", fill:"PWY"  }
    Constraint:          { study:"Determine",   icon:"fa-square-o",     css:"ikw-topic", fill:"PWY"  }
    PrincipleComponents: { study:"Dimensional", icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    SingleValueDecom:    { study:"Dimensional", icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    Eigen:               { study:"Dimensional", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Multivariate:        { study:"Dimensional", icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    #LinearAlgebra:      { study:"Dimensional", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Sampling:            { study:"Ontology",    icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    Feature:             { study:"Ontology",    icon:"fa-th",           css:"ikw-topic", fill:"PWY" }
    Metadata:            { study:"Ontology",    icon:"fa-th",           css:"ikw-topic", fill:"PWY" }
    Markov:              { study:"Ontology",    icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    GradientDescent:     { study:"Algorithms",  icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    LimitedMemory:       { study:"Algorithms",  icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }
    Kernel:              { study:"Algorithms",  icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    CollabFilter:        { study:"Algorithms",  icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }

    # Conduct
    D3:                  { study:"Visual",    icon:"fa-euro",           css:"ikw-topic", fill:"PWY" }
    C3:                  { study:"Visual",    icon:"fa-line-chart",     css:"ikw-topic", fill:"PWY" }
    MathBox:             { study:"Visual",    icon:"fa-heartbeat",      css:"ikw-topic", fill:"PWY" }
    PivotTable:          { study:"Visual",    icon:"fa-th",             css:"ikw-topic", fill:"PWY" }
    Scala:               { study:"Languages", icon:"fa-database",       css:"ikw-topic", fill:"LDT" }
    Python:              { study:"Languages", icon:"fa-gg-circle",      css:"ikw-topic", fill:"LDT" }
    R:                   { study:"Languages", icon:"fa-ruble",          css:"ikw-topic", fill:"LDT" }
    Javascript:          { study:"Languages", icon:"fa-html5",          css:"ikw-topic", fill:"PWY" }
    Zeppelin:            { study:"Notebook",  icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    SparkR:              { study:"Notebook",  icon:"R",                 css:"ikw-topic", fill:"MWM" }
    IPython:             { study:"Notebook",  icon :"IP[y]",            css:"ikw-topic", fill:"MWM" }
    RegionOfInterest:    { study:"Prepare",   icon:"fa-star-o",         css:"ikw-topic", fill:"PWY" }
    LocateExploreData:   { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    ManipulateData:      { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    FormatData:          { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    PresentData:         { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    ###
    SelectData:          { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    ConstructData:       { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    MergeData:           { study:"Prepare",   icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    ###

    # Spark
    Topics:              { study:"Kafka",     icon:"fa-list",           css:"ikw-topic", fill:"LDT" }
    Producers:           { study:"Kafka",     icon:"fa-upload",         css:"ikw-topic", fill:"LDT" }
    Brokers:             { study:"Kafka",     icon:"fa-bars",           css:"ikw-topic", fill:"LDT" }
    Consumers:           { study:"Kafka",     icon:"fa-download",       css:"ikw-topic", fill:"LDT" }
    DataFrames:          { study:"Streams",   icon:"fa-th",             css:"ikw-topic", fill:"MWM" }
    Context:             { study:"Streams",   icon:"fa-map",            css:"ikw-topic", fill:"MWM" }
    Transforms:          { study:"Streams",   icon:"fa-bars",           css:"ikw-topic", fill:"MWM" }
    Actions:             { study:"Streams",   icon:"fa-list",           css:"ikw-topic", fill:"MWM" }
    RDD:                 { study:"Store",       icon:"fa-database",         css:"ikw-topic", fill:"MWM" }
    GraphX:              { study:"Store",       icon:"fa-joomla",         css:"ikw-topic", fill:"MWM" }
    Cassandra:           { study:"Store",       icon:"fa-eye",            css:"ikw-topic", fill:"MWM" }
    Slick:               { study:"Store",      icon:"fa-bars",           css:"ikw-topic", fill:"MWM" }
    Rest:                { study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    Clusters:            { study:"Akka",      icon:"fa-server",         css:"ikw-topic", fill:"MWM" }
    Actors:              { study:"Akka",      icon:"fa-users",          css:"ikw-topic", fill:"MWM" }
    Play:                { study:"Akka",      icon:"fa-chevron-right",  css:"ikw-topic", fill:"LDT" }

    # Interpret
    Distributions:       { study:"Pattern",      icon:"fa-bell",        css:"ikw-topic", fill:"PWY" }
    Equations:           { study:"Pattern",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    CurveFit:            { study:"Pattern",      icon:"fa-signal",      css:"ikw-topic", fill:"PWY" }
    Report:              { study:"Descriptive",  icon:"fa-table",       css:"ikw-topic", fill:"PWY" }
    Querying:            { study:"Descriptive",  icon:"fa-table",       css:"ikw-topic", fill:"PWY" }
    DrillDown:           { study:"Descriptive",  icon:"fa-table",       css:"ikw-topic", fill:"PWY" }
    BusinessAlign:       { study:"Descriptive",  icon:"fa-table",       css:"ikw-topic", fill:"PWY" }
    Baseline:            { study:"Diagnostic",   icon:"fa-user-md",     css:"ikw-topic", fill:"PWY" }
    AnomalyDetection:    { study:"Diagnostic",   icon:"fa-user-md",     css:"ikw-topic", fill:"PWY" }
    Escalation:          { study:"Diagnostic",   icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    Interpolation:       { study:"Predictive",   icon:"fa-line-chart",  css:"ikw-topic", fill:"PWY" }
    Extrapolation:       { study:"Predictive",   icon:"fa-line-chart",  css:"ikw-topic", fill:"PWY" }
    Verify:              { study:"Predictive",   icon:"fa-thumbs-up",   css:"ikw-topic", fill:"PWY" }
    NextSteps:           { study:"Predictive",   icon:"fa-thumbs-up",   css:"ikw-topic", fill:"PWY" }

    # Prove
    TestDesign:          { study:"Trial",        icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    AccessModels:        { study:"Trial",        icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    ApproveModels:       { study:"Trial",        icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    Cross:               { study:"Validate",     icon:"fa-soundcloud",  css:"ikw-topic", fill:"PWY" }
    Precision:           { study:"Validate",     icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    Recall:              { study:"Validate",     icon:"fa-random",      css:"ikw-topic", fill:"PWY" }
    Prior:               { study:"Validate",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }
    RootMean:            { study:"Validate",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }
    Overfitting:         { study:"Pitfalls",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }
    Underfitting:        { study:"Pitfalls",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }
    Dimensionallity:     { study:"Pitfalls",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }
    Notes:               { study:"Reproduce",    icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    Steps:               { study:"Reproduce",    icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    Params:              { study:"Reproduce",    icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    DataSets:            { study:"Reproduce",    icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }

    # Explain
    Write:               { study:"Teach_",       icon:"fa-newspaper-o",     css:"ikw-topic", fill:"LDT" }
    Present:             { study:"Teach_",       icon:"fa-user-plus",       css:"ikw-topic", fill:"LDT" }
    Examples:            { study:"Enable",       icon:"fa-user-times",      css:"ikw-topic", fill:"MWM" }
    Scenarios:           { study:"Enable",       icon:"fa-refresh",         css:"ikw-topic", fill:"MWM" }
    Workshops:           { study:"Enable",       icon:"fa-leanpub",         css:"ikw-topic", fill:"MWM" }
    Cassandra1:          { study:"Warehouse1",   icon:"fa-cubes",           css:"ikw-topic", fill:"LDT" }
    Archival:            { study:"Warehouse1",   icon:"fa-cubes",           css:"ikw-topic", fill:"LDT" }
    Comparison:          { study:"Warehouse1",   icon:"fa-cubes",           css:"ikw-topic", fill:"LDT" }
    Secure1:             { study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }

    # Decision
    Query1:              { study:"Query",        icon:"fa-question-circle", css:"ikw-topic", fill:"MWM" }
    Prescriptive1:       { study:"Prescriptive", icon:"fa-thumbs-up",       css:"ikw-topic", fill:"PWY" }
    Legal1:              { study:"Legal",        icon:"fa-balance-scale",   css:"ikw-topic", fill:"MWM" }
    Publish1:            { study:"Publish",      icon:"fa-newspaper-o",     css:"ikw-topic", fill:"PWY" }
    ReviewResults:       { study:"Publish",      icon:"fa-newspaper-o",     css:"ikw-topic", fill:"PWY" }
  }

  @Items = {
    Transformer:       { topic:"DataFrame",          icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Estimator:         { topic:"DataFrame",          icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Pipeline:          { topic:"DataFrame",          icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Parameter:         { topic:"DataFrame",          icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ThresholdTuning:   { topic:"ClassifyEvaluation", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    LabelBasedMetrics: { topic:"ClassifyEvaluation", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    MultiLabel:        { topic:"ClassifyEvaluation", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    RankingSystem:     { topic:"ClassifyEvaluation", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    RegressMetrics:    { topic:"RegressEvaluation",  icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    FPMining:          { topic:"FrequentPattern",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    FPGrowth:          { topic:"FrequentPattern",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    AssociationRule:   { topic:"FrequentPattern",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    PrefixSpan:        { topic:"FrequentPattern",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    TermFrequency:     { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Word2Vec:          { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    StandardScalar:    { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Normalizer:        { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ChiSquareSelector: { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ElementWise:       { topic:"Feature",            icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ExpectationMax:    { topic:"GaussianMixture",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    MeanShift:         { topic:"KMeans",             icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Spectral:          { topic:"PowerIteration",     icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Hierarchical:      { topic:"LatentDisichlet",    icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Pearson:           { topic:"Correlation",        icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Spearman:          { topic:"Correlation",        icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    KeyExact:          { topic:"Sampling",           icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ChiSquared:        { topic:"Hypothesis",         icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    KolmogorovSmirnov: { topic:"Hypothesis",         icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    KernelDensity:     { topic:"Kernel",             icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    NearestNeighbor:   { topic:"Kernel",             icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    MultiNormal:       { topic:"NaiveBayes",         icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Bernoulli:         { topic:"NaiveBayes",         icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Ridge:             { topic:"Linear",             icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Lasso:             { topic:"Linear",             icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Isotonic:          { topic:"Linear",             icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    Stepwise:          { topic:"MiscRegressions",    icon:"fa-star-o", css:"ikw-topic", fill:"PWY" }
    Local:             { topic:"MiscRegressions",    icon:"fa-circle", css:"ikw-topic", fill:"PWY" }
    Multivariate:      { topic:"MiscRegressions",    icon:"fa-circle", css:"ikw-topic", fill:"PWY", name:"MultivariateSplines" }
    FrequentPattern:   { topic:"MiscRegressions",    icon:"fa-star-o", css:"ikw-topic", fill:"PWY" }

    Kriging:           { topic:"Miscellaneous",      icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Boosting:          { topic:"Miscellaneous",      icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    Constraint:        { topic:"Miscellaneous",      icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    SimulatedAnealing: { topic:"Miscellaneous",      icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    LevenbergMarquardt:       { topic:"NonLinear",              icon:"fa-circle", css:"ikw-item", fill:"PWY" }
    AlternatingLeastSquares:  { topic:"CollaborativeFiltering", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
    ExplicitImplicitFeedback: { topic:"CollaborativeFiltering", icon:"fa-star-o", css:"ikw-item", fill:"PWY" }
  }

  @Chapters = {

    #Acquire
    TeamSport:           { ch:4, study:"Collect",     icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    TeamBuild:           { ch:5, study:"Refine",      icon:"fa-retweet", css:"ikw-topic", fill:"PWY" }
    DataBug:          { ch:1, study:"Schema",      icon:"fa-list",    css:"ikw-topic", fill:"PWY" }
    DataMining:           { ch:1, study:"Quality",     icon:"fa-circle",  css:"ikw-topic", fill:"LDT" }


    # Model
    Techniques:           { ch:9, study:"Learning",    icon:"fa-circle",  css:"ikw-topic", fill:"PWY" }
    Experiments:         { ch:10, study:"Clustering",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    BadDataScience:      { ch:11, study:"Regression",  icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    MachineLearning:       { ch:12, study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }
    NeuralNetworks:       { ch:13, study:"Classify",    icon:"fa-star-o",  css:"ikw-topic", fill:"PWY" }

    # Distill
    ProbabilisticThinking:          { ch:16, study:"Determine",   icon:"fa-line-chart",   css:"ikw-topic", fill:"PWY"  }
    Experiments2: { ch:15, study:"Dimensional", icon:"fa-star-o",       css:"ikw-topic", fill:"PWY" }

    # Conduct

    # Spark
    Ecosystems:              { ch:17, study:"Kafka",     icon:"fa-list",           css:"ikw-topic", fill:"LDT" }
    BatchRealTime:          { ch:18, study:"Streams",   icon:"fa-th",             css:"ikw-topic", fill:"MWM" }
    Technology:           { ch:19, study:"Store",       icon:"fa-eye",            css:"ikw-topic", fill:"MWM" }
    DataStack:                { ch:20, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    Lambda:                { ch:22, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    OpenSource:                { ch:23, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    InMemory:                { ch:24, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    Cloud:                { ch:25, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    SupplyChain:                { ch:26, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }
    Advanced:                { ch:40, study:"Akka",      icon:"fa-circle",         css:"ikw-topic", fill:"MWM" }


    # Interpret
    Predictive_:         { ch:3, study:"Predictive",   icon:"fa-line-chart",  css:"ikw-topic", fill:"PWY" }

    # Prove
    Professional:          { ch:43, study:"Trial",        icon:"fa-stethoscope", css:"ikw-topic", fill:"PWY" }
    WalkerLaws:               { ch:44, study:"Validate",     icon:"fa-soundcloud",  css:"ikw-topic", fill:"PWY" }
    Conduct:         { ch:45, study:"Pitfalls",     icon:"fa-cogs",        css:"ikw-topic", fill:"PWY" }

    # Explain
    WhatIs:              { ch:1, study:"Teach_",       icon:"fa-newspaper-o",     css:"ikw-topic", fill:"LDT" }
    IoT:            { ch:31, study:"Enable",       icon:"fa-user-times",      css:"ikw-topic", fill:"MWM" }
    FutureDataTypes:  { ch:41, study:"Enable",       icon:"fa-user-times",      css:"ikw-topic", fill:"MWM" }
    FutureLanguage:  { ch:42, study:"Enable",       icon:"fa-user-times",      css:"ikw-topic", fill:"MWM" }

    HealthCare:          { ch:32, study:"Warehouse1",   icon:"fa-cubes",           css:"ikw-topic", fill:"LDT" }
    Government:             { ch:33, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    Legal:             { ch:33, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    HumanCapital:             { ch:33, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    Sports:             { ch:34, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    Vendors:             { ch:35, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    Ubiquitous:             { ch:35, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }
    Privacy:             { ch:35, study:"Protect",      icon:"fa-lock",            css:"ikw-topic", fill:"LDT" }

    # Decision
    CompetitiveAdvantage:              { ch:6, study:"Query",        icon:"fa-question-circle", css:"ikw-topic", fill:"MWM" }
    DecisionTrees:       { ch:14, study:"Prescriptive", icon:"fa-thumbs-up",       css:"ikw-topic", fill:"PWY" }
    Prescriptive_:       { ch:30, study:"Prescriptive", icon:"fa-thumbs-up",       css:"ikw-topic", fill:"PWY" }
    Forecasting:       { ch:29, study:"Prescriptive", icon:"fa-thumbs-up",       css:"ikw-topic", fill:"PWY" }
    Cognitive:      { ch:27, study:"Legal",        icon:"fa-balance-scale",   css:"ikw-topic", fill:"MWM" }
    DecisionSupport:            { ch:28, study:"Publish",      icon:"fa-newspaper-o",     css:"ikw-topic", fill:"PWY" }
  }

