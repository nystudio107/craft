#!/bin/bash

# NPM Install shell script
#
# This shell script runs `npm install` if either the `package-lock.json` file or
# the `node_modules/` directory is not present`
#
# @author    nystudio107
# @copyright Copyright (c) 2022 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

cd /var/www/project/buildchain
if [ ! -f "package-lock.json" ] || [ ! -n "$(ls -A node_modules 2>/dev/null)" ]; then
    npm install
fi
