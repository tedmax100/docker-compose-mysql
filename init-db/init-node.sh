#!/bin/bash

set -e

sleep 60

mysql -u root -p${MYSQL_ROOT_PASSWORD} -h localhost \
-e "CHANGE MASTER TO MASTER_HOST='master', \
MASTER_USER='${MYSQL_REPLICATION_USER}', \
MASTER_PASSWORD='${MYSQL_REPLICATION_USER_PWD}', \
GET_MASTER_PUBLIC_KEY=1; "

mysql -u root -p${MYSQL_ROOT_PASSWORD} -h localhost \
-e "START SLAVE; show slave status\G"