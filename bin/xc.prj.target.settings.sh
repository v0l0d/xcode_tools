#!/bin/bash

if [ "x$2" = "x" ]; then
	echo "usage: $0 <project> <target>"
	exit 1
fi

xcodebuild -project "$1.xcodeproj" -target "$2" -showBuildSettings

