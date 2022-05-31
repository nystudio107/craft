# nystudio107/craft Change Log

## 2.5.12 - 2022.05.31
### Changed
* Use `craft up` to run migrations & apply Project Config changes

## 2.5.11 - 2022.05.03
### Added
* Determine the container name separator character by checking the Docker Compose API version at runtime

## 2.5.10 - 2022.05.02
### Changed
* Ignore `max-line-length` rule

### Fixed
* Fix eslint errors pinning `vite-plugin-eslint` to `1.3.0`

## 2.5.9 - 2022.05.02
### Fixed
* Clean up initial check for `composer.lock` or `vendor/autoload.php` to ensure the first-time install is done

### Changed
* Changed `bootstrap.php` to allow `.env`-set environment variables override existing injected environment variables ([#82](https://github.com/craftcms/craft/issues/82))

## 2.5.8 - 2022.04.13
### Fixed
* Changed the hostname from `mysql` to `mariadb` in the `composer_install.sh` and `run_queue.sh` scripts, since we're using MariaDB

### Changed
* Use `"eslint": "^7.0.0"` to avoid package version conflicts with `vite-plugin-eslint`
* Add correct at-rule-no-unknown config ([#80](https://github.com/nystudio107/craft/pull/80))

## 2.5.7 - 2022.04.08
### Changed
* Run migrations first via `composer.json` scripts, because Craft won't apply Project Config if there are pending migrations
* Added `tty: true` back in now that the issue has been fixed in the Docker Compose API `2.4.1` ([#9348](https://github.com/docker/compose/pull/9348))
* Wait for both `vendor/autoload.php` as we as `composer.lock` before starting up the queue listener

## 2.5.6 - 2022.03.30
### Changed
* Fix `WORKDIR` in `php-prod-craft` container so `make craft` etc. commands work as expected
* Fix `WORKDIR` in `node-dev-vite` container so `make npm` etc. commands work as expected
* Fix linting issue with `import.meta.hot`

## 2.5.5 - 2022.03.30
### Changed
* Remove deprecated `useProjectConfigFile` from `config/general.php`
* Remove `platform` from `composer.json`

## 2.5.4 - 2022.03.28
### Changed
* Add `disableProcessTimeout` to the `post-craft-update` Composer scripts, and run Project Config before migrations
* Add `import.meta.hot.accept()` to accept HMR as per: https://vitejs.dev/guide/api-hmr.html

## 2.5.3 - 2022.03.26
### Changed
* Ensure permissions on directories Craft needs to write to

## 2.5.2 - 2022.03.26
### Added
* Added more logging to indicate when a container is waiting for another service to start up, and when seeding a database is complete
* Run `composer craft-update` after a `composer install` is done via `composer_install.sh`

### Changed
* Moved permissions setting to Docker image creation

## 2.5.1 - 2022.03.26
### Added
* Dramatically sped up the startup time for the PHP containers by moving the permissions setting script to run asynchronously in the queue container via the `run_queue.sh` script

## 2.5.0 - 2022.03.19
### Added
* Switch the main branch to `craft-vite` so the default project now uses Vite.js
* Significantly increased startup times via a `composer_install.sh` script that only runs `composer install` at container startup time if `composer.lock` or `vendor/` is missing
* Significantly increased startup times via a `npm_install.sh` script that only runs `npm install` at container startup time if `package-lock.json` or `node_modules/` is missing

### Changed
* Run migrations / project config changes via the `run_queue.sh` script, only after the db container responds
* refactor: Remove `tty: true` which causes console output to not appear in Docker Composer API 2.3.0. ref: https://github.com/docker/compose/issues/9288

## 2.4.55 - 2022.01.07

### Fixed

* fix: Use `su-exec www-data` in the Makefile so `craft` and `composer` commands are not run as root

## 2.4.54 - 2021.12.25

### Fixed

* Fixed an issue with Critical CSS not generating properly out of the box

## 2.4.53 - 2021.12.25

### Fixed

* Fix `node-dev-webpack/Dockerfile` so `npm install` is run

## 2.4.52 - 2021.12.25

### Fixed

* Fix Composer [2.2.0 error](https://getcomposer.org/doc/06-config.md#allow-plugins) by adding `allow-plugins`

## 2.4.51 - 2021.12.22

### Changed

* Updated to use a unified `bootstrap.php`
* Updated to use `vlucas/phpdotenv` `^5.4.0`
* Updated to Tailwind CSS `^3.0.0`

## 2.4.50 - 2021.12.07

### Changed

* Use Node 16 for the webpack buildchain container
* Updated deps for native ARM buildchain container
* Updated the `Makefile` to accommodate _another_ change in Docker that switches back to using `_` instead of `-` in
  container names

## 2.4.49 - 2021.11.20

### Added

* Use `tty: true` for nicer output in terminal from the PHP & webpack Docker containers

### Changed

* Move Craft Autocomplete to `require-dev`
* `poll` -> `usePolling`

## 2.4.48 - 2021.10.20

### Changed

* Updated the `Makefile` to accommodate the change in Docker to using `-` instead of `_` in container names

## 2.4.47 - 2021.08.07

### Added

* Handle both `XDEBUG_SESSION` and `XDEBUG_PROFILE` cookies
* Added `compiled_templates` as a bind mount in `docker-compose.yaml` for IDE autocompletion
* Added `nystudio107/craft-autocomplete` for autocomplete of variables in Twig templates

## 2.4.46 - 2021.07.29

### Added

* Added `putyourlightson/craft-autocomplete` for the Twig + Symfony plugin auto-complete, removed FauxTwigExtension.php

## 2.4.45 - 2021.07.20

### Fixed

* Add `publicPath` back in, and fix `allowedHosts` location in the config

## 2.4.44 - 2021.07.20

### Fixed

* Fix breaking changes due to `webpack-dev-server` `^4.0.0-rc.0`

## 2.4.43 - 2021.07.19

### Changed

* Remove `storage/` dir

## 2.4.42 - 2021.06.22

### Changed

* Continue running the `php-fpm` containers as root (since `php-fpm` uses worker pools with the proper user/group), but
  switch to `su-exec` to ensure any craft CLI commands are run as `www-data`

## 2.4.41 - 2021.06.15

### Fixed

* Fixed typo in Dockerfile that would cause the PHP container to not build

## 2.4.40 - 2021.06.15

### Changed

* Removed `USER` directive in the PHP containers, since the pool runs as `www-data` already
* Fix permissions regression

## 2.4.39 - 2021.06.11

### Changed

* Removed whitelist settings in `tailwind.conf.js`
* Cleaned up the `php-dev-craft` & `php-prod-craft` Dockerfile file permissions

## 2.4.38 - 2021.05.23

### Changed

* Run php container as the `www-data` user to avoid permissions issues

## 2.4.37 - 2021.05.14

### Changed

* Added `logs` and `compiled_templates` dirs back in, so they appear on the client side

## 2.4.36 - 2020.05.09

### Changed

* Silence errors from the root `post-create-project-cmd` script

### Fixed

* Fixed a breaking change of `dev` to `devMiddleware` in `webpack-dev-server` `^4.0.0-beta.3`

## 2.4.35 - 2021.04.27

### Changed

* Delegate all of `storage` & `cpresources` volumes, let the container own it

## 2.4.34 - 2021.04.10

### Added

* Added `make craft` to the Makefile commands

## 2.4.33 - 2021.04.06

### Changed

* Use `rm -f` to ensure no errors if the file doesn’t exist

## 2.4.32 - 2021.04.05

### Changed

* Use Tailwind CSS `^2.1.0` with JIT

## 2.4.31 - 2021.04.05

### Added

* Added `make update` to update Composer & NPM packages
* Added `make update-clean` to completely remove `vendor/` and `node_modules/`, then update Composer & NPM packages

## 2.4.30 - 2021.04.05

### Fixed

* Fixed `make up` command by removing an errant `$`
* Add `storage/config-deltas/` to prevent permissions issues

## 2.4.29 - 2021.03.25

### Added

* Added `make clean` to the Makefile
* Added **Makefile Project Commands** to `README.md`
* Added `make composer xxx` & `make npm xxx` commands

### Changed

* Remove deprecated `scripts/docker_prod_build.sh` in favor of `make build`

## 2.4.28 - 2021.03.24

### Fixed

* Fixed an issue with the `webpack-dev-server` version `^4.0.0-beta.1` by moving the `overlay` config setting
  to `client` (https://github.com/nystudio107/craft/issues/54)

## 2.4.27 - 2021.03.22

### Added

* Added `make` command aliases

### Changed

* Use `@tailwindcss/jit` for the CSS generation

### Fixed

* Fix webpack buildchain pipeline

## 2.4.26 - 2021.03.07

### Changed

* Use aliases for import paths
* Remove version, require, autoload, and config from the project `composer.json`
* Use Tailwind CSS `^2.0.3`
* Use official MariaDB images
* Use `craftcms/cms` version `^3.6.7`
* Updated db-seed & Project Config to match `craftcms/cms` version `^3.6.7`

## 2.4.25 - 2021.02.09

### Added

* Use PHP 8.0 Alpine images for the prod & dev containers

### Changed

* Ensure that the `cms/config` directory has the right permissions

### Fixed

* Updated `buddy.yaml` to match with Alpine update

## 2.4.24 - 2021.02.03

### Fixed

* Fixed an issue with favicon generation caused by changes in `favicons-webpack-plugin`

## 2.4.23 - 2021.02.02

### Changed

* Use `get-webpack-config` package

## 2.4.22 - 2021.02.02

### Fixed

* Fix setting that’d cause HMR to fail to work unless a production build existed

## 2.4.21 - 2021.02.02

### Changed

* Changed `return 0` to `exit 0` in the `composer.json` scripts

### Fixed

* Fixed an issue where the default ImageOptimize transform was set to ServerlessSharp, causing mayhem and confusion

## 2.4.20 - 2021.01.27

### Changed

* Changed `--interactive 0` to `--interactive=0` just for consistency (either works)

## 2.4.19 - 2021.01.27

### Added

* Added Docker bind mount for `compiled_templates` so XDebug can be used with Twig templates

### Changed

* Remove vestigial `HotModuleReplacementPlugin`
* Set `--interactive=0` on console commands in the `composer.json` to force non-interactivity for CI commands

## 2.4.18 - 2021.01.21

### Changed

* Set the minimum platform reqs to PHP  `7.2.5`

## 2.4.17 - 2021.01.14

### Changed

* Clean up AMP CSS approach
* Change AMP CSS URL to a path, so we can include it server-side
* Strip `!important` rules from AMP CSS
* Clean up critical CSS config

## 2.4.16 - 2021.01.12

### Changed

* `gzip` the seed database
* Update to deps required for `favicons-webpack-plugin` `^5.0.0-alpha.4`

## 2.4.15 - 2021.01.09

### Changed

* Update to Axios `^0.21.1`
* Tabs -> Spaces in the Dockerfiles

## 2.4.14 - 2021.01.04

### Changed

* Use slimmed down Alpine images for Docker
* Added `--no-install-recommends` to all `apt-get install` commands
* Put complete output in each config
* Remove `imagemin-gifsicle` due to build issues (and also we rarely use `.gif` files)

## 2.4.13 - 2020.12.21

### Changed

* Refactored `output.path` to `app.config.js`
* Remove unused base Docker configs
* Use PHP 7.4

## 2.4.12 - 2020.12.17

### Added

* Added some useful PostCSS plugins

### Changed

* Don't try to remove `vendor/` after project install
* Use named `chunkIds`
* Allow HMR through Craft CMS error pages by including the now-separate `runtime.js`

## 2.4.11 - 2020.12.06

### Changed

* Ensure poll is always an integer
* Updated seed db

## 2.4.10 - 2020.12.05

### Changed

* Updated to latest buildchain semver deps

## 2.4.9 - 2020.12.05

### Changed

* config/redactor/Standard.json → Default.json
* Unlicense → BSD Zero Clause License

### Fixed

* Fixed import WebpackManifestPlugin from webpack-manifest-plugin 3.x
* Fixed craftcms/redactor#278

## 2.4.8 - 2020.11.30

### Added

* Added `nodemon` so `webpack-dev-server` will automatically restart if we change any of the webpack configs

### Changed

* Use `webpack-dev-server` version `^4.0.0-beta.0` for additional speed & better webpack 5 support

## 2.4.7 - 2020.11.26

### Changed

* Remove `postcss-preset-env`, add `autoprefixer` & `postcss-nested`

## 2.4.6 - 2020.11.25

### Changed

* Change `mysql-client` to `mariadb-client`

## 2.4.5 - 2020.11.25

### Added

* Add `mysql-client` in the `php-dev-craft` & `php-prod-craft` MariaDB containers so we get `mysqldump`
* Added image optimization tools to the `php-dev-craft` & `php-prod-craft` MariaDB containers

## 2.4.4 - 2020.11.21

### Changed

* Ignore `/admin` routes in the Service Worker

## 2.4.3 - 2020.11.17

### Fixed

* Removed `xdebug.remote_connect_back` from the `php-dev-base` container's `xdebug.ini` file to allow xdebug to connect
  properly

## 2.4.2 - 2020.11.11

### Fixed

* Removed unused `path` attribute passed to `MiniCssExtractPlugin` in the `production.config.js`

## 2.4.1 - 2020.11.11

### Changed

* Sync Craft version

## 2.4.0 - 2020.11.10

### Added

* Updated buildchain to a modular webpack config system, using webpack 5 & PostCSS 8
* Added `yiisoft/yii2-shell` to `require-dev`
* Add `--no-dev --no-progress` to the composer install command

### Changed

* Ignore Nginx requests for `favicon.ico`
* Removed deprecated `links` from `docker-compose.yaml`
* Use Composer 2.x

## 2.3.14 - 2020.10.25

### Added

* Added `/cms/web/dist/*` to root `.gitignore`
* Use a separate `php_xdebug` container only when the `XDEBUG_SESSION` cookie is set, so regular requests are more
  performant

## 2.3.13 - 2020.09.25

### Added

* Add `run_queue.sh` keep alive script

## 2.3.12 - 2020.09.25

### Added

* Added a `db-seed` directory, and moved the `seed_db.sql` there
* Added `--set-gtid-purged=OFF` to the `common_mysql.sh` to avoid permissions issues with some database dumps
* Explicitly set the `user` that the PHP & queue containers run as to `www-data`

### Changed

* Removed unneeded `composer dump-autoload` from the project `composer.json`

## 2.3.11 - 2020.09.15

### Changed

* Explicitly set `id` from APP_ID and use `keyPrefix` for cache component
* Add docker_prod_build script

## 2.3.10 - 2020.09.10

### Changed

* Sessions should use `REDIS_DEFAULT_DB`

## 2.3.9 - 2020.09.09

### Changed

* Better nginx config for local dev, based on `nystudio107/nginx`

## 2.3.8 - 2020.09.09

### Added

* Added a `queue` docker container to run queue jobs via `./craft queue/listen`

### Changed

* Removed `dotenvy`
* Removed https://repo.repman.io from `repositories`

## 2.3.7 - 2020.09.07

### Changed

* Remove the use of `craft on` and `craft off` because they create pointless `dateUpdated` changes to `project.yaml`

## 2.3.6 - 2020.09.05

### Added

* Added image optimizers to the `php-dev-craft` Docker image
* Added the default `DB_PORT` of `3306` to `example.env` and `example.env.sh`

### Changed

* Updated the `css-loader` config to ignore embedded URLs

## 2.3.5 - 2020.09.02

### Changed

* Changed `project-config/sync` -> `project-config/apply`
* Updated the `buddy.yaml` with the latest Prep Craft script

## 2.3.4 - 2020.09.02

### Added

* Added a `queue` component with a longer `ttr`

### Changed

* Refactor composer scripts to handle Craft not being installed, leveraging craft `install/check`
* Boilerplate now requires `craftcms/cms` `^3.5.8`

## 2.3.3 - 2020.08.13

### Fixed

* Modern config only for local
  dev, [fixing multi-compiler issues](https://github.com/webpack/webpack-dev-server/issues/2355) with HRM

## 2.3.2 - 2020.08.12

### Changed

* Remove `[hash]` from dev config to eliminate
  potential [memory errors](https://github.com/webpack/webpack-dev-server/issues/438)
* Use `[contenthash]` in production instead
  of [hash or chunkhash](https://github.com/webpack/webpack.js.org/issues/2096)

## 2.3.1 - 2020.08.10

### Added

* Added `init` to the `docker-compose.yml` to processes are sent signals
* Added `--no-tablespaces` to the mysqldump command options to work around changes in MySQL

### Fixed

* Fix redis session config to use `App::sessionConfig()`

## 2.3.0 - 2020.08.02

### Added

* Add native image lazy loading
* Slim Docker containers after build

### Fixed

* Refactored Docker config to use more sane contexts during builds, speeding up build time immensely 🎩 Patrick
* Change `throwExceptions` deprecator config to use `App::env('DEV_MODE')`

## 2.2.13 - 2020.07.18

### Changed

* Disable the ForkTS plugins for now

## 2.2.12 - 2020.07.18

### Added

* Added TypeScript support
* Use Vue.js 3.0
* Added `buddy.yml` for atomic deployments

### Changed

* Replaced moment with vanilla JavaScript
* Replaced `getenv()` with `App::env()`
* No longer use DSN for db connections
* Switch from TSLint to ESLint

### Fixed

* Fixed config path in the module `helpers/Config.php`

## 2.2.11 - 2020.05.26

### Changed

* Use DSN for database connections

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

* Removed entirely the concept of a "modern" and "legacy" build from the `webpack.dev.js`; we don't need legacy builds
  with `webpack-dev-server`

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
* Added a `post-update-cmd` to `composer.json` to recreate any symlinks that may have been removed after
  a `composer update` or `composer install`

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
