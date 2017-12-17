# nystudio107/craft Change Log

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