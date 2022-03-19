#!/bin/bash

# Composer Install shell script
#
# This shell script runs `composer install` if either the `composer.lock` file or
# the `vendor/` directory is not present`
#
# @author    nystudio107
# @copyright Copyright (c) 2022 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

cd /var/www/project/cms
if [ ! -f "composer.lock" ] || [ ! -d "vendor" ]; then
    su-exec www-data composer install --verbose --no-progress --no-scripts --optimize-autoloader --no-interaction
fi
