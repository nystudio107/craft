<p align="center"><a href="https://craftcms.com/" target="_blank"><img width="300" height="300" src="https://nystudio107.com/img/site/nystudio107_submark.svg" alt="nystudio107"></a></p>

## About nystudio107/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.

In addition to setting up a new Craft 3 CMS project, this project sets up:
 
* [Craft 3 Multi-Environment](https://github.com/nystudio107/craft3-multi-environment) as described in the [Multi-Environment Config for Craft CMS](https://nystudio107.com/blog/multi-environment-config-for-craft-cms) article
* [Craft-Scripts](https://github.com/nystudio107/craft-scripts) as described in the [Database & Asset Syncing Between Environments in Craft CMS](https://nystudio107.com/blog/database-asset-syncing-between-environments-in-craft-cms), [Mitigating Disaster via Website Backups](https://nystudio107.com/blog/mitigating-disaster-via-website-backups) & [Hardening Craft CMS Permissions](https://nystudio107.com/blog/hardening-craft-cms-permissions) articles
  
...and sets up some other base scaffolding as described to the following articles:

* [A Better package.json for the Frontend](https://nystudio107.com/blog/a-better-package-json-for-the-frontend)
* [A Gulp Workflow for Frontend Development Automation](https://nystudio107.com/blog/a-gulp-workflow-for-frontend-development-automation)
* [Implementing Critical CSS on your website](https://nystudio107.com/blog/implementing-critical-css)
* [Simple Static Asset Versioning in Craft CMS](https://nystudio107.com/blog/simple-static-asset-versioning)
* [Enhancing a Craft CMS 3 Website with a Custom Module](https://nystudio107.com/blog/simple-static-asset-versioning)

It also installs a few base plugins that I use on every project. You can read more about it in the [Setting up a New Craft 3 CMS Project](https://nystudio107.com/blog/enhancing-a-craft-cms-3-website-with-a-custom-module) article.

## Assumptions Made

Since this is boilerplate that nystudio107 uses for projects, it is by definition opinionated, and has a number of assumptions:

* Gulp is used as a the frontend workflow automation tool
* [Vue](https://github.com/vuejs/vue) is used as the frontend JavaScript framework, with [Axios](https://github.com/axios/axios) providing the http client
* [Tailwind CSS](https://tailwindcss.com/docs/what-is-tailwind) is used as the utility-first CSS framework
* Nginx with `ssi on;` is used as the web server
* Redis is used as the PHP Session and Craft data caching method
* Critical CSS is used site-wide
* FontFaceObserver is used for font loading
* Craft-Scripts are used for db/asset synching
* Craft 3 Multi-Environment is used for the Craft 3 multi-environment setup

Obviously you're free to remove whatever components you don't need/want to use.

## Using nystudio107/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

    composer create-project nystudio107/craft PATH -s RC

Make sure that `PATH` is the path to your project, including the name you want for the project, e.g.:

    composer create-project nystudio107/craft craft3 -s RC

Then `cd` to your new project directory, and run Craft's `setup` console command to create your `.env` environments and optionally install:

    cd PATH
    ./craft setup

Finally, run the `nys-setup` command to configure Craft-Scripts & Craft 3 Multi-Environment based on your newly created `.env` settings:

    ./nys-setup

That's it, enjoy!

If you ever delete the `vendor` folder or such, just re-run:

    ./nys-setup

...and it will re-create the symlink to your `.env.sh`; don't worry, it won't stomp on any changes you've made.

Below is the entire intact, unmodified `README.md` from Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft):

.....

## About Craft CMS

Craft is a content-first CMS that aims to make life enjoyable for developers and content managers alike. It is optimized for bespoke web and application development, offering developers a clean slate to build out exactly what they want, rather than wrestling with a theme.

Learn more about Craft at [craftcms.com](https://craftcms.com).

## How to Install Craft 3 Beta

Installation instructions can be found in the [Craft 3 documentation](https://github.com/craftcms/docs/blob/master/en/installation.md).

## Resources

#### Official Resources
- [Craft 3 Documentation](https://github.com/craftcms/docs)
- [Craft 3 Plugins](https://github.com/craftcms/plugins)
- [Demo site](https://demo.craftcms.com/)
- [Craft Slack](https://craftcms.com/community#slack)
- [Craft CMS Stack Exchange](http://craftcms.stackexchange.com/)

#### Community Resources
- [Mijingo](https://mijingo.com/craft) – Video courses and other learning resources
- [Envato Tuts+](https://webdesign.tutsplus.com/categories/craft-cms/courses) – Video courses
- [Straight Up Craft](http://straightupcraft.com/) – Articles, tutorials, and more
- [Craft Cookbook](https://craftcookbook.net/) – Quick answers for common tasks
- [pluginfactory.io](https://pluginfactory.io/) – Craft plugin scaffold generator
