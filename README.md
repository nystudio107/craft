<p align="center"><a href="https://craftcms.com/" target="_blank"><img width="300" height="300" src="https://nystudio107.com/img/site/nystudio107_submark.svg" alt="nystudio107"></a></p>

## About nystudio107/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.
 
The project is based on [Craft CMS](https://CraftCMS.com) using a unique `templates/_boilerplate` system for web/AJAX/AMP pages, and implements a number of technologies/techniques:
 
* [Docker](https://www.docker.com/) Docker is used for local development; see **Setting Up Local Dev** below for details
* A base Twig templating setup as described in [An Effective Twig Base Templating Setup](https://nystudio107.com/blog/an-effective-twig-base-templating-setup)
* [webpack](https://webpack.js.org/) is used for the build system as per [An Annotated webpack 4 Config for Frontend Web Development](https://nystudio107.com/blog/an-annotated-webpack-4-config-for-frontend-web-development)
* [VueJS](https://vuejs.org/) is used for some of the interactive bits on the website as per 
* [Tailwind CSS](https://tailwindcss.com/) for the site-wide CSS
* JSON-LD structured data as per [Annotated JSON-LD Structured Data Examples](https://nystudio107.com/blog/annotated-json-ld-structured-data-examples)
* [Google AMP](https://developers.google.com/amp/) versions of the podcast episode and other pages
* Static assets are stored in AWS S3 buckets with CloudFront as the CDN, as per the [Setting Up AWS S3 Buckets + CloudFront CDN for your Assets](https://nystudio107.com/blog/using-aws-s3-buckets-cloudfront-distribution-with-craft-cms) article
* Implements a Service Worker via Google's [Workbox](https://developers.google.com/web/tools/workbox/) as per [Service Workers and Offline Browsing](https://nystudio107.com/blog/service-workers-and-offline-browsing)
* Critical CSS as per [Implementing Critical CSS on your website](https://nystudio107.com/blog/implementing-critical-css)
* Frontend error handling as per [Handling Errors Gracefully in Craft CMS](https://nystudio107.com/blog/handling-errors-gracefully-in-craft-cms)
* A custom site module as per [Enhancing a Craft CMS 3 Website with a Custom Module](https://nystudio107.com/blog/enhancing-a-craft-cms-3-website-with-a-custom-module)
* CLI-based queue as per [Robust queue job handling in Craft CMS](https://nystudio107.com/blog/robust-queue-job-handling-in-craft-cms)
* FastCGI Static Cache as per [Static Page Caching with Craft CMS](https://nystudio107.com/blog/static-caching-with-craft-cms)
* [Craft-Scripts](https://github.com/nystudio107/craft-scripts) as described in the [Database & Asset Syncing Between Environments in Craft CMS](https://nystudio107.com/blog/database-asset-syncing-between-environments-in-craft-cms), [Mitigating Disaster via Website Backups](https://nystudio107.com/blog/mitigating-disaster-via-website-backups) & [Hardening Craft CMS Permissions](https://nystudio107.com/blog/hardening-craft-cms-permissions) articles

...and probably a bunch of other stuff too.

The following Craft CMS plugins are used on this site:
* [FastCGI Cache Bust](https://nystudio107.com/plugins/fastcgi-cache-bust) - to bust the FastCGI cache whenever entries are modified
* [ImageOptimize](https://nystudio107.com/plugins/imageoptimize) - for the optimized images and `srcset`s used on the site
* [Minify](https://nystudio107.com/plugins/minify) - to minify the HTML and inline JS/CSS
* [Retour](https://nystudio107.com/plugins/retour) - for setting up 404 redirects
* [SEOmatic](https://nystudio107.com/plugins/seomatic) - for handling site-side SEO
* [Twigpack](https://nystudio107.com/plugins/twigpack) - for loading webpack-generated `manifest.json` resources in a modern way
* [Typogrify](https://nystudio107.com/plugins/typogrify) - for smart quotes and other typographic ligatures
* [Webperf](https://nystudio107.com/plugins/webperf) - for monitoring web performance

You can read more about it in the [Setting up a New Craft 3 CMS Project](https://nystudio107.com/blog/setting-up-a-craft-cms-3-project) article.

## Using nystudio107/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

    composer create-project nystudio107/craft PATH

Make sure that `PATH` is the path to your project, including the name you want for the project, e.g.:

    composer create-project nystudio107/craft craft3

## Setting Local Dev

You'll need Docker desktop for your platform installed to run the project in local development

* Set up a `.env` file in the `cms/` directory, based off of the provided `example.env`
* Set up a `.env.sh.` file in the `scripts/` directory, based off of the provided `example.env.sh`
* Start up the site with `docker-composer up` (the first build will be somewhat lengthy)
* On the first time setting it up, the `craft_php_1` container will fail; this is normal
* Import the `seed_db.sql` database dump the first time from the `scripts/` dir with `./docker_restore)db.sh seed_db.sql`
* Then hit ^C (Control-C) to stop the Docker containers, and restart them with `docker-compose up` and `craft_php_1` should then work properly, since the db has been seeded
* Navigate to `http://localhost:8000` to use the site; the `webpack-dev-server` runs off of `http://localhost:8080`

The CP login credentials are initially set as follows:

Login: `andrew@nystudio107.com`
Password: `letmein`

Obviously change these to whatever you like as needed

**N.B.:** Without authorization & credentials (which are private), the `./docker_pull_db.sh` will not work. It's provided here for instructional purposes

To update to the latest Composer packages (as constrained by the `cms/composer.json` semvers), do:
```
rm cms/composer.lock
docker-compose up
```

To update to the latest npm packages (as constrained by the `docker-config/webpack-dev-craft/package.json` semvers), do:
```
rm docker-config/webpack-dev-craft/package-lock.json
docker-compose up
```

Below is the entire intact, unmodified `README.md` from Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft):

.....

<p align="center"><a href="https://craftcms.com/" target="_blank"><img width="312" height="90" src="https://craftcms.com/craftcms.svg" alt="Craft CMS"></a></p>

## About Craft CMS 

Craft is a flexible and scalable CMS for creating bespoke digital experiences on the web and beyond.

It features:

- An intuitive Control Panel for administration tasks and content creation.
- A clean-slate approach to content modeling and [front-end development](https://docs.craftcms.com/v3/dev/).
- A built-in Plugin Store with hundreds of free and commercial [plugins](https://plugins.craftcms.com/).
- A robust framework for [module and plugin development](https://docs.craftcms.com/v3/extend/).

Learn more about it at [craftcms.com](https://craftcms.com).

## Tech Specs

Craft is written in PHP (7+), and built on the [Yii 2 framework](https://www.yiiframework.com/). It can connect to MySQL (5.5+) and PostgreSQL (9.5+) for content storage.

## Installation

See the following documentation pages for help installing Craft 3:

- [Server Requirements](https://docs.craftcms.com/v3/requirements.html)
- [Installation Instructions](https://docs.craftcms.com/v3/installation.html)
- [Upgrading from Craft 2](https://docs.craftcms.com/v3/upgrade.html)

## Popular Resources

- **[Documentation](http://docs.craftcms.com/v3/)** – Read the official docs.
- **[Guides](https://craftcms.com/guides)** – Follow along with the official guides.
- **[#craftcms](https://twitter.com/hashtag/craftcms)** – See the latest tweets about Craft.
- **[Discord](https://craftcms.com/discord)** – Meet the community.
- **[Stack Exchange](http://craftcms.stackexchange.com/)** – Get help and help others.
- **[CraftQuest](https://craftquest.io/)** – Watch unlimited video lessons and courses.
- **[Craft Link List](http://craftlinklist.com/)** – Stay in-the-know.
- **[nystudio107 Blog](https://nystudio107.com/blog)** – Learn Craft and modern web development.
