#!/bin/bash

# Common DB
#
# Shared script to set various database-related variables
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

# Tables to exclude from the db dump
EXCLUDED_DB_TABLES=(
            "assetindexdata"
            "assettransformindex"
            "cache"
            "sessions"
            "templatecaches"
            "templatecachecriteria"
            "templatecacheelements"
            "templatecachequeries"
            )

TMP_DB_DUMP_CREDS_PATH="/tmp/craftscripts.creds"

# -- LOCAL settings -- hard-coded for Docker

# Local database constants; default port for mysql is 3306, default port for postgres is 5432
LOCAL_DB_NAME="project"
LOCAL_DB_PASSWORD="project"
LOCAL_DB_USER="project"
LOCAL_DB_HOST="localhost"
LOCAL_DB_PORT="5432"
LOCAL_DB_SCHEMA="public"

# The `mysql` and `mysqldump` commands to run locally
LOCAL_MYSQL_CMD="mysql"
LOCAL_MYSQLDUMP_CMD="mysqldump"

# The `psql` and `pg_dump` commands to run locally
LOCAL_PSQL_CMD="psql"
LOCAL_PG_DUMP_CMD="pg_dump"
