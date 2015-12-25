#!/bin/bash

scriptdir=`dirname $0`

if [ "x$3" = "x" ]; then
	echo "usage: $0 <workspace> <scheme> <property>"
	exit 1
fi

$scriptdir/xc.ws.scheme.settings.sh "$1" "$2" | grep "$3" |perl -pi -e "s|^(.+?\s+=\s+)||g"

