const path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const GlobalEntries = require('webpaack-glob-entries');

module.exports = {
  mode: 'production',
  entry: GlobalEntries('./src/scenarios/*.ts'),
  output: {
    path: path.join(__dirname, 'dist'),
    libraryTarget: 'commonjs',
    filename: '[name].js',
  },
  resolve: {
    extensions: ['.ts'],
  },
  plugins: [new CleanWebpackPlugin()],

  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/i,
        use: 'ts-loader',
        exclude: ['/node_modules/'],
      },
    ],
  },
  target: 'none',
  externals: /^(k6|https?\\:\/\/)(\/.*)?/,
  devtool: 'source-map',
  stats: {
    colors: true,
  },
  optimization: {
    minimize: false,
  },
};
