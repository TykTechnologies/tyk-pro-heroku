#!/bin/bash

# Heroku specific dynamic runtime env vars
REDIS_URL=`echo $REDIS_URL | sed -e s,redis://,,g`
userpass=`echo $REDIS_URL | grep @ | cut -d@ -f1`
hostport=`echo $REDIS_URL |  cut -d@ -f2`

export TYK_PMP_REDIS_HOST=`echo $hostport | grep : | cut -d: -f1`
export TYK_PMP_REDIS_PORT=`echo $hostport | grep -oE "[^:]+$"`
export TYK_PMP_REDIS_PASSWORD=`echo $userpass | grep : | cut -d: -f2`

cd /opt/tyk-pump
exec ./tyk-pump -c /opt/tyk-pump/pump.conf

