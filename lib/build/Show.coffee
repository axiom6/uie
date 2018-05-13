
Build = require( "js/build/Build" )

class Show

  Build.Show =  Show
  module.exports = Util.Export( Show, "build/Show" )

  @sitemap:( rotate ) ->
    "fa-sitemap fa-rotate-#{rotate}"

  # cells[j,m,i,n] and telss[j,m,i,n] reference a 6x6 colxrow grid
  @ncol      = 8
  @nrow      = 6
  @Margin            = { width:2, height:3, west:5, north:5, east:2, south:2 }
  @MarginDataScience = { width:1, height:1, west:5, north:5, east:2, south:2 }

  @Planes = {
    Information: {}
    Knowledge:   {}
    Wisdom:      {} }

  @Rows    = {
    Learn:     { icon:"fa-book",      css:"ikw-row", cells:[1,8,1,2], fill:"LDT" }
    Do:        { icon:"fa-list",      css:"ikw-row", cells:[1,8,3,2], fill:"PWG" }
    Share:     { icon:"fa-share-alt", css:"ikw-row", cells:[1,8,7,2], fill:"PWG" } }

  @Columns = {
    Embrace:   { icon:"fa-link",     css:"ikw-col", cells:[1,2,1,8], fill:"PWG" }
    UI:        { icon:"fa-desktop",  css:"ikw-col", cells:[3,2,1,8], fill:"PWG" }
    Data:      { icon:"fa-database", css:"ikw-col", cells:[5,2,1,8], fill:"PWG" }
    Encourage: { icon:"fa-music",    css:"ikw-col", cells:[7,2,1,8], fill:"PWG" } }

  @Groups  = {}

  @Practices = {
    Tree  :   { column:"Embrace",   row:"Learn", plane:"Information", icon:@sitemap(90),  css:"ikw-pane", cells:[1,2,1,2], fill:"LDT", pos:"NW", show:"", svg:""   }
    Radial:   { column:"UI",        row:"Learn", plane:"Information", icon:"fa-circle",   css:"ikw-pane", cells:[3,2,1,2], fill:"LDT", pos:"N",  show:"", svg:""   }
    Links:    { column:"Data",      row:"Learn", plane:"Information", icon:"fa-circle",   css:"ikw-pane", cells:[5,2,1,2], fill:"LDT", pos:"N",  show:"", svg:""   }
    Axes:     { column:"Encourage", row:"Learn", plane:"Information", icon:"fa-sitemap",  css:"ikw-pane", cells:[7,2,1,2], fill:"PWY", pos:"NE", show:"", svg:""   }
    Radar:    { column:"Embrace",   row:"Do",    plane:"Information", icon:"fa-bullseye", css:"ikw-pane", cells:[1,2,3,2], fill:"LDT", pos:"W",  show:"", svg:""   }
    Wheel:    { column:"UI",        row:"Do",    plane:"Information", icon:"fa-dribbble", css:"ikw-pane", cells:[3,2,3,2], fill:"PWY", pos:"C",  show:"", svg:""   }
    Sankey:   { column:"Data",      row:"Do",    plane:"Information", icon:"fa-circle",   css:"ikw-pane", cells:[5,2,3,2], fill:"LDT", pos:"N",  show:"", svg:""   }
    #chema:   { column:"Encourage", row:"Do",    plane:"Information", icon:"fa-eye",      css:"ikw-pane", cells:[7,2,3,2], fill:"MWM", pos:"E",  show:"", table:"" }
    Brewer:   { column:"Data",      row:"Learn", plane:"Information", icon:"fa-eye",      css:"ikw-pane", cells:[7,2,3,2], fill:"MWM", pos:"E",  show:"", parts: { mcol:9, nrow:4, css:'ikw-part' } }
    Chord:    { column:"Embrace",   row:"Share", plane:"Information", icon:"fa-random",   css:"ikw-pane", cells:[1,2,5,2], fill:"LDT", pos:"SW", show:"", svg:""   }
    Table:    { column:"UI",        row:"Share", plane:"Information", icon:"fa-trello",   css:"ikw-pane", cells:[3,2,5,2], fill:"PWY", pos:"S",  show:"", table:"" }
    Pivot:    { column:"Data",      row:"Share", plane:"Information", icon:"fa-circle",   css:"ikw-pane", cells:[5,2,5,2], fill:"LDT", pos:"N",  show:"", table:"" }
    Classify: { column:"Encourage", row:"Share", plane:"Information", icon:"fa-th",       css:"ikw-pane", cells:[7,2,5,2], fill:"MWM", pos:"SE", show:"", table:"" } }

  @Studies = {}

  @Topics  = {}

  @Talks   = {}

  @Conveys = []

