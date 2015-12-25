#!/bin/bash -x

if [ "x$2" = "x" ]; then
    echo "usage: $0 <Scheme> <RedPlanet iOS dir>"
    exit 1
fi

iOSWorkspaceDir=$2
scheme=$1

#testsGit="https://github.com/RedPlanetTesting/RedPlanetApp.git"
testsGit="rphlTests_bare"


#---------
rphlTestsDir="rphlTests"

xcBuildEnvFile="$iOSWorkspaceDir/bin/env.$scheme.sh"

function appium_start {

/Applications/Appium.app/Contents/Resources/node/bin/node \
	/Applications/Appium.app/Contents/Resources/node_modules/appium/bin/appium.js \
	--native-instruments-lib \
	--address 127.0.0.1 \
	--port 4723 \
	--log-level info:info > /tmp/appium.log 2>&1 &
	
#sleep 30
}

function appium_stop {
    killall node
}

function build_simulator {
xcBuildEnvFile=$1
iOSWorkspaceDir=$2

pushd  "$iOSWorkspaceDir"
`dirname $0`/xc.build_simulator.sh "$xcBuildEnvFile" .
result=$?
if [ $result != 0 ]; then
    "echo failed to build ios app"
    exit 1
fi
popd

}

function run_tests {
rphlTestsDir=$1

pushd "$rphlTestsDir"
rm -rf "RP Staging.app"
cp -r "/tmp/1/Build/Products/Debug-iphonesimulator/RP Staging.app" .
popd

pushd "$rphlTestsDir/RedPlanetTest"
ant Mobile
#./run.sh

popd

}

appium_stop
appium_start

#build_simulator $xcBuildEnvFile $iOSWorkspaceDir
    
#clone tests
rm -rf "$rphlTestsDir"
#git clone "$testsGit" "$rphlTestsDir"
cp -r 

run_tests $rphlTestsDir

appium_stop

