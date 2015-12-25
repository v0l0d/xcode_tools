#!/bin/bash

if [ "x$1" = "x" ]; then
	echo "usage: $0 <project>"
	exit 1
fi

xcodebuild -project "$1.xcodeproj" -list
