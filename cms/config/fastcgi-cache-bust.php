<?php
/**
 * FastCGI Cache Bust plugin for Craft CMS 3.x
 *
 * Bust the Nginx FastCGI Cache when entries are saved or created.
 *
 * @link      https://nystudio107.com
 * @copyright Copyright (c) 2017 nystudio107
 */

use craft\helpers\App;

/**
 * FastCGI Cache Bust config.php
 *
 * This file exists only as a template for the FastCGI Cache Bust settings.
 * It does nothing on its own.
 *
 * Don't edit this file, instead copy it to 'craft/config' as 'fastcgi-cache-bust.php'
 * and make your changes there to override default settings.
 *
 * Once copied to 'craft/config', this file will be multi-environment aware as
 * well, so you can have different settings groups for each environment, just as
 * you do for 'general.php'
 */

return [
    // Enter the full absolute path to the FastCGI Cache directory.
    'cachePath' => App::env('FAST_CGI_CACHE_PATH'),
];
