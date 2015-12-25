#!/bin/bash

if [ "x$2" = "x" ]; then
	echo "usage: $0 <workspace> <scheme>"
	exit 1
fi

xcodebuild -workspace "$1".xcworkspace -scheme "$2" -showBuildSettings

