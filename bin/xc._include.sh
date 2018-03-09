#!/bin/bash

#build
#param 1: projectnmae
#param 2: scheme
function build () {
projectname="$1"
scheme="$2"

echo "Cleaning archive dir..."
rm -rf "$scheme".xcarchive
rm -rf "$scheme".ipa

    CONFIGURATION_BUILD_DIR="/tmp/" \

xcodebuild \
    -workspace "$projectname".xcworkspace \
    -scheme "$scheme" \
    $XCODEBUILD_PARAMS \
    clean \
    build

return $?

}

#archive
#param 1: projectnmae
#param 2: scheme
function archive () {
projectname="$1"
scheme="$2"

echo "Cleaning archive dir..."
rm -rf "$scheme".xcarchive
rm -rf "$scheme".ipa

xcodebuild \
    -workspace "$projectname".xcworkspace \
    -scheme "$scheme" \
    -archivePath "$scheme".xcarchive \
    $XCODEBUILD_PARAMS \
    clean \
    archive

return $?

}

#build
#param 1: projectnmae
#param 2: scheme
function build_simulator () {
projectname="$1"
scheme="$2"

echo "Cleaning archive dir..."
rm -rf "$scheme".xcarchive
rm -rf "$scheme".ipa

#    CONFIGURATION_BUILD_DIR="/tmp/" \

derivedDataPath="/tmp/1"
mkdir -p "$derivedDataPath"

xcodebuild \
    -workspace "$projectname".xcworkspace \
    -scheme "$scheme" \
    -destination 'name=iPhone 6' \
    -derivedDataPath "$derivedDataPath" \
    $XCODEBUILD_PARAMS \
    clean \
    build

return $?

}


#build IPA
#param 1: projectname
#param 2: scheme
function buildIpa () {
projectname="$1"
scheme="$2"

xcodebuild \
    -exportArchive \
    -exportPath . \
    -archivePath "$scheme".xcarchive \
    $XCODEBUILD_PARAMS \
    -exportOptionsPlist ExportOptions.plist 
#    -exportOptionsPlist  `dirname $0`/adhoc.plist
#    -exportFormat ipa
#    -exportProvisioningProfile "RPHL_Internal_Staging_Distribution_Profile.mobileprovision"
return $?
}
