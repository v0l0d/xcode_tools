#!/bin/bash

if [ "x$1" = "x" ]; then
    echo "usage: $0 env.sh"
    exit
fi

env="$1"
workspace_dir="$2"

if [[ "$env" = /* ]]; then
        . "$env"
else
        . "./$env"
fi

tmpdir=`mktemp -d`
cp $scheme.ipa $tmpdir/

pushd $tmpdir
	unzip *.ipa
	ios-deploy -b ./Payload/*.app
popd

rm -rf $tmpdir

