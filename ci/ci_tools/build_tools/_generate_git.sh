#!/usr/bin/env bash


#0. get project name
SERVICE_NAME=$1
lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`
next_ver=$2


#1. invoke directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILDS_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_GIT_DIR=$BUILDS_ROOT_DIR/git


#2. generate git.txt 
GIT_VER=`git rev-parse HEAD`
DATETIME=`date '+%Y/%m/%d %H:%M:%S'`
cd $BUILD_GIT_DIR
rm -rf $lowcase_project_name-*.git.txt
GIT_FILE=$lowcase_project_name-$next_ver.git.txt
echo "$SERVICE_NAME-$next_ver.tar.gz Revision:$GIT_VER Build:$DATETIME" > $GIT_FILE
cd -

