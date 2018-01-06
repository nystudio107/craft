<?php
/**
 * Implements a static asset filename-based cache busting driver for Craft CMS,
 * based on the built-in CraftValetDriver. Place this file in your project root,
 * and Valet will pick it up automatically as per the "Local Drivers" section here:
 *
 * https://laravel.com/docs/5.5/valet
 *
 * Static asset filename-based cache busting for Craft CMS is discussed here:
 *
 * https://nystudio107.com/blog/simple-static-asset-versioning
 *
 * Based on https://gist.github.com/stidges/3d0c0317bf0d36073dd045bbcc742852
 *
 * @author    nystudio107
 * @copyright Copyright (c) 2017 nystudio107
 * @link      https://nystudio107.com/
 * @package   nystudio107/craft
 * @since     1.0.0
 * @license   MIT
 */

class LocalValetDriver extends CraftValetDriver
{
    /**
     * @inheritdoc
     */
    public function isStaticFile($sitePath, $siteName, $uri)
    {
        // Try the parent first
        $result = parent::isStaticFile($sitePath, $siteName, $uri);
        if ($result !== false) {
            return $result;
        }

        // Determine if this is a type we use filename-based cache busting with
        if (preg_match('/(.+)\.(?:\d+)\.(js|css|png|jpg|jpeg|gif|webp)$/i', $uri, $matches)) {
            // Rewrite cache busted URIs to their original filename (e.g. jquery.1476809927.js to jquery.js)
            return $sitePath.'/'.$this->frontControllerDirectory($sitePath).$matches[1].'.'.$matches[2];
        }

        return false;
    }
}
