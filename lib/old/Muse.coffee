
Build = require( "js/prac/Build" )

class Muse

  Build.Muse     =  Muse
  module.exports = Muse
  B = Build

  # cells[j,m,i,n] and telss[j,m,i,n] reference a 36x36 colxrow grid
  @ncol      = 36
  @nrow      = 36
  @Margin    = { width:1, height:1, west:5, north:5, east:2, south:2, wStudy:0.5, hStudy:0.5 }

  @Planes = {
    Information: { prev:"",            next:"DataScience", talk:"muse", slide:"Information" }
    DataScience: { prev:"Information", next:"Knowledge",   talk:"muse", slide:"DataScience" }
    Knowledge:   { prev:"DataScience", next:"Wisdom",      talk:"muse", slide:"Knowledge"   }
    Wisdom:      { prev:"Knowledge",   next:"Hues",        talk:"muse", slide:"Wisdom"      }
    Hues:        { prev:"Wisdom",      next:"",            talk:"muse", slide:"Hues"        } }

  @Rows    = {
    Learn: { north:"",      south:"Do",    icon:"fa-book",      css:"ikw-row", cells:[1,36, 1,12], fill:"LDT", talk:"muse", slide:"Learn", perspectives:[ "Context",    "Concept" ],              }
    Do:    { north:"Learn", south:"Share", icon:"fa-list",      css:"ikw-row", cells:[1,36,13,12], fill:"PWG", talk:"muse", slide:"Do",    perspectives:[ "Architect",  "Engineer", "Construct" ] }
    Share: { north:"Do",    south:"",      icon:"fa-share-alt", css:"ikw-row", cells:[1,36,25,12], fill:"PWG", talk:"muse", slide:"Share", perspectives:[ "Transition", "Adminstrate" ],          } }

  @Columns = {
    Embrace:   { west:"",         east:"Innovate",  icon:"fa-link",  css:"ikw-col", cells:[ 1,12,1,36], fill:"PWG", w:107, fab:"Feature",   plan:"Tactics",  dimensions:["Behavior"],                          talk:"muse", slide:"Embrace"   }
    Innovate:  { west:"Embrace",  east:"Encourage", icon:"fa-bolt",  css:"ikw-col", cells:[13,12,1,36], fill:"PWG", w: 96, fab:"Advantage", plan:"Execute",  dimensions:["People","Service","Data","Network"], talk:"muse", slide:"Innovate"  }
    Encourage: { west:"Innovate", east:"",          icon:"fa-music", css:"ikw-col", cells:[25,12,1,36], fill:"PWG", w:122, fab:"Benefit",   plan:"Strategy", dimensions:["Motivation"],                        talk:"muse", slide:"Encourage" } }

  @None ={ Name:"Name", hsv:[210,60,90], column:"Embrace", row:"Learn", plane:"Information", icon:"fa-group", css:"ikw-pane", cells:[1,12,1,12], fill:"PWY", svg:"" }




  @Concerns = {
    Internal:   { hsv:[210,70,70], dimension:"Behavior",     zachman:"Time",       muse:"Embrace"   }
    Activity:   { hsv:[210,90,90], dimension:"Behavior",     zachman:"Time",       muse:"Embrace"   }
    External:   { hsv:[210,80,80], dimension:"Behavior",     zachman:"Time",       muse:"Embrace"   }
    Refine:     { hsv:[220,90,70], dimension:"Behavior",     zachman:"Time",       muse:"Embrace"   }
    People:     { hsv:[180,60,90], dimension:"People",       zachman:"People",     muse:"Innovate"  }
    Service:    { hsv:[ 90,60,90], dimension:"Service",      zachman:"Function",   muse:"Innovate"  }
    Data:       { hsv:[ 45,60,90], dimension:"Data",         zachman:"Data",       muse:"Innovate"  }
    Network:    { hsv:[ 60,60,90], dimension:"Network",      zachman:"Network",    muse:"Innovate"  }
    Vision:     { hsv:[255,70,70], dimension:"Motivation",   zachman:"Motivation", muse:"Encourage" }
    Method:     { hsv:[255,70,90], dimension:"Motivation",   zachman:"Motivation", muse:"Encourage" }
    Mission:    { hsv:[255,70,80], dimension:"Motivation",   zachman:"Motivation", muse:"Encourage" }
    Result:     { hsv:[265,70,90], dimension:"Motivation",   zachman:"Motivation", muse:"Encourage" } }

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
    Chaos:       { icon:"fa-link",  matter:"Gas",     water:"Vapor",     cynefin:"Chaotic" } }

  ###
  @Conveys = [
    { name:"CE", source:"Collaborate", target:"Concept"    }
    { name:"DE", source:"Discover",    target:"Concept"    }
    { name:"AT", source:"Adapt",       target:"Technology" }
    { name:"BT", source:"Benefit",     target:"Technology" }
    { name:"CF", source:"Change",      target:"Production" }
    { name:"GF", source:"Govern",      target:"Production" }
    { name:"IR", source:"Interact",    target:"Science"    }
    { name:"UR", source:"Understand",  target:"Science"    }
    { name:"OC", source:"Orchestrate", target:"Cognition"  }
    { name:"CC", source:"Reason",      target:"Cognition"  }
    { name:"EE", source:"Evolve",      target:"Educate"    }
    { name:"ME", source:"Mentor",      target:"Educate"    }
    { name:"AC", source:"Openness",    target:"Creativity" }
    { name:"IC", source:"Truth",       target:"Creativity" }
    { name:"EC", source:"Awareness",   target:"Conscience" }
    { name:"CC", source:"Complexity",  target:"Conscience" }
    { name:"EI", source:"Emerge",      target:"Inspire"    }
    { name:"AI", source:"Actualize",   target:"Inspire"    } ]
  ###
