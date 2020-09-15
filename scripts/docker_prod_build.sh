#!/bin/bash

# Build production assets
#
# Build the production assets inside of the buildchain Docker container
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @package   craft-scripts
# @since     1.2.2
# @license   MIT

# Get the directory of the currently executing script
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Include files
INCLUDE_FILES=(
            "common/defaults.sh"
            ".env.sh"
            )
for INCLUDE_FILE in "${INCLUDE_FILES[@]}"
do
    if [[ ! -f "${DIR}/${INCLUDE_FILE}" ]] ; then
        echo "File ${DIR}/${INCLUDE_FILE} is missing, aborting."
        exit 1
    fi
    source "${DIR}/${INCLUDE_FILE}"
done

# Temporary db dump path (remote & local)
if [[ -z "${LOCAL_BUILDCHAIN_CONTAINER}" ]]; then
    echo "Variable LOCAL_BUILDCHAIN_CONTAINER is missing from .env.sh, aborting."
else
    docker exec -it ${LOCAL_BUILDCHAIN_CONTAINER} npm run build
fi

# Normal exit
exit 0
