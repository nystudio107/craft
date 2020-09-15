# Craft 3 Scripts Environment
#
# Local environmental config for nystudio107 Craft scripts
#
# @author    nystudio107
# @copyright Copyright (c) 2020 nystudio107
# @link      https://nystudio107.com/
# @license   MIT
#
# This file should be renamed to '.env.sh' and it should reside in the
# `scripts` directory.  Add '.env.sh' to your .gitignore.

# -- GLOBAL settings --

# The database driver for this Craft install ('mysql' or 'pgsql')
GLOBAL_DB_DRIVER="mysql"

# -- LOCAL settings --

LOCAL_DB_CONTAINER="REPLACE_ME"
LOCAL_BUILDCHAIN_CONTAINER="REPLACE_ME"

# -- REMOTE settings --

# Remote ssh credentials, user@domain.com and Remote SSH Port
REMOTE_SSH_LOGIN="REPLACE_ME"
REMOTE_SSH_PORT="22"

# Should we connect to the remote database server via ssh?
REMOTE_DB_USING_SSH="yes"

# Remote database constants; default port for mysql is 3306, default port for postgres is 5432
REMOTE_DB_NAME="REPLACE_ME"
REMOTE_DB_PASSWORD="REPLACE_ME"
REMOTE_DB_USER="REPLACE_ME"
REMOTE_DB_HOST="localhost"
REMOTE_DB_PORT="3306"
REMOTE_DB_SCHEMA="public"

# If you are using mysql 5.6.10 or later and you have `login-path` setup as per:
# https://opensourcedbms.com/dbms/passwordless-authentication-using-mysql_config_editor-with-mysql-5-6/
# you can use it instead of the above REMOTE_DB_* constants; otherwise leave this blank
REMOTE_DB_LOGIN_PATH=""

# The `mysql` and `mysqldump` commands to run remotely
REMOTE_MYSQL_CMD="mysql"
REMOTE_MYSQLDUMP_CMD="mysqldump"

# The `psql` and `pg_dump` commands to run remotely
REMOTE_PSQL_CMD="psql"
REMOTE_PG_DUMP_CMD="pg_dump"
