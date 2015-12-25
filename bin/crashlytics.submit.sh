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

ipa="$scheme".ipa

pushd "$workspace_dir"
changelist_file="./__ChangeList.txt"
echo $Changelog > "$changelist_file"
echo "ChangeLog: $Changelog"

$workspace_dir/Crashlytics.framework/submit \
$CRASHLYTICS_API_KEY \
$CRASHLYTICS_BUILD_SECRET \
-emails vladimir.bilyov@gmail.com \
-groupAliases "$CRASHLYTICS_GROUP_ALIASES" \
-notifications YES \
-notesPath "$changelist_file" \
-ipaPath "$ipa"

#rm -f "$changelist_file"

popd
