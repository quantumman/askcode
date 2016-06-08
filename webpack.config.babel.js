import { join } from 'path';

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
    preLoaders: [
      {
        // Notice that the preloader actually reads .elm files looking for dependencies to be compiled from elmx
        test: /\.elm$/,
        loader: 'elmx-webpack-preloader',
        query: {
          sourceDirectories: [join(__dirname, "web/elm")],
          outputDirectory: '.tmp/elm',
        }
      },
    ],
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack',
        include: [join(__dirname, ".tmp/elm")]
      },
    ]
  },
};
