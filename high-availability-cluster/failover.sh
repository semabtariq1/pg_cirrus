#!/bin/bash
# This script is run by failover_command. This script runs when the primary PostgreSQL node fails and a standby node is promoted as primary node. 

set -o xtrace

# Special values:
# 1)  %d = failed node id
# 2)  %h = failed node hostname
# 3)  %p = failed node port number
# 4)  %D = failed node database cluster path
# 5)  %m = new main node id
# 6)  %H = new main node hostname
# 7)  %M = old main node id
# 8)  %P = old primary node id
# 9)  %r = new main port number
# 10) %R = new main database cluster path
# 11) %N = old primary node hostname
# 12) %S = old primary node port number
# 13) PG_MAJOR_VERSION = major version number of postgresql server
# 14) %% = '%' character

# Assigning values to variables using the special values in the failover command
FAILED_NODE_ID="$1"
FAILED_NODE_HOST="$2"
FAILED_NODE_PORT="$3"
FAILED_NODE_PGDATA="$4"
NEW_MAIN_NODE_ID="$5"
NEW_MAIN_NODE_HOST="$6"
OLD_MAIN_NODE_ID="$7"
OLD_PRIMARY_NODE_ID="$8"
NEW_MAIN_NODE_PORT="$9"
NEW_MAIN_NODE_PGDATA="${10}"
OLD_PRIMARY_NODE_HOST="${11}"
OLD_PRIMARY_NODE_PORT="${12}"
PG_MAJOR_VERSION="${13}"

# Promoting the new main node to primary using pg_ctl command on the new main node host
ssh postgres@$NEW_MAIN_NODE_HOST "/usr/lib/postgresql/$PG_MAJOR_VERSION/bin/pg_ctl -D $NEW_MAIN_NODE_PGDATA promote"
