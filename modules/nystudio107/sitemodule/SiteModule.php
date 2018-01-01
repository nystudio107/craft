<?php
/**
 * SiteModule
 *
 * @link      https://nystudio107.com
 * @copyright Copyright (c) 2017 nystudio107
 */

namespace modules\nystudio107\sitemodule;

use modules\nystudio107\sitemodule\assetbundles\sitemodule\SiteModuleAsset;

use Craft;
use craft\events\TemplateEvent;
use craft\web\View;

use yii\base\Event;
use yii\base\InvalidConfigException;
use yii\base\Module;

/**
 * @author    nystudio107
 * @package   SiteModule
 * @since     1.0.0
 * @inheritdoc
 */
class SiteModule extends Module
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        Craft::setAlias('@site-module', $this->getBasePath());
        parent::init();

        // Only respond to AdminCP requests
        $request = Craft::$app->getRequest();
        if ($request->getIsCpRequest()) {
            // Handler: View::EVENT_BEFORE_RENDER_TEMPLATE
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function (TemplateEvent $event) {
                    Craft::trace(
                        'View::EVENT_BEFORE_RENDER_TEMPLATE',
                        __METHOD__
                    );
                    // Add our SiteModule AssetBundle
                    $view = Craft::$app->getView();
                    try {
                        $view->registerAssetBundle(SiteModuleAsset::class);
                    } catch (InvalidConfigException $e) {
                        Craft::error(
                            'Error registering AssetBundle - '.$e->getMessage(),
                            __METHOD__
                        );
                    }
                }
            );
        }
    }
}
