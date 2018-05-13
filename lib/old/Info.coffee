
Build = require( "js/prac/Build" )

class Info

  Build.Info     = Info
  module.exports = Info

  @Concerns = {
    norths : ['Internal','Service','Vision' ]
    wests  : ['Activity','People', 'Result' ]
    easts  : ['Refine',  'Data',   'Method' ]
    souths : ['External','Network','Mission']
  }

  @Groups = {}

  @Practices = {
    Collaborate: { hsv:[210,60,90], column:"Embrace",   row:"Learn", plane:"Information", icon:"fa-group",       css:"ikw-pane", cells:[ 1,12, 1,12], fill:"LDT", svg:"" }
    Concept:     { hsv:[ 60,60,90], column:"Innovate",  row:"Learn", plane:"Information", icon:"fa-empire",      css:"ikw-pane", cells:[13,12, 1,12], fill:"PWY", svg:"" }
    Discover:    { hsv:[255,60,90], column:"Encourage", row:"Learn", plane:"Information", icon:"fa-external-link-square",     css:"ikw-pane", cells:[25,12, 1,12], fill:"MWM", svg:"" }
    Adapt:       { hsv:[210,60,90], column:"Embrace",   row:"Do",    plane:"Information", icon:"fa-spinner",     css:"ikw-pane", cells:[ 1,12,13,12], fill:"LDT", svg:"" }
    Technology:  { hsv:[ 60,60,90], column:"Innovate",  row:"Do",    plane:"Information", icon:"fa-wrench",      css:"ikw-pane", cells:[13,12,13,12], fill:"PWY", svg:"" }
    Benefit:     { hsv:[255,60,90], column:"Encourage", row:"Do",    plane:"Information", icon:"fa-bar-chart-o", css:"ikw-pane", cells:[25,12,13,12], fill:"MWM", svg:"" }
    Change:      { hsv:[210,60,90], column:"Embrace",   row:"Share", plane:"Information", icon:"fa-refresh",     css:"ikw-pane", cells:[1, 12,25,12], fill:"LDT", svg:"" }
    Production:  { hsv:[ 60,60,90], column:"Innovate",  row:"Share", plane:"Information", icon:"fa-medkit",      css:"ikw-pane", cells:[13,12,25,12], fill:"PWY", svg:"" }
    Govern:      { hsv:[255,60,90], column:"Encourage", row:"Share", plane:"Information", icon:"fa-compass",     css:"ikw-pane", cells:[25,12,25,12], fill:"MWM", svg:"" }
  }

  @Studies = {
    Team:         { practice:"Collaborate", concern:"Internal",   icon:"fa-group",        css:"ikw-study", fill:"DDT", reference:"BMG",  bmg:"Resources"  }
    Kanban:       { practice:"Collaborate", concern:"Activity",   icon:"fa-tasks",        css:"ikw-study", fill:"PDT", reference:"BMG",  bmg:"Activities" }
    Partner:      { practice:"Collaborate", concern:"External",   icon:"fa-link",         css:"ikw-study", fill:"MTG", reference:"BMG"                    }
    Entitlement:  { practice:"Concept",     concern:"People",     icon:"fa-child",        css:"ikw-study", fill:"PDG" }
    Proposition:  { practice:"Concept",     concern:"Service",    icon:"fa-lightbulb-o",  css:"ikw-study", fill:"PDO" }
    Portfolio:    { practice:"Concept",     concern:"Network",    icon:"fa-briefcase",    css:"ikw-study", fill:"PDY" }
    Intelligence: { practice:"Concept",     concern:"Data",       icon:"fa-dropbox",      css:"ikw-study", fill:"PDR" }
    Customer:     { practice:"Discover",    concern:"Vision",     icon:"fa-user",         css:"ikw-study", fill:"LDM", reference:"BMG"  }
    Relationship: { practice:"Discover",    concern:"Method",     icon:"fa-heart",        css:"ikw-study", fill:"PWM", reference:"BMG"  }
    Channel:      { practice:"Discover",    concern:"Mission",    icon:"fa-truck",        css:"ikw-study", fill:"LWM", reference:"BMG"  }
    Feature:      { practice:"Adapt",       concern:"Internal",   icon:"fa-star",         css:"ikw-study", fill:"MTG" }
    Trace:        { practice:"Adapt",       concern:"Activity",   icon:"fa-sitemap",      css:"ikw-study", fill:"PDT" }
    Component:    { practice:"Adapt",       concern:"External",   icon:"fa-cube",         css:"ikw-study", fill:"DDT" }
    Acceptance:   { practice:"Adapt",       concern:"Refine",     icon:"fa-circle",       css:"ikw-study", fill:"LHT" }
    UI:           { practice:"Technology",  concern:"People",     icon:"fa-desktop",      css:"ikw-study", fill:"PDG", rm:"ARM/Apps"    }
    Services:     { practice:"Technology",  concern:"Service",    icon:"fa-bars",         css:"ikw-study", fill:"PDY", rm:"ARM/Systems" }
    Cloud:        { practice:"Technology",  concern:"Network",    icon:"fa-cloud",        css:"ikw-study", fill:"PDO", rm:"DRM" }
    Database:     { practice:"Technology",  concern:"Data",       icon:"fa-database",     css:"ikw-study", fill:"PDR", rm:"IRM" }
    Quantify:     { practice:"Benefit",     concern:"Result",     icon:"fa-circle",       css:"ikw-study", fill:"MFM" }
    Architect:    { practice:"Benefit",     concern:"Vision",     icon:"fa-university",   css:"ikw-study", fill:"LDM" }
    Review:       { practice:"Benefit",     concern:"Method",     icon:"fa-thumbs-up",    css:"ikw-study", fill:"PWM" }
    Patterns:     { practice:"Benefit",     concern:"Mission",    icon:"fa-align-left",   css:"ikw-study", fill:"LWM" }
    Test:         { practice:"Change",      concern:"Internal",   icon:"fa-stethoscope",  css:"ikw-study", fill:"DDT" }
    Transition:   { practice:"Change",      concern:"Activity",   icon:"fa-random",       css:"ikw-study", fill:"PDT" }
    Automate:     { practice:"Change",      concern:"External",   icon:"fa-cogs",         css:"ikw-study", fill:"MTG" }
    Support:      { practice:"Production",  concern:"People",     icon:"fa-life-ring",    css:"ikw-study", fill:"PDG" }
    Network:      { practice:"Production",  concern:"Service",    icon:"fa-globe",        css:"ikw-study", fill:"PDO", rm:"SRM" }
    Security:     { practice:"Production",  concern:"Network",    icon:"fa-lock",         css:"ikw-study", fill:"LDR", rm:"IRM" }
    Warehouse:    { practice:"Production",  concern:"Data",       icon:"fa-cubes",        css:"ikw-study", fill:"PDR" }
    Resource:     { practice:"Govern",      concern:"Vision",     icon:"fa-money",        css:"ikw-study", fill:"LDM" }
    Maturity:     { practice:"Govern",      concern:"Method",     icon:"fa-anchor",       css:"ikw-study", fill:"PWM" }
    Comply:       { practice:"Govern",      concern:"Mission",    icon:"fa-legal",        css:"ikw-study", fill:"LWM" }
  }

  @Topics = {

    # Collaborate
    Diversity: { study:"Team", icon:"fa-users", css:"ikw-topic", fill:"PWY" }


    # Concept
    Objectives: { study:"Intelligence", icon:"fa-compass", css:"ikw-topic", fill:"PWY" } # For DataScience from Crisp-DM
    Assessment: { study:"Intelligence", icon:"fa-cicle",   css:"ikw-topic", fill:"PWY" } # For DataScience from Crisp-DM
    Goals:      { study:"Intelligence", icon:"fa-cicle",   css:"ikw-topic", fill:"PWY" } # For DataScience from Crisp-DM

    # Benefit
    Reference:  { study:"Architect", icon:"fa-university", css:"ikw-topic", fill:"PWY" }
    Monitor:    { study:"Review",    icon:"fa-binoculars", css:"ikw-topic", fill:"PWY" }
    Quantify:   { study:"Review",    icon:"fa-bell",       css:"ikw-topic", fill:"PWY" }
  }

  @Items  = {}