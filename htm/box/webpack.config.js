
var path    = require( "path"  );

function resolve (dir) {
  return path.join(__dirname, '../../', dir)
}

module.exports = {
  context: __dirname,
  entry: './Box.js',
  output: {
    path: path.resolve( __dirname, './' ),
    filename: 'Pack.js' },
  resolve: {
    modules: [
      resolve('js'),
      resolve('data'),
      resolve('node_modules')
    ],
    alias: {
      js:   path.resolve( __dirname, '../../js'   ),
      data: path.resolve( __dirname, '../../data' ) } },
  module: {
    loaders: [
      { test: /\.json$/, loader: "json-loader" } ] }
};