#!/bin/bash

# Heroku specific dynamic runtime env vars
export TYK_DB_LISTENPORT=$PORT
export TYK_DB_NOTIFICATIONSLISTENPORT=5000

REDIS_URL=`echo $REDIS_URL | sed -e s,redis://,,g`
userpass=`echo $REDIS_URL | grep @ | cut -d@ -f1`
hostport=`echo $REDIS_URL |  cut -d@ -f2`

export TYK_DB_REDISHOST=`echo $hostport | grep : | cut -d: -f1`
export TYK_DB_REDISPORT=`echo $hostport | grep -oE "[^:]+$"`
export TYK_DB_REDISPASSWORD=`echo $userpass | grep : | cut -d: -f2`

cd /opt/tyk-dashboard
exec ./tyk-analytics --conf=/opt/tyk-dashboard/tyk_analytics.conf

