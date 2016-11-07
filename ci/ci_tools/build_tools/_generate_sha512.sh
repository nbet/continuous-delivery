#!/usr/bin/env bash


#0. get project name
SERVICE_NAME=$1
lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`
next_ver=$2


#1. invoke directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILDS_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_LATEST_DIR=$BUILDS_ROOT_DIR/latest
BUILD_LATEST_SHA512_DIR=$BUILDS_ROOT_DIR/latest/sha512
BUILD_BUNDLE_SHA512_DIR=$BUILDS_ROOT_DIR/sha512
mkdir -p $BUILD_BUNDLE_SHA512_DIR


#2. set module sha512 output
cd $BUILD_LATEST_DIR

BUNDLE_SHA512_FILE_NAME=$BUILD_BUNDLE_SHA512_DIR/$lowcase_project_name-$next_ver.sha512

JAR_FLAG=`ls .|grep .jar$`
WAR_FLAG=`ls .|grep .war$`
sha512sum $lowcase_project_name-$next_ver.jar > $BUNDLE_SHA512_FILE_NAME
sha512sum $lowcase_project_name-$next_ver.war >> $BUNDLE_SHA512_FILE_NAME
sha512sum $lowcase_project_name-$next_ver.tar.gz >> $BUNDLE_SHA512_FILE_NAME
cd -


#3. generate sha512 symbolic
cd $BUILD_LATEST_SHA512_DIR
MATCH_TAR=$BUILD_LATEST_SHA512_DIR/$lowcase_project_name-*.sha512
rm -f $MATCH_TAR

LATEST_SHA512=$BUILD_LATEST_SHA512_DIR/$lowcase_project_name-$next_ver.sha512
echo "ln -s ../../sha512/$lowcase_project_name-$next_ver.sha512 $LATEST_SHA512"
ln -s ../../sha512/$lowcase_project_name-$next_ver.sha512 $LATEST_SHA512
cd -




