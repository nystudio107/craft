// webpack.dev.js - developmental builds

// node modules
const merge = require('webpack-merge');
const path = require('path');
const webpack = require('webpack');

// webpack plugins
const DashboardPlugin = require('webpack-dashboard/plugin');

// config files
const common = require('./webpack.common.js');
const pkg = require('./package.json');
const settings = require('./webpack.settings.js');

// Configure the webpack-dev-server
const configureDevServer = () => ({
    public: settings.devServerConfig.public(),
    contentBase: path.resolve(__dirname, settings.paths.templates),
    host: settings.devServerConfig.host(),
    port: settings.devServerConfig.port(),
    https: !!parseInt(settings.devServerConfig.https()),
    disableHostCheck: true,
    hot: true,
    overlay: true,
    watchContentBase: true,
    watchOptions: {
        poll: !!parseInt(settings.devServerConfig.poll()),
        ignored: /node_modules/,
    },
    headers: {
        'Access-Control-Allow-Origin': '*'
    }
});

// Configure Image loader
const configureImageLoader = () => ({
    test: /\.(png|jpe?g|gif|svg|webp)$/i,
    use: [
        {
            loader: 'file-loader',
            options: {
                name: 'img/[name].[hash].[ext]'
            }
        }
    ]
});

// Configure the Postcss loader
const configurePostcssLoader = () => ({
    test: /\.(pcss|css)$/,
    use: [
        {
            loader: 'style-loader',
        },
        {
            loader: 'vue-style-loader',
        },
        {
            loader: 'css-loader',
            options: {
                importLoaders: 2,
                sourceMap: true
            }
        },
        {
            loader: 'resolve-url-loader'
        },
        {
            loader: 'postcss-loader',
            options: {
                sourceMap: true
            }
        }
    ]
});

// Development module exports (only uses modern config)
module.exports = merge(
    common.modernConfig,
    {
        output: {
            filename: path.join('./js', '[name].[hash].js'),
            publicPath: settings.devServerConfig.public() + '/',
        },
        mode: 'development',
        devtool: 'inline-source-map',
        devServer: configureDevServer(MODERN_CONFIG),
        module: {
            rules: [
                configurePostcssLoader(MODERN_CONFIG),
                configureImageLoader(MODERN_CONFIG),
            ],
        },
        plugins: [
            new webpack.HotModuleReplacementPlugin(),
            new DashboardPlugin(),
        ],
    }
);
