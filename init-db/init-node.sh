#!/bin/bash

set -e

sleep 30
until mysql -u root -p${MYSQL_ROOT_PASSWORD} -h master; do 
    >&2 echo "MySQL master is unavailable -sleeping"
    sleep 5
done

mysql -u root -p${MYSQL_ROOT_PASSWORD} -h localhost \
-e "CREATE USER '${MYSQL_REPLICATION_USER}'@'${MYSQL_HOST}' IDENTIFIED BY '${MYSQL_REPLICATION_USER_PWD}'; \
GRANT REPLICATION SLAVE ON *.* TO '${MYSQL_REPLICATION_USER}'@'${MYSQL_HOST}';"


mysql -u root -p${MYSQL_ROOT_PASSWORD} -h localhost \
-e "CHANGE MASTER TO MASTER_HOST='master', \
MASTER_USER='${MYSQL_REPLICATION_USER}', \
MASTER_PASSWORD='${MYSQL_REPLICATION_USER_PWD}', \
GET_MASTER_PUBLIC_KEY=1; "

mysql -u root -p${MYSQL_ROOT_PASSWORD} -h localhost \
-e "START SLAVE; show slave status\G"