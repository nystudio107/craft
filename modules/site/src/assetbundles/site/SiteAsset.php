<?php
/**
 * Site plugin for Craft CMS 3.x
 *
 * An example module for Craft CMS 3 that lets you enhance your websites with a custom site module
 *
 * @link      https://nystudio107.com/
 * @copyright Copyright (c) 2018 nystudio107
 */

namespace modules\site\assetbundles\Site;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    nystudio107
 * @package   Site
 * @since     1.0.0
 */
class SiteAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = "@site/assetbundles/site/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/Site.js',
        ];

        $this->css = [
            'css/Site.css',
        ];

        parent::init();
    }
}
