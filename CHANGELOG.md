# nystudio107/craft Change Log

## 2.2.10 - 2020.05.20
### Added
* Added baked-in support for xdebug

### Changed
* Always do a `composer install` & `npm install` when starting up via `docker-compose up`

### Fixed
* Fixed tab handler not adding the class to the `<body>`

## 2.2.9 - 2020.04.14
### Added
* Added support for repo.repman.io Packagist proxy global CDN 

### Changed
* Use the CSS hash for Critical CSS cookie value

### Fixed
* Fixed Asset Bundle namespace casing

## 2.2.8 - 2020.03.30
### Changed
* Remove project `composer.lock` file
* Use separate app config files for web/console requests

## 2.2.7 - 2020.03.27
### Changed
* Removed `SITE_NAME` from the `.env` vars; it's not a secret, and it doesn't change per environment

## 2.2.6 - 2020.03.27
### Changed
* Remove Craft & Plugin Licenses from .env — not necessary except for public repos

## 2.2.5 - 2020.03.27
### Changed
* Synced up the `project.yaml` with the `seed_db.sql` so it can properly propagate
* Added a default `SECURITY_KEY` in `example.env`

## 2.2.4 - 2020.03.27
### Changed
* Skip a superfluous copy operation in the Nginx container

## 2.2.3 - 2020.03.21
### Changed
* Added `SERVERLESS_SHARP_CLOUDFRONT_URL` to the `example.env`
* Added plugin licenses environment variables to `project.yaml`
* Added `SERVERLESS_SHARP_CLOUDFRONT_URL` to the ImageOptimized default settings in `project.yaml`

## 2.2.2 - 2020.03.18
### Added
* Added `seed_db.sql` to seed the initial database

### Changed
* Numerous setup changes/tweaks

## 2.2.1 - 2020.03.17
### Changed
* Switch base config setup to MariaDB instead of Postgres

## 2.2.0 - 2020.03.16
### Changed
* Switch to Docker for local dev

## 2.1.1 - 2020.02.28
### Changed
* Remove `craft.twigpack.includeCssRelPreloadPolyfill()`
* Use a regular function for our ServiceWorker registration JS, because IE11
* Remove the `include` setting from `configureBabelLoader()`
* Add `sourceType: 'unambiguous'` to better handle different types of modules

## 2.1.0 - 2020.02.24
### Changed
* Set `'defaultTokenDuration' => 'P2W'` in `config/general.php` for longer preview tokens

## 2.0.4 - 2020.02.05
### Added
* Added `settings.babelLoaderConfig.include`

### Changed
* Removed entirely the concept of a "modern" and "legacy" build from the `webpack.dev.js`; we don't need legacy builds with `webpack-dev-server`

### Fixed
* Changed deprecated use of `cacheFirst` to `CacheFirst` in the Workbox config

## 2.0.3 - 2019.08.29
### Added
* Added a default `config/project.yaml` for base setup

### Changed
* Updated `.gitignore` and `.env.example`
* Ignore CP and `.php` for Service Worker runtime caching
* Remove `siteUrl`, since it is now set via Project Config

## 2.0.2 - 2019.08.17
### Changed
* Added `maxUploadFileSize` to `general.php`
* Added `/web/dist/*` to `.gitignore`
* Refactored the error pages out to a single channel
* Added generic login image background

## 2.0.1 - 2019.08.15
### Changed
* Numerous template changes to get the base build working

## 2.0.0 - 2019.08.14
### Changed
* Updated to use modern webpack config
* Updated to use Craft 3.2 as the baseline

## 1.0.16 - 2018.05.24
### Changed
* Removed references to the Craft RC in the `composer.json`
* Added SEOmatic to the list of base plugins
* Change the Critical CSS loader to `onload="this.onload=null;this.rel='stylesheet'"` for IE 11 compatibility

## 1.0.15 - 2018.02.19
### Changed
* Updated `composer.json` to reflect the updated dependencies
* Fixed the site module's controller namespacing
* Added `sort-packages` to the `composer.json`
* Added `async-queue` plugin

## 1.0.14 - 2018.02.01
### Changed
* Fixed composer dependencies to reflect the `nystudio107/craft-` renaming

## 1.0.13 - 2018.01.26
### Changed
* Tell Composer to install PHP 7.0-compatible dependencies
* Fixed `sitemodule` namespacing

## 1.0.12 - 2018.01.25
### Changed
* Switched from `craft.app.config.general.custom.baseUrl` to `alias('@baseUrl')`

## 1.0.11 - 2018.01.23
### Added
* Added `post-install-cmd` to `composer.json`

## 1.0.10 - 2018.01.18
### Changed
* Synced the `modules/site` with `site-module` and pluginfactory.io generated modules

## 1.0.9 - 2018.01.06
### Added
* Added a static asset filename-based cache busting `LocalValetDriver.php` for Laravel Valet

## 1.0.8 - 2018.01.01
### Added
* Added a better PurgeCSS pipeline
* Added a `purgecssWhitelist` to `package.json`
* Execute JavaScript when doing Critical CSS
* Added a `criticalWhitelist` to `package.json`
* Added SiteModule framework to nystudio107/craft
* Added a `post-update-cmd` to `composer.json` to recreate any symlinks that may have been removed after a `composer update` or `composer install`

## 1.0.7 - 2017.12.16
### Added
* Added `purgecss` to production builds
* Added automatic incrementing of `staticAssetsVersion` for production builds

## 1.0.6 - 2017.12.16
### Changed
* Updated to use the latest `critical` package, adjusted `gulpfile.js` base path

## 1.0.5 - 2017.12.13
### Changed
* Slurp whitespace with the minify tags
* Fix favicon URLs/meta
* Fix manifest

## 1.0.4 - 2017.12.06
### Changed
* Fixed asset versioning in `sw.js`
* Run all inline JavaScript through `js-babel` for ES6 goodness

### Added
* Added base VueJS and Axios support

## 1.0.3 - 2017.12.05
### Changed
* Updated for Craft CMS 3 RC1 release

## 1.0.2 - 2017.12.04
### Changed
* Fixed deprecation errors
* Cleaned up the default ServiceWorker in `sw.js`
* Added Fontello CSS to the `package.json`
* Added PhpStorm Craft app API type hinting

## 1.0.1 - 2017.12.01
### Added
* Added accessible tabhandler.js
* Added Tailwind CSS
* Added support for Redis via `app.php`
* Fixed `package.json` paths for `web/`
* Cleaned up the default templates
* Added `src/conf/` for Nginx or other configuration files

## 1.0.0 - 2017.11.26
### Added
* Initial release

Brought to you by [nystudio107](https://nystudio107.com/)
