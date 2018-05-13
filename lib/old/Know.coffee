
Build = require( "js/prac/Build" )

class Know

  Build.Know     = Know
  module.exports = Know

  @Groups = {}

  @Practices = {
    Interact:    { hsv:[215,70,90], column:"Embrace",   row:"Learn", plane:"Knowledge", icon:"fa-question-circle", css:"ikw-pane", cells:[ 1,12, 1,12], fill:"LDT", svg:"" }
    Science:    { hsv:[ 80,70,90],  column:"Innovate",  row:"Learn", plane:"Knowledge", icon:"fa-flask",           css:"ikw-pane", cells:[13,12, 1,12], fill:"PWY", svg:"" }
    Understand:  { hsv:[280,70,90], column:"Encourage", row:"Learn", plane:"Knowledge", icon:"fa-tripadvisor",     css:"ikw-pane", cells:[25,12, 1,12], fill:"MWM", svg:"" }
    Orchestrate: { hsv:[215,70,90], column:"Embrace",   row:"Do",    plane:"Knowledge", icon:"fa-magic",           css:"ikw-pane", cells:[ 1,12,13,12], fill:"LDT", svg:"" }
    Cognition:   { hsv:[ 80,70,90], column:"Innovate",  row:"Do",    plane:"Knowledge", icon:"fa-object-group",    css:"ikw-pane", cells:[13,12,13,12], fill:"PWY", svg:"" }
    Reason:      { hsv:[280,70,90], column:"Encourage", row:"Do",    plane:"Knowledge", icon:"fa-connectdevelop",  css:"ikw-pane", cells:[25,12,13,12], fill:"MWM", svg:"" }
    Evolve:      { hsv:[215,60,90], column:"Embrace",   row:"Share", plane:"Knowledge", icon:"fa-language",        css:"ikw-pane", cells:[ 1,12,25,12], fill:"LDT", svg:"" }
    Educate:     { hsv:[ 80,60,90], column:"Innovate",  row:"Share", plane:"Knowledge", icon:"fa-graduation-cap",  css:"ikw-pane", cells:[13,12,25,12], fill:"PWY", svg:"" }
    Mentor:      { hsv:[280,60,90], column:"Encourage", row:"Share", plane:"Knowledge", icon:"fa-user-plus",       css:"ikw-pane", cells:[25,12,25,12], fill:"MWM", svg:"" }
  }
  
  @Studies = {
    Purpose:      { practice:"Interact",    concern:"Internal",   icon:"fa-balance-scale",  css:"ikw-study", fill:"DDT" }
    Communicate:  { practice:"Interact",    concern:"Activity",   icon:"fa-wechat",         css:"ikw-study", fill:"PDT" }
    Setting:      { practice:"Interact",    concern:"External",   icon:"fa-circle",         css:"ikw-study", fill:"MTG" }
    Social:       { practice:"Science",     concern:"People",     icon:"fa-child",          css:"ikw-study", fill:"PDG" }
    Theory:       { practice:"Science",     concern:"Service",    icon:"fa-signal",         css:"ikw-study", fill:"PDY" }
    Semantic:     { practice:"Science",     concern:"Data",       icon:"fa-dropbox",        css:"ikw-study", fill:"PDR" }
    Meaning:      { practice:"Understand",  concern:"Vision",     icon:"fa-leanpub",        css:"ikw-study", fill:"LDM" }
    Comprehend:   { practice:"Understand",  concern:"Method",     icon:"fa-empire",         css:"ikw-study", fill:"PWM" }
    Sympathize:   { practice:"Understand",  concern:"Mission",    icon:"fa-heart",          css:"ikw-study", fill:"LWM" }
    Arrange:      { practice:"Orchestrate", concern:"Internal",   icon:"fa-star",           css:"ikw-study", fill:"DDT" }
    Conduct:      { practice:"Orchestrate", concern:"Activity",   icon:"fa-sitemap",        css:"ikw-study", fill:"PDT" }
    Perform:      { practice:"Orchestrate", concern:"External",   icon:"fa-cube",           css:"ikw-study", fill:"MTG" }
    Express:      { practice:"Cognition",   concern:"People",     icon:"fa-desktop",        css:"ikw-study", fill:"PDG" }
    Transform:    { practice:"Cognition",   concern:"Service",    icon:"fa-bars",           css:"ikw-study", fill:"PDY" }
    Distribute:   { practice:"Cognition",   concern:"Network",    icon:"fa-cloud",          css:"ikw-study", fill:"PDO" }
    Compose:      { practice:"Cognition",   concern:"Data",       icon:"fa-database",       css:"ikw-study", fill:"PDR" }
    Logic:        { practice:"Reason",      concern:"Vision",     icon:"fa-binoculars",     css:"ikw-study", fill:"LDM" }
    Category:     { practice:"Reason",      concern:"Method",     icon:"fa-connectdevelop", css:"ikw-study", fill:"PWM" }
    Represent:    { practice:"Reason",      concern:"Mission",    icon:"fa-circle",         css:"ikw-study", fill:"LWM" }
    Awareness:    { practice:"Evolve",      concern:"Internal",   icon:"fa-stethoscope",    css:"ikw-study", fill:"DDT" }
    Balance:      { practice:"Evolve",      concern:"Activity",   icon:"fa-balance-scale",  css:"ikw-study", fill:"PDT" }
    Improve:      { practice:"Evolve",      concern:"External",   icon:"fa-circle",         css:"ikw-study", fill:"MTG" }
    Teach:        { practice:"Educate",     concern:"People",     icon:"fa-life-ring",      css:"ikw-study", fill:"PDG" }
    Campus:       { practice:"Educate",     concern:"Service",    icon:"fa-university",     css:"ikw-study", fill:"PDO" }
    Preserve:     { practice:"Educate",     concern:"Network",    icon:"fa-shield",         css:"ikw-study", fill:"LDR" }
    Library:      { practice:"Educate",     concern:"Data",       icon:"fa-cubes",          css:"ikw-study", fill:"PDR" }
    Manifest:     { practice:"Mentor",      concern:"Vision",     icon:"fa-circle",         css:"ikw-study", fill:"LDM" }
    Seek:         { practice:"Mentor",      concern:"Method",     icon:"fa-circle",         css:"ikw-study", fill:"PWM" }
    Exemplify:    { practice:"Mentor",      concern:"Mission",    icon:"fa-circle",         css:"ikw-study", fill:"LWM" }
  }
  
  @Topics = {

    # Interact
    Implicit:  { study:"Purpose",     icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Feedback:  { study:"Communicate", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Explicit:  { study:"Diversity",   icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }

   # Reason
    Objects:     { study:"Category",  icon:"fa-object-group", css:"ikw-topic", fill:"PWY" }
    Morphisms:   { study:"Category",  icon:"fa-arrows-h",     css:"ikw-topic", fill:"PWY" }
    Procedural:  { study:"Represent", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Semantics:   { study:"Represent", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Episodic:    { study:"Represent", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Symbolic:    { study:"Represent", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }
    Visuals:     { study:"Represent", icon:"fa-circle",       css:"ikw-topic", fill:"PWY" }

    # Mentor
    Accompany:   { study:"Seek",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    Sow:         { study:"Seek",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    Catalyze:    { study:"Seek",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    Demonstrate: { study:"Seek",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
    Harvest:     { study:"Seek",      icon:"fa-circle",      css:"ikw-topic", fill:"PWY" }
  }
  
  @Items = {}