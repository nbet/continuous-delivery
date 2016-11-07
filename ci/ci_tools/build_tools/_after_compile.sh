#!/usr/bin/env bash

#0. get project name
SERVICE_NAME=$1
CONFIG_DIR=$2
PACKAGE_DIR=$3

lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`


#1. generate directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILD_OUTPUT_DIR=$BUILDS_ROOT_DIR/modules/$lowcase_project_name


#2. generate next module version
next_ver=`$BUILD_SHELL_DIR/get_next_version.sh $BUILD_OUTPUT_DIR/ $lowcase_project_name`
echo "next version: $next_ver"


#3. generate package
. $BUILD_SHELL_DIR/_generate_package.sh $SERVICE_NAME $next_ver $PACKAGE_DIR


#4. generate sha512
. $BUILD_SHELL_DIR/_generate_sha512.sh $SERVICE_NAME $next_ver


#5. generate config
. $BUILD_SHELL_DIR/_generate_config.sh $SERVICE_NAME $CONFIG_DIR $next_ver


#6. generate git
. $BUILD_SHELL_DIR/_generate_git.sh $SERVICE_NAME $next_ver

