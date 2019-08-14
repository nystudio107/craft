<?php
/**
 * Asset Volume Configuration
 *
 * All of your system's volume configuration settings go in here.
 * Put the Asset Volume handle in `ASSET_HANDLE` key, and put the path
 * to the asset directory in `ASSET_PATH`. Create an array for each Asset
 * Volume your website uses.
 *
 * You must create each Asset Volume in the CP first, and then override
 * the settings here.
 */

return [
    'site' => [
        'path' => '@webroot/assets/site',
        'url' => '@assetsUrl/assets/site',
    ],
];
