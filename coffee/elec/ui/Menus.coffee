
class Menus

  module.exports = Menus

  constructor:( @app, @process, @action ) ->
    @name    = 'Muse'

  menus:() ->
    all = []
    all.push( @macs() ) if @process.platform is 'darwin'
    all.push( @file() )
    all.push( @edit() )
    all.push( @view() )
    all

  macs:() ->
    { label: @name, submenu:[
      { label:'About '+@name, role:'about' }
      { type:  'separator' }
      { label:'Services',         role:'services', submenu:[] }
      { type:'separator' }
      { label:'Hide '+@name,  role:'hide',       accelerator:'Command+H'       }
      { label:'Hide Others',  role:'hideothers', accelerator:'Command+Shift+H' }
      { label:'Show All',     role:'unhide' }
      { label: 'Quit', accelerator:'Command+Q', click:()=> @app.quit() } ] }

  file:() ->
    { label: 'File', submenu: [
      { label: 'New',   accelerator:'Command+N', click: () => @action.newf()  }
      { label: 'Open',  accelerator:'Command+O', click: () => @action.open()  }
      { label: 'Save',  accelerator:'Command+S', click: () => @action.save()  }
      { type:'separator' }
      { label: 'Preferences', accelerator:'Command+P', click: () => @action.pref() } ] }

  edit:() ->
    { label: 'Edit', submenu: [
      { label: 'Undo',       accelerator:'Command+Z', click: () => @action.undo()  }
      { label: 'Redo',       accelerator:'Command+U', click: () => @action.redo() }
      { type: 'separator' }
      { label: 'Cut',        accelerator:'Command+X', click: () => @action.cut()  }
      { label: 'Copy',       accelerator:'Command+C', click: () => @action.copy() }
      { label: 'Paste',      accelerator:'Command+V', click: () => @action.paste() }
      { label: 'Select All', accelerator:'Command+A', click: () => @action.selectAll() }
      { type: 'separator' }
      { label: 'Find',       accelerator:'Command+F', click: () => @action.find() }
      { label: 'Replace',    accelerator:'Command+R', click: () => @action.replace() }] }

  view:() ->
    { label: 'View', submenu: [
      { label: 'Close', accelerator:'Command+W', click: () => @action.close() }
      { label: 'Skyline',  click: () => @action.view( 'Skyline',  '/htm/skyline/skyline.html'  ) }
      { label: 'Test',     click: () => @action.view( 'Test',     '/htm/muse/Test.html'  ) }
      { label: 'Store',    click: () => @action.view( 'PouchDB',  '/htm/muse/Store.html' ) }
      { type: 'separator' }
      { label: 'Info',     click: () => @action.view( 'Muse',     '/htm/muse/Muse.html#Info' ) }
      { label: 'Augm',     click: () => @action.view( 'Augm',     '/htm/muse/Muse.html#Augm' ) }
      { label: 'Data',     click: () => @action.view( 'Data',     '/htm/muse/Muse.html#Data' ) }
      { label: 'Know',     click: () => @action.view( 'Know',     '/htm/muse/Muse.html#Know' ) }
      { label: 'Wise',     click: () => @action.view( 'Wise',     '/htm/muse/Muse.html#Wise' ) }
      { type: 'separator' }
      { label: 'Exit',     click: () => @action.view( 'Exit',     '/htm/exit/Exit.html'      ) }
      { label: 'Pivot',    click: () => @action.view( 'Pivot',    '/htm/pivot/Pivot.html'    ) }
      { label: 'Hues',     click: () => @action.view( 'Hues',     '/htm/muse/Muse.html#Hues' ) }
      { type: 'separator' }
      { label: 'MuseTalk', click: () => @action.view( 'MuseTalk', '/htm/ikws/Muse.html' ) }
      { label: 'InfoTalk', click: () => @action.view( 'InfoTalk', '/htm/ikws/Info.html' ) }
      { label: 'DataTalk', click: () => @action.view( 'DataTalk', '/htm/ikws/Data.html' ) }
      { label: 'KnowTalk', click: () => @action.view( 'KnowTalk', '/htm/ikws/Know.html' ) }
      { label: 'WiseTalk', click: () => @action.view( 'WiseTalk', '/htm/ikws/Wise.html' ) }
      { label: 'EafdTalk', click: () => @action.view( 'EafdTalk', '/htm/ikws/Eafd.html' ) }
      { label: 'KnowScala',click: () => @action.view( 'KnowScala','/htm/ikws/KnowScala.html' ) }
      { type: 'separator' }
      { label: 'Color',    click: () => @action.view( 'Color',    '/htm/box/Box.html#Color'    ) }
      { label: 'Cart',     click: () => @action.view( 'Cart',     '/htm/box/Box.html#Cart'     ) }
      { label: 'Rgbs',     click: () => @action.view( 'Rgbs',     '/htm/box/Box.html#Rgbs'     ) }
      { label: 'IKW',      click: () => @action.view( 'IKW',      '/htm/box/Box.html#IKW'      ) }
      { label: 'Planes',   click: () => @action.view( 'Planes',   '/htm/box/Box.html#Planes'   ) }
      { label: 'Sphere',   click: () => @action.view( 'Sphere',   '/htm/box/Box.html#Sphere'   ) }
      { label: 'Regress',  click: () => @action.view( 'Regress',  '/htm/box/Box.html#Regress'  ) }
      { type: 'separator' }
      { label: 'Vecs',     click: () => @action.view( 'Vecs',     '/htm/box/Box.html#Vecs'     ) }
      { label: 'VecRgb',   click: () => @action.view( 'VecRgb',   '/htm/box/Box.html#VecsRgb'  ) }
      { label: 'VecHsv',   click: () => @action.view( 'VecHsv',   '/htm/box/Box.html#VecsHsv'  ) }
      { label: 'PolarRgb', click: () => @action.view( 'PolarRgb', '/htm/box/Box.html#PolarRgb' ) }
      { label: 'ScaleRgb', click: () => @action.view( 'ScaleRgb', '/htm/box/Box.html#ScaleRgb' ) }
      { type: 'separator' }
      { label: 'Plotly',   click: () => @action.view( 'Plotly',   '/htm/plot/Plot.html'  ) }
      { type: 'separator' }
      { label: 'Toggle Dev Tools', accelerator: 'Command+T', click: () => @action.toggleDevTools() } ] }