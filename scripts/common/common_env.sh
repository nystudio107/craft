#!/bin/bash

# Common Env
#
# Shared script to set various environment-related variables
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

# Commands to output database dumps, using gunzip -c instead of zcat for MacOS X compatibility
DB_ZCAT_CMD="gunzip -c"
DB_CAT_CMD="cat"
