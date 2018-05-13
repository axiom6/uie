# Full list of configuration options available here:
# https://github.com/hakimel/reveal.js#configuration

$  = require( 'jquery'   )

$(document).ready ->
  initialize()
  #imgSrc();
  pdfCSS()
  return

initialize = ->
  #bower     = '../../lib/bower_components/'
  nodejs     = '../../node_modules/'
  revdir     = nodejs + 'reveal.js/'
  preCodeFn  = () ->! !document.querySelector('pre code')
  initHighFn = () -> hljs.initHighlightingOnLoad()
  Reveal.initialize
    controls: true
    progress: true
    history: true
    center: true
    slideNumber: true
    transition: 'slide'
    math:
      mathjax: nodejs + 'MathJax/MathJax.js'
      config: 'TeX-AMS_HTML-full'
    dependencies: [
      { src: revdir + 'lib/js/classList.js',           condition: ->  !document.body.classList }
      { src: revdir + 'plugin/markdown/marked.js',     condition: -> !!document.querySelector('[data-markdown]') }
      { src: revdir + 'plugin/markdown/markdown.js',   condition: -> !!document.querySelector('[data-markdown]')}
      { src: revdir + 'plugin/highlight/highlight.js', condition:preCodeFn, async: true, callback:initHighFn  }
      { src: revdir + 'plugin/zoom-js/zoom.js', async: true }
      { src: revdir + 'plugin/math/math.js',    async: true }
      ]
  return

imgSrc = ->

  rep = ->
    src1 = $(this).attr('src')
    src2 = src1.replace(/htm\/spark\/img/, 'img/spark')
    Util.log 'src', src1, src2
    $(this).attr 'src', src2
    return

  $('img').each rep
  return

# PDF and Paper printing

pdfCSS = ->
  #bower = '../../lib/bower_components/'
  nodejs = '../../node_modules/'
  revdir = nodejs + 'reveal.js/'
  link = document.createElement('link')
  link.rel = 'stylesheet'
  link.type = 'text/css'
  link.href = if window.location.search.match(/pdf/gi) then revdir + 'css/print/pdf.css' else revdir + 'css/print/paper.css'
  document.getElementsByTagName('head')[0].appendChild link
  return
