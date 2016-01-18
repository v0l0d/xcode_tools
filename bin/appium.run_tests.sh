#!/bin/bash -x

if [ "x$2" = "x" ]; then
    echo "usage: $0 <Scheme> <RedPlanet iOS dir>"
    exit 1
fi

iOSWorkspaceDir=$2
scheme=$1

rphlTestsDir="AppiumTests"
xcBuildEnvFile="$iOSWorkspaceDir/bin/env.$scheme.sh"

#Load script env settings
envFile=`dirname $0`/env.sh

if [ -f $envFile ]; then
    . $envFile
else
    echo "$envFile doesn't exist. See `dirname $0`/env.sample.sh as an example"
    exit
fi

function appium_start {

    $BIN_NODE \
	$APPIUM_JS \
	--native-instruments-lib \
	--address 127.0.0.1 \
	--port $appiumPort \
	--bootstrap-port $appiumBootstrapPort \
	--tmp $appiumTmpDir \
	--log-level info:info > /tmp/appium.log 2>&1 &
	
#sleep 30
}

function appium_stop {
    #kill by port
    pid=$(lsof -i tcp:$appiumPort -t);
    kill -TERM $pid || kill -KILL $pid
}

function build_simulator {
    xcBuildEnvFile="$1"
    iOSWorkspaceDir="$2"

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
#    cp -r "/tmp/1/Build/Products/Debug-iphonesimulator/RP Staging.app" .
    ln -s "/tmp/1/Build/Products/Debug-iphonesimulator/RP Staging.app" "RP Staging.app"
#    popd

#    pushd "$rphlTestsDir/RedPlanetTest"
    ant Mobile
    #./run.sh

    popd
}

function cloneTests {
    if [ -d "$rphlTestsDir" ]; then
        pushd $rphlTestsDir
        git pull
        popd
    else
        rm -rf "$rphlTestsDir"
        git clone "$testsGit" "$rphlTestsDir"
    fi
}

appium_stop
appium_start

#exit

build_simulator "$xcBuildEnvFile" "$iOSWorkspaceDir"
    
#cloneTests

run_tests $rphlTestsDir

appium_stop

