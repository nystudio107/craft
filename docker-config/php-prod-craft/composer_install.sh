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

# Ensure permissions on directories Craft needs to write to
chown -R www-data:www-data /var/www/project/cms/storage
chown -R www-data:www-data /var/www/project/cms/web/cpresources
# Check for `composer.lock` & `vendor/autoload.php`
cd /var/www/project/cms
if [ ! -f "composer.lock" ] || [ ! -f "vendor/autoload.php" ]; then
    su-exec www-data composer install --verbose --no-progress --no-scripts --optimize-autoloader --no-interaction
    # Wait until the MySQL db container responds
    echo "### Waiting for MySQL database"
    until eval "mysql -h mariadb -u $DB_USER -p$DB_PASSWORD $DB_DATABASE -e 'select 1' > /dev/null 2>&1"
    do
      sleep 1
    done
    # Run any pending migrations/project config changes
    su-exec www-data composer craft-update
fi
