#!/bin/bash -x

if [ "x$2" = "x" ]; then
    echo "usage: $0 env.sh workspace_dir"
    exit
fi

env="$1"
workspace_dir="$2"

if [[ "$env" = /* ]]; then
	. "$env"
else
	. "./$env"
fi

. `dirname $0`/xc._include.sh

build_simulator "$projectname" "$scheme"
exit $?
