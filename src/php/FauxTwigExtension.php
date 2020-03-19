<?php
/**
 * FauxTwigExtension for Craft CMS 3.x
 *
 * This is intended to be used with the Symfony Plugin for PhpStorm:
 * https://plugins.jetbrains.com/plugin/7219-symfony-plugin
 *
 * It will provide full auto-complete for craft.app. and and many other useful things
 * in your Twig templates.
 *
 * Documented in the article:
 * https://nystudio107.com/blog/auto-complete-craft-cms-3-apis-in-twig-with-phpstorm
 *
 * Place the file somewhere in your project or include it via PhpStorm Settings -> Include Path.
 * You never call it, it's never included anywhere via PHP directly nor does it affect other
 * classes or Twig in any way. But PhpStorm will index it, and think all those variables
 * are in every single template and thus allows you to use Intellisense auto completion.
 *
 * Thanks to Robin Schambach; for context, see:
 * https://github.com/Haehnchen/idea-php-symfony2-plugin/issues/1103
 *
 * @link      https://nystudio107.com
 * @copyright Copyright (c) 2019 nystudio107
 * @license   MIT
 * @license   https://opensource.org/licenses/MIT MIT Licensed
 */

namespace nystudio107\craft;

/**
 * Class FauxCraftVariable extends the actual Craft Variable, but with added properties
 * that reflect things that are added to the Craft Variable dynamically by
 * plugins or modules.
 *
 * @property \craft\web\twig\variables\Cp $cp
 * @property \craft\web\twig\variables\Io $io
 * @property \craft\web\twig\variables\Routes $routes
 * @property \craft\web\twig\variables\CategoryGroups $categoryGroups
 * @property \craft\web\twig\variables\Config $config
 * @property \craft\web\twig\variables\Deprecator $deprecator
 * @property \craft\web\twig\variables\ElementIndexes $elementIndexes
 * @property \craft\web\twig\variables\EntryRevisions $entryRevisions
 * @property \craft\web\twig\variables\Feeds $feeds
 * @property \craft\web\twig\variables\Fields $fields
 * @property \craft\web\twig\variables\Globals $globals
 * @property \craft\web\twig\variables\I18N $i18n
 * @property \craft\web\twig\variables\Request $request
 * @property \craft\web\twig\variables\Sections $sections
 * @property \craft\web\twig\variables\SystemSettings $systemSettings
 * @property \craft\web\twig\variables\UserSession $session
 * @property \craft\commerce\web\twig\CraftVariableBehavior $commerce
 * @property \putyourlightson\blitz\variables\BlitzVariable $blitz
 * @property \nystudio107\twigpack\variables\ManifestVariable $twigpack
 * @property \modules\sitemodule\SiteModule $site
 * @mixin \craft\commerce\web\twig\CraftVariableBehavior
 *
 * @author    nystudio107
 * @package   nystudio107\craft
 * @since     1.0.1
 */
class FauxCraftVariable extends \craft\web\twig\variables\CraftVariable
{
}

/**
 * Class FauxTwigExtension provides a faux Twig extension for PhpStorm to index
 * so that we get Intellisense auto-complete in our Twig templates.
 *
 * @author    nystudio107
 * @package   nystudio107\craft
 * @since     1.0.1
 */
class FauxTwigExtension extends \Twig\Extension\AbstractExtension implements \Twig\Extension\GlobalsInterface
{
    public function getGlobals(): array
    {
        return [
            // Craft Variable
            'craft' => new FauxCraftVariable(),
            // Craft Elements
            'asset' => new \craft\elements\Asset(),
            'category' => new \craft\elements\Category(),
            'entry' => new \craft\elements\Entry(),
            'tag' => new \craft\elements\Tag(),
            // Craft "Constants"
            'SORT_ASC' => 4,
            'SORT_DESC' => 3,
            'SORT_REGULAR' => 0,
            'SORT_NUMERIC' => 1,
            'SORT_STRING' => 2,
            'SORT_LOCALE_STRING' => 5,
            'SORT_NATURAL' => 6,
            'SORT_FLAG_CASE' => 8,
            'POS_HEAD' => 1,
            'POS_BEGIN' => 2,
            'POS_END' => 3,
            'POS_READY' => 4,
            'POS_LOAD' => 5,
            // Misc. Craft globals
            'currentUser' => new \craft\elements\User(),
            'currentSite' => new \craft\models\Site(),
            'now' => new DateTime(),
            // Commerce Elements
            'lineItem' => new \craft\commerce\models\LineItem(),
            'order' => new \craft\commerce\elements\Order(),
            'product' => new \craft\commerce\elements\Product(),
            // Third party globals
            'seomatic' => new \nystudio107\seomatic\variables\SeomaticVariable(),
        ];
    }
}
