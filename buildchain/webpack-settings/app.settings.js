// app.settings.js

// node modules
require('dotenv').config();

// settings
module.exports = {
    alias: {
    },
    copyright: 'Example Company, Inc.',
    entry: {
        'app': [
            '../src/js/app.ts',
            '../src/css/app-base.pcss',
            '../src/css/app-components.pcss',
            '../src/css/app-utilities.pcss',
        ],
        'lazysizes-wrapper': [
            '../src/js/utils/lazysizes-wrapper.ts',
        ],
    },
    extensions: ['.ts', '.js', '.vue', '.json'],
    name: 'Example Project',
    paths: {
        dist: '../../cms/web/dist/',
    },
    urls: {
        criticalCss: 'http://example.test/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};
