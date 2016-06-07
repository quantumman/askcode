export default {
  entry: {
    app: ["./web/static/js/app.js", "./web/elm/Main.elm"],
  },
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },

  resolve: {
    extensions: ['', '.js', '.elm', '.elmx'],
  },

  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack'
      },
    ]
  },
};
