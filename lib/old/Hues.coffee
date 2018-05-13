
Build = require( "js/prac/Build" )

class Hues

  Build.Hues     = Hues
  module.exports = Hues
  B = Build

  @Groups = {}

  @Practices = {
    Red:     { parts: { hue:  0, mcol:20, nrow:20, css:'ikw-part' }, column:"Embrace",   row:"Learn", plane:"Hues",   icon:B.inquireFA,           css:"ikw-hues", cells:[ 1,12, 1,12], fill:"LDT" }
    Orange:  { parts: { hue: 30, mcol:20, nrow:20, css:'ikw-part' }, column:"Innovate",  row:"Learn", plane:"Hues",   icon:"fa-flask",            css:"ikw-hues", cells:[13,12, 1,12], fill:"PWY" }
    Tan:     { parts: { hue: 60, mcol:20, nrow:20, css:'ikw-part' }, column:"Encourage", row:"Learn", plane:"Hues",   icon:"fa-tripadvisor",      css:"ikw-hues", cells:[25,12, 1,12], fill:"MWM" }
    Yellow:  { parts: { hue: 90, mcol:20, nrow:20, css:'ikw-part' }, column:"Embrace",   row:"Do",    plane:"Hues",   icon:"fa-magic",            css:"ikw-hues", cells:[ 1,12,13,12], fill:"LDT" }
    Green:   { parts: { hue:180, mcol:20, nrow:20, css:'ikw-part' }, column:"Innovate",  row:"Do",    plane:"Hues",   icon:"fa-object-group",     css:"ikw-hues", cells:[13,12,13,12], fill:"PWY" }
    Aqua:    { parts: { hue:210, mcol:20, nrow:20, css:'ikw-part' }, column:"Encourage", row:"Do",    plane:"Hues",   icon:B.machineFA,           css:"ikw-hues", cells:[25,12,13,12], fill:"MWM" }
    Blue:    { parts: { hue:270, mcol:20, nrow:20, css:'ikw-part' }, column:"Embrace",   row:"Share", plane:"Hues",   icon:"fa-language",         css:"ikw-hues", cells:[ 1,12,25,12], fill:"LDT" }
    Violet:  { parts: { hue:300, mcol:20, nrow:20, css:'ikw-part' }, column:"Innovate",  row:"Share", plane:"Hues",   icon:"fa-graduation-cap",   css:"ikw-hues", cells:[13,12,25,12], fill:"PWY" }
    Magenta: { parts: { hue:330, mcol:20, nrow:20, css:'ikw-part' }, column:"Encourage", row:"Share", plane:"Hues",   icon:"fa-user-plus",        css:"ikw-hues", cells:[25,12,25,12], fill:"MWM" }
  }

  @Studies = {}
  @Topics  = {}
  @Items   = {}
