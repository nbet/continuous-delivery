#!/usr/bin/env bash


#0. get project name
SERVICE_NAME=$1
CONFIG_DIR=$2
lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`
next_ver=$3


#1. invoke directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILDS_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_SOURCE_DIR=$BUILD_WORKSPACE/$lowcase_project_name
COPY_CONFIG_FROM_DIR=$BUILD_SOURCE_DIR/$CONFIG_DIR
BUILD_LATEST_CONFIG_DIR=$BUILDS_ROOT_DIR/latest/config
BUILD_CONFIG_OUTPUT_DIR=$BUILDS_ROOT_DIR/configs/$SERVICE_NAME


#2. generate config
cd $COPY_CONFIG_FROM_DIR
CONFIG_TAR_FILE_NAME=$SERVICE_NAME-$next_ver-config.tar.gz
tar zcvf $BUILD_CONFIG_OUTPUT_DIR/$CONFIG_TAR_FILE_NAME ./ --exclude=CMakeLists.txt*
cd -


#3. generate config symbolic
cd $BUILD_LATEST_CONFIG_DIR
echo "update latest config info"
MATCH_TAR=$BUILD_LATEST_CONFIG_DIR/$lowcase_project_name-*-config.tar.gz
rm -f $MATCH_TAR

LATEST_CONFIG=$BUILD_LATEST_CONFIG_DIR/$lowcase_project_name-$next_ver-config.tar.gz
echo "../../configs/$lowcase_project_name/$lowcase_project_name-$next_ver-config.tar.gz $LATEST_CONFIG"
ln -s ../../configs/$lowcase_project_name/$lowcase_project_name-$next_ver-config.tar.gz $LATEST_CONFIG
cd -

