#!/bin/bash

# 此脚本必须放在.podspec同一层级下

read -p "Please enter new version > " newVersion

newVersionString="  s.version          = '${newVersion}'"
oldVersionString=`grep -E 's.version.*=' XNCountdown.podspec`

sed -i "" "s/${oldVersionString}/${newVersionString}/g" $(dirname "${BASH_SOURCE[0]}")/XNCountdown.podspec

echo "oldVersion is ${oldVersionString},newVersion is ${newVersionString}"


git add .
git commit -am ${newVersion}
git tag ${newVersion}
git push origin master --tags
pod trunk push --verbose --allow-warnings --use-libraries --use-modular-headers
