<?php
/**
 * Vite plugin for Craft CMS 3.x
 *
 * Allows the use of the Vite.js next generation frontend tooling with Craft CMS
 *
 * @link      https://nystudio107.com
 * @copyright Copyright (c) 2021 nystudio107
 */

use craft\helpers\App;

/**
 * Vite config.php
 *
 * This file exists only as a template for the Vite settings.
 * It does nothing on its own.
 *
 * Don't edit this file, instead copy it to 'craft/config' as 'vite.php'
 * and make your changes there to override default settings.
 *
 * Once copied to 'craft/config', this file will be multi-environment aware as
 * well, so you can have different settings groups for each environment, just as
 * you do for 'general.php'
 */

return [

   /**
    * @var bool Should the dev server be used for?
    */
    'useDevServer' => App::env('DEV_MODE'),

    /**
     * @var string File system path (or URL) to the Vite-built manifest.json
     */
    'manifestPath' => '@webroot/dist/manifest.json',

    /**
     * @var string The public URL to the dev server (what appears in `<script src="">` tags
     */
    'devServerPublic' => App::env('VITE_DEV_SERVER_PUBLIC'),

    /**
     * @var string The public URL to use when not using the dev server
     */
    'serverPublic' => App::env('SITE_URL') . '/dist/',

    /**
     * @var string The JavaScript entry from the manifest.json to inject on Twig error pages
     *              This can be a string or an array of strings
     */
    'errorEntry' => 'src/js/app.ts',

    /**
     * @var string String to be appended to the cache key
     */
    'cacheKeySuffix' => '',

    /**
     * @var string The internal URL to the dev server, when accessed from the environment in which PHP is executing
     *              This can be the same as `$devServerPublic`, but may be different in containerized or VM setups.
     *              ONLY used if $checkDevServer = true
     */
    'devServerInternal' => App::env('VITE_DEV_SERVER_INTERNAL'),

    /**
     * @var bool Should we check for the presence of the dev server by pinging $devServerInternal to make sure it's running?
     */
    'checkDevServer' => true,

    /**
     * @var bool Whether the react-refresh-shim should be included
     */
    'includeReactRefreshShim' => false,

    /**
     * @var bool Whether the modulepreload-polyfill shim should be included
     */
    'includeModulePreloadShim' => true,

    /**
     * @var string File system path (or URL) to where the Critical CSS files are stored
     */
    'criticalPath' => '@webroot/dist/criticalcss',

    /**
     * @var string the suffix added to the name of the currently rendering template for the critical css file name
     */
    'criticalSuffix' =>'_critical.min.css',
];
