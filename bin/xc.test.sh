#!/bin/bash

scriptdir=`dirname $0`

#pushd $scriptdir
#. ./env.sh
#popd

if [ "x$1" = "x" ]; then
    echo "usage: $0 env.file.sh"
    exit 1
fi

env_file="$1"

. "$env_file"

pushd "$scriptdir/.."

echo "SCHEME: $SCHEME"
echo `pwd`

#-workspace $WORKSPACE \
#-project $WORKSPACE.xcodeproj \

xcodebuild -workspace "$projectname".xcworkspace \
           -scheme "$scheme" \
           -sdk iphonesimulator \
           -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.0' \
           -derivedDataPath '/tmp/output' \
           test || exit 1

popd

