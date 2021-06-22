#!/bin/bash

# Run Queue shell script
#
# This shell script runs the Craft CMS queue via `php craft queue/listen`
# It's wrapped in a "keep alive" infinite loop that restarts the command
# (after a 60 second sleep) should it exit unexpectedly for any reason
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

while true
do
  cd /var/www/project/cms
  su-exec www-data php craft queue/listen 10
  echo "-> craft queue/listen will retry in 60 seconds"
  sleep 60
done
