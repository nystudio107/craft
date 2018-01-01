<?php
/**
 * SiteModule AssetBundle
 *
 * @link      https://nystudio107.com
 * @copyright Copyright (c) 2017 nystudio107
 */

namespace modules\nystudio107\sitemodule\assetbundles\sitemodule;

use craft\redactor\assets\redactor\RedactorAsset;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    nystudio107
 * @package   SiteModule
 * @since     1.0.0
 * @inheritdoc
 */
class SiteModuleAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        // Set the path to our AssetBundle source
        $this->sourcePath = '@site-module/assetbundles/sitemodule/dist';
        // Declare AssetBundles that must be loaded first
        $this->depends = [
            CpAsset::class,
        ];
        // Add in our CSS
        $this->css = [
            'css/SiteModule.css',
        ];
        // Add in our JS
        $this->js = [
            'js/SiteModule.js',
        ];

        parent::init();
    }
}
