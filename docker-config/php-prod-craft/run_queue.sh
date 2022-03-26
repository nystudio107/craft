#!/bin/bash

# Run Queue shell script
#
# This shell script runs the Craft CMS queue via `php craft queue/listen`
# It waits until the database container responds, then runs any pending
# migrations / project config changes via the `craft-update` Composer script,
# then runs the queue listener that listens for and runs pending queue jobs
#
# @author    nystudio107
# @copyright Copyright (c) 2022 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

cd /var/www/project/cms
# Force the permissions to be set properly
chown -R www-data:www-data /var/www/project &
# Wait until the MySQL db container responds
until eval "mysql -h mysql -u $DB_USER -p$DB_PASSWORD $DB_DATABASE -e 'select 1' > /dev/null 2>&1"
do
  sleep 1
done
# Wait until the `composer install` is done by looking for the `vendor/autoload.php` file
while [ ! -f vendor/autoload.php ]
do
  sleep 1
done
# Run any pending migrations/project config changes
su-exec www-data composer craft-update
# Run a queue listener
su-exec www-data php craft queue/listen 10
