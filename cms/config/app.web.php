<?php
/**
 * Yii Web Application Config
 *
 * Edit this file at your own risk!
 *
 * The array returned by this file will get merged with
 * vendor/craftcms/cms/src/config/app.php and app.[web|console].php, when
 * Craft's bootstrap script is defining the configuration for the entire
 * application.
 *
 * You can define custom modules and system components, and even override the
 * built-in system components.
 *
 * This application config is applied only for *only* web requests
 */

use craft\helpers\App;

return [
    'components' => [
        'session' => [
            'class' => \yii\redis\Session::class,
            'redis' => [
                'hostname' => App::env('REDIS_HOSTNAME'),
                'port' => App::env('REDIS_PORT'),
                'database' => App::env('REDIS_CRAFT_DB'),
            ],
            'as session' => [
                'class' => \craft\behaviors\SessionBehavior::class,
            ],
        ],
    ],
];
