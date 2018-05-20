#!/bin/bash

# Heroku specific dynamic runtime env vars
export TYK_GW_LISTENPORT=$PORT

REDIS_URL=`echo $REDIS_URL | sed -e s,redis://,,g`
userpass=`echo $REDIS_URL | grep @ | cut -d@ -f1`
hostport=`echo $REDIS_URL |  cut -d@ -f2`

export TYK_GW_STORAGE_HOST=`echo $hostport | grep : | cut -d: -f1`
export TYK_GW_STORAGE_PORT=`echo $hostport | grep -oE "[^:]+$"`
export TYK_GW_STORAGE_PASSWORD=`echo $userpass | grep : | cut -d: -f2`

tyk_exec="tyk"
if [ -n "$TYK_PLUGINS" ]; then
	echo "Tyk will be using $TYK_PLUGINS plugins"
	tyk_exec="tyk-$TYK_PLUGINS"
	export TYK_GW_COPROCESSOPTIONS_ENABLECOPROCESS="true"
fi

cd /opt/tyk-gateway
exec ./$tyk_exec --conf=/opt/tyk-gateway/tyk.conf

