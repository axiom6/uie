
var path = require( "path"  );

module.exports = {
  context: __dirname,
  entry: './Pivot.js',
  output: {
    path: './',
    filename: 'Pack.js' },
  resolve: {
    root: [
      path.resolve('../../') ] },
  module: {
    loaders: [
      { test: /\.json$/,   loader: "json-loader" } ] }
};
