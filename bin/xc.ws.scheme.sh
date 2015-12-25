#!/bin/bash

if [ "x$1" = "x" ]; then
	echo "usage: $0 <workspace>"
	exit 1
fi

xcodebuild -workspace "$1.xcworkspace" -list
