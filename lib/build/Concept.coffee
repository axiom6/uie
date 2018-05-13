
Build = require(  "js/build/Build" )

class Concept

  Build.Concept =  Concept
  module.exports = Util.Export( Concept, "build/Concept" )

  @MachineLearning: {
    Classification:{}
    Clustering:{}
    Dimensional:{}
    Regression:{}

    NeuralNetwork: {}
    Bayesian:{}
    Reasoning:{}
  }

  @Classification: {
     Decision:{}
     SupportVectorMachine:{ sub1:"Relevance", sub2:"SVC", sub3:"LinearSVC", sub4:"EnsembleClassifiers"  }
     KNeighbors:{}
     KernelApproximation:{}
     StochasticGradientDescent:{ sub:"Classifier" }
  }


  @Clustering:{
    KMmeans:{ branch:"MiniBatch"}
    MeanShift:{ alt:"VBGMM"}
    Spectral:{ alt:"GMM"}
    BIRCH:{}
    Hierarchical:{}
    ExpectationMaximization:{}
    DBSCAN:{}
    OPTICS:{}
  }

  @Regression: {
    Linear:{ branch:"General" }
    NonLinear:{ sub:"LevenbergMarquardt" }
    LeastSquares:{}
    Kriging:{}
    Logistic:{}
    Ridge:{ alt:"Tikhonov Regularization"}
    SupportVectorMachine:{ sub:"Regression"}
    StochasticGradientDescent:{ sub1:"Regressor", sub2:"LeastSquares" }
    ElasticNet:{ sub:"Lasso" }
    SVRKernel:{ sub:"EnsembleRegressors" }
  }

  @Dimensional:{
    FactorAnalysis:{}
    PrincipleComponentsAnalysis:{}
    CCA:{}
    ICA:{}
    LDA:{}
    NMF:{}
    TSNE:{}
  }

  @StructuredPrediction:{

  }

  @AnomolyDetection:{

  }

  @NeuralNets = {
    Backpropagation: {}
    Autoencoders: {}
    HopfieldNetworks: {}
    BoltzmannNachines: {}
    RestrictedBoltzmannMachines: {}
    SpikingNeuralNetworks: {}
    LearningVectorQuantization :{}
    Perceptron:{}
  }

  @Decision:{
    Bagging:{}
    RandomForest:{}
    BoosetedTrees:{}
    RotationForest:{}
    Learning:{}
  }

  @Reasoning: {
    CaseBased: {}
    Inductive:{}
    CommonSense:{}
  }

  @Inductive:{
    Logic:{}
    Reasoning:{}
    Inference:{}
    Programming:{}
    Probability:{}
    GroupMethod:{}
  }

  @Genetic:{
    GeneExpression:{}
  }

  @Learning: {
    InstanceBased:{}
    Lazy:{}
    Automate:{}
    DesisionTree:{}
  }

  @Bayesian: {
    BayesianNetwork:{}
    NaiveBayes:{}
    AONE: { name:"Averaged one-dependence estimators"}
  }

  @Fuzzy: {

  }
