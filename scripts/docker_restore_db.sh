#!/bin/bash

# Restore Database
#
# Restore the local database to the file path passed in via ARGV
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

# Get the directory of the currently executing script
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Include files
INCLUDE_FILES=(
            "common/defaults.sh"
            ".env.sh"
            "common/common_env.sh"
            "common/common_db.sh"
            )
for INCLUDE_FILE in "${INCLUDE_FILES[@]}"
do
    if [[ ! -f "${DIR}/${INCLUDE_FILE}" ]] ; then
        echo "File ${DIR}/${INCLUDE_FILE} is missing, aborting."
        exit 1
    fi
    source "${DIR}/${INCLUDE_FILE}"
done

# Source the correct file for the database driver
case "$GLOBAL_DB_DRIVER" in
    ( 'mysql' ) source "${DIR}/common/common_mysql.sh" ;;
    ( 'pgsql' ) source "${DIR}/common/common_pgsql.sh" ;;
    ( * )
        echo "Environment variable GLOBAL_DB_DRIVER was neither 'mysql' nor 'pgsql'. Aborting."
        exit 1 ;;
esac

# Get the path to the database passed in
SRC_DB_PATH="$1"
if [[ -z "${SRC_DB_PATH}" ]] ; then
    echo "No input database dump specified via variable SRC_DB_PATH"
    exit 1
fi
if [[ ! -f "${SRC_DB_PATH}" ]] ; then
    echo "File not found for variable SRC_DB_PATH"
    exit 1
fi

# Figure out what type of file we're being passed in
case "$SRC_DB_PATH" in
    ( *.gz )  CAT_CMD="${DB_ZCAT_CMD}" ;;
    ( *.sql ) CAT_CMD="${DB_CAT_CMD}" ;;
    ( * )
        echo "Unknown file type for variable SRC_DB_PATH"
        exit 1 ;;
esac

# Functions
function restore_local_from_dump_mysql() {
    # Restore the local db from the passed in db dump
    $CAT_CMD "${SRC_DB_PATH}" | docker exec -i ${LOCAL_DB_CONTAINER} ${LOCAL_MYSQL_CMD} ${LOCAL_DB_CREDS}
    echo "*** Restored docker MySQL database from ${SRC_DB_PATH}"
}
function restore_local_from_dump_pgsql() {
    # Restore the local db from the passed in db dump
    $CAT_CMD "${SRC_DB_PATH}" | docker exec -i ${LOCAL_DB_CONTAINER} ${LOCAL_PSQL_CMD} --output /dev/null --quiet ${LOCAL_DB_CREDS}
    echo "*** Restored docker Postgres database from ${SRC_DB_PATH}"
}

case "$GLOBAL_DB_DRIVER" in
    ( 'mysql' )
        restore_local_from_dump_mysql
        ;;
    ( 'pgsql' )
        restore_local_from_dump_pgsql
        ;;
esac

# Normal exit
exit 0
