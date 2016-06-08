import { join } from 'path';

export default {
  entry: {
    app: [
      "./web/static/js/app.js",
      "./web/elm/Main.elm"
    ],
  },
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },

  devtool: "#source-map",

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
      }, {
        test: /\.js$/,
        exclude:  [/elm-stuff/, /node_modules/],
        loader: 'babel',
      }, {
        test: /\.css$/,
        loader: 'style!css',
      }, {
        test: /.(png|woff(2)?|eot|ttf|svg)(\?[a-z0-9=\.]+)?$/,
        loader: 'url?limit=100000',
      },
    ],
    noParse: [/.elm$/],
  },
};
