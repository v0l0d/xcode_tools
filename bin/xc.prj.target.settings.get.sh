#!/bin/bash

scriptdir=`dirname $0`

if [ "x$3" = "x" ]; then
	echo "usage: $0 <project> <target> <property>"
	exit 1
fi

#$scriptdir/xc.prj.target.settings.sh "$1" "$2" | grep "$3" |perl -pi -e "s|^(.+?\s+=\s+)||g"

$scriptdir/xc.prj.target.settings.sh "$1" "$2" | grep "$3" |perl -pi -e "s|^(.+?\s+=\s+)||g"

