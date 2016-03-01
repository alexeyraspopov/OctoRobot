export const development = {};
export const testing = {};
export const production = {};
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
