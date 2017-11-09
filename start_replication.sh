#! /bin/sh

MASTER_ID="master-mysql"
MASTER_HOST="master-mysql"
MASTER_PORT="3306"

MASTER_ID_PASS="-u root"
REPL_USER="repl_user"
REPL_PASSWD="repl_user"

SLAVE_ID="slave-mysql"
SLAVE_HOST="slave-mysql"
SLAVE_PORT="3306"

DOCKER_EXEC="docker exec"

log_file=`${DOCKER_EXEC} ${MASTER_ID} bash -c "mysql -h ${MASTER_HOST} -P ${MASTER_PORT} ${MASTER_ID_PASS} -e 'SHOW MASTER STATUS\G' | grep File: | sed -e 's/^ *File: *//'"`
position=`${DOCKER_EXEC} ${MASTER_ID} bash -c "mysql -h ${MASTER_HOST} -P ${MASTER_PORT} ${MASTER_ID_PASS} -e 'SHOW MASTER STATUS\G' | grep Position: | sed -e 's/^ *Position: *//'"`

sql="CHANGE MASTER TO MASTER_HOST='"${MASTER_HOST}"', MASTER_USER='"${REPL_USER}"', MASTER_PASSWORD='"${REPL_PASSWD}"', MASTER_LOG_FILE='"${log_file}"', MASTER_LOG_POS=${position};"

${DOCKER_EXEC} ${SLAVE_ID} bash -c "mysql -h ${SLAVE_HOST} -P ${SLAVE_PORT} -u root -e 'STOP SLAVE'"
${DOCKER_EXEC} ${SLAVE_ID} bash -c "mysql -h ${SLAVE_HOST} -P ${SLAVE_PORT} -u root -e \"${sql}\""
${DOCKER_EXEC} ${SLAVE_ID} bash -c "mysql -h ${SLAVE_HOST} -P ${SLAVE_PORT} -u root -e 'START SLAVE'"
