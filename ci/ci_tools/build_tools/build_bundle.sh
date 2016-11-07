#!/usr/bin/env bash

if [ $# -eq 1 ]
then
    PROJECT_NAME=$1
else
    echo "usage: build_module.sh <PROJECT_NAME>"
    exit 1
fi

#0. get shell original directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
echo $BUILD_SHELL_DIR

#0.1 generate directory
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILD_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_GIT_DIR=$BUILD_ROOT_DIR/git
BUILD_LATEST_DIR=$BUILD_ROOT_DIR/latest
BUILD_BUNDLE_DIR=$BUILD_ROOT_DIR/bundles
mkdir -p $BUILD_BUNDLE_DIR
BUILD_LATEST_BUNDLE_DIR=$BUILD_ROOT_DIR/latest/bundles
mkdir -p $BUILD_LATEST_BUNDLE_DIR
BUILD_LATEST_GIT_DIR=$BUILD_ROOT_DIR/latest/bundle2rev
mkdir -p $BUILD_LATEST_GIT_DIR
BUNDLE2REV_DIR=$BUILD_ROOT_DIR/bundle2rev
mkdir -p $BUNDLE2REV_DIR

#0.3 generate next bundle version
next_ver=`$BUILD_SHELL_DIR/get_next_version.sh $BUILD_BUNDLE_DIR $PROJECT_NAME`
echo "next version: $next_ver"

#1. set bundle output
BUNDLE_FILE_NAME=$BUILD_BUNDLE_DIR/$PROJECT_NAME.bundle-$next_ver.txt
LATEST_BUNDLE_FILE_NAME=$BUILD_BUNDLE_DIR/$PROJECT_NAME.bundle-latest.txt
cd $BUILD_LATEST_DIR
ls *.tar.gz > $BUNDLE_FILE_NAME 2>/dev/null
ls *.jar >> $BUNDLE_FILE_NAME 2>/dev/null
ls *.war >> $BUNDLE_FILE_NAME 2>/dev/null

echo "bundle-$next_ver" > $LATEST_BUNDLE_FILE_NAME
ls *.tar.gz >> $LATEST_BUNDLE_FILE_NAME 2>/dev/null
ls *.jar >> $LATEST_BUNDLE_FILE_NAME 2>/dev/null
ls *.war >> $LATEST_BUNDLE_FILE_NAME 2>/dev/null

#1.1 generate bundle symbolic
cd $BUILD_LATEST_BUNDLE_DIR
rm -f $PROJECT_NAME.bundle-*.txt

LATEST_BUNDLE=$BUILD_LATEST_BUNDLE_DIR/$PROJECT_NAME.bundle-$next_ver.txt
echo "-s ../../bundles/$PROJECT_NAME.bundle-$next_ver.txt $LATEST_BUNDLE"
ln -s ../../bundles/$PROJECT_NAME.bundle-$next_ver.txt $LATEST_BUNDLE
LATEST_BUNDLE=$BUILD_LATEST_BUNDLE_DIR/$PROJECT_NAME.bundle-latest.txt
echo "../../bundles/$PROJECT_NAME.bundle-latest.txt $LATEST_BUNDLE"
ln -s ../../bundles/$PROJECT_NAME.bundle-latest.txt $LATEST_BUNDLE
cd -

echo "$BUNDLE_FILE_NAME ready"
echo "----------------------------->>>>"
cat $BUNDLE_FILE_NAME
echo "<<<<-----------------------------"

#2. set git output
BUNDLE2REV_FILE_NAME=$BUNDLE2REV_DIR/$PROJECT_NAME.bundle-$next_ver.git.txt
LATEST_BUNDLE2REV_FILE_NAME=$BUNDLE2REV_DIR/$PROJECT_NAME.bundle-latest.git.txt
cd $BUILD_GIT_DIR
cat *.git.txt > $BUNDLE2REV_FILE_NAME 2>/dev/null
cat *.git.txt > $LATEST_BUNDLE2REV_FILE_NAME 2>/dev/null

#2.1 generate git symbolic
cd $BUILD_LATEST_GIT_DIR
rm -f $PROJECT_NAME.bundle-*.git.txt

LATEST_GIT=$BUILD_LATEST_GIT_DIR/$PROJECT_NAME.bundle-$next_ver.git.txt
echo "../../bundle2rev/$PROJECT_NAME.bundle-$next_ver.git.txt $LATEST_GIT"
ln -s ../../bundle2rev/$PROJECT_NAME.bundle-$next_ver.git.txt $LATEST_GIT
LATEST_GIT=$BUILD_LATEST_GIT_DIR/$PROJECT_NAME.bundle-latest.git.txt
echo "../../bundle2rev/$PROJECT_NAME.bundle-latest.git.txt $LATEST_GIT"
ln -s ../../bundle2rev/$PROJECT_NAME.bundle-latest.git.txt $LATEST_GIT
cd -

echo "$BUNDLE2REV_FILE_NAME ready"
echo "----------------------------->>>>"
cat $BUNDLE2REV_FILE_NAME
echo "<<<<-----------------------------"



