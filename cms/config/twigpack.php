<?php
/**
 * Twigpack plugin for Craft CMS 3.x
 *
 * Twigpack is the conduit between Twig and webpack, with manifest.json &
 * webpack-dev-server HMR support
 *
 * @link      https://nystudio107.com/
 * @copyright Copyright (c) 2018 nystudio107
 */

use craft\helpers\App;

/**
 * Twigpack config.php
 *
 * This file exists only as a template for the Twigpack settings.
 * It does nothing on its own.
 *
 * Don't edit this file, instead copy it to 'craft/config' as 'twigpack.php'
 * and make your changes there to override default settings.
 *
 * Once copied to 'craft/config', this file will be multi-environment aware as
 * well, so you can have different settings groups for each environment, just as
 * you do for 'general.php'
 */

return [
    // If `devMode` is on, use webpack-dev-server to all for HMR (hot module reloading)
    'useDevServer' => App::env('DEV_MODE'),
    // The JavaScript entry from the manifest.json to inject on Twig error pages
    'errorEntry' => ['runtime.js', 'app.js'],
    // Manifest file names
    'manifest' => [
        'legacy' => 'manifest-legacy.json',
        'modern' => 'manifest.json',
    ],
    // Public server config
    'server' => [
        'manifestPath' => '@webroot/dist/',
        'publicPath' => '/',
    ],
    // webpack-dev-server config
    'devServer' => [
        'manifestPath' => App::env('TWIGPACK_DEV_SERVER_MANIFEST_PATH'),
        'publicPath' => App::env('TWIGPACK_DEV_SERVER_PUBLIC_PATH'),
    ],
    // Bundle to use with the webpack-dev-server
    'devServerBuildType' => 'modern',
    // Whether to include a Content Security Policy "nonce" for inline
    // CSS or JavaScript. Valid values are 'header' or 'tag' for how the CSP
    // should be included. c.f.:
    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/script-src#Unsafe_inline_script
    'cspNonce' => '',
    // Local files config
    'localFiles' => [
        'basePath' => '@webroot/',
        'criticalPrefix' => 'dist/criticalcss/',
        'criticalSuffix' => '_critical.min.css',
    ],
];
