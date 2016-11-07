#!/usr/bin/env bash

if [ $# -ne 2 ]
then
	echo "usage: build_module_src.sh <SERVICE_NAME> <CONFIG_DIR>"
	echo "       example: "
	echo "       build_module_src.sh loginserver QM.CI"
	exit 1
fi

#0. get project name
SERVICE_NAME=$1
CONFIG_DIR=$2


#1. generate directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

#2. package output path
PACKAGE_DIR=./..

. $BUILD_SHELL_DIR/_before_compile.sh $SERVICE_NAME

. $BUILD_SHELL_DIR/_after_compile.sh $SERVICE_NAME $CONFIG_DIR $PACKAGE_DIR



