module.exports = {
  scssLoader: {
    test: /\.scss$/,
    use: [
      'vue-style-loader',
      'css-loader',
      'sass-loader'
    ]
  },
  sassLoader: {
    test: /\.sass$/,
    use: [
      'vue-style-loader',
      'css-loader',
      {
        loader: 'sass-loader',
        options: {
          sassOptions: {
            indentedSyntax: true
          }
        }
      }
    ]
  }
}