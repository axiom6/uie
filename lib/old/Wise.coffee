
Build = require( "js/prac/Build" )

class Wise

  Build.Wise     = Wise
  module.exports = Wise

  @Groups = {}

  @Practices = {
    Openness:    { hsv:[225,70,90], column:"Embrace",   row:"Learn", plane:"Wisdom", icon:"fa-github-square",  css:"ikw-pane", cells:[ 1,12, 1,12], fill:"LDT", svg:"" }
    Creativity:  { hsv:[ 90,70,90], column:"Innovate",  row:"Learn", plane:"Wisdom", icon:"fa-paint-brush",    css:"ikw-pane", cells:[13,12, 1,12], fill:"PWY", svg:"" }
    Truth:       { hsv:[290,70,90], column:"Encourage", row:"Learn", plane:"Wisdom", icon:"fa-lightbulb-o",    css:"ikw-pane", cells:[25,12, 1,12], fill:"MWM", svg:"" }
    Awareness:   { hsv:[225,70,90], column:"Embrace",   row:"Do",    plane:"Wisdom", icon:"fa-circle",         css:"ikw-pane", cells:[ 1,12,13,12], fill:"LDT", svg:"" }
    Conscience:  { hsv:[ 90,70,90], column:"Innovate",  row:"Do",    plane:"Wisdom", icon:"fa-eye",            css:"ikw-pane", cells:[13,12,13,12], fill:"PWY", svg:"" }
    Complexity:  { hsv:[290,70,90], column:"Encourage", row:"Do",    plane:"Wisdom", icon:"fa-connectdevelop", css:"ikw-pane", cells:[25,12,13,12], fill:"MWM", svg:"" }
    Emerge:      { hsv:[225,70,90], column:"Embrace",   row:"Share", plane:"Wisdom", icon:"fa-dropbox",        css:"ikw-pane", cells:[ 1,12,25,12], fill:"LDT", svg:"" }
    Inspire:     { hsv:[ 90,70,90], column:"Innovate",  row:"Share", plane:"Wisdom", icon:"fa-fire",           css:"ikw-pane", cells:[13,12,25,12], fill:"PWY", svg:"" }
    Actualize:   { hsv:[290,70,90], column:"Encourage", row:"Share", plane:"Wisdom", icon:"fa-codepen",        css:"ikw-pane", cells:[25,12,25,12], fill:"MWM", svg:"" }
  }

  @Studies = {
    Reflect:       { practice:"Openness",    concern:"Internal",   icon:"fa-circle",       css:"ikw-study", fill:"DDT" }
    Let:           { practice:"Openness",    concern:"Activity",   icon:"fa-circle",       css:"ikw-study", fill:"PDT" }
    Transparent:   { practice:"Openness",    concern:"External",   icon:"fa-circle",       css:"ikw-study", fill:"MTG" }
    Humanize:      { practice:"Creativity",  concern:"People",     icon:"fa-child",        css:"ikw-study", fill:"PDG" }
    Shape:         { practice:"Creativity",  concern:"Service",    icon:"fa-steam",        css:"ikw-study", fill:"PDY" }
    Medium:        { practice:"Creativity",  concern:"Data",       icon:"fa-dropbox",      css:"ikw-study", fill:"PDR" }
    Authentic:     { practice:"Truth",       concern:"Vision",     icon:"fa-heart",        css:"ikw-study", fill:"LDM" }
    Empathy:       { practice:"Truth",       concern:"Method",     icon:"fa-truck",        css:"ikw-study", fill:"PWM" }
    Substance:     { practice:"Truth",       concern:"Mission",    icon:"fa-circle",       css:"ikw-study", fill:"LWM" }
    Conceive:      { practice:"Awareness",   concern:"Internal",   icon:"fa-star",         css:"ikw-study", fill:"DDT" }
    Perceive:      { practice:"Awareness",   concern:"Activity",   icon:"fa-circle",       css:"ikw-study", fill:"PDT" }
    Receive:       { practice:"Awareness",   concern:"External",   icon:"fa-cube",         css:"ikw-study", fill:"MTG" }
    Emotion:       { practice:"Conscience",  concern:"People",     icon:"fa-desktop",      css:"ikw-study", fill:"PDG" }
    Transcend:     { practice:"Conscience",  concern:"Service",    icon:"fa-bars",         css:"ikw-study", fill:"PDY" }
    Expand:        { practice:"Conscience",  concern:"Network",    icon:"fa-cloud",        css:"ikw-study", fill:"PDO" }
    Memory:        { practice:"Conscience",  concern:"Data",       icon:"fa-database",     css:"ikw-study", fill:"PDR" }
    Nature:        { practice:"Complexity",  concern:"Vision",     icon:"fa-leaf",         css:"ikw-study", fill:"LDM" }
    Flow:          { practice:"Complexity",  concern:"Method",     icon:"fa-circle",       css:"ikw-study", fill:"PWM" }
    Constructal:   { practice:"Complexity",  concern:"Mission",    icon:"fa-circle",       css:"ikw-study", fill:"LWM" }
    Coherence:     { practice:"Emerge",      concern:"Internal",   icon:"fa-circle",       css:"ikw-study", fill:"DDT" }
    Novelty:       { practice:"Emerge",      concern:"Activity",   icon:"fa-circle",       css:"ikw-study", fill:"PDT" }
    Wholeness:     { practice:"Emerge",      concern:"External",   icon:"fa-circle",       css:"ikw-study", fill:"MTG" }
    Reach:         { practice:"Inspire",     concern:"People",     icon:"fa-life-ring",    css:"ikw-study", fill:"PDG" }
    Connect:       { practice:"Inspire",     concern:"Service",    icon:"fa-globe",        css:"ikw-study", fill:"PDO" }
    Nurture:       { practice:"Inspire",     concern:"Network",    icon:"fa-lock",         css:"ikw-study", fill:"LDR" }
    Reveal:        { practice:"Inspire",     concern:"Data",       icon:"fa-circle",       css:"ikw-study", fill:"PDR" }
    Peaks:         { practice:"Actualize",   concern:"Vision",     icon:"fa-circle",       css:"ikw-study", fill:"LDM" }
    Humanistic:    { practice:"Actualize",   concern:"Method",     icon:"fa-circle",       css:"ikw-study", fill:"PWM" }
    Realistic:     { practice:"Actualize",   concern:"Mission",    icon:"fa-circle",       css:"ikw-study", fill:"LWM" }
  }


  @Topics = {

    # Creativity
    Incubate:       { study:"Humanize",   icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Diverge:        { study:"Humanize",   icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Exploratory:    { study:"Humanize",   icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Originality:    { study:"Humanize",   icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Flexible:       { study:"Shape",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Blending:       { study:"Shape",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Fluidity:       { study:"Shape",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Letting:        { study:"Shape",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Consistency:    { study:"Medium",     icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Honing:         { study:"Medium",     icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Mending:        { study:"Medium",     icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Elaboration:    { study:"Medium",     icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }

    # Truth
    Correspondence: { study:"Substance",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Coherence:      { study:"Substance",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Constructivist: { study:"Substance",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Consensus:      { study:"Substance",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Pragmatic:      { study:"Substance",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }

    # Actualize
    Ecstasy:       { study:"Peaks",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Harmony:       { study:"Peaks",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Depth:         { study:"Peaks",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Calm:          { study:"Peaks",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Humorous:      { study:"Peaks",      icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Sensitive:     { study:"Humanistic", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Intimate:      { study:"Humanistic", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Interpersonal: { study:"Humanistic", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Solitude:      { study:"Humanistic", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Appreciative:  { study:"Humanistic", icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Honest:        { study:"Realistic",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Acceptance:    { study:"Realistic",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Reliant:       { study:"Realistic",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Spontaneous:   { study:"Realistic",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }
    Autonomous:    { study:"Realistic",  icon:"fa-circle",         css:"ikw-topic", fill:"MTG" }

  }

  @Items = {}


  """
    (i) Incubate (Long-term Development)
    (ii) Imagine (Breakthrough Ideas)
    (iii) Improve (Incremental Adjustments)
    (iv) Invest (Short-term Goals)

    (i) "Idea Generation" (Fluency, Originality, Incubation and Illumination)
    (ii) "Personality" (Curiosity and Tolerance for Ambiguity)
    (iii) "Motivation" (Intrinsic, Extrinsic and Achievement)
    (iv) "Confidence" (Producing, Sharing and Implementing)

    Establishing purpose and intention
    Building basic skills
    Encouraging acquisitions of domain-specific knowledge
    Stimulating and rewarding curiosity and exploration
    Building motivation, especially internal motivation
    Encouraging confidence and a willingness to take risks
    Focusing on mastery and self-competition
    Promoting supportable beliefs about creativity
    Providing opportunities for choice and discovery
    Developing self-management (metacognitive skills)
    Teaching techniques and strategies for facilitating creative performance
    Providing balance

  """