#!/bin/bash

OTRS_CONF='/opt/otrs/Kernel/Config.pm'

if [ -z "${OTRS_DB_HOST}" ]; then OTRS_DB_HOST='otrs-db';fi
if [ -z "${OTRS_DB_NAME}" ]; then OTRS_DB_NAME='otrs';fi
if [ -z "${OTRS_DB_USER}" ]; then OTRS_DB_USER='otrs';fi
if [ -z "${OTRS_DB_PASS}" ]; then OTRS_DB_PASS='suP3rp244w0rds910tr4';fi

sed -i "s/DOCKER_DB_HOST/${OTRS_DB_HOST}/" ${OTRS_CONF};
sed -i "s/DOCKER_DB_NAME/${OTRS_DB_NAME}/" ${OTRS_CONF};
sed -i "s/DOCKER_DB_USER/${OTRS_DB_USER}/" ${OTRS_CONF};
sed -i "s/DOCKER_DB_PASS/${OTRS_DB_PASS}/" ${OTRS_CONF};

su -c "/opt/otrs/bin/otrs.Daemon.pl start" otrs

rm -f /var/run/crond.pid
service cron start

export APACHE_RUN_USER=otrs
export APACHE_RUN_GROUP=otrs
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_LOG_DIR=/var/log/apache2

export LANG=C
export LANG

rm -f ${APACHE_PID_FILE}

apache2 -DFOREGROUND
