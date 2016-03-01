import Path from 'path';
import Webpack from 'webpack';

const entry = {
  app: Path.resolve('ClientApp/index.web.js'),
};

const devOutputPath = Path.resolve('ClientApp/build');
const prodOutputPath = Path.resolve('bundle');
const filename = 'bundle.js';

const resolve = {
  modulesDirectories: ['node_modules', 'ClientApp'],
  extensions: ['', '.js', '.html', '.css'],
};

const define = new Webpack.DefinePlugin({
  'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
});

const plugins = [
  define,
];

export const development = {
  entry,
  resolve,
  plugins,
  output: {
    path: devOutputPath,
    filename,
  },
  module: {
    loaders: [
      { test: /js$/, loader: 'babel?cacheDirectory' },
    ],
  },
};

export const testing = {
  resolve,
  module: {
    loaders: [
      { test: /js$/, loader: 'babel' },
    ],
  },
  plugins: [
    define,
  ],
};

export const production = {
  entry,
  resolve,
  plugins,
  output: {
    path: prodOutputPath,
    filename,
  },
  module: {
    loaders: [
      { test: /js$/, loader: 'babel' },
    ],
  },
};
