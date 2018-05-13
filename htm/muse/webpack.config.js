
var path  = require( "path"  );

module.exports = {
  context: path.resolve( __dirname, '../'),
  entry:   path.resolve( __dirname, '../target/Muse.js' ),
  output: {
    path: path.resolve(__dirname, './'),
    filename: 'Pack.js' },
  resolve: {
    alias: {
      js:     path.resolve( __dirname, '../../js'  ),
      data:   path.resolve( __dirname, '../../data'),
      target: path.resolve( __dirname, '../target' ),
      htm:    path.resolve( __dirname, '../htm'    ) } },
  module: {
    loaders: [
      {test: /\.json$/, loader: 'json-loader'}],
    rules: [
      {test: /\.coffee$/, use: ['coffee-loader']}]
  }

};
