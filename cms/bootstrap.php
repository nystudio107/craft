<?php
/**
 * Shared bootstrap file
 */

// Define path constants
define('CRAFT_BASE_PATH', __DIR__);
define('CRAFT_VENDOR_PATH', CRAFT_BASE_PATH . '/vendor');

// Load Composer's autoloader
require_once CRAFT_VENDOR_PATH . '/autoload.php';

// Load dotenv?
if (class_exists('Dotenv\Dotenv')) {
    Dotenv\Dotenv::createUnsafeImmutable(CRAFT_BASE_PATH)->safeLoad();
}

// Define additional PHP constants
// (see https://craftcms.com/docs/3.x/config/#php-constants)
define('CRAFT_ENVIRONMENT', getenv('ENVIRONMENT') ?: 'production');
